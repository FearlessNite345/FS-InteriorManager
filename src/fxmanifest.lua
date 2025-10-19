fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FearlessStudios'
description 'FS-InteriorManager by FearlessStudios'
version '1.4.0'

escrow_ignore 'config.lua'

client_script 'dist/client/**/*.lua'
server_script 'dist/server/**/*.lua'

files {
    'nui/**/*'
}

ui_page 'nui/index.html'

shared_scripts {
    'config.lua'
}

dependencies {
    'FS-Lib'
}
