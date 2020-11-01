-- TODO: This plugin needs to be able to create or detect a jonii framework environment.
--- 1.Keep a repository of the source code needed to build the framework.
--- 2.Map out where each object will be placed
--- 3.When the framework is built, add a bool value to serverscriptservice indicating to the plugin that the framework is loaded.

local source_code = script.Parent:WaitForChild("source_code")

local framework_model = {
    ["GameServer"] = {
        ["name"] = "GameServer";

        ["class"] = "Folder";

        ["core_modules"] = {
            ["name"] = "core_modules";
            ["class"] = "Folder";

            ["services"] = {
                ["name"] = "services";
                ["class"] = "Folder";
            };
    
            ["classes"] = {
                ["name"] = "classes";
                ["class"] = "Folder";
            };
    
            ["modules"] = {
                ["name"] = "modules";
                ["class"] = "Folder";
            };
        };

        ["framework_runner_server"] = {
            ["name"] = "framework_runner_server";

            ["class"] = "Script";

            ["source"] = source_code:WaitForChild("framework_runner_server_source");

            ["injected_methods"] = {
                ["name"] = "injected_methods";

                ["class"] = "Folder";

                ["filtering_enabled_server"] = {
                    ["name"] = "filtering_enabled_server";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("filtering_enabled_server_source");
                };

                ["instance_creation"] = {
                    ["name"] = "instance_creation";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("instance_creation_source");
                };

                ["number_format"] = {
                    ["name"] = "number_format";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("number_format_source");
                };
            };

            ["misc"] = {
                ["name"] = "injected_methods";
                
                ["class"] = "Folder";

                ["debug_module"] = {
                    ["name"] = "debug_module";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("debug_module_source");
                };
            };

            ["environment"] = {
                ["name"] = "environment";
    
                ["class"] = "ModuleScript";
    
                ["source"] = source_code:WaitForChild("environment_server_source");
            };

            ["start_server"] = {
                ["name"] = "start_server";
    
                ["class"] = "ModuleScript";
    
                ["source"] = source_code:WaitForChild("start_server_source");
            };
        };
    };

    ["GameClient"] = {
        ["name"] = "GameClient";

        ["class"] = "Folder";

        ["core_modules"] = {
            ["name"] = "core_modules";
            ["class"] = "Folder";

            ["controllers"] = {
                ["name"] = "controllers";
                ["class"] = "Folder";
            };
    
            ["classes"] = {
                ["name"] = "classes";
                ["class"] = "Folder";
            };
    
            ["modules"] = {
                ["name"] = "modules";
                ["class"] = "Folder";
            };
        };

        ["framework_runner_client"] = {
            ["name"] = "framework_runner_client";

            ["class"] = "Script";

            ["source"] = source_code:WaitForChild("framework_runner_client_source");

            ["injected_methods"] = {
                ["name"] = "injected_methods";

                ["class"] = "Folder";

                ["filtering_enabled_client"] = {
                    ["name"] = "filtering_enabled_client";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("filtering_enabled_client_source");
                };

                ["instance_creation"] = {
                    ["name"] = "instance_creation";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("instance_creation_source");
                };

                ["number_format"] = {
                    ["name"] = "number_format";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("number_format_source");
                };
            };

            ["misc"] = {
                ["name"] = "injected_methods";
                
                ["class"] = "Folder";

                ["debug_module"] = {
                    ["name"] = "debug_module";
        
                    ["class"] = "ModuleScript";
        
                    ["source"] = source_code:WaitForChild("debug_module_source");
                };
            };

            ["environment"] = {
                ["name"] = "environment";
    
                ["class"] = "ModuleScript";
    
                ["source"] = source_code:WaitForChild("environment_client_source");
            };

            ["start_client"] = {
                ["name"] = "start_client";
    
                ["class"] = "ModuleScript";
    
                ["source"] = source_code:WaitForChild("start_client_source");
            };
        };
    };

    ["GameShared"] = {
        ["name"] = "GameShared";

        ["class"] = "Folder";

        ["core_modules"] = {
            ["name"] = "core_modules";
            ["class"] = "Folder";
    
            ["modules"] = {
                ["name"] = "modules";
                ["class"] = "Folder";
            };
        };

        ["remotes"] = {
            ["name"] = "remotes";
            ["class"] = "Folder";
        };
    };
}


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