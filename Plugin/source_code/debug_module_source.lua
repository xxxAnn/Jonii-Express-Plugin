--[[
local DebugModule = {}

function DebugModule:print_table(tab, descendance)
    local indent = ""

    descendance = descendance or 0

    if descendance > 0 then
        indent = string.rep(" ", descendance)
    elseif descendance == 0 then
        print(indent..tostring(tab).." ("..tostring(descendance/2).."): ")

        descendance = 2

        indent = string.rep(" ", descendance)
    end
    
    for k, v in pairs(tab) do
        if typeof(v) == "table" then
            print(indent..tostring(k).." ("..tostring(descendance/2).."): ")
            self:print_table(v, descendance + 2)
        else
            print(indent..tostring(k).." ("..tostring(descendance/2).."): "..tostring(v))
        end
    end
end

return DebugModule    
--]]