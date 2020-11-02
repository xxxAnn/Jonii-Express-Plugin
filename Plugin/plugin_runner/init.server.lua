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

fetch_game_modules_button.Click:Connect(framework_builder.fetch_game_modules)