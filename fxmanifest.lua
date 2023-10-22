-- Script Info
name         'flight_admin'
version      '1.0.0'
description  'Wildlife script'
author       'DevTheBully'
repository   'https://github.com/DevTheBully/flight-animals'

-- Start the script 
files {'peds.meta'}
server_scripts {'server/*.lua'}
shared_scripts {'config/*.lua', '@ox_lib/init.lua',}
client_scripts {  
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

data_file 'PED_METADATA_FILE' 'peds.meta'

-- manifest things
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'