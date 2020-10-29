local StandardClass = {}
StandardClass.__index = StandardClass

function StandardClass:new(options)
    -- construct object
    local object = {}

    return setmetatable(object, StandardClass)
end

return StandardClass