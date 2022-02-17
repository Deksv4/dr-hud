fx_version 'cerulean'
games { 'gta5' }

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
}

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    'callback/client.lua',
    'client.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'callback/server.lua',
    'server.lua'
}