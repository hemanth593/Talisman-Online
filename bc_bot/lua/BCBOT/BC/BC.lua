--[[ Reading game memory --]]



local BC = {}
local bot = require("Bot/bot")
--local cave = require("BC/InsideBC")

BC.potskey = {
    hp = 6, mana = 7
}
function BC.mount()
	if bot.mount_status() == 0 then
		send(mountkey)
		if bot.mount_status() >= 0 then
			log("Mount up")
		end
		wait("5s")
    	end
end
function BC.unmount()
	if bot.mount_status() >= 0 then
		send(mountkey)
		if bot.mount_status() == 0 then
			log("Mount Down")
		end
		wait("2s")
    	end
end

function BC.findcourage()
	log("Opening Bag")
	send("i")
	log("Opened Bag")
	wait("2s")
	--showwindow()
	log("Finding Courage")
	wait("2s")
	local handle = workwindow()
	local startX, startY, endX, endY = 1, 1, 1024, 799 -- search coordinates
	--local path = [["stonecitycharmzero.bmp"]] -- path to the image
	local path = [["Package.bmp"]] -- path to the image
	if handle then
    		local arr, a = findimage (startX, startY, endX, endY, {path}, workwindow()) -- image search
	    	hint (a) -- search result, hint in the lower right corner
    		if arr then -- if found
	        	log("Package of Courage Badge Found :" .. #arr)
         		right (arr[1][1], arr[1][2], handle) -- clicked, left does not work in all applications
        		-- move (arr[1][1], arr[1][2], handle[1][1]) -- move the cursor over the image (uncomment the line for it to work)
	    	else
        		log("Image not found")
    		end
		else
    		log("Window not found")
	end
	wait(30)
	send("i")
	wait("2s")
end
function BC.BuyStoneCityCharm()
    BC.Viewreset()
    BC.Surroundings()
    left(318, 327) -- click on richman
    log("Moving to Richman to Buy Stonecitycharm")
    wait("20s")
    left(974, 58) -- close surroundings
    wait(300)
        local m = 0
        repeat
        m = m + 1
        local n = 0
        repeat
            n = n + 1
            right(473, 392)
        until n == 8
        wait(2000)
        left(315, 398)
        wait(1000)
        local o = 0
        repeat -- 24
            o = o + 1
            wait(100)
            left(202, 330)
        until o == 2
        wait(500)
        left(180, 713)
        wait(500)
    until m == 10 -- Added missing "until" to close the outer "repeat" block
end

function BC.find_image(imagename)
	local handle = workwindow()
	local startX, startY, endX, endY = 1, 1, 1024, 799 -- search coordinates
	--local path = [["stonecitycharmzero.bmp"]] -- path to the image
	local path = [[image_name]] -- path to the image
	if handle then
	    	log(workwindow())
    		local arr, a = findimage (startX, startY, endX, endY, {path}, workwindow()) -- image search
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
function BC.verifystonecharm()
	local verifycharm = BC.find_image("stonecitycharmzero.bmp")
	if verifycharm == 0 then
		log("StoneCityCharm Unavailable")
		BC.BuyStoneCityCharm()
		BC.GotoStoneCity()
	end
	if verifycharm == 1 then
		log("StoneCityCharm Available")
	end
	if verifycharm == 2 then
		log("Window Not Selected")
	end		
end
function BC.clickCoordinates()
	log("Opening Bag")
	send("i")
	log("Opened Bag")
	wait("2s")
   	local coordinates = {
        {422, 410}, {463, 409}, {494, 411},
        {524, 407}, {562, 408}, {596, 411},
        {421, 443}, {454, 443}, {489, 447},
        {523, 444}, {560, 446}, {595, 447},
        {424, 480}, {457, 478}, {494, 478},
        {528, 482}, {558, 481}, {597, 480},
        {422, 516}, {455, 514}, {489, 516},
        {523, 518}, {562, 516}, {596, 515}
	}
	for _, coord in ipairs(coordinates) do
        	right(coord[1], coord[2])
        	wait(900)
	end
	wait("2s")
	log("Closing Bag")
	send("i")
	log("Closed Bag")
	wait("2s")
	BC.EquipCorrectGears()
end
function BC.EquipCorrectGears()
	wait("2s")
   	local coordinates = {
	{ 1000, 207 }, { 1000, 207 },
	{ 1000, 243 }, { 996, 279 },
	{ 998, 308 }, { 1000, 350 },
	{ 997, 388 }, { 955, 205 }
	}
	for _, coord in ipairs(coordinates) do
        	right(coord[1], coord[2])
        	wait("1s")
	end
	wait("2s")
	
end
function BC.Addteam()
 --   if bot.friendlist() == 0 then
         wait("1s")
         send("f")
         wait("1s")
   -- end
    wait("1s")
    left (867, 58 ) -- click on Foe list
    wait("1s")
   -- if bot.friendlist() == 1 then
        wait("1s")
        --left(700, 189 )--blocklist
	left(626, 187 ) -- Foe list
        wait("1s")
        --right(577, 253 )--blocklist
	right(585, 273 )-- Foe list
        wait("2s")
      --  left(619, 324 )--blocklist
	left(597, 344 )-- Foe list
        wait("5s")
        start_script (startreseterscritpt)
	log("Initiated Reseter Script")
        wait("1s")
        send("f")
        wait("1s")
   -- end
end

function Healthcheck()
	wait(300)
	send("F1")
	wait(300)
	while bot.CharHPpercent() < 95 do
		BC.unmount()
		if Fairy == "YES" then 
			wait(300)
			send(healskill)
			log("Waiting to heal till 100% and  Current HP in %  :", bot.CharHPpercent())
			wait(300)
		else
		
			wait(300)
			send(BC.potskey.hp) wait(500)
			send(healskill) wait(500)
			log("Waiting to heal till 100% and  Current HP in %  :", bot.CharHPpercent())
			wait("16s")
			
		end
	end
	log("health is full" )
	BC.mount()
end

function convert_epoch_to_normal()
	epoch_time = os.time()
	return os.date("%Y-%m-%d %H:%M:%S", epoch)
end

function calculate_time_difference(epoch1, epoch2)
	return epoch2 - epoch1
end
function convertSecondsToTime(seconds)
	local hours = math.floor(seconds/3600)
    	local minutes = math.floor((seconds % 3600) / 60)
    	local remainingseconds = seconds % 60 
    	log ("Time Take to complete this BC run in minutes :",hours,"h",minutes,"m",remainingseconds,"s")
end
function BC.Leaveteam()
    	wait("1s")
   	right (39, 41 )
    	wait("1s")
   	left (96, 91 )
    	wait("1s")
end
function BC.StoneCity()
    	if bot.getLocation() == "Stone City" and bot.getLocation_cords(0) == "178" and bot.getLocation_cords(1) == "-515"  then
        	return 1
    	else
        	return 0
    	end
end
function BC.Invisiblemode()
	BC.Viewreset()
 	wait(300)
    	send ("@")
 	wait(300)
	send ("F12")
 	wait(300)
	log("Resetting screen and zoom")
	send ("F12")
 	wait(300)
	send_down ("F12", 1000) -- hold down the 'q' key for 3 seconds (1 sec = 1000 ms.)
	send_down ("@", 1000)
	send_up("F12",1000)
	send_up("@",1000)
	send_down ("{down}", 3000)
	send_up("{down}")
 	wait(300)
    	send ("@")
 	wait(300)
end
function BC.autobuff()
	wait(300)
	send("F1")
	wait(300)
	send(buff1)
	wait(1000)
	send(buff2)
	wait(1000)
end
function BC.GotoStoneCity()
	if bot.mount_status() == 1 then
		wait(300)
		send(mountkey)
		wait("2s")
		log("Mount Down to go to StoneCity")
    	end
	BC.attackBlazeSkullMarshal()
	BC.autobuff()
    	while not (bot.getLocation() == "Stone City" and bot.getLocation_cords(0) == "178" and bot.getLocation_cords(1) == "-515") do
        	wait(300)
		send(stonecitycharm)
        	wait(5000)
	end
end
function BC.VastMountain()
    	if bot.getLocation() == "White Bear Village" and bot.getLocation_cords(0) == "847" and bot.getLocation_cords(1) == "-606"  then
        	return 1
    	else
        	return 0
    	end
end
function BC.Ghostdinwoods()
    	if bot.getLocation() == "Ghost Din Woods" and bot.getLocation_cords(0) == "1372" and bot.getLocation_cords(1) == "-417"  then
        	return 1
    	else
        	return 0
    	end
end
function BC.Viewreset()
   	wait(1000)
   	left (866, 61 )     --view reset
   	wait(1000)
end
function BC.Surroundings()
   	wait(1000)
   	left (975, 58 )     --Surroundings
   	wait(1000)
   	left (560, 541 )
  	wait(1000)
end

function BC.attack(attackskills)
	if bot.mount_status() == 1 then
		wait(300)
		send(mountkey)
		wait("2s")
    	end
	while bot.Battle_Status() == 1 do
		send("Tab")
		wait(100)
		send(attackskills)
	end
	wait("2s")
end
function BC.MovingtoAltar()
	local coordinatesToCheck = {
		{ "423", "53", 0, 0 },
		{ "397", "76", 876, 78 },
	        { "369", "78", 873, 111 },
	        { "357", "107", 899, 68 },
	        { "333", "133", 880, 73 },
	        { "326", "164", 908, 64 },
	        { "302", "180", 880, 89 },
	        { "271", "168", 868, 134 },
	        { "237", "158", 864, 132 },
	        { "221", "163", 893, 107 },
	        { "184", "165", 859, 112 },
	        { "150", "163", 864, 118 },
	        { "125", "145", 879, 145 },
	        { "108", "120", 891, 156 },
	        { "107", "95", 917, 156 },
	        { "86", "67", 885, 161 },
	        { "82", "37", 912, 164 },
	        { "109", "20", 963, 142 },
	        { "125", "-2", 945, 152 },
	        { "119", "-35", 909, 169 },
	        { "142", "-52", 957, 143 },
	        { "155", "-66", 940, 138 },
	        { "168", "-91", 941, 155 },
	        { "191", "-108", 956, 143 },
	        { "222", "-97", 970, 97 },
	        { "235", "-65", 941, 63 },
	        { "229", "-47", 909, 85 },
	        { "263", "-45", 974, 112 },
	        { "274", "-71", 937, 158 },
	        { "297", "-84", 957, 136 },
	        { "322", "-64", 960, 83 },
	        { "340", "-39", 949, 75 },
	        { "350", "-5", 935, 59 },
	        { "342", "27", 906, 61 },
	        { "316", "50", 877, 77 },
	        { "280", "48", 861, 118 },
	        { "257", "49", 882, 113 },
	        { "258", "78", 920, 68 },
	        { "221", "79", 859, 113 },
	        { "191", "80", 870, 114 },
	        { "190", "46", 918, 170 },
	        { "205", "45", 943, 116 },
	        { "204", "23", 918, 151 },
	        { "235", "23", 970, 115 },
	        { "246", "42", 937, 84 },
	        { "223", "44", 881, 111 }
	}
	
	if not ( bot.getLocation_cords(0) == "423" and bot.getLocation_cords(1) == "53" ) then
		log("Restarting Script")
		BC.attack(attackskills)
		BC.Start()
	end
	wait(300)
	send(windcontrolling)
	wait(300)
	    for i, coords in ipairs(coordinatesToCheck) do
	        local nextCoords = coordinatesToCheck[i % #coordinatesToCheck + 1]
		local resetclock = os.time()
	        while not (bot.getLocation_cords(0) == nextCoords[1] and bot.getLocation_cords(1) == nextCoords[2])  do
			if (BC.calculate_time_difference(resetclock, os.time()) <= 20) or (bot.getLocation() == "Stone City" ) then
	           		if bot.getLocation_cords(0) == coords[1] and bot.getLocation_cords(1) == coords[2] then
	                		wait(100)
	                		right(nextCoords[3], nextCoords[4])
					--log(coords[1],coords[2],coords[3],coords[4])
					--log(nextCoords[1],nextCoords[2])
	                		wait(200)
	                		break
	            		end
			else
				if bot.mount_status() == 1 then
					send(mountkey)
					log("Mount Down to restart script")
					wait("2s")
    				end
				BC.attack(attackskills)
				BC.start()
			end
	        end
	    end
end
function BC.MovingtoBoss()
	   local coordinatesToCheck1 = {
		{ "187", "-405", 0, 0 },
		{ "185", "-406", 915, 116 },
	        { "149", "-406", 861, 115 },
	        { "113", "-406", 861, 115 },
	        { "77", "-406", 861, 115 },
	        { "77", "-420", 919, 138 },
	        { "60", "-401", 891, 84 },
	        { "83", "-396", 956, 107 },
	        { "70", "-402", 897, 125 }
	}
	
	for i, coords in ipairs(coordinatesToCheck1) do
	        local nextCoords = coordinatesToCheck1[i % #coordinatesToCheck1 + 1]
		local resetclock = os.time()
	        while not (bot.getLocation_cords(0) == nextCoords[1] and bot.getLocation_cords(1) == nextCoords[2])  do
			if (BC.calculate_time_difference(resetclock, os.time()) <= 20) or (bot.getLocation() == "Stone City" ) then
	           		if bot.getLocation_cords(0) == coords[1] and bot.getLocation_cords(1) == coords[2] then
	                		wait(100)
	                		right(nextCoords[3], nextCoords[4])
					--log(coords[1],coords[2],coords[3],coords[4])
					--log(nextCoords[1],nextCoords[2])
	                		wait(200)
	                		break
	            		end
			else
				if bot.mount_status() == 1 then
					send(mountkey)
					log("Mount Down to restart script")
					wait("2s")
    				end
				BC.attack(attackskills)
				wait("5s")
				BC.attackBlazeSkullMarshal()
				BC.GotoStoneCity()
				BC.start()
			end
	        end
	    end
end	
function BC.TeleporttoBoss()
	log("Moving to Boss")
	wait("3s")
	if (not (bot.getLocation() == "Secret Cemetery")) then
	log("AT Secret Altar Tele")
		while bot.getLocation_cords(0) == "223" and bot.getLocation_cords(1) == "44" do
	    		while bot.Dialogue() == 0 do
	        		wait(100)
				right(104, 144)
	        		wait(100)
	        		right(155, 104 )
	        		wait(100)
	       	 		right(156, 116 )
	        		wait(100)
	    		end
	    		if bot.Dialogue() == 1 then
	        		wait(100)
	        		left(299, 330 )
	        		wait(100)
	    		end
	    		wait("3s")
	    		BC.Viewreset()
	    		wait(100)
		end
	else
		BC.attackBlazeSkullMarshal()
		BC.start()
	end	
end

function BC.InsideBC()
	wait("3s")
	Healthcheck()
	wait(500)
	BC.Leaveteam()
	wait("2s")
	BC.mount()
	BC.MovingtoAltar()
	wait("1s")
	BC.TeleporttoBoss()
	wait("1s")
	if WeakChar == "YES" then 
		Healthcheck()
	end
	wait("1s")
	BC.MovingtoBoss()  
	wait("5s")
	BC.attackBlazeSkullMarshal()
	BC.attack(attackskills)
    	wait("5s")
    	BC.attack(attackskills)
    	log("Finished Killing Boss")
  	BC.findcourage()
    	epoch2 = os.time()
	log("Ended BC Time :", BC.convert_epoch_to_normal() )
	log(BC.convertSecondsToTime(BC.calculate_time_difference(epoch1, epoch2)))  
end


function BC.convert_epoch_to_normal()
	epoch_time = os.time()
	return os.date("%Y-%m-%d %H:%M:%S", epoch)
end

function BC.calculate_time_difference(epoch1, epoch2)
	return epoch2 - epoch1
end
function BC.convertSecondsToTime(seconds)
	local hours = math.floor(seconds/3600)
	local minutes = math.floor((seconds % 3600) / 60)
    	local remainingseconds = seconds % 60 
    	log ("Time Taken to complete this BC run :",hours,"h",minutes,"m",remainingseconds,"s")
	wait(300)
end
function  BC.attackBlazeSkullMarshal()
	if Fairy == "NO" then 
	if bot.mount_status() == 1 then
		wait(300)
		send(mountkey)
		wait("2s")
		log("Mount down to attack")
 	end
	clock1= os.time()
	while bot.Battle_Status() == 1 do
		while not (BC.calculate_time_difference(clock1, os.time()) >= 20) do
	    		--log(BC.calculate_time_difference(clock1, os.time()))
            		wait(100)
            		send(aoe)
            		wait(100)
	    		send("Tab")
	    		wait(100)
        	end
        	if bot.targetHPpercent() > 0 then
           		 wait(100)
            		send(attackskills)
            		wait(100)
        	else
            		wait(100)
        		send("Tab")
            		wait(100)
        	end
    	end
	else
		if bot.mount_status() == 1 then
			wait(300)
			send(mountkey)
			wait("2s")
			log("Mount down to attack")
 		end
		clock1= os.time()
		while bot.Battle_Status() == 1 do
			while not (BC.calculate_time_difference(clock1, os.time()) >= 20) do
	    			--log(BC.calculate_time_difference(clock1, os.time()))
            			wait(100)
            			send(aoe)
            			wait(100)
	    			send("Tab")
	    			wait(100)
        		end
			if bot.CharHPpercent() > 35 then
        			if bot.targetHPpercent() > 0 then
           				wait(100)
            				send(attackskills)
            				wait(100)
        			else
            				wait(100)
        				send("Tab")
            				wait(100)
        			end
			else
				wait(100)
				send("F1")
				wait(100)
				while bot.CharHPpercent() < 95 do 
					wait(100)
					send(healskill)
					wait(100)
				end
            			wait(100)
        			send("Tab")
            			wait(100)
			end
    		end
	end
	
end

function BC.MovingfromStonecity()
	while BC.StoneCity() == 1 and (timerclock() <= resettime) do
		log("In StoneCity")
		BC.Viewreset()
		while bot.Dialogue() == 0 and (timerclock() <= resettime) do
        	 	wait(300)
			right(478, 508)
		 	wait(300)
		end
		wait("1s")
		if bot.Dialogue() == 1 then
        		wait(300)
		        left(477, 324 )
		 	wait(300)
		        left(277, 558 )
        		wait(300)
		end
		wait("3s")
		while BC.StoneCity() == 1 and (timerclock() <= resettime) do 
			left(362, 655)
			wait("1s")
		end
	end
end
function BC.MovingfromVastmountain()
	while BC.VastMountain() == 1 and (timerclock() <= resettime) do
		log("In VastMountain")
		while bot.SellDialogue() == 0 and (timerclock() <= resettime) do
	        	while bot.Dialogue() == 0 and (timerclock() <= resettime) do
				right(277, 251 )
			end
			wait("1s")
		--while bot.Dialogue() == 1 do
		--	wait(500)
				left(279, 394  )
		--	        wait(500)
				break
       		--	end
		end
   		wait("1s")
		while bot.SellDialogue() == 1 and (timerclock() <= resettime) do
			log("Selling Junk to clear space in inventory")
        		local q = 0
       	 		repeat
            			q = q + 1
      				wait(100)
            			left (450, 326 )
            			wait(100)
            			if bot.getConfirmBox() == 1 then
                		wait(100)
   	            		left (445, 325 )
                		wait(100)
   	        	end
        		until q == 7
        		wait("1s")
        		left (469, 713 )
        		wait("1s")
        		log("Sold Items")
        		break
    		end
    		wait("1s")
    		while bot.SellDialogue() ==1 and (timerclock() <= resettime) do
        		wait("1s")
        		left (469, 713 )
        		wait("1s")
        		log("Sold Items")
    		end
		--if bot.SellDialogue() ==1 then
        	while bot.Dialogue() == 0 and (timerclock() <= resettime) do
                	wait(300)
                	right(471, 402 )
                	wait(300)
        	end
        	while bot.Dialogue() == 1 and (timerclock() <= resettime) do
                	log("Transport Dialogue" )
                	wait(300)
            		left(282, 377 )
                	wait(300)
                	left(358, 655 )
                	wait(300)
        	end
        	wait("3s")
        	--log ("clear")
	end
end
function BC.MovingfromGhostdinwoods()
	while BC.Ghostdinwoods() == 1 and (timerclock() <= resettime) do
    		log("In GhostDinWoods")
    		BC.Addteam()
		BC.mount()
    		if bot.Surroundings() == 0 then
        		wait(100)
        		left (975, 57 )
        		wait("1s")
    		end
    		if bot.Surroundings() == 1 then
        		wait(100)
        		left(404, 194 ) --click on NPC tab
        		wait(100)
        		left(556, 542 ) --box to write
        		wait("1s")
        		send("Skull")
        		wait("1s")
        		left (330, 265 )
        		wait("3s")
        		log("Moving to Entrance of BC")
    		end
	end
	left(417, 538 )   --close Surroundings
	wait("1s")
	while not (bot.getLocation_cords(0) == "1395" and bot.getLocation_cords(1) == "-635") do
    		wait("1s")
	end
	while (bot.getLocation_cords(0) == "1395" and bot.getLocation_cords(1) == "-635") and (timerclock() <= resettime) do
    		log("Entrance of Bewitcher Cave")
    		while bot.Dialogue() == 0  and (timerclock() <= resettime) do
        		wait(100)
        		right(473, 420 )
        		wait(100)
    		end
    		wait(100)
    		left(291, 363 )
    		wait("2s")
	end
end
function timerclock()
	return BC.calculate_time_difference(epoch1, os.time())
end
function BC.outsideBC()
	BC.Viewreset()
	BC.verifystonecharm()
	epoch1 = os.time()
	resettime = 120
	log("Started BC time :",BC.convert_epoch_to_normal())
	BC.GotoStoneCity()
	if timerclock() <= resettime then
		BC.MovingfromStonecity()
	end
	if timerclock() <= resettime then
		BC.MovingfromVastmountain()	
	end
	if timerclock() <= resettime then
		BC.MovingfromGhostdinwoods()
	end
	log("Entered Cave")
	if timerclock() <= resettime then
		BC.InsideBC()
	else	
		BC.attackBlazeSkullMarshal()
		BC.GotoStoneCity()
		BC.start()
	end
end
function BC.start()
    wait("1s")
    send(Petfood)
    wait("1s")
    local s = 0
    repeat
        s = s + 1
         BC.outsideBC()
    until s == 5
end
return BC
