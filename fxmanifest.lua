fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'os'
description 'Five M Queue System.'
version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/utils.lua',
    'server/queue.lua',
    'server/events.lua',
}

dependency 'oxmysql'

lua54 'yes'
