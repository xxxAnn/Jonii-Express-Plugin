local source_code; script.Parent.Parent:WaitForChild("source_code")

return {
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