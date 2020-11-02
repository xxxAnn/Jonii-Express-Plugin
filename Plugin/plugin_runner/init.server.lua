-- TODO: This plugin needs to be able to create or detect a jonii framework environment.
--- 1.Keep a repository of the source code needed to build the framework.
--- 2.Map out where each object will be placed
--- 3.When the framework is built, add a bool value to serverscriptservice indicating to the plugin that the framework is loaded.

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local framework_builder = require(script.framework_builder)

local plugin_tool_bar = plugin:CreateToolbar("Jonii Express")

local main_button = plugin_tool_bar:CreateButton("Jonii Express", "Jonii Express", "rbxassetid://3633860364")
local fetch_game_modules_button = plugin_tool_bar:CreateButton("Fetch Game Modules", "Fetch Game Modules", "rbxassetid://0")

--[[
1. Type of module? (service, class, module, controller, etc.)
2. Module name
3. Player name
4. Date
--]]

local function create_module(options)
    local sample_module_index = {
        ["service"] = {
            sample = script.Parent.module_components.server_assets.service;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("services");
            sample_name = "MyService";
        };
    
        ["server_class"] = {
            sample = script.Parent.module_components.server_assets.server_class;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("classes");
            sample_name = "MyClass";
        };
        
        ["server_module"] = {
            sample = script.Parent.module_components.server_assets.server_module;
            location = ServerScriptService:WaitForChild("GameServer"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    
        ["controller"] = {
            sample = script.Parent.module_components.client_assets.controller;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("controllers");
            sample_name = "MyController";
        };
    
        ["client_class"] = {
            sample = script.Parent.module_components.client_assets.client_class;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("classes");
            sample_name = "MyClass";
        };
    
        ["client_module"] = {
            sample = script.Parent.module_components.client_assets.client_module;
            location = StarterPlayer.StarterPlayerScripts:WaitForChild("GameClient"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    
        ["shared_class"] = {
            sample = script.Parent.module_components.shared_assets.shared_class;
            location = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyClass";
        };
    
        ["shared_module"] = {
            sample = script.Parent.module_components.shared_assets.shared_module;
            location = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules");
            sample_name = "MyModule";
        };
    }

    local loaded_server = ServerScriptService:FindFirstChild(framework_builder:get_load_keyword())
    local loaded_client = StarterPlayer.StarterPlayerScripts:FindFirstChild(framework_builder:get_load_keyword())
    local loaded_shared = ReplicatedStorage:FindFirstChild(framework_builder:get_load_keyword())

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

framework_builder:fetch_game_modules()

create_module {
    module_type = "service";
    module_name = "my_service";
    player_name = "Jonesloto"
}

-- fetch_game_modules_button.Click:Connect(framework_builder.fetch_game_modules)