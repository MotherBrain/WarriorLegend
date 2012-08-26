-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:07b63248058ef29bbc7ba191a5e0b929$
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
				spriteColorRect = { x = 4, y = 0, width = 78, height = 117 },
				textureRect = { x = 2, y = 242, width = 78, height = 117 },
				spriteSourceSize = { width = 82, height = 117 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "1.png",
				spriteColorRect = { x = 4, y = 0, width = 83, height = 117 },
				textureRect = { x = 105, y = 126, width = 83, height = 117 },
				spriteSourceSize = { width = 87, height = 117 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "2.png",
				spriteColorRect = { x = 4, y = 0, width = 101, height = 124 },
				textureRect = { x = 2, y = 2, width = 101, height = 124 },
				spriteSourceSize = { width = 105, height = 124 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "3.png",
				spriteColorRect = { x = 3, y = 0, width = 100, height = 122 },
				textureRect = { x = 105, y = 2, width = 100, height = 122 },
				spriteSourceSize = { width = 104, height = 124 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "4.png",
				spriteColorRect = { x = 2, y = 0, width = 81, height = 112 },
				textureRect = { x = 2, y = 128, width = 81, height = 112 },
				spriteSourceSize = { width = 83, height = 112 },
				spriteTrimmed = true,
				textureRotated = false
			},
			{
				name = "5.png",
				spriteColorRect = { x = 2, y = 1, width = 64, height = 73 },
				textureRect = { x = 190, y = 126, width = 64, height = 73 },
				spriteSourceSize = { width = 66, height = 75 },
				spriteTrimmed = true,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

