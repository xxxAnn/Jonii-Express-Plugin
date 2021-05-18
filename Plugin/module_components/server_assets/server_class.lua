-- Created by user

-- Date: 99/99/9999

-- Server Module

--[[
    Framework API reference:

    Roblox Services:

    self.players
    self.server_script_service
    self.replicated_storage
    self.physics_service
    self.debris

    Container References:

    self.services - reference to the "services" container
    self.classes - reference to the "classes" container
    self.modules - reference to the "modules" container
    self.shared_modules - reference to the "shared_modules" container
    
    Methods:

    self:print_table(table_params)
    self:signal_client(table_params)
    self:signal_all_clients(table_params)
    self:register_event(table_params)
    self:register_function(table_params)
    self:create_instance(table_params)
    self:update_instance(table_params)
    self:format_number(number)
--]]

return require(script.Parent.Parent.class)()