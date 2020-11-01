--[[local Environment = {}

local StarterPlayer = game:GetService("StarterPlayer")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local debug_module = require(script.Parent.misc.debug_module)
local filtering_enabled_client = require(script.Parent.injected_methods.filtering_enabled_client)
local instance_creation = require(script.Parent.injected_methods.instance_creation)
local number_format = require(script.Parent.injected_methods.number_format)

local CORE_MODULES = script.Parent.Parent.core_modules
local SHARED_SOURCE = ReplicatedStorage:WaitForChild("GameShared")

Environment.client_environment = {}

function Environment:build_environment()
    -- container for the core server modules
    self.client_environment.core_modules = {}
    self.client_environment.references = {}
    self.client_environment.references.__index = self.client_environment.references

    -- core module categories
    self.client_environment.core_modules.controllers = {}
    self.client_environment.references.controllers = self.client_environment.core_modules.controllers

    self.client_environment.core_modules.classes = {}
    self.client_environment.references.classes = self.client_environment.core_modules.classes

    self.client_environment.core_modules.modules = {}
    self.client_environment.references.modules = self.client_environment.core_modules.modules

    self.client_environment.core_modules.shared_modules = {}
    self.client_environment.references.shared_modules = self.client_environment.core_modules.shared_modules

    -- methods
    self.client_environment.references.print_table = debug_module.print_table

    self.client_environment.references.signal_server = filtering_enabled_client.signal_server
    self.client_environment.references.retrieve_from_server = filtering_enabled_client.retrieve_from_server
    self.client_environment.references.register_event = filtering_enabled_client.register_event

    self.client_environment.references.create_instance = instance_creation.create_instance
    self.client_environment.references.update_instance = instance_creation.update_instance

    self.client_environment.references.format_number = number_format.format_number

    -- roblox services
    self.client_environment.references.starter_player = StarterPlayer
    self.client_environment.references.players = Players
    self.client_environment.references.replicated_storage = ReplicatedStorage
    self.client_environment.references.debris = Debris

    -- other
    self.client_environment.references.player = Players.LocalPlayer
end

function extract_modules_from(options)
    for _, core_module in pairs(options.folder:GetChildren()) do
        if core_module:IsA("ModuleScript") then
            local required_module = require(core_module)

            Environment.client_environment.core_modules[options.core_module_container.Name][core_module.Name] = required_module

            Environment.client_environment.core_modules[options.core_module_container.Name][core_module.Name].children = {}

            extract_children_from_module {
                module = core_module;
                core_module_container = options.core_module_container;
            }

            setmetatable(required_module, Environment.client_environment.references)
        end
    end
end

function extract_children_from_module(options)
    for _, sub_module in pairs(options.module:GetDescendants()) do
        if sub_module:IsA("ModuleScript") then
            local required_sub_module = require(sub_module)

            Environment.client_environment.core_modules[options.core_module_container.Name][options.module.Name].children[sub_module.Name] = required_sub_module

            setmetatable(required_sub_module, Environment.client_environment.references)
        end
    end 
end

function extract_core_modules(core_module_container)
    for _, core_module in pairs(core_module_container:GetChildren()) do
        if core_module:IsA("ModuleScript") then
            local required_module = require(core_module)

            Environment.client_environment.core_modules[core_module_container.Name][core_module.Name] = required_module

            Environment.client_environment.core_modules[core_module_container.Name][core_module.Name].children = {}

            extract_children_from_module {
                module = core_module;
                core_module_container = core_module_container;
            }

            setmetatable(required_module, Environment.client_environment.references)
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

function Environment:start_controllers()
   for _, controller in pairs(self.client_environment.core_modules.controllers) do
       coroutine.wrap(function()
           if typeof(controller.start) == "function" then
               controller:start()
           end
       end)()
   end
end

return Environment
--]]