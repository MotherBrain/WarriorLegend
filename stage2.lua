module(..., package.seeall)

locallives = stage1.locallives
score = stage1.localscore

function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------

require "sprite"


-- Hide status bar, so it won't keep covering our game objects
display.setStatusBar(display.HiddenStatusBar)

-- Load and start physics

local ui = require("ui")



-- Layers (Groups). Think as Photoshop layers: you can order things with Corona groups,
-- as well have display objects on the same group render together at once.
local gameLayer    = display.newGroup()
localGroup:insert(gameLayer)
local bulletsLayer = display.newGroup()
local enemiesLayer = display.newGroup()

-- Declare variables
local gameIsActive = true
local scoreText
local sounds

local toRemove = {}
local background
local player
local halfPlayerWidth



local isflip = 0

local rkills = 0
local lkills = 0
local origx = 0

local touchattack = false

-- Keep the texture for the enemy and bullet on memory, so Corona doesn't load them everytime
local textureCache = {}
textureCache[1] = 0
textureCache[2] = 0


-- Adjust the volume
audio.setMaxVolume( 0.85, { channel=1 } )

-- Pre-load our sounds
sounds = {
	die1 = audio.loadSound("kill4.wav"),
	dead1 = audio.loadSound("dead2.wav"),
	sword1 = audio.loadSound("sword1.wav"),
	bug = audio.loadSound("bug.wav")
}


-- Blue background
-- background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
-- background:setFillColor(21, 115, 193)
background = display.newImage("assets/graphics/back5.png")
localGroup:insert(background)
-- background.rotation = -90
-- background:scale(0.3, 0.3)



gameLayer:insert(background)

function touchScreen (event)
--motionx = speed
--motiony = 0

if gameIsActive == true then
return
end

if event.phase == "ended" then

director:changeScene ("menu")
end

end
background:addEventListener("touch", touchScreen)

-- Order layers (background was already added, so add the bullets, enemies, and then later on
-- the player and the score will be added - so the score will be kept on top of everything)
gameLayer:insert(bulletsLayer)
gameLayer:insert(enemiesLayer)




----------------------------------------------------------------------
--								ARROWS								--
----------------------------------------------------------------------	
attack1 = display.newImage ("attack1.png")
attack1.x = 70
attack1.y = 300
localGroup:insert(attack1)

attack2 = display.newImage ("attack1.png")
attack2.rotation = 90 
attack2.x = 140
attack2.y = 300
localGroup:insert(attack2)
---
flip = display.newImage ("flip.png")
flip.x = 420
flip.y = 300
flip.xScale = 1.5
flip.yScale = 1.5
localGroup:insert(flip)
---
left = display.newImage ("left.png")
left.x = 350
left.y = 300
left.xScale = 1.5
left.yScale = 1.5
localGroup:insert(left)
---
right = display.newImage ("right.png")
right.x = 490
right.y = 300
right.xScale = 1.5
right.yScale = 1.5
localGroup:insert(right)
-- The arrow images to move our sprite

local livesheet = sprite.newSpriteSheet("lives3.png", 205, 300)
local liveset = sprite.newSpriteSet(livesheet, 1, 1)

sprite.add(liveset, "dolives", 1, 1, 1)

livesicon = sprite.newSprite(liveset)
livesicon.x = 350
livesicon.y = 60
livesicon.xScale = 0.10
livesicon.yScale = 0.10
livesicon:prepare("dolives")
livesicon:play("dolives")

localGroup:insert(livesicon)


-- MONSTER AND PLAYER OBJECTS
local isAttacking = 0
local heroAlive = true



local sheetData = require "charfinal"
local char1data = sheetData.getSpriteSheetData()


local herosheet = sprite.newSpriteSheetFromData("charfinal2.png", char1data)

local heroset = sprite.newSpriteSet(herosheet, 1, 7)

sprite.add (heroset, "herowalk1", 1, 2, 200, 1)
sprite.add (heroset, "herowalk2", 2, 1, 200, 1)
sprite.add (heroset, "hero2", 3, 2, 100, 1)
sprite.add (heroset, "herostab", 4, 1, 500, 1)
sprite.add (heroset, "herodie", 6, 2, 1500, 1)
sprite.add (heroset, "herodead", 7,1, 2000, 1)
sprite.add (heroset, "herostabdown", 5, 1, 1000, 1)

local hero = sprite.newSprite(heroset)
hero.x = 295
hero.y = 180
hero.alpha = 1.0
hero:prepare("herowalk2")
hero:play("herowalk2")
localGroup:insert(hero)

local pikeSheetData = require "sword1"
local pikeData = pikeSheetData.getSpriteSheetData()


-- Pike Man sprite sheet
local pikeSheet = sprite.newSpriteSheetFromData("sword1.png", pikeData)

local pikeSet = sprite.newSpriteSet(pikeSheet, 1, 9)

sprite.add (pikeSet, "pikewalk1", 3, 6, 1200, 1)
sprite.add (pikeSet, "pikewalk2", 1, 2, 500, 1)
sprite.add (pikeSet, "pikeattack", 1, 1, 300, 1)
sprite.add (pikeSet, "pikedie", 9, 2, 1000, 1)
sprite.add (pikeSet, "pikedead", 10, 1, 1300, 1)

-- Set up Monster on Right
local monster1 = sprite.newSprite(pikeSet)
monster1.x = 520
monster1.y = 185
monster1.xScale = 1
monster1.yScale = -1
monster1:prepare("pikewalk1")
monster1:play("pikewalk1")
localGroup:insert(monster1)



local monsterBrain1 = {aggression = 3, respawn = 3, reach = 5} 

local monsterR = {sprite = monster1, ai = monsterBrain1, state = "alive" }




function pikeEvent (event)
    
       
    if event.sprite.sequence == "pikedie" and event.sprite.currentFrame == 2 and event.phase == "next" then
    event.sprite.y = 225
   
    audio.play(sounds.dead1)            
    end
    
    if event.sprite.sequence == "pikedie" and event.sprite.currentFrame == 1 and event.phase == "next" then
    event.sprite.x = 20 + event.sprite.x
             
    end
    
        
    if event.sprite.sequence == "pikewalk1" and event.sprite.currentFrame == 3 then
       
       event.sprite.x = event.sprite.x + 7
       end 
   
 if event.sprite.sequence == "pikewalk1" and event.sprite.currentFrame == 4 then
       
       event.sprite.x = event.sprite.x - 7 
       event.sprite.y = 168
       end 
   
    if event.sprite.sequence == "pikewalk1" and event.sprite.currentFrame == 5 then
       
       event.sprite.y = 189
       event.sprite.x = event.sprite.x - 28 
       end
       
    if event.sprite.sequence == "pikewalk1" and event.sprite.currentFrame == 6 and event.phase == "next" then
       event.sprite.y = 185
       event.sprite.x = event.sprite.x + 28 
        end
        
    
if event.phase == "end" and event.sprite.sequence == "pikedie" then
   monsterR.state = "dead"
 
   end
end
monster1:addEventListener("sprite", pikeEvent)


-- Gnoll Man sprite sheet
local gnollSheetData = require "gnoll1"
local gnollData = gnollSheetData.getSpriteSheetData()

local gnollSheet = sprite.newSpriteSheetFromData("gnoll1.png", gnollData)

local gnollSet = sprite.newSpriteSet(gnollSheet, 1, 6)

sprite.add (gnollSet, "gnollwalk1", 1,1, 600, 1)
sprite.add (gnollSet, "gnollswing1", 3, 1, 600, 1)
sprite.add (gnollSet, "gnolldie1", 5, 1, 1000, 1)
sprite.add (gnollSet, "gnolldead1", 6, 1, 300, 1)


-- Ogre Man sprite sheet
local ogreSheetData = require "ranger1"
local ogreData = ogreSheetData.getSpriteSheetData()

local ogreSheet = sprite.newSpriteSheetFromData("ranger1.png", ogreData)

local ogreSet = sprite.newSpriteSet(ogreSheet, 1, 16)

sprite.add (ogreSet, "ogrewalk1", 1,3, 800, 1)
sprite.add (ogreSet, "ogrewalk2", 12,3, 1000, 1)
sprite.add (ogreSet, "ogreattack1", 12,3, 1000, 1)
sprite.add (ogreSet, "ogreattack2", 4,8, 1500, 1)
sprite.add (ogreSet, "ogredie1", 15,2, 1000, 1)

-- Arrow sprite sheet
local arrowSheetData = require "arrow1"
local arrowData = arrowSheetData.getSpriteSheetData()

local arrowSheet = sprite.newSpriteSheetFromData("arrow1.png", arrowData)

local arrowSet = sprite.newSpriteSet(arrowSheet, 1, 1)

sprite.add (arrowSet, "shoot", 1, 1, 700, 1)

-- Set up Arrow logic

local bullet1 = sprite.newSprite(arrowSet)
bullet1.x = 700
bullet1.y = 154
bullet1.xScale = 1
bullet1:prepare("shoot")
bullet1:play("shoot")
localGroup:insert(bullet1)

local bulletBrain1 = {aggression = 2, respawn = 1, reach = 5} 

local monsterBullet1 = {sprite = bullet1, ai = bulletBrain1, state = "dead" }

function bullet1Event (event)

if event.phase == "end" and event.sprite.sequence == "shoot" then
   monsterBullet1.state = "dead"
   monsterBullet1.sprite.x = 700
 
   end
   

end
bullet1:addEventListener("sprite", bullet1Event)


-- Set up Monster on Left
local monster2 = sprite.newSprite(ogreSet)
monster2.x = 700
monster2.y = 180
monster2.yScale = 1
monster2:prepare("ogreattack1")
monster2:play("ogreattack1")
localGroup:insert(monster2)

local monsterBrain2 = {aggression = 3, respawn = 1, reach = 5} 

local monsterL = {sprite = monster2, ai = monsterBrain2, state = "dead" }

function ogreEvent (event)
if event.sprite.sequence == "ogredie1" and event.sprite.currentFrame == 2 and event.phase == "next" then
    event.sprite.y = 30 + event.sprite.y
    audio.play(sounds.dead1)
    
    
    end
if event.phase == "end" and event.sprite.sequence == "ogredie1" then
   monsterL.state = "dead"
 
   end
   
if event.sprite.sequence == "ogreattack2" and event.sprite.currentFrame == 7 then
    monsterBullet1.sprite.x = event.sprite.x + 20
    monsterBullet1.state = "alive"
    end
    
if event.sprite.sequence == "ogreattack1" and event.phase == "next" then
    monster2.y = monster2.y - 0
    end
end
monster2:addEventListener("sprite", ogreEvent)


-- Bug sprite sheet
local bugSheetData = require "bug1"
local bugData = bugSheetData.getSpriteSheetData()

local bugSheet = sprite.newSpriteSheetFromData("bug1.png", bugData)

local bugSet = sprite.newSpriteSet(bugSheet, 1, 3)

sprite.add (bugSet, "bugbite", 3, 1, 700, 1)
sprite.add (bugSet, "bugwalk1", 1, 3, 300, 0)


-- Set up Monster on Right


local monster3 = sprite.newSprite(bugSet)
monster3.x = 700
monster3.y = 215
monster3.xScale = 1
monster3:prepare("bugwalk1")
monster3:play("bugwalk1")
localGroup:insert(monster3)

local monsterBrain3 = {aggression = 2, respawn = 1, reach = 5} 

local monsterBug = {sprite = monster3, ai = monsterBrain3, state = "dead" }

function bugEvent (event)

if event.phase == "end" and event.sprite.sequence == "bugbite" then
   monsterBug.state = "dead"
   monsterBug.sprite.x = 700
 
   end
   
  

end
monster3:addEventListener("sprite", bugEvent)



-- Hound sprite sheet
local houndSheetData = require "boar1"
local houndData = houndSheetData.getSpriteSheetData()

local houndSheet = sprite.newSpriteSheetFromData("boar1.png", houndData)

local houndSet = sprite.newSpriteSet(houndSheet, 1, 4)

sprite.add (houndSet, "houndbite", 3, 1, 700, 1)
sprite.add (houndSet, "houndwalk1", 1, 4, 600, 0)


-- Set up Monster on Right


local monster4 = sprite.newSprite(houndSet)
monster4.x = 700
monster4.y = 207
monster4.xScale = -1
monster4:prepare("houndwalk1")
monster4:play("houndwalk1")
localGroup:insert(monster4)

local monsterBrain4 = {aggression = 2, respawn = 1, reach = 5} 

local monsterHound = {sprite = monster4, ai = monsterBrain4, state = "dead" }

function houndEvent (event)

if event.phase == "end" and event.sprite.sequence == "houndbite" then
   monsterHound.state = "dead"
   monsterHound.sprite.x = 700
 
   end
   

end
monster4:addEventListener("sprite", houndEvent)




----------------------------------------------------------------------
--								MOVEMENT							--
----------------------------------------------------------------------
local motionx = 0 
local motiony = 0 
local speed = 10

-- These are required below; change the speed if you wish to experiment but not motionx or motiony.

local function stop (event)
	if event.phase =="ended" then
		motionx = 0
		motiony = 0
		--hero:pause()
	end
end

Runtime:addEventListener("touch", stop )

-- Here we state that we don't want the sprite animated or moving if we aren't pressing an arrow

local function movehero (event)
--hero.x = hero.x + motionx
--hero.y = hero.y + motiony
end

timer1 = timer.performWithDelay(1,movehero,0)
-- The function to move the hero; it's on a timer but you could also use a Runtime listener




-----------------------HERO EVENT---------------- Reset the hero to walk after stabbing
function heroEvent (event)
if event.phase == "end" and event.sprite.sequence == "herostab"  then
isAttacking = 3

local step = 30

if isflip == 0 then
step = 30
elseif isflip == 1 then
step = -30
end

  hero:prepare("herowalk2")
  hero:play("herowalk2")

if origx ~= 0 then
hero.x = origx
origx = 0
end

end
  
  -- Move down the dead body
if event.sprite.sequence == "herodie" and event.sprite.currentFrame == 2 and event.phase == "next" then
event.sprite.y = event.sprite.y + 30
audio.play(sounds.dead1)
end

if event.sprite.sequence == "herodie" and event.sprite.currentFrame == 2 and event.sprite.animating == false then

hero.x = 295
hero:prepare("herodead")
hero:play("herodead")

monsterBug.state = "dead"
monsterBug.sprite.x = 700
monsterHound.state = "dead"
monsterHound.sprite.x = 700

end
  
if event.sprite.sequence == "herodead" and event.sprite.animating == false and gameIsActive == true then
heroAlive = true
hero.x = 295
hero.y = 180
hero:prepare("herowalk2")
hero:play("herowalk2")

end 




  
end

hero:addEventListener("sprite", heroEvent)


function touchattack1 (event)
motionx = 0
motiony = 0

local step = 30

if isflip == 0 then
step = 30
elseif isflip == 1 then
step = -30
end
  
if heroAlive == false then
return
end




if event.phase == "began" and hero.sequence ~= "herostab" then
touchattack = true
isAttacking = 1
origx = hero.x
hero.x = hero.x + step
hero:prepare("hero2")
hero:play("hero2")
attack1.alpha = 0.5
end


if event.phase == "ended" then
isAttacking = 0
touchattack = false
attack1.alpha = 1
end 

if event.phase == "ended" and monsterR.state ~= "dying" and monsterL.state ~= "dying" and hero.sequence == "hero2" then
isAttacking = 0

hero:prepare("herowalk2")
hero:play("herowalk2")

return
end

if event.phase == "ended" and monsterR.state == "dying" then
isAttacking = 0

hero:prepare("herostab")
hero:play("herostab")
return
end

if event.phase == "ended" and monsterL.state == "dying" then
isAttacking = 0

hero:prepare("herostab")
hero:play("herostab")
return
end

if hero.sequence ~= "herostab" then
if origx ~= 0 then
hero.x = origx
origx = 0
end
end


end
attack1:addEventListener("touch", touchattack1)
-- When the attack1 arrow is touched, play hero attack1 


---------------- STAB DOWN

function touchattack2 (event)
motionx = 0
motiony = 0

local step = 30

if isflip == 0 then
step = 30
elseif isflip == 1 then
step = -30
end
  
if heroAlive == false then
return
end

if origx ~= 0 then
hero.x = origx
origx = 0
end

if event.phase == "began" then
isAttacking = 1
hero:prepare("herostabdown")
hero:play("herostabdown")
attack2.alpha = 0.5
end

if event.phase == "ended" then
attack2.alpha = 1
end



end

attack2:addEventListener("touch", touchattack2)
-- When the attack1 arrow is touched, play hero attack1 



------------------------ FLIP


function touchflip (event)
motionx = 0
motiony = 0

if heroAlive == false then
return
end

if hero.sequence == "herostab" or hero.sequence == "hero2" then
return
end

if event.phase == "began" then
flip.alpha = 0.5
if hero.xScale == 1 then 
  hero.xScale = -1
elseif hero.xScale == -1 then
  hero.xScale = 1
end
if isflip == 0 then
isflip = 1
elseif isflip == 1
then isflip = 0
end
end

if event.phase == "ended" then
flip.alpha = 1
end

end
flip:addEventListener("touch", touchflip)
-- When the flip arrow is touched, play hero flip and move the hero flipwards

function touchleft (event)
--motionx = -speed
--motiony = 0

if heroAlive == false then
return
end

if origx ~= 0 then
hero.x = origx
origx = 0
end

if event.phase == "began" then
left.alpha = 0.5
hero:prepare("herowalk1")
hero:play("herowalk1")

if hero.x > 70 then
hero.x = hero.x - speed 
end
end

if event.phase == "ended" then
left.alpha = 1
end

end
left:addEventListener("touch", touchleft)
-- When the left arrow is touched, play hero left and move the hero left

function touchright (event)
--motionx = speed
--motiony = 0

if heroAlive == false then
return
end

if origx ~= 0 then
hero.x = origx
origx = 0
end

if event.phase == "began" then
right.alpha = 0.5
hero:prepare("herowalk1")
hero:play("herowalk1")

if hero.x < 520 then
hero.x = hero.x + speed 
end
end

if event.phase == "ended" then
right.alpha = 1
end

end
right:addEventListener("touch", touchright)
-- When the right arrow is touched, play hero right and move the hero right





-- When the right arrow is touched, play hero right and move the hero right


-- Take care of collisions
local function onCollision(self, event)
	-- Bullet hit enemy
	if self.name == "bullet" and event.other.name == "enemy" and gameIsActive then
		-- Increase score
		score = score + 1
		scoreText.text = score

		-- Play Sound
		audio.play(sounds.boom)

		-- We can't remove a body inside a collision event, so queue it to removal.
		-- It will be removed on the next frame inside the game loop.
		table.insert(toRemove, event.other)

	-- Player collision - GAME OVER
	elseif self.name == "player" and event.other.name == "enemy" then
		audio.play(sounds.gameOver)
		
		local gameoverText = display.newText("GAME OVER", 0, 0, "HelveticaNeue", 35)
		gameoverText:setTextColor(255, 0 , 5)
		gameoverText.x = display.contentCenterX
		gameoverText.y = display.contentCenterY
		gameLayer:insert(gameoverText)

		-- This will stop the gameLoop
		gameIsActive = false
	end
end

-- Load and position the player
player = display.newImage("charfinal2.png")
player.x = display.contentCenterX
player.y = 1000

-- This is necessary so we know who hit who when taking care of a collision event
player.name = "player"

-- Listen to collisions
player.collision = onCollision
player:addEventListener("collision", player)

-- Add to main layer
-- gameLayer:insert(player)

-- Store half width, used on the game loop
halfPlayerWidth = player.contentWidth * .5

-- Show the score

scoreText1 = display.newText("KILLS:", 0, 0, "HelveticaNeue", 20)
scoreText1:setTextColor(255, 0, 0)
scoreText1.x = 240
scoreText1.y = 60
gameLayer:insert(scoreText1)

scoreText = display.newText(score, 0, 0, "HelveticaNeue", 20)
scoreText:setTextColor(255, 0, 0)
scoreText.x = 290
scoreText.y = 60
gameLayer:insert(scoreText)

livesText1 = display.newText("X "..locallives, 0, 0, "HelveticaNeue", 20)
livesText1:setTextColor(15, 250, 20)
livesText1.x = 380
livesText1.y = 61
gameLayer:insert(livesText1)

debug1Text = display.newText(score, 0, 0, "HelveticaNeue", 15)
debug1Text:setTextColor(255, 255, 255)
debug1Text.x = 300
debug1Text.y = 1105
gameLayer:insert(debug1Text)
debug2Text = display.newText(score, 0, 0, "HelveticaNeue", 15)
debug2Text:setTextColor(255, 255, 255)
debug2Text.x = 300
debug2Text.y = 1115
gameLayer:insert(debug2Text)
debug3Text = display.newText(score, 0, 0, "HelveticaNeue", 15)
debug3Text:setTextColor(255, 255, 255)
debug3Text.x = 300
debug3Text.y = 1135
gameLayer:insert(debug3Text)

local OnButton = 1 

local buttonHandler = function(event)
  if event.phase == "release" then
    if event.id == "start" then
       OnButton = 0
end
end
end


--[[
local button1 = ui.newButton{
default = "buttonGray.png",
over = "buttonGrayOver.png",
onEvent = buttonHandler,
text = "Start Game",
id = "start",
size=12,
emboss=true,


}

button1.x=(display.contentWidth /4 )
button1.y=(display.contentHeight /2 )

--]]




--------------------------------------------------------------------------------
-- Game loop
--------------------------------------------------------------------------------
local timeLastBullet, timeLastEnemy = 0, 0
local bulletInterval = 1000


local function RunMonster1(monster) 
   -- if monster.state == "alive" and          
  --   monster.sprite.x <= hero.x then
    --    monster.sprite.x = monster.sprite.x + 2
    if monster.state == "alive" and math.random(1, 30) <= monster.ai.aggression and monster.sprite.animating == false then
        monster.sprite.x = monster.sprite.x - 10
        monster.sprite:prepare("pikewalk1")
        monster.sprite:play("pikewalk1")
        elseif monster.state == "alive" and monster.sprite.animating == false and math.random(1, 30) <= 3 then
        if monster.sprite.sequence == "pikewalk1" then
        monster.sprite.x = monster.sprite.x - 4
        end
        monster.sprite:prepare("pikewalk2")
        monster.sprite:play("pikewalk2")
        
    end
    
    if (monster.state == "dead" and math.random(1, 100) <= monster.ai.respawn) or ( monster.state == "dead" and  monsterL.state == "dead" and score > 2) then
        
        if rkills > 2 then
         return
        end
                        
        monster.sprite:prepare("pikewalk1")
        monster.sprite:play("pikewalk1")
        monster.sprite.x = monster.sprite.x + 40
        if monster.sprite.x > 520 then
        monster.sprite.x = 520
        end
        
        monster.sprite.y = 185        
        monster.state = "alive"
end
end

local function RunMonster2(monster) 
 --   if monster.state == "alive" and          
  --   monster.sprite.x >= hero.x-70 then
    --    monster.sprite.x = monster.sprite.x - 2
    if monster.state == "alive" and math.random(1, 30) <= monster.ai.aggression and monster.sprite.animating == false then
        monster.sprite.x = monster.sprite.x + 5
        monster.sprite:prepare("ogrewalk1")
        monster.sprite:play("ogrewalk1")
        elseif monster.state == "alive" and monster.sprite.animating == false and math.random(1, 30) <= 2 then
        
        if hero.x - monster.sprite.x > 130 and monsterBullet1.state ~= "alive" and heroAlive == true then
        monster.sprite:prepare("ogreattack2")
        monster.sprite:play("ogreattacik2")
        elseif hero.x - monster.sprite.x <= 130 then
         monster.sprite:prepare("ogreattack1")
         monster.sprite:play("ogreattack1")
         monster.sprite.x = monster.sprite.x + 10
        end
        
        
        if monster.sprite.sequence == "ogrewalk1" then
        monster.sprite.x = monster.sprite.x + 7
        end
       
        
    end
    
    if (monster.state == "dead" and math.random(1, 150) <= monster.ai.respawn and score > 32 ) or (monster.state == "dead" and monsterR.state == "dead" and score > 2) then
       if lkills > 2 then
         return
       end       
        
        monster.sprite:prepare("ogrewalk1")
        monster.sprite:play("ogrewalk1")
        monster.sprite.x = 70
        
        if monster.sprite.x > 600
            then monster.sprite.x = 70
        end
        
        if monster.sprite.x < 70 then
        monster.sprite.x = 70
        end
        
        monster.sprite.y = 180        
        monster.state = "alive"
end
end


local function RunMonsterBug(monster) 

if monster.sprite.x + 40 < hero.x and monster.state == "alive" then
monster.sprite.x = monster.sprite.x + 1
end

       
    if monster.state == "dead" and math.random(1, 300) <= monster.ai.respawn and score > 37  then
        monster.sprite:prepare("bugwalk1")
        monster.sprite:play("bugwalk1")
        monster.sprite.x = 70    
        
        monster.sprite.y = 215   
        audio.play(sounds.bug)     
        monster.state = "alive"
end
end

local function RunMonsterHound(monster) 

if monster.sprite.x - 40 > hero.x and monster.state == "alive" then
monster.sprite.x = monster.sprite.x - 1
end

       
    if monster.state == "dead" and math.random(1, 300) <= monster.ai.respawn and score > 40  then
        monster.sprite:prepare("houndwalk1")
        monster.sprite:play("houndwalk1")
        monster.sprite.x = 520    
        
        monster.sprite.y = 207   
        audio.play(sounds.bug)     
        monster.state = "alive"
end
end


local function RunBullet1(monster) 

if monster.sprite.x < hero.x and monster.state == "alive" and heroAlive == true then
monster.sprite.x = monster.sprite.x + 6

if heroAlive == false then
monster.sprite.x = 700
end

end

       
    
end

--------------------------- MAIN GAME LOOP

local soundLoop = 0

local function gameLoop(event)
	if gameIsActive then
		-- Remove collided enemy planes
		for i = 1, #toRemove do
			toRemove[i].parent:remove(toRemove[i])
			toRemove[i] = nil
		end

         if OnButton == 0 then
              button1:removeSelf()
          end
          
          RunMonster1(monsterR)
          RunMonster2(monsterL)
          RunMonsterBug(monsterBug)
          RunMonsterHound(monsterHound)
          RunBullet1(monsterBullet1)
          
          debug1Text.text = monsterR.sprite.x
          debug2Text.text = monsterR.sprite.y
          debug3Text.text = heroAlive
          livesText1.text = "X "..locallives
          
          soundLoop = soundLoop + 1
          if soundLoop > 100 then
            soundLoop = 0
            end
          
          if monsterR.state == "alive" and hero.xScale == 1 and hero.x + 75 >= monsterR.sprite.x and hero.sequence == "hero2" and hero.currentFrame == 2 then
            if monsterR.sprite.sequence == "pikewalk1" and (monsterR.sprite.currentFrame == 4 or monsterR.sprite.currentFrame == 5) then
                        
            audio.play(sounds.die1)
            monsterR.state = "dying"
            monsterR.sprite:prepare("pikedie")
            monsterR.sprite:play("pikedie")
            score = score + 1
            scoreText.text = score
            rkills = rkills + 1
            lkills = 0
            
           -- elseif monsterR.sprite.sequence == "pikewalk2" then
           --  if soundLoop % 10 == 0 then
           --  audio.play(sounds.sword1)
           --  end
           --  monsterR.sprite.x = monsterR.sprite.x + 10
            --   if monsterR.sprite.x > 520 then
             --   monsterR.sprite.x = 520
             --  end
            end        
                       
          end
          
          
          if monsterL.state == "alive" and hero.xScale == -1 and hero.x - 85 <= monsterL.sprite.x and hero.sequence == "hero2" and hero.currentFrame == 2 then
            if monsterL.sprite.sequence ~= "ogrewalk1" then
                        
            audio.play(sounds.die1)
            monsterL.state = "dying"
            monsterL.sprite:prepare("ogredie1")
            monsterL.sprite:play("ogredie1")
            score = score + 1
            scoreText.text = score
            lkills = lkills + 1
            rkills = 0  
          
            end        
                       
          end
          
          --- KILL BUG
           if monsterBug.state == "alive" and hero.xScale == -1 and hero.x - 85 <= monsterBug.sprite.x and hero.sequence == "herostabdown" then
           
            audio.play(sounds.die1)
            monsterBug.state = "dead"
            monsterBug.sprite:prepare("bugbite")
            monsterBug.sprite:play("bugbite")
            
            score = score + 1
            scoreText.text = score
                         
                       
          end
          
          -- KILL HOUND
           if monsterHound.state == "alive" and hero.xScale == 1 and hero.x + 105 >= monsterHound.sprite.x and hero.sequence == "herostabdown" then
           
            audio.play(sounds.die1)
            monsterHound.state = "dead"
            monsterHound.sprite:prepare("houndbite")
            monsterHound.sprite:play("houndbite")
            
            score = score + 1
            scoreText.text = score                         
                       
          end
          
            -- KILL ARROW
           if monsterBullet1.state == "alive" and hero.xScale == -1 and hero.x - 30 <= monsterBullet1.sprite.x and (hero.sequence == "herowalk1" or hero.sequence == "herowalk2") then
           
            audio.play(sounds.sword1)
            monsterBullet1.state = "dead"
            monsterBullet1.sprite.x = 700           
                                   
                       
          end
          
          ------- BUMPED BY MONSTERS
          if monsterR.state == "alive" and  monsterR.sprite.sequence == "pikewalk2" and hero.xScale == 1 and hero.x + 95 >= monsterR.sprite.x and hero.sequence == "hero2" and hero.currentFrame == 2 then
              if soundLoop % 5 == 0 then
              audio.play(sounds.sword1)
              end
              
              if monsterR.sprite.x <= 510 then
              monsterR.sprite.x = monsterR.sprite.x + 10
              end
             
             end
             
          if monsterL.state == "alive" and  monsterL.sprite.sequence == "ogrewalk1" and hero.xScale == -1 and hero.x - 95 <= monsterL.sprite.x and hero.sequence == "hero2" and hero.currentFrame == 2 then
              if soundLoop % 5 == 0 then
              audio.play(sounds.sword1)
              end
              
              if monsterL.sprite.x >= 80 then
              monsterL.sprite.x = monsterL.sprite.x - 10
              end
             
             end
            
          --- KILLED BY PIKE
          if monsterR.state == "alive" and heroAlive == true and hero.x + 50 >= monsterR.sprite.x and hero.sequence ~= "herodie" then
             hero.y = hero.y + 10
             audio.play(sounds.die1)
             hero:prepare("herodie")
             hero:play("herodie")
             if locallives>0 then
             locallives = locallives - 1
             livesText1.text = "X "..locallives
             end
             heroAlive = false                      
          
          end
          
            --- KILLED BY OGRE
          if monsterL.state == "alive" and heroAlive == true and hero.x - 55 <= monsterL.sprite.x and hero.sequence ~= "herodie" then
             hero.y = hero.y + 10
             audio.play(sounds.die1)
             hero:prepare("herodie")
             hero:play("herodie")
             if locallives>0 then
             locallives = locallives - 1
             livesText1.text = "X "..locallives
             end
             heroAlive = false                      
          
          end
          
          ---- KILLED BY ARROW
          if monsterBullet1.state == "alive" and heroAlive == true and hero.x - 10 <= monsterBullet1.sprite.x and hero.sequence ~= "herodie" then
             hero.y = hero.y + 10
             audio.play(sounds.die1)
             hero:prepare("herodie")
             hero:play("herodie")
             if locallives>0 then
             locallives = locallives - 1
             livesText1.text = "X "..locallives
             end
             heroAlive = false  
             monsterBullet1.state = "dead"                    
             monsterBullet1.sprite.x = 700 
          end
          
          
          
          ---- KILLED BY BUG
           if heroAlive == true and hero.x <= monster3.x+50 and  hero.sequence ~= "herodie" and monsterBug.state == "alive" then
             hero.y = hero.y + 10
             audio.play(sounds.die1)
             hero:prepare("herodie")
             hero:play("herodie")
             if locallives>0 then
             locallives = locallives - 1
             livesText1.text = "X "..locallives
             end
             heroAlive = false
             monsterBug.state = "bite"
             monsterBug.sprite:prepare("bugbite")
             monsterBug.sprite:play("bugbite")
          
          end
          
           ---- KILLED BY HOUND
           if heroAlive == true and hero.x >= monster4.x-50 and hero.sequence ~= "herodie" and monsterHound.state == "alive" then
             hero.y = hero.y + 10
             audio.play(sounds.die1)
             hero:prepare("herodie")
             hero:play("herodie")
             if locallives>0 then
             locallives = locallives - 1
             livesText1.text = "X "..locallives
             end
             heroAlive = false
             monsterHound.state = "bite"
             monsterHound.sprite:prepare("houndbite")
             monsterHound.sprite:play("houndbite")
          
          end
          
          if heroAlive == false then
          origx= 0
              if monsterR.sprite.x < 295 and monsterR.state == "alive" then
                 monsterR.sprite.x = 345
                 end
              if monsterL.sprite.x > 295 and monsterL.state == "alive" then
                 monsterL.sprite.x = 245
                 end 
           end
              
          
          
            ------------------- GAME OVER
             if locallives == 0 then
             
				local gameoverText = display.newText("GAME OVER!", 0, 0, "HelveticaNeue", 30)
				gameoverText:setTextColor(255, 5,5)
				gameoverText.x = display.contentCenterX
				gameoverText.y = display.contentCenterY - 100
				gameLayer:insert(gameoverText)
				
			    local restartText = display.newText("Press to Restart..", 0, 0, "HelveticaNeue", 15)
				restartText:setTextColor(255, 5,5)
				restartText.x = display.contentCenterX
				restartText.y = display.contentCenterY -30
				gameLayer:insert(restartText)
		        
				-- This will stop the gameLoop
				gameIsActive = false
				
				monsterBug.state = "dead"
				monsterBug.sprite:pause()
				monsterHound.state = "dead"
				monsterHound.sprite:pause()
				
			end
			
			
			-----------  NEXT STAGE
			--[[
			if localscore > 5 then
				monsterBug.state = "dead"
				monsterBug.sprite:pause()
				monsterHound.state = "dead"
				monsterHound.sprite:pause()
				monsterBullet1.state = "dead"
				monsterBullet1.sprite:pause()
				gameIsActive = false
			  director:changeScene ("stage1")
			  return 
			end
			--]]
						

		-- Check if it's time to spawn another enemy,
		-- based on a random range and last spawn (timeLastEnemy)
		if event.time - timeLastEnemy >= math.random(600, 1000) then
			-- Randomly position it on the top of the screen
			--local enemy = display.newImage("assets/graphics/enemy.png")
			--enemy.x = math.random(halfEnemyWidth, display.contentWidth - halfEnemyWidth)
			--enemy.y = -enemy.contentHeight

			-- This has to be dynamic, making it react to gravity, so it will
			-- fall to the bottom of the screen.
			--physics.addBody(enemy, "dynamic", {bounce = 0})
			--enemy.name = "enemy"

			--enemiesLayer:insert(enemy)
			--timeLastEnemy = event.time
		end

		-- Spawn a bullet
		if event.time - timeLastBullet >= math.random(250, 300) then
			--local bullet = display.newImage("assets/graphics/bullet.png")
			--bullet.x = player.x
			--bullet.y = player.y - halfPlayerWidth

			-- Kinematic, so it doesn't react to gravity.
			--physics.addBody(bullet, "kinematic", {bounce = 0})
			--bullet.name = "bullet"

			-- Listen to collisions, so we may know when it hits an enemy.
			--bullet.collision = onCollision
			--bullet:addEventListener("collision", bullet)

			--bulletsLayer:insert(bullet)

			-- Pew-pew sound!
			-- audio.play(sounds.pew)

			-- Move it to the top.
			-- When the movement is complete, it will remove itself: the onComplete event
			-- creates a function to will store information about this bullet and then remove it.
			--transition.to(bullet, {time = 1000, y = -bullet.contentHeight,
			--	onComplete = function(self) self.parent:remove(self); self = nil; end
			--})

			--timeLastBullet = event.time
			
			
			
		end
	end
end

-- Call the gameLoop function EVERY frame,
-- e.g. gameLoop() will be called 30 times per second ir our case.
Runtime:addEventListener("enterFrame", gameLoop)

--------------------------------------------------------------------------------
-- Basic controls
--------------------------------------------------------------------------------
local function playerMovement(event)
	-- Doesn't respond if the game is ended
	if not gameIsActive then return false end

	-- Only move to the screen boundaries
	if event.x >= halfPlayerWidth and event.x <= display.contentWidth - halfPlayerWidth then
		-- Update player x axis
		player.x = event.x
	end
end

-- Player will listen to touches
player:addEventListener("touch", playerMovement)


------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment