local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local plugin_tool_bar = plugin:CreateToolbar("Jonii Express")

local main_button = plugin_tool_bar:CreateButton("Jonii Express", "Jonii Express", "rbxassetid://3633860364")

local function fetch_game_modules()
    local framework_detected;

    local game_server = ServerScriptService:FindFirstChild("GameServer")
    local game_client = StarterPlayer.StarterPlayerScripts:FindFirstChild("GameClient")
    local game_shared = ReplicatedStorage:FindFirstChild("GameClient")

    if not game_server then
        game_server = script.Parent:WaitForChild("framework_model"):WaitForChild("GameServer"):Clone()
        game_server.Parent = ServerScriptService
    end

    if not game_client then
        game_client = script.Parent:WaitForChild("framework_model"):WaitForChild("GameClient"):Clone()
        game_client.Parent = StarterPlayer.StarterPlayerScripts
    end

    if not game_shared then
        game_shared = script.Parent:WaitForChild("framework_model"):WaitForChild("GameShared"):Clone()
        game_shared.Parent = ReplicatedStorage
    end

    if game_server and game_client and game_shared then
        framework_detected = true
    end
end