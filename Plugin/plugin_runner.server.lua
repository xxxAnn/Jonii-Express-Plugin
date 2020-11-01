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

            ["class"] = "LocalScript";

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

local function convert_table_to_object(options)
    options = options or {}

    local this_object = Instance.new(options.tab.class)
    this_object.Name = options.tab.name

    if (this_object.ClassName == "Script") or (this_object.ClassName == "LocalScript") or (this_object.ClassName == "ModuleScript") then
        this_object.Source = options.tab.source.Source:gsub("--%[%[", ""):gsub("--%]%]", "")
    end

    for _, v in pairs(options.tab) do
        if typeof(v) == "table" then
            convert_table_to_object {
                tab = v;
                parent = this_object;
            }
        end
    end

    this_object.Parent = options.parent
end

local function fetch_game_modules()
    convert_table_to_object {
        tab = framework_model.GameServer;
        parent = ServerScriptService;
    }

    convert_table_to_object {
        tab = framework_model.GameClient;
        parent = StarterPlayer.StarterPlayerScripts;
    }

    convert_table_to_object {
        tab = framework_model.GameShared;
        parent = ReplicatedStorage
    }
end

fetch_game_modules()