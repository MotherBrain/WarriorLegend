display.setStatusBar (display.HiddenStatusBar)
--> Hides the status bar

local director = require ("director")
--> Imports director

local mainGroup = display.newGroup()
--> Creates a main group

lives = 3
mainscore = 0
local function main()
--> Adds main function
	
	mainGroup:insert(director.directorView)
	--> Adds the group from director
	
	director:changeScene("menu")
	--> Change the scene, no effects
	
	return true
end

main()
--> Starts our app