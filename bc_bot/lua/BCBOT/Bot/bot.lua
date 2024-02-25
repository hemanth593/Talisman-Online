--[[ Reading game memory --]]

local bot = {}
local CLIENT = 0x00400000
function bot.charName()
    local CLIENT = 0x00400000
    local CHAR_NAME= readmem(0x00400000 +0x00C15980, "d")
    local name = readmem(CHAR_NAME + 0x3C4, "s", 30)

    if string.match(name, "^[%w]+$") then return name
    else
        return readmem(readmem(CHAR_NAME + 0x3C4, "d") + 0x0, "s", 30)
    end
end
function bot.Inventory()
    return readmem(BAG_OPEN_POINTER + 0x240, "d") == 903 and true or false
end

function bot.CHAR_HP()
    return readmem (0x00400000 +0x00C15980, "d")
end
function bot.get_current_HP()
    return readmem(bot.CHAR_HP() + 0x320, "d")
end
function bot.get_percent_HP()
    return readmem(bot.CHAR_HP() + 0x3EC, "b")
end
function bot.get_pethp_skillpoints()
    return readmem(bot.CHAR_HP() + 0x3E8, "d")
end
function bot.get_basic_max_HP()
    return readmem(bot.CHAR_HP() + 0x3E4, "d")
end

function bot.TOTAL_CHAR_MAX_HP()
    local maxhp = math.floor((((bot.get_percent_HP() - 100) / 100) * (bot.get_basic_max_HP() + bot.get_pethp_skillpoints())) + (bot.get_basic_max_HP() + bot.get_pethp_skillpoints()))
     return maxhp
end

function bot.CharHPpercent()
	return ((bot.get_current_HP()/bot.TOTAL_CHAR_MAX_HP())*100)
end

function bot.targetHP()
    local targetHPPointers = {0x18, 0x16C, 0x0, 0xC, 0x1F8, 0x448, 0xC00}
    local targetHP = readmem(CLIENT + 0x00EC2D28, "d")
    for i = 1, #targetHPPointers
    do
        targetHP = readmem(targetHP + targetHPPointers[i], "d")
    end

    return  targetHP
end

function bot.targetHPpercent()
        local max = 597
        local min = 460
        local x =  bot.targetHP()
        local c = (100 * (x - min)/137)
        if c < 0 then
            return 0
        else
            return c
        end
end
function bot.getLocation()
    local locationPointers = {0x18, 0x2304, 0xC, 0x1F4, 0x54, 0x54}
    local Location = readmem(CLIENT + 0x00EC2D28, "d")
    for i = 1, #locationPointers
    do
    Location = readmem(Location + locationPointers[i], "d")
    end
    local location = readmem(Location + 0x0, "s", 51)
    local position = regexp(location, [[\[]])
    return string.sub(location, 0, position - 2)
end
function bot.getLocation_cords(p)
    local locationPointers = {0x18, 0x2304, 0xC, 0x1F4, 0x54, 0x54}
    local Location = readmem(CLIENT + 0x00EC2D28, "d")
    for i = 1, #locationPointers
    do
    Location = readmem(Location + locationPointers[i], "d")
    end
    local location = readmem(Location + 0x0, "s", 51)
    local pattern = "%[(-?%d+),(-?%d+)]"
    local a, b = string.match(location, pattern)
    m = p
    if m == 0
        then return a
    end
    if m == 1 then
        return b
    end
end


function bot.getCharLevel()
    return readmem(readmem(0x00400000 +0x00C15980, "d") + 0x32C, "w")
end
function bot.Battle_Status()
    return readmem(readmem(0x00400000 +0x00C15980, "d") + 0x7BC, "b")
end
function bot.Target_Selected()
    local targetSelectedPointers = {0xD0, 0x794, 0x0, 0x24, 0xAC, 0x20}
    local Target_Selected = readmem(CLIENT + 0x00EB5010, "d")
    for i = 1, #targetSelectedPointers
    do
        Target_Selected = readmem(Target_Selected + targetSelectedPointers[i], "d")
    end

    return  readmem(Target_Selected + 0x1AC, "d")
end

function bot.Target_Name()
    local targetNamePointers = {0x18, 0xB1C, 0x0, 0xC, 0xD9C}
    local Target_Name = readmem(CLIENT + 0x012C2D28, "d")
    for i = 1, #targetNamePointers
    do
        Target_Name = readmem(Target_Name + targetNamePointers[i], "d")
    end

    local name = readmem(Target_Name + 0x9AC, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else
        return readmem(readmem(Target_Name + 0x9AC, "d") + 0x0, "s", 51)
    end
end
function bot.Char_Sit()
    return readmem(CLIENT + 0xC4D8B8, "d")
end
function bot.mount_status()
    mount = readmem((readmem(0x01139C0C, "d")) + 0x8B0, "d")
    if mount > 0 then
        return 1
    else
        return 0
    end
end

--Mana
function bot.Mana()
    return readmem(0x00400000 +0x00C15980, "d")
end
-- Current Mana
function bot.Current_Mana()
    return readmem(bot.Mana() + 0x324, "d")
end
-- Mana buff
function bot.Mana_Buff()
    return readmem(bot.Mana() + 0x2B8, "d")
end
-- Max mana
function bot.Max_Mana()
    return readmem(bot.Mana()  + 0x2B4, "d") + bot.Mana_Buff()
end

--ManaPercent
function bot.Mana_Percent()
   return  ((bot.Current_Mana()/ bot.Max_Mana())*100)
end
--HPPercent
function bot.HP_Percent()
   return  ((bot.get_current_HP()/ bot.TOTAL_CHAR_MAX_HP())*100)
end

local kill = 0

function bot.killed(x)

               kill = kill + x
               log("kill_count :",kill)
end
function bot.Moke_Boss()
    Boss_Name = "Mo Ke's Follower Leader"
     if  bot.Target_Name() == Boss_Name and targetHPpercent() > 0 then
        while bot.Target_Name() == Boss_Name and targetHPpercent() > 0 do
            send ("123123")
         end

     else
         while bot.Target_Name() == Boss_Name and targetHPpercent() == 0 do
                     log(killed(1))
                     wait ("2s")
                     send ("Tab")
                      wait ("2s")
         end
         while (not(bot.Target_Name() == Boss_Name)) do
            send ("Tab")
         end
     end
end
function bot.getConfirmBox()
    return readmem(CLIENT + 0xEC2DA4, "d")
end
function bot.deadbox()
    local dead_box = readmem(CLIENT + 0xC2E894, "d")
    if dead_box > 1 then
        return 0
    end
    if dead_box <= 1 then
        return 1
    end
end
function bot.dead()
   if bot.get_current_HP() < 1 and bot.Battle_Status() == 0 and bot.deadbox() == 1 then
       return 1
   else
       return 0
   end
end

function bot.auto_attack_on_rev()
    if bot.dead() == 1 and bot.getConfirmBox() == 1 then
	wait(300)
        left(442, 334)
	wait(300)
    else
        if  bot.targetHPpercent() > 0 and bot.Target_Selected() == 1 and bot.dead() == 0 then
		wait(100)
            	send (attackskills)
		wait(100)
        end
    end
end
function bot.pcp_suwan()
    if bot.dead() == 1  then
	wait(900)
        left(508, 467)
	wait(900)
    else
        if  bot.targetHPpercent() > 0 and bot.Target_Selected() == 1 and bot.dead() == 0 then
		wait(100)
            	send (attackskills)
		wait(100)
        end
    end
end
function bot.KILLBOSS()

    --log(Boss_Name)
    while bot.Target_Name() == Boss_Name and bot.targetHPpercent() > 0 do
	wait(300)
        send (attackkeys)
        wait(100)
    end
    wait(100)
    send ("Tab")
    wait(100)
end

function bot.Dialogue()
    local dialogOffsets = {0x70, 0x56C, 0xC, 0x4, 0x1F4, 0x54 , 0x720}
    local DIALOG_POINTER = readmem(CLIENT + 0x00D6FCC0, "d")
    for i = 1, #dialogOffsets
    do
        DIALOG_POINTER = readmem(DIALOG_POINTER + dialogOffsets[i], "d")
    end
    if DIALOG_POINTER == 16775 then
        return 1
    else
        if DIALOG_POINTER == 16774 then
            return 0
        else
            return 2
        end
    end
end
function bot.SellDialogue()
    local dialogOffsets = {0x18, 0x324, 0xC, 0x450, 0x47C, 0x1F8 , 0x240}
    local DIALOG_POINTER = readmem(CLIENT + 0x00EC2D28, "d")
    for i = 1, #dialogOffsets
    do
        DIALOG_POINTER = readmem(DIALOG_POINTER + dialogOffsets[i], "d")
    end
    if DIALOG_POINTER == 16775 then
        return 1
    else
        if DIALOG_POINTER == 16774 then
            return 0
        else
            return 2
        end
    end
end

function bot.friendlist()
	local friendListOffsets = {0x18, 0x744, 0x4, 0xC, 0x4150}
	local FRIEND_LIST_POINTER = readmem(0x012C2D28, "d")
	for i = 1, #friendListOffsets
	do
    	FRIEND_LIST_POINTER = 
        	readmem(FRIEND_LIST_POINTER + friendListOffsets[i], "d")
	end
	if FRIEND_LIST_POINTER == 16775 then
        	return 1
    	else
        	if FRIEND_LIST_POINTER == 16774 then
            		return 0
        	else
            		return 2
        	end
    	end
end
function bot.Surroundings()
    local dialogOffsets = {0x18, 0x61C, 0x0, 0xC, 0x4A8, 0x80 , 0xBD0}
    local DIALOG_POINTER = readmem(CLIENT + 0x00EC2D28, "d")
    for i = 1, #dialogOffsets
    do
        DIALOG_POINTER = readmem(DIALOG_POINTER + dialogOffsets[i], "d")
    end
    if DIALOG_POINTER == 16775 then
        return 1
    else
        if DIALOG_POINTER == 16774 then
            return 0
        else
            return 2
        end
    end
end
function bot.find_image(imagename)
	local handle = workwindow()
	--log(imagename)
	local startX, startY, endX, endY = 1, 1, 1024, 799 -- search coordinates
	--local path = [["stonecitycharmzero.bmp"]] -- path to the image
	--local path = [[image_name]] -- path to the image
	if handle then
	    	--log(workwindow())
    		local arr, a = findimage (startX, startY, endX, endY, {imagename}, workwindow(), 100, -1, 5) -- image search
	    	hint (a) -- search result, hint in the lower right corner
    		if arr then -- if found
	        	--log("Image found at coordinates X= " .. arr[1][1] .. " Y= " .. arr[1][2])
			return 1
         		--right (arr[1][1], arr[1][2], handle) -- clicked, left does not work in all applications
        		-- move (arr[1][1], arr[1][2], handle[1][1]) -- move the cursor over the image (uncomment the line for it to work)
	    	else
        		--log("Image not found")
			return 0
    		end
		else
    		--log("Window not found")
		return 2
	end
end
function bot.count_image(imagename4)
	local handle = workwindow()
	local startX, startY, endX, endY = 1, 1, 1024, 799 -- search coordinates
	if handle then
    		local arr, a = findimage (startX, startY, endX, endY, {imagename4}, workwindow(), 100, -1, 5) -- image search
	    	hint (a) -- search result, hint in the lower right corner
    		if arr then -- if found
	        	log("Found :" .. #arr)

		--	for j=1, #arr do
         		--	left (arr[1][1] +18 , arr[1][2] + 7, handle) -- clicked, left does not work in all applications
			--	log(arr[1][1], arr[1][2], handle)
			--	wait(500)
        			-- move (arr[1][1], arr[1][2], handle[1][1]) -- move the cursor over the image (uncomment the line for it to work)
		--	end
    		end
		else
    		log("Window not found")
	end
end
function bot.clickimage(imagename1)
	local handle = workwindow()
	local startX, startY, endX, endY = 1, 1, 1024, 799 -- search coordinates
	if handle then
    		local arr, a = findimage (startX, startY, endX, endY, {imagename1}, workwindow(), 100, -1, 5) -- image search
	    	hint (a) -- search result, hint in the lower right corner
    		if arr then -- if found
	        	log("Found :" .. #arr)
		--	for j=1, #arr do
         			left (arr[1][1] +18 , arr[1][2] + 7, handle) -- clicked, left does not work in all applications
				log(arr[1][1], arr[1][2], handle)
				wait(500)
        			-- move (arr[1][1], arr[1][2], handle[1][1]) -- move the cursor over the image (uncomment the line for it to work)
		--	end
    		end
		else
    		log("Window not found")
	end
end
function bot.surrounding(name)
    while bot.find_image("surroundings.bmp") == 0 do
        left(978, 58)
        wait(500)
    end
    if  bot.find_image("surroundings.bmp") == 1 then
        left(553, 544)
        wait(40)
        send(name)
        wait(40)
        left(378, 263)
        wait(200)
        left (424, 539 )
        wait(200)
    end
end
function bot.sscgivequest(image2)
        while bot.find_image("mysticbeliever.bmp") == 0 do
            double_right(469, 426 )
        end
       if bot.find_image(image2) == 1 then
           bot.clickimage(image2)
           wait("2s")
           if bot.find_image("quest.bmp") == 1 then
            -- bot.clickimage("accomplish.bmp")
           end
           wait("1s")
       end
end
return bot