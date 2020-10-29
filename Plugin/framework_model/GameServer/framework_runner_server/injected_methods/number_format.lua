local NumberFormat = {}

local number_format_table = {
    {1e3, "K+"},
    {1e6,"M+"},
    {1e9, "B+"},
    {1e12, "T+"},
    {1e15, "Qa+"},
    {1e18, "Quint+"},
    {1e21, "Se+"},
    {1e24, "Sep+"},
    {1e27,"Octil+"},
    {1e30, "Non+"},
    {1e100, "Googl+"}
}

function NumberFormat:format_number(x)
    if not tonumber(x) then return end
				
    local formattedNum
    
    for i = #number_format_table, 1, -1 do
        if x >= number_format_table[i][1] then
            local prefix = string.format("%.2f", x/number_format_table[i][1])
            local suffix = number_format_table[i][2]
            
            formattedNum = prefix..suffix
            
            return formattedNum
        end
    end
    
    return string.format("%.2f", x)
end

return NumberFormat