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
    local module_index = {
        ["service"] = script.Parent.module_components.server_assets.service;
        ["server_class"] = script.Parent.module_components.server_assets.server_class;
        ["server_module"] = script.Parent.module_components.server_assets.server_module;

        ["controller"] = script.Parent.module_components.client_assets.controller;
        ["client_class"] = script.Parent.module_components.client_assets.client_class;
        ["client_module"] = script.Parent.module_components.client_assets.client_module;

        ["shared_class"] = script.Parent.module_components.shared_assets.shared_class;
        ["shared_module"] = script.Parent.module_components.shared_assets.shared_module;
    }

    if not module_index[options.module_type] then return warn("invalid source module type!") end

    local module = module_index[options.module_type]:Clone()

    module.Name = options.module_name

    
end



fetch_game_modules_button.Click:Connect(framework_builder.fetch_game_modules)