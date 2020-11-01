local FrameworkBuilder = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local framework_model = require(script.framework_model)

local LOADED = "JONII_EXPRESS_LOADED"

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