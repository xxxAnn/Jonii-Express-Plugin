local FrameworkBuilder = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local framework_model = require(script.framework_model)

local LOADED = "JONII_EXPRESS_LOADED"

function FrameworkBuilder:get_load_keyword()
    return LOADED
end

function FrameworkBuilder:sample_module_index()
    return {
        ["service"] = {
            sample = script.Parent.Parent.module_components.server_assets.service;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("services");
            sample_name = "MyService";
        };
    
        ["server_class"] = {
            sample = script.Parent.Parent.module_components.server_assets.server_class;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("classes");
            sample_name = "MyClass";
        };
        
        ["server_module"] = {
            sample = script.Parent.Parent.module_components.server_assets.server_module;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    
        ["controller"] = {
            sample = script.Parent.Parent.module_components.client_assets.controller;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("controllers");
            sample_name = "MyController";
        };
    
        ["client_class"] = {
            sample = script.Parent.Parent.module_components.client_assets.client_class;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("classes");
            sample_name = "MyClass";
        };
    
        ["client_module"] = {
            sample = script.Parent.Parent.module_components.client_assets.client_module;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    
        ["shared_class"] = {
            sample = script.Parent.Parent.module_components.shared_assets.shared_class;
            location = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyClass";
        };
    
        ["shared_module"] = {
            sample = script.Parent.Parent.module_components.shared_assets.shared_module;
            location = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    }
end

function FrameworkBuilder:build_module(options)
    local sample_module_index = self:sample_module_index()

    local loaded_server = ServerScriptService:FindFirstChild(LOADED)
    local loaded_client = StarterPlayer.StarterPlayerScripts:FindFirstChild(LOADED)
    local loaded_shared = ReplicatedStorage:FindFirstChild(LOADED)

    if not (loaded_server and loaded_client and loaded_shared) then return warn("Did not detect Jonii Express environment. Failed to create module.") end

    local module_type = options.module_type
    local module_name = options.module_name
    local player_name = options.player_name

    if not sample_module_index[module_type] then return warn("invalid source module type!") end

    local module = sample_module_index[module_type].sample:Clone()

    module.Name = module_name

    module.Source = module.Source:gsub("%-- Created by user", "-- Created by "..player_name):gsub("%-- Date: 99/99/9999", "-- Date: "..os.date("%x", tick()))

    if module_name then
        module.Source = module.Source:gsub(sample_module_index[module_type].sample_name, module_name)
    end

    module.Parent = sample_module_index[module_type].location
end

function FrameworkBuilder:convert_table_to_object(options)
    options = options or {}

    local this_object = Instance.new(options.tab.class)
    this_object.Name = options.tab.name

    if (this_object.ClassName == "Script") or (this_object.ClassName == "LocalScript") or (this_object.ClassName == "ModuleScript") then
        this_object.Source = options.tab.source.Source:gsub("--%[%[", ""):gsub("--%]%]", "")
    end

    for _, v in pairs(options.tab) do
        if typeof(v) == "table" then
            self:convert_table_to_object {
                tab = v;
                parent = this_object;
            }
        end
    end

    this_object.Parent = options.parent
end

function FrameworkBuilder:fetch_game_modules()
    if not (ServerScriptService:FindFirstChild(LOADED) and ServerScriptService[LOADED].Value) then
        FrameworkBuilder:convert_table_to_object {
            tab = framework_model.GameServer;
            parent = ServerScriptService;
        }

        local loaded = Instance.new("BoolValue")
        loaded.Name = LOADED
        loaded.Value = true
        loaded.Parent = ServerScriptService
    end

    if not (StarterPlayer.StarterPlayerScripts:FindFirstChild(LOADED) and StarterPlayer.StarterPlayerScripts[LOADED].Value) then
        FrameworkBuilder:convert_table_to_object {
            tab = framework_model.GameClient;
            parent = StarterPlayer.StarterPlayerScripts;
        }

        local loaded = Instance.new("BoolValue")
        loaded.Name = LOADED
        loaded.Value = true
        loaded.Parent = StarterPlayer.StarterPlayerScripts
    end

    if not (ReplicatedStorage:FindFirstChild(LOADED) and ReplicatedStorage[LOADED].Value) then
        FrameworkBuilder:convert_table_to_object {
            tab = framework_model.GameShared;
            parent = ReplicatedStorage
        }

        local loaded = Instance.new("BoolValue")
        loaded.Name = LOADED
        loaded.Value = true
        loaded.Parent = ReplicatedStorage
    end

    print("Fetched game modules for framework, ready to be used!")
end

return FrameworkBuilder