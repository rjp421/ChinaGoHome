local cgh_gui = gui.get_tab("ChinaGoHome")

-- DISCLAIMER
-- This script is only used to combat the invasion of Chinese in GTAOnline in Western regions,
-- who are mostly toxic modders, break sessions, etc, from my experience over the years.
-- Apologies to those who are not.

-- thanks to the contributors at YimMenu Extras Addon LUA Script for some of this as a base
local addonVersion = "0.0.3"


-- Function to create a text element
function createText(tab, text)
    tab:add_text(text)
end

function toolTip(tab, text, seperate)
    local seperate = seperate or false
    if tab == "" then
        if seperate then --waiting approval
            ImGui.SameLine()
            ImGui.TextDisabled("(?)")
        end
        if ImGui.IsItemHovered() then
            ImGui.BeginTooltip()
      ImGui.Text(text)
            ImGui.EndTooltip()
        end
    else
        tab:add_imgui(function()
            if seperate then
                ImGui.SameLine()
                ImGui.TextDisabled("(?)")
            end
            if ImGui.IsItemHovered() then
                ImGui.BeginTooltip()
                ImGui.Text(text)
                ImGui.EndTooltip()
            end
        end)
    end
end

function newText(tab, text, size)
    local size = size or 1
    tab:add_imgui(function()
        ImGui.SetWindowFontScale(size)
        ImGui.Text(text)
        ImGui.SetWindowFontScale(1)
    end)
end

function sleep(seconds)
    local start = os.clock()
    while os.clock() - start < seconds do
        -- Yield the CPU to avoid high CPU usage during the delay
        coroutine.yield()
    end
end

function delete_entity(ent) --discord@rostal315
    if ENTITY.DOES_ENTITY_EXIST(ent) then
        ENTITY.DETACH_ENTITY(ent, true, true)
        ENTITY.SET_ENTITY_VISIBLE(ent, false, false)
        NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(ent, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, 0.0, 0.0, -1000.0, false, false, false)
        ENTITY.SET_ENTITY_COLLISION(ent, false, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ent)
        ENTITY.DELETE_ENTITY(ent)
    end
end

function fcrash(script, pid)
    script.run_in_fiber(function(fragcrash)
        fragcrash:yield()
        if PLAYER.GET_PLAYER_PED(pid) == PLAYER.PLAYER_PED_ID() then --避免目标离开战局后作用于自己
            showDebugMsg('gui',"The attack has stopped","The target has been detected to have left or the target is you")
            return
        end
        local fraghash = joaat("prop_fragtest_cnst_04")
        STREAMING.REQUEST_MODEL(fraghash)
        local TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local crashstaff1 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff1, 1, false)
        local crashstaff2 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff2, 1, false)
        local crashstaff3 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff3, 1, false)
        local crashstaff4 = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(crashstaff4, 1, false)
        for i = 0, 100 do
            fragcrash:yield()
            if PLAYER.GET_PLAYER_PED(pid) == PLAYER.PLAYER_PED_ID() then --避免目标离开战局后作用于自己
                showDebugMsg('gui',"The attack has stopped","The target has been detected to have left or the target is you")
                return
            end
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(crashstaff4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            fragcrash:sleep(10)
            delete_entity(crashstaff1)
            delete_entity(crashstaff2)
            delete_entity(crashstaff3)
            delete_entity(crashstaff4)
        end
    end)
    script.run_in_fiber(function(fragcrash2)
        fragcrash2:yield()
        local TargetCrds = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local fraghash = joaat("prop_fragtest_cnst_04")
        STREAMING.REQUEST_MODEL(fraghash)
        for i=1,10 do
            fragcrash2:yield()
            if PLAYER.GET_PLAYER_PED(pid) == PLAYER.PLAYER_PED_ID() then --避免目标离开战局后作用于自己
                showDebugMsg('gui',"The attack has stopped","The target has been detected to have left or the target is you")
                return
            end
            local object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            delete_entity(object)
            object = OBJECT.CREATE_OBJECT(fraghash, TargetCrds.x, TargetCrds.y, TargetCrds.z, true, false, false)
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            fragcrash2:sleep(100)
            delete_entity(object)
        end
        sleep(100)
    end)
end

newText(cgh_gui, "Welcome to CGH v"..addonVersion, 1)
createText(cgh_gui, "China Go Home!")
cgh_gui:add_separator()


local cghEnabled = cgh_gui:add_checkbox("CGH Enabled")
toolTip(cgh_gui, "Detect chinese in the session")
cghEnabled:set_enabled(true)
cgh_gui:add_sameline()
local cghAnnounce = cgh_gui:add_checkbox("Announce")
toolTip(cgh_gui, "Announce kicks to the session")
cgh_gui:add_sameline()
local cghLoop = cgh_gui:add_checkbox("Loop")
toolTip(cgh_gui, "Loop detection. May cause lag spikes. [WIP]")

cgh_gui:add_separator()
local cghFlag = cgh_gui:add_checkbox("Flag")
toolTip(cgh_gui, "Flag all chinese the session as a modder May cause lag spikes. [WIP]")
cgh_gui:add_sameline()
local cghKick = cgh_gui:add_checkbox("Kick")
toolTip(cgh_gui, "Kick when detected, requires Host. [WIP]")
cgh_gui:add_sameline()
local cghCrash = cgh_gui:add_checkbox("Crash")
toolTip(cgh_gui, "Crash when detected. Disabled when Looped. May lag/crash you if there are a lot of targets. [WIP]")

cgh_gui:add_separator()
local cghSpamBlock = cgh_gui:add_checkbox("Block Bots")
toolTip(cgh_gui, "Block most known spam/crash bots, may hit a few innocents. [WIP]")
cghSpamBlock:set_enabled(true)
cgh_gui:add_sameline()
local cghSpamAnnounce = cgh_gui:add_checkbox("Announce Bots")
toolTip(cgh_gui, "Announce blocked bots to the session")


cgh_gui:add_separator()
local cghDebug = cgh_gui:add_checkbox("Debug")
toolTip(cgh_gui, "Show debug messages")
cghDebug:set_enabled(true)
cgh_gui:add_sameline()
local cghDebugChat = cgh_gui:add_checkbox("Chat")
toolTip(cgh_gui, "Show chat messages in the console")
cghDebugChat:set_enabled(true)

cgh_gui:add_separator()
local checkNumMax = cgh_gui:add_input_int("At a time")
toolTip(cgh_gui, "Maximum number of players to process at a time, to prevent lag/crashes")
checkNumMax:set_value(10)


local cghDetected = {}
local cghKicked = {}
local cghCrashed = {}
local showDebugMessages = cghDebug:is_enabled()


function showDebugMsg(msgType, msg, msg2)
    if not showDebugMessages then return end
    if msgType == 'log' then
        log.info(msg)
    elseif msgType == 'gui' then
        gui.show_message(msg, msg2)
    end
end

function getPlayerIndex(inTable, pid)
    for k,v in pairs(inTable) do
        if pid == v[1] then
            return k
        end
    end
    -- else
    return nil
end


function cghCheck()
    script.run_in_fiber(function(cghCheckNow)
        local localPlayerID = PLAYER.PLAYER_ID()
        local isHost = NETWORK.NETWORK_IS_HOST()
        local numChecked = 0
        
        -- Identify offenders and store their IDs
        for i = 0, 31 do
            if numChecked > checkNumMax:get_value() then return end
            -- sleep until next game frame
            cghCheckNow:yield()
            local pid = i
            ent = PLAYER.GET_PLAYER_PED(pid)
            if ENTITY.DOES_ENTITY_EXIST(ent) and not ENTITY.IS_ENTITY_DEAD(ent, false) then
                local langid = network.get_player_language_id(pid)
                local lang = network.get_player_language_name(pid)
                local detect = network.is_player_flagged_as_modder(pid)
                local reason = network.get_flagged_modder_reason(pid)
                local targetPlayerName = PLAYER.GET_PLAYER_NAME(pid)
                local targetPlayerWallet = network.get_player_wallet(pid)
                local targetPlayerBank = network.get_player_bank(pid)
                local targetPlayerRank = network.get_player_rank(pid)
                local targetPlayerRP = network.get_player_rp(pid)
                local targetPlayerMoney = targetPlayerWallet+targetPlayerBank
                
                --showDebugMsg('log',"[CGH]  targetPlayerName: "..targetPlayerName.."  pid: "..pid..",  langid: "..langid..",  lang: "..lang)
                --showDebugMsg('gui',"ChinaGoHome", "targetPlayerName: "..targetPlayerName.."  PID: "..pid..",  langid: "..langid..",  lang: "..lang)

                if (string.find(lang,"Chinese",1) and targetPlayerMoney > 0) then
                    -- avoid false positives
                    local kickedPlayerIndex = getPlayerIndex(cghKicked, pid)
                    if kickedPlayerIndex and (pid == cghKicked[kickedPlayerIndex][1] and targetPlayerMoney == cghKicked[kickedPlayerIndex][3] and targetPlayerRP == cghKicked[kickedPlayerIndex][4]) then
                        -- false positive found, TODO move this part to separate function and return?
                        --showDebugMsg('log',"[CGH:cghCheck]  lastKicked  MATCH!!  PID: "..cghKicked[kickedPlayerIndex][1].."  name: "..cghKicked[kickedPlayerIndex][2].."  money: "..cghKicked[kickedPlayerIndex][3].."  rp: "..cghKicked[kickedPlayerIndex][4])
                        --showDebugMsg('log',"[CGH:cghCheck]  lastKicked  MATCH!!  PID: "..pid.."  name: "..targetPlayerName.."  money: "..targetPlayerMoney.."  rp="..targetPlayerRP.."  Language: "..lang)
                    else
                        showDebugMsg('log',"[CGH:cghCheck]  CHINA DETECTED:  ["..targetPlayerName.."]  pid: "..pid..",  langid: "..langid..",  lang: "..lang.."  wallet="..targetPlayerWallet.."  bank="..targetPlayerBank.."  targetPlayerMoney: "..targetPlayerMoney.."  rank="..targetPlayerRank.."  rp="..targetPlayerRP)
                        showDebugMsg('gui',"ChinaGoHome:cghCheck", "CHINA DETECTED:  ["..targetPlayerName.."]  PID:"..pid.. "  lang: "..lang.."  wallet="..targetPlayerWallet.."  bank="..targetPlayerBank.."  targetPlayerMoney: "..targetPlayerMoney.."  rank="..targetPlayerRank.."  rp="..targetPlayerRP)
                        -- add to the array if not already there
                        if not getPlayerIndex(cghDetected, pid) then
                            table.insert(cghDetected, {pid,targetPlayerName})
                        end
                        if cghEnabled:is_enabled() and cghFlag:is_enabled() then 
                            if not detect or (detect and not string.find(reason,"ChinaGoHome",1)) then
                                network.flag_player_as_modder(pid, infraction.CUSTOM_REASON, "[ChinaGoHome]  "..lang)
                                reason = network.get_flagged_modder_reason(pid)
                                log.warning("[CGH:cghCheck]  FLAGGING:  ["..targetPlayerName.."]  pid: "..pid..",  langid: "..langid..",  lang: "..lang.."  reason: "..reason)
                            end
                        end
                        if cghEnabled:is_enabled() and cghCrash:is_enabled() and not cghLoop:is_enabled() then
                            log.warning("[CGH:cghCheck]  CRASHING:  ["..targetPlayerName.."]  pid: "..pid..",  langid: "..langid..",  lang: "..lang.."  reason: "..reason)
                            fcrash(script, pid)
                        end
                        if cghEnabled:is_enabled() and cghKick:is_enabled() then 
                            reason = "[ChinaGoHome]  "..lang
                            log.warning("[CGH:cghCheck]  KICKING:  ["..targetPlayerName.."]  pid: "..pid..",  langid: "..langid..",  lang: "..lang.."  reason: "..reason)
                            gui.show_warning("ChinaGoHome:cghCheck", "Kicking!  ["..targetPlayerName.."]  PID: "..pid..",  langid: "..langid..",  lang: "..lang)
                            if isHost then
                                command.call("hostkick", {pid})
                            else
                                command.call("smartkick", {pid})
                            end
                            if cghAnnounce:is_enabled() then
                                network.send_chat_message("Auto-Kicked ["..targetPlayerName.."] Reason: "..reason, false)
                            end
                            -- cleanup array, move to PlayerLeft?
                            for k,v in pairs(cghDetected) do
                                if v[2] == targetPlayerName then
                                    table.remove(cghDetected,k)
                                end
                            end
                            -- TEST prevent duplicate PIDs in cghKicked
                            if kickedPlayerIndex then
                                table.remove(cghKicked,kickedPlayerIndex)
                            end
                            table.insert(cghKicked, {pid,targetPlayerName,targetPlayerMoney,targetPlayerRP})
                        end
                    end
                    numChecked = numChecked+1
                end
            end
        end
    end)
end


cgh_gui:add_button("Check now!", function()
    if cghEnabled:is_enabled() then 
        showDebugMsg('log',"[CGH]  Checking!")
        showDebugMsg('gui',"CGH", "Checking!")
        cghCheck()
    end
end)

cgh_gui:add_sameline()
cgh_gui:add_button("Print Array", function()
    showDebugMsg('log',"[ChinaGoHome:PrintArray]  #cghDetected: "..#cghDetected.."\t#cghKicked: "..#cghKicked)
    for k, v in pairs(cghDetected) do
        --showDebugMsg('log',"[ChinaGoHome:PrintArray]  [cghDetected]  k="..tostring(k).."\tv="..tostring(v))
        showDebugMsg('log',"[ChinaGoHome:PrintArray]  [cghDetected]  k="..tostring(k).."  pid="..v[1].."  name="..v[2]--[[.."  wallet="..targetPlayerWallet.."  bank="..targetPlayerBank.."  targetPlayerMoney: "..targetPlayerMoney.."  rank="..targetPlayerRank.."  rp="..network.get_player_rp(v[1])]])
    end
    for k, v in pairs(cghKicked) do
        --showDebugMsg('log',"[ChinaGoHome:PrintArray]  [cghKicked]  k="..tostring(k).."\tv="..tostring(v))
        showDebugMsg('log',"[ChinaGoHome:PrintArray]  [cghKicked]  k="..tostring(k).."  pid="..v[1].."  name="..v[2].."  money: "..v[3].."  rp: "..v[4])
    end
end)


script.register_looped("cghEnabled", function(script)
    -- sleep until next game frame
    script:yield()
    if cghEnabled:is_enabled() and cghLoop:is_enabled() then 
        cghCheck()
    end
end) 

event.register_handler(menu_event.PlayerJoin, function(playerName, pid)
    showDebugMsg('log',"[ChinaGoHome:PlayerJoin]  pid: "..pid.."  name: "..playerName.."  money: "..network.get_player_wallet(pid)+network.get_player_bank(pid).."  rp: "..network.get_player_rp(pid).."  lang: "..network.get_player_language_name(pid))
    -- kick if name matches known trouble makers
    if cghSpamBlock:is_enabled() then
        --if string.find(playerName,"xiao-",1) or string.find(playerName,"-WX-GTA") or string.find(playerName,"x-gta") then
        if string.sub(playerName,1,6) == "rc1030" or string.sub(playerName,1,5) == "xiao-" or string.sub(playerName,1,4) == "TXDW" or string.sub(string.lower(playerName),5,8) == "-gta" or string.sub(string.lower(playerName),6,12) == "-wx-gta" then
            if NETWORK.NETWORK_IS_HOST() then
                showDebugMsg('log',"[ChinaGoHome:PlayerJoin]  HOST KICKING  "..playerName.."  pid: "..pid)
                if cghSpamAnnounce:is_enabled() then
                    network.send_chat_message("[ChinaGoHome] Blocked "..playerName.." from joining")
                end
                command.call("hostkick", {pid})
            else
                -- TODO
                --showDebugMsg('log',"[ChinaGoHome:PlayerJoin]  SMART KICKING  "..playerName.."  pid: "..pid)
                --command.call("smartkick", {pid})
            end
        end
    end
end)

event.register_handler(menu_event.PlayerLeave, function(playerName)
    showDebugMsg('log',"[ChinaGoHome:PlayerLeave]  name: "..playerName)
    --showDebugMsg('log',"Player "..playerName.." left")
    for k,v in pairs(cghDetected) do
        if v[2] == playerName then
            table.remove(cghDetected,k)
        end
    end
end)

event.register_handler(menu_event.ChatMessageReceived, function(pid, msg)
    --log.info(player_id)
    --log.info(chat_message)
    if showDebugMessages and cghDebugChat:is_enabled() then
        showDebugMsg('log',"[ChatMessageReceived]  "..PLAYER.GET_PLAYER_NAME(pid)..":  "..msg)
    end
end)

event.register_handler(menu_event.PlayerMgrInit, function()
    showDebugMsg('log',"Player manager inited, we just joined a session.")
    cghLoop:set_enabled(false)
    cghDetected = 'nil'
    cghDetected = {}
    cghKicked = 'nil'
    cghKicked = {}
end)

event.register_handler(menu_event.PlayerMgrShutdown, function()
    showDebugMsg('log',"Player manager inited, we just left a session.")
    cghLoop:set_enabled(false)
    cghDetected = 'nil'
    cghDetected = {}
    cghKicked = 'nil'
    cghKicked = {}
end)