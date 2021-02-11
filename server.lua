--------------------------------------------------------------------------------
------------------------------------------------- Print in console -------------
--------------------------------------------------------------------------------

    local s0kin = [[^7
           _   _ _______ _____   __      _______  _   _ 
     /\   | \ | |__   __|_   _|  \ \    / /  __ \| \ | |
    /  \  |  \| |  | |    | |_____\ \  / /| |__) |  \| |
   / /\ \ | . ` |  | |    | |______\ \/ / |  ___/| . ` |
  / ____ \| |\  |  | |   _| |_      \  /  | |    | |\  |
 /_/    \_\_| \_|  |_|  |_____|      \/   |_|    |_| \_| 
            ]]
print(s0kin)

--------------------------------------------------------------------------------
------------------------------------------------- Event Handlers ---------------
--------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)

    local player = source
    local name, setKickReason, deferrals = name, setKickReason, deferrals;
    local ipIdentifier -- adress ip 
    local nick = GetPlayerName(source) -- nick name steam 
    local steam = GetPlayerIdentifier(source, 0) -- steam hex
    local identifiers = GetPlayerIdentifiers(player) -- adress ip 
    local discord = 'Not found' -- [Not found] = discord is no connected to fivem

    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("Hi "..nick.." Your IP Address is being checked.", name)) -- reason for connect to server
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            ipIdentifier = v:sub(4)
        end
        if string.find(v, "discord") then
            discord = v
        end
    end
    Wait(0)    
    if not ipIdentifier then
        deferrals.done("We could not find your IP Address.")
    else
        PerformHttpRequest("http://ip-api.com/json/" .. ipIdentifier .. "?fields=proxy", function(err, text, headers) -- checking ip 
            if tonumber(err) == 200 then
                local tbl = json.decode(text)
                if tbl["proxy"] == false then
                    deferrals.done()
                else
                  
sendlogstodiscord(nick, steam,ipIdentifier,discord )
                    deferrals.done("\n Are using VPN , Please disable and try again \n Username: ".. nick.." \n IP:" ..ipIdentifier.."\n") -- reason if you use a vpn
                end
            else
                deferrals.done("There was an error in the API.")
            end
        end)
    end
end)
--------------------------------------------------------------------------------
-------------------------------------------------  Functions  ------------------
--------------------------------------------------------------------------------
function sendlogstodiscord(source, steam, ip,discord) 

local sokin_webhook = "https://discord.com/api/webhooks/803941480284422144/N9MDciTz3N512kmZyfJ7zznQ9TKLOjgNj9cCKq80eQ152HBnlZazkoXSWhNNmVKNS94_" -- webhook for logs 

     local sokin_time = os.date("%c | dev-sokin.xyz") -- footer : https://imgur.com/RnjIvbA

            local sokin_embed = {
        {
            ["color"] = 23295, -- color embed
            ["title"] = "ANTI-VPN", -- titile webhook
            ["description"] = "\n **[Username]:** `"..source.."` \n **[Steam]:**` " ..steam.."` \n **[IP]:**` " ..ip.."`\n **[Discord]:**`"..discord.."`\n",
            ["footer"] = {
                ["text"] = sokin_time
            },
        }
    }
       PerformHttpRequest(sokin_webhook, function(err, text, headers) end, 'POST', json.encode({username = 'anti-vpn', embeds = sokin_embed}), { ['Content-Type'] = 'application/json' })
end

--------------------------------------------------------------------------------
---------- [PL] Jesli to bierzesz to prosze nie pastuj tego :) -----------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---------------- [CREDITS] Sokin#9999 | discord.gg/APKbW8SwQG  -----------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---------- [ENG] If you re using it please dont paste this script :) -----------
--------------------------------------------------------------------------------
