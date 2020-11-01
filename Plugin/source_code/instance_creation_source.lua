--[[local InstanceCreation = {}
InstanceCreation.__index = InstanceCreation

function InstanceCreation:create_instance(options)
    local inst
				
    local successful, result = pcall(function()
        inst = Instance.new(options[1])
        
        assert(inst ~= nil, "Not a valid arguement of constructor Instance.new()")
    end)
    
    if not successful then return warn(result, debug.traceback()) end
    
    for property, value in pairs(options[3] or {}) do
        local type_check_successful, type_check_result = pcall(function()
            assert(typeof(value) == typeof(inst[property]), 
                "Attempted to set "..tostring(property).." of "..tostring(inst).." to ("..tostring(value).."). Data types do not match..."
            )
        end)
        
        if not type_check_successful then return warn(type_check_result, debug.traceback()) end
        
        inst[property] = value
    end
    
    inst.Parent = options[2] or game.ServerStorage
    
    return inst
end

function InstanceCreation:update_instance(options)
    local successful, result = pcall(function()
        assert(options[1], "Instance does not exist within the game.")
    end)
    
    if not successful then warn(result..": ", debug.traceback()) return end
    
    for property, value in pairs(options[2] or {}) do
        local type_check_successful, type_check_result = pcall(function()
            assert(typeof(value) == typeof(options[1][property]), 
                "Attempted to set "..tostring(property).." of "..tostring(options[1]).." to ("..tostring(value).."). Data types do not match..."
            )
        end)
        
        if not type_check_successful then return warn(type_check_result, debug.traceback()) end
        
        options[1][property] = value
    end
end

return InstanceCreation    
--]]