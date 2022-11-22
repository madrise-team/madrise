local current_selection = nil
local changing_wind_direction = false
local highlight = true
guiEnabled = false
snowToggle = false
local snow = {}
-- default settings
settings = {type = "real", density = 400, wind_direction = {0.01,-1}, wind_speed = 0, snowflake_min_size = 1, snowflake_max_size = 4, fall_speed_min = 1, fall_speed_max = 2, jitter = false}

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),function()

	triggerServerEvent("onClientReady",localPlayer)
	
	snow.window = guiCreateWindow(sx-290,sy-345,285,340,"Snow Settings",false)
	
	--snow.cursor_highlight_checkbox = guiCreateCheckBox(170,18,106,19,"Highlight cursor",true,false,snow.window)
	
	snow.wind_direction_image = guiCreateStaticImage(20,144,64,64,"direction_image.png",false,snow.window)
	snow.wind_direction_pointer = guiCreateStaticImage(20,144,16,16,"direction_pointer.png",false,snow.window)
	snow.wind_direction_pointer_middle = guiCreateStaticImage(44,168,16,16,"direction_pointer.png",false,snow.window)
	snow.wind_direction_north_label = guiCreateLabel(49,130,8,12,"N",false,snow.window)
	guiSetFont(snow.wind_direction_north_label,"default-small")
	snow.wind_direction_south_label = guiCreateLabel(50,207,8,12,"S",false,snow.window)
	guiSetFont(snow.wind_direction_south_label,"default-small")
	snow.wind_direction_east_label = guiCreateLabel(87,170,8,12,"E",false,snow.window)
	guiSetFont(snow.wind_direction_east_label,"default-small")
	snow.wind_direction_west_label = guiCreateLabel(10,170,8,12,"W",false,snow.window)
	guiSetFont(snow.wind_direction_west_label,"default-small")	
	snow.wind_direction_label = guiCreateLabel(13,117,123,19,"Snow wind direction:",false,snow.window)
	guiLabelSetColor(snow.wind_direction_label,255,255,255)
	guiSetFont(snow.wind_direction_label,"default-bold-small")
	snow.wind_direction_x_edit = guiCreateEdit(126,150,48,20,tostring(settings.wind_direction[1]*100),false,snow.window)
	snow.wind_direction_y_edit = guiCreateEdit(126,183,48,20,tostring(settings.wind_direction[2]*100),false,snow.window)
	snow.wind_direction_x_label = guiCreateLabel(106,152,16,17,"X:",false,snow.window)
	guiLabelSetColor(snow.wind_direction_x_label,255,255,255)
	snow.wind_direction_y_label = guiCreateLabel(106,184,16,18,"Y:",false,snow.window)
	guiLabelSetColor(snow.wind_direction_y_label,255,255,255)
	guiEditSetReadOnly(snow.wind_direction_x_edit,true)
	guiEditSetReadOnly(snow.wind_direction_y_edit,true)
	guiSetProperty(snow.wind_direction_pointer,"AlwaysOnTop","true")
	
	-- set the pointer position
	local ix,iy = guiGetPosition(snow.wind_direction_image,false)
	ix,iy = ix+32,iy+32
	guiSetPosition(snow.wind_direction_pointer,ix+((settings.wind_direction[1]*100)*32)-8,iy+(-(settings.wind_direction[2]*100)*32)-8,false,snow.window)	

	snow.snow_type_label = guiCreateLabel(13,23,109,19,"Snow type:",false,snow.window)
	guiLabelSetColor(snow.snow_type_label,255,255,255)
	guiSetFont(snow.snow_type_label,"default-bold-small")	
	snow.snow_type_real = guiCreateRadioButton(14,41,49,23,"Real",false,snow.window)
	snow.snow_type_cartoon = guiCreateRadioButton(68,41,68,23,"Cartoon",false,snow.window)
	guiRadioButtonSetSelected(snow.snow_type_cartoon,(settings.type == "cartoon" and true or false))	
	guiRadioButtonSetSelected(snow.snow_type_real,(settings.type == "real" and true or false))
	
	snow.snow_density_label = guiCreateLabel(13,69,107,20,"Snow density:",false,snow.window)
	guiLabelSetColor(snow.snow_density_label,255,255,255)
	guiSetFont(snow.snow_density_label,"default-bold-small")
--	snow.snow_density_scrollbar = guiCreateScrollBar(11,88,193,20,true,false,snow.window)
	snow.snow_density_edit = guiCreateEdit(11,88,61,20,tostring(settings.density),false,snow.window)
	guiEditSetMaxLength(snow.snow_density_edit,5)

	snow.wind_speed_label = guiCreateLabel(13,218,123,20,"Snow wind speed:",false,snow.window)
	guiLabelSetColor(snow.wind_speed_label,255,255,255)
	guiSetFont(snow.wind_speed_label,"default-bold-small")
	snow.wind_speed_edit = guiCreateEdit(211,239,61,20,tostring(settings.wind_speed),false,snow.window)
	snow.wind_speed_scrollbar = guiCreateScrollBar(11,239,193,20,true,false,snow.window)
	guiScrollBarSetScrollPosition(snow.wind_speed_scrollbar,tonumber(settings.wind_speed))
	guiEditSetMaxLength(snow.wind_speed_edit,3)
	
	snow.snowflake_size_label = guiCreateLabel(162,69,107,20,"Snowflake size:",false,snow.window)
	guiLabelSetColor(snow.snowflake_size_label,255,255,255)
	guiSetFont(snow.snowflake_size_label,"default-bold-small")
	
	snow.snowflake_min_edit = guiCreateEdit(143,88,45,20,tostring(settings.snowflake_min_size),false,snow.window)
	snow.snowflake_min_label = guiCreateLabel(118,88,24,17,"Min:",false,snow.window)
	guiLabelSetColor(snow.snowflake_min_label,255,255,255)

	snow.snowflake_max_label = guiCreateLabel(200,88,24,17,"Max:",false,snow.window)
	guiLabelSetColor(snow.snowflake_max_label,255,255,255)
	snow.snowflake_max_edit = guiCreateEdit(228,88,45,20,tostring(settings.snowflake_max_size),false,snow.window)
	
	guiEditSetMaxLength(snow.snowflake_min_edit,3)
	guiEditSetMaxLength(snow.snowflake_max_edit,3)
	
	snow.fall_speed_label = guiCreateLabel(13,265,123,20,"Snow fall speed:",false,snow.window)
	guiLabelSetColor(snow.fall_speed_label,255,255,255)
	guiSetFont(snow.fall_speed_label,"default-bold-small")
	
	snow.fall_speed_min_edit = guiCreateEdit(38,284,45,20,tostring(settings.fall_speed_min),false,snow.window)
	snow.fall_speed_min_label = guiCreateLabel(13,284,24,17,"Min:",false,snow.window)
	guiLabelSetColor(snow.fall_speed_min_label,255,255,255)

	snow.fall_speed_max_label = guiCreateLabel(90,284,24,17,"Max:",false,snow.window)
	guiLabelSetColor(snow.fall_speed_max_label,255,255,255)
	snow.fall_speed_max_edit = guiCreateEdit(117,284,45,20,tostring(settings.fall_speed_max),false,snow.window)	
	
	snow.jitter_backing = guiCreateLabel(225,130,60,80,"",false,snow.window)
	snow.jitter_label = guiCreateLabel(225,117,40,19,"Jitter:",false,snow.window)
	guiLabelSetHorizontalAlign(snow.jitter_label,"right")
	guiSetFont(snow.jitter_label,"default-bold-small")
	snow.jitter_yes = guiCreateRadioButton(5,5,50,20,"Yes",false,snow.jitter_backing)
	snow.jitter_no = guiCreateRadioButton(5,30,50,20,"No",false,snow.jitter_backing)
	guiRadioButtonSetSelected(snow.jitter_yes,settings.jitter)	
	guiRadioButtonSetSelected(snow.jitter_no,not settings.jitter)	
	
	snow.accept_button = guiCreateButton(16,312,84,22,"Accept",false,snow.window)
	snow.exit_button = guiCreateButton(184,312,84,22,"Exit",false,snow.window)
	
	guiSetVisible(snow.window,false)
	guiWindowSetMovable(snow.window,true)
	guiWindowSetSizable(snow.window,false)
	
	addEventHandler("onClientClick",root,function(button,state)
		if current_selection == snow.wind_direction_pointer and button == "left" then
			if state == "down" then
				if changing_wind_direction == false then
					addEventHandler("onClientMouseMove",root,moveDirectionPointer)
					changing_wind_direction = true
				end
			else
				if changing_wind_direction == true then
					removeEventHandler("onClientMouseMove",root,moveDirectionPointer)
					changing_wind_direction = false
				end
			end
		end
		
		if button == "left" and state == "up" and changing_wind_direction == true then
			removeEventHandler("onClientMouseMove",root,moveDirectionPointer)
			changing_wind_direction = false			
		end
	end)
	
--[[	
	addEventHandler("onClientGUIChanged",snow.wind_direction_x_edit,function()
		if not changing_wind_direction then
			local newx = tonumber(guiGetText(snow.wind_direction_x_edit))
			if newx then
				local newy = tonumber(guiGetText(snow.wind_direction_y_edit))
				local ix,iy = guiGetPosition(snow.wind_direction_image,false)
				ix,iy = ix+24,iy+24
				
				guiSetPosition(snow.wind_direction_pointer,ix+(newx*32),iy+(newy*32),false,snow.window)	
			end
		end
	end)
]]	

	addEventHandler("onClientGUIScroll",snow.wind_speed_scrollbar,function()
		guiSetText(snow.wind_speed_edit,tostring(guiScrollBarGetScrollPosition(snow.wind_speed_scrollbar)))
	end)
	
	addEventHandler("onClientGUIChanged",snow.wind_speed_edit,function()
		local speed = tonumber(guiGetText(snow.wind_speed_edit))
		if speed then
			if speed <= 100 and speed >= 0 then
				guiScrollBarSetScrollPosition(snow.wind_speed_scrollbar,speed)
			else
				outputChatBox("Invalid snow wind speed. ("..tostring(speed)..")")
				guiSetText(snow.wind_speed_edit,"1")
			end
		end
	end)	
	
--[[	
	addEventHandler("onClientGUIScroll",snow.snow_density_scrollbar,function()
		local density = guiScrollBarGetScrollPosition(snow.snow_density_scrollbar)*200
	--	outputChatBox("scrolled to "..density/200)
		guiSetText(snow.snow_density_edit,tostring(density))
	end)
]]	
	addEventHandler("onClientGUIChanged",snow.snow_density_edit,function()
		local density = guiGetText(snow.snow_density_edit)
	
		if density and tonumber(density) and (tonumber(density) > 20000 or tonumber(density) < 0) then
			outputChatBox("Invalid snow density. ("..tostring(density)..")")
			guiSetText(snow.snow_density_edit,"1000")
		end
	--	if density and density <= 20000 and density >= 0 then
	--		guiScrollBarSetScrollPosition(snow.snow_density_scrollbar,density/200)
	--	end
	end)
	
	addEventHandler("onClientGUIChanged",snow.fall_speed_min_edit,function()
		local speed = guiGetText(snow.fall_speed_min_edit)
		
		if speed and tonumber(speed) and tonumber(speed) < 0 then
			outputChatBox("Invalid minimum fall speed. ("..tostring(speed)..")")
			guiSetText(snow.fall_speed_min_edit,"1")
		end
	end)
	
	addEventHandler("onClientGUIChanged",snow.fall_speed_max_edit,function()
		local speed = guiGetText(snow.fall_speed_max_edit)
		
		if speed and tonumber(speed) and tonumber(speed) < 0 then
			outputChatBox("Invalid maximum fall speed. ("..tostring(speed)..")")
			guiSetText(snow.fall_speed_max_edit,"1")
		end
	end)	
	
	addEventHandler("onClientGUIClick",snow.accept_button,function(button,state)
		if button == "left" and state == "up" then
			if changing_wind_direction == true then
				removeEventHandler("onClientMouseMove",root,moveDirectionPointer)
				changing_wind_direction = false
			end		
			
			updateSnowType(guiRadioButtonGetSelected(snow.snow_type_real) == true and "real" or "cartoon")
			updateSnowDensity(tonumber(guiGetText(snow.snow_density_edit)),true)
			updateSnowWindDirection(tonumber(guiGetText(snow.wind_direction_x_edit)),tonumber(guiGetText(snow.wind_direction_y_edit)))
			updateSnowWindSpeed(tonumber(guiGetText(snow.wind_speed_edit)))
			updateSnowflakeSize(tonumber(guiGetText(snow.snowflake_min_edit)),tonumber(guiGetText(snow.snowflake_max_edit)))
			updateSnowFallSpeed(tonumber(guiGetText(snow.fall_speed_min_edit)),tonumber(guiGetText(snow.fall_speed_max_edit)))
			updateSnowJitter(guiRadioButtonGetSelected(snow.jitter_yes))

			if highlight then
			--	removeEventHandler("onClientPreRender",root,highlightCursor)
			end
			
		--	outputChatBox(string.format("Settings updated: type: %s density: %.1f wdir: {%.1f,%.1f} wspeed: %.1f",settings.type,settings.density,settings.wind_direction[1],settings.wind_direction[2],settings.wind_speed))
			guiSetVisible(snow.window,false)
			showCursor(false,true)
			
			saveSnowSettings()
		end
	end,false)
	
	addEventHandler("onClientGUIClick",snow.exit_button,function(button,state)
		if button == "left" and state == "up" then
			if changing_wind_direction == true then
				removeEventHandler("onClientMouseMove",root,moveDirectionPointer)
				changing_wind_direction = false
			end		
			
			guiSetVisible(snow.window,false)
			showCursor(false,true)
		end
	end,false)	
	
	--addEventHandler("onClientGUIClick",snow.cursor_highlight_checkbox,function(button,state)
		--if button == "left" and state == "up" then
			--if guiCheckBoxGetSelected(snow.cursor_highlight_checkbox) then
				--highlight = true
				--addEventHandler("onClientPreRender",root,highlightCursor)
			--else
				--highlight = false
				--removeEventHandler("onClientPreRender",root,highlightCursor)
			--end
		--end
	--end,false)
end)


addEvent("triggerGuiEnabled",true)
addEventHandler("triggerGuiEnabled",root,function(enabled,toggle)
	guiEnabled = enabled
	snowToggle = toggle
end)


function showSnowSettings()
	if guiEnabled then
		updateGuiFromSettings()
		guiSetVisible(snow.window,true)
		showCursor(true,true)
	else
		outputChatBox("Snow settings are disabled.")
	end
end
--addCommandHandler("1287398712897319827398761278963",showSnowSettings)

function updateGuiFromSettings()
	guiSetText(snow.wind_direction_x_edit,tostring(settings.wind_direction[1]*100))
	guiSetText(snow.wind_direction_y_edit,tostring(settings.wind_direction[2]*100))
	
	-- set the pointer position
	local ix,iy = guiGetPosition(snow.wind_direction_image,false)
	ix,iy = ix+32,iy+32
	guiSetPosition(snow.wind_direction_pointer,ix+((settings.wind_direction[1]*100)*32)-8,iy+(-(settings.wind_direction[2]*100)*32)-8,false,snow.window)	

	guiRadioButtonSetSelected(snow.snow_type_cartoon,(settings.type == "cartoon" and true or false))	
	guiRadioButtonSetSelected(snow.snow_type_real,(settings.type == "real" and true or false))
	
	guiSetText(snow.snow_density_edit,tostring(settings.density))

	guiSetText(snow.wind_speed_edit,tostring(settings.wind_speed))
	guiScrollBarSetScrollPosition(snow.wind_speed_scrollbar,tonumber(settings.wind_speed))
	
	guiSetText(snow.snowflake_min_edit,tostring(settings.snowflake_min_size))
	guiSetText(snow.snowflake_max_edit,tostring(settings.snowflake_max_size))
	
	guiSetText(snow.fall_speed_min_edit,tostring(settings.fall_speed_min))
	guiSetText(snow.fall_speed_max_edit,tostring(settings.fall_speed_max))
	
	--guiCheckBoxSetSelected(snow.cursor_highlight_checkbox,highlight)
end


function moveDirectionPointer(x,y)
	local ix,iy = guiGetPosition(snow.wind_direction_image,false)
	ix,iy = ix+32,iy+32
	local wx,wy = guiGetPosition(snow.window,false)
	
	local rot = findRotation(ix+wx,iy+wy,x,y)+90
	local newx,newy = math.cos(math.rad(rot)),math.sin(math.rad(rot))
	
	guiSetPosition(snow.wind_direction_pointer,ix+(newx*32)-8,iy+(newy*32)-8,false,snow.window)
	
	guiSetText(snow.wind_direction_x_edit,string.format("%.1f",newx))
	guiSetText(snow.wind_direction_y_edit,string.format("%.1f",-newy))
end


function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end


addEventHandler("onClientMouseEnter",root,function()
	current_selection = source
end)

addEventHandler("onClientMouseLeave",root,function()
	current_selection = nil
end)


function setGuiEnabled(enabled)
	if enabled == true or enabled == false then
		guiEnabled = enabled
		return true
	end
	return false
end


function setSnowToggle(enabled)
	if enabled == true or enabled == false then
		snowToggle = enabled
		return true
	end
	return false
end


-- settings file

