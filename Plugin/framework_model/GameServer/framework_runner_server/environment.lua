local Environment = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local Debris = game:GetService("Debris")

local debug_module = require(script.Parent.misc.debug_module)
local filtering_enabled_server = require(script.Parent.injected_methods.filtering_enabled_server)
local instance_creation = require(script.Parent.injected_methods.instance_creation)
local number_format = require(script.Parent.injected_methods.number_format)

local CORE_MODULES = script.Parent.Parent.core_modules
local SHARED_SOURCE = ReplicatedStorage:WaitForChild("GameShared")

Environment.server_environment = {}

function Environment:build_environment()
    -- container for the core server modules
    self.server_environment.core_modules = {}
    self.server_environment.references = {}
    self.server_environment.references.__index = self.server_environment.references

    -- core module categories
    self.server_environment.core_modules.services = {}
    self.server_environment.references.services = self.server_environment.core_modules.services

    self.server_environment.core_modules.classes = {}
    self.server_environment.references.classes = self.server_environment.core_modules.classes

    self.server_environment.core_modules.modules = {}
    self.server_environment.references.modules = self.server_environment.core_modules.modules

    self.server_environment.core_modules.shared_modules = {}
    self.server_environment.references.shared_modules = self.server_environment.core_modules.shared_modules

    -- methods
    self.server_environment.references.print_table = debug_module.print_table

    self.server_environment.references.signal_client = filtering_enabled_server.signal_client
    self.server_environment.references.signal_all_clients = filtering_enabled_server.signal_all_clients
    self.server_environment.references.register_event = filtering_enabled_server.register_event
    self.server_environment.references.register_function = filtering_enabled_server.register_function

    self.server_environment.references.create_instance = instance_creation.create_instance
    self.server_environment.references.update_instance = instance_creation.update_instance

    self.server_environment.references.format_number = number_format.format_number

    -- roblox services
    self.server_environment.references.server_script_service = ServerScriptService
    self.server_environment.references.players = Players
    self.server_environment.references.replicated_storage = ReplicatedStorage
    self.server_environment.references.physics_service = PhysicsService
    self.server_environment.references.debris = Debris
end

function extract_modules_from(options)
    for _, core_module in pairs(options.folder:GetChildren()) do
        if core_module:IsA("ModuleScript") then
            local required_module = require(core_module)

            Environment.server_environment.core_modules[options.core_module_container.Name][core_module.Name] = required_module

            Environment.server_environment.core_modules[options.core_module_container.Name][core_module.Name].children = {}

            extract_children_from_module {
                module = core_module;
                core_module_container = options.core_module_container;
            }

            setmetatable(required_module, Environment.server_environment.references)
        end
    end
end

function extract_children_from_module(options)
    for _, sub_module in pairs(options.module:GetDescendants()) do
        if sub_module:IsA("ModuleScript") then
            local required_sub_module = require(sub_module)

            Environment.server_environment.core_modules[options.core_module_container.Name][options.module.Name].children[sub_module.Name] = required_sub_module

            setmetatable(required_sub_module, Environment.server_environment.references)
        end
    end 
end

function extract_core_modules(core_module_container)
    for _, core_module in pairs(core_module_container:GetChildren()) do
        if core_module:IsA("ModuleScript") then
            local required_module = require(core_module)

            Environment.server_environment.core_modules[core_module_container.Name][core_module.Name] = required_module

            Environment.server_environment.core_modules[core_module_container.Name][core_module.Name].children = {}

            extract_children_from_module {
                module = core_module;
                core_module_container = core_module_container;
            }

            setmetatable(required_module, Environment.server_environment.references)
        elseif core_module:IsA("Folder") then
            extract_modules_from {
                folder = core_module;
                core_module_container = core_module_container;
            }
        end
    end
end

function Environment:add_environment_contents()
    for _, core_module_container in pairs(CORE_MODULES:GetChildren()) do
        extract_core_modules(core_module_container)
    end

    extract_core_modules(SHARED_SOURCE.core_modules.modules)
end

function Environment:start_services()
   for _, service in pairs(self.server_environment.core_modules.services) do
       coroutine.wrap(function()
           if typeof(service.start) == "function" then
               service:start()
           end
       end)()
   end
end

return Environment