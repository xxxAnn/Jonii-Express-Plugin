--[[
local FilteringEnabledClient = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTES_LOCATION = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules")

local remote_event;
local remote_function;

local remote_event_listeners = {}

function FilteringEnabledClient:register_event(options)
    local event_name = options[1]
    local func_to_register = options[2]

    remote_event_listeners[event_name] = func_to_register
end

function FilteringEnabledClient.event_listen(options)
    options = options or {}

    local signal_name = options[1]

    if remote_event_listeners[signal_name] then
        table.remove(options, 1)

        remote_event_listeners[signal_name](options)
    end
end

function FilteringEnabledClient:retrieve_from_server(options)
    options = options or {}

    return remote_function:InvokeServer(options)
end

function FilteringEnabledClient:signal_server(options)
    options = options or {}

    remote_event:FireServer(options)
end

function FilteringEnabledClient:remote_event()
    remote_event = REMOTES_LOCATION:FindFirstChild("jonii_express_event_gateway")

    remote_event.OnClientEvent:Connect(self.event_listen)

    return remote_event
end

function FilteringEnabledClient:remote_function()
    remote_function = REMOTES_LOCATION:FindFirstChild("jonii_express_function_gateway")

    return remote_function
end

remote_event = FilteringEnabledClient:remote_event();
remote_function = FilteringEnabledClient:remote_function();

return FilteringEnabledClient    
--]]