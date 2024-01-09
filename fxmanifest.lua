-- Script Info
name 'flight-animals'
version '1.0.0'
description 'Wildlife script'
author 'DevTheBully'
repository 'https://github.com/DevTheBully/flight-animals'

-- Start the script
files { 'peds.meta' }
server_scripts { 'server/*.lua' }
shared_scripts { 'config/*.lua', '@ox_lib/init.lua' }
client_scripts { 'client/*.lua' }

data_file 'PED_METADATA_FILE' 'peds.meta'

-- manifest things
fx_version 'cerulean'
lua54 'yes'
game 'gta5'