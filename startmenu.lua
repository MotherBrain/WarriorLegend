module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------
local background = display.newImage ("paladin.jpg")
localGroup:insert(background)
--> This sets the background



local function pressScreen (event)
if event.phase == "ended" then
director:changeScene ("stage1")
end
end

background:addEventListener ("touch", pressScreen)


--> This adds the functions and listeners to each button

------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment