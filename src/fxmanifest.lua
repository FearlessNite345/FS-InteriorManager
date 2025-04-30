fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FearlessStudios'
description 'FS-EntitySetLoader by FearlessStudios'
version '1.0.0'

escrow_ignore 'config.lua'

client_script 'dist/client/**/*.lua'
server_script 'dist/server/**/*.lua'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

dependencies {
    'FS-Lib',
    'ox_lib'
}
