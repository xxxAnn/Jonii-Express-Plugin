-- Made by Jonesloto (UserID: 42161942)
-- Date: 10/29/2020 EST
-- Client Sided Module

--[[
    Framework API reference:

    Roblox Services:

    self.players
    self.starter_player
    self.replicated_storage
    self.debris

    Container References:

    self.controllers - reference to the "controllers" container
    self.classes - reference to the "classes" container
    self.modules - reference to the "modules" container
    self.shared_modules - reference to the "shared_modules" container
    
    Methods:

    self:print_table(table_params)
    self:signal_server(table_params)
    self:retrieve_from_server(table_params)
    self:register_event(table_params)
    self:create_instance(table_params)
    self:update_instance(table_params)
    self:format_number(number)

    Other:

    self.player - reference to the client this script is running on
--]]

local TestController = {}

function TestController:start()
    print(self.controllers.character_controller:get_character())
end

return TestController