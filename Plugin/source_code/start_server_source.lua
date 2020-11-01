--[[local StartServer = {}

-- Roblox Services

-- Modules

local debug_module = require(script.Parent.misc.debug_module)
local environment = require(script.Parent.environment)

-- Constants

-- Variables and Functions

-- Class/Module

function StartServer:start()
    environment:build_environment()
    environment:add_environment_contents()
    environment:start_services()

--    debug_module:print_table(server_environment)
end

return StartServer
--]]