-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:6e10e66edcdc1ca87dbd8ca393e7ec73$
-- 
-- Usage example:
--        local sheetData = require "ThisFile.lua"
--        local data = sheetData.getSpriteSheetData()
--        local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
-- 
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets

local SpriteSheet = {}
SpriteSheet.getSpriteSheetData = function ()
	return {
		frames = {
			{
				name = "0.png",
				spriteColorRect = { x = 0, y = 0, width = 89, height = 56 },
				textureRect = { x = 2, y = 60, width = 89, height = 56 },
				spriteSourceSize = { width = 89, height = 56 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "1.png",
				spriteColorRect = { x = 0, y = 0, width = 95, height = 56 },
				textureRect = { x = 2, y = 2, width = 95, height = 56 },
				spriteSourceSize = { width = 95, height = 56 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "2.png",
				spriteColorRect = { x = 0, y = 0, width = 88, height = 55 },
				textureRect = { x = 2, y = 118, width = 88, height = 55 },
				spriteSourceSize = { width = 88, height = 55 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "3.png",
				spriteColorRect = { x = 0, y = 0, width = 84, height = 54 },
				textureRect = { x = 2, y = 175, width = 84, height = 54 },
				spriteSourceSize = { width = 84, height = 54 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

