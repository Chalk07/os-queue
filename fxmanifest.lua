fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'os'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/utils.lua',
    'server/queue.lua',
    'server/events.lua',
}

lua54 'yes'
