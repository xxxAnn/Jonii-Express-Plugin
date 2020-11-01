--[[local FilteringEnabledServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTES_LOCATION = ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("core_modules"):WaitForChild("modules")

local remote_event;
local remote_function;

local remote_event_listeners = {}
local remote_function_listeners = {}

function FilteringEnabledServer:register_function(options)
    local func_name = options[1]
    local func_to_register = options[2]

    remote_function_listeners[func_name] = func_to_register
end

function FilteringEnabledServer:register_event(options)
    local event_name = options[1]
    local func_to_register = options[2]

    remote_event_listeners[event_name] = func_to_register
end

function FilteringEnabledServer.event_listen(player, options)
    options = options or {}

    local signal_name = options[1]

    if remote_event_listeners[signal_name] then
        table.remove(options, 1)
        
        remote_event_listeners[signal_name](player, options)
    end

end

function FilteringEnabledServer.function_listen(player, options)
    options = options or {}

    local return_value

    local func_name = options[1]

    if remote_function_listeners[func_name] then
        table.remove(options, 1)

        return_value = remote_function_listeners[func_name](player, options)
    end

    return return_value
end

function FilteringEnabledServer:signal_all_clients(options)
    options = options or {}

    remote_event:FireAllClients(options)
end

function FilteringEnabledServer:signal_client(options)
    options = options or {}

    local player = options[1]

    table.remove(options, 1)

    remote_event:FireClient(player, options)
end

function FilteringEnabledServer:remote_event()
    remote_event = REMOTES_LOCATION:FindFirstChild("jonii_express_event_gateway") or Instance.new("RemoteEvent")

    remote_event.Name = "jonii_express_event_gateway"

    remote_event.OnServerEvent:Connect(self.event_listen)

    remote_event.Parent = REMOTES_LOCATION

    return remote_event
end

function FilteringEnabledServer:remote_function()
    remote_function = REMOTES_LOCATION:FindFirstChild("jonii_express_function_gateway") or Instance.new("RemoteFunction")

    remote_function.Name = "jonii_express_function_gateway"

    remote_function.OnServerInvoke = self.function_listen

    remote_function.Parent = REMOTES_LOCATION

    return remote_function
end

remote_event = FilteringEnabledServer:remote_event();
remote_function = FilteringEnabledServer:remote_function();

return FilteringEnabledServer
--]]