local default_impl = function(instance, options)
    return instance
end

return function(class_options)
    local Class = {}
    Class.__index = Class
    --! Sugar code Class(Options) = Class:new(options)
    local ClassMeta = {__call = function(class, options)
        return class:new(options)
    end}
    setmetatable(Class, ClassMeta)
    --! Wrapper for creating a table.
    --! Sets the class table as a metatable.
    --!  The equality 'getmetatable(instance) == class'
    --! will necessarily be true.
    --! Will call __init with the given options
    function Class.new(class, options)
        local instance = setmetatable({}, class)
        return instance:__init(options)
    end
    class_options = class_options or {}
    --! Sets init from the options.
    --! If no init was given, it will use
    --! UPVALUE - default_impl.
    if class_options.init ~= nil then Class.__init = class_options.init else Class.__init = default_impl end

    return Class
end