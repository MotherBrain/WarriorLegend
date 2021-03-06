-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:3312e1d6995f1b75a76988c7875daa0a$
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
				spriteColorRect = { x = 0, y = 0, width = 106, height = 110 },
				textureRect = { x = 2, y = 263, width = 106, height = 110 },
				spriteSourceSize = { width = 106, height = 110 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "1.png",
				spriteColorRect = { x = 0, y = 0, width = 102, height = 119 },
				textureRect = { x = 2, y = 378, width = 102, height = 119 },
				spriteSourceSize = { width = 102, height = 119 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "2.png",
				spriteColorRect = { x = 0, y = 0, width = 138, height = 113 },
				textureRect = { x = 110, y = 263, width = 138, height = 113 },
				spriteSourceSize = { width = 138, height = 113 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "3.png",
				spriteColorRect = { x = 0, y = 0, width = 177, height = 98 },
				textureRect = { x = 2, y = 52, width = 177, height = 98 },
				spriteSourceSize = { width = 177, height = 98 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "4.png",
				spriteColorRect = { x = 0, y = 0, width = 78, height = 103 },
				textureRect = { x = 2, y = 152, width = 78, height = 103 },
				spriteSourceSize = { width = 78, height = 103 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "5.png",
				spriteColorRect = { x = 0, y = 0, width = 117, height = 48 },
				textureRect = { x = 2, y = 2, width = 117, height = 48 },
				spriteSourceSize = { width = 117, height = 48 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "6.png",
				spriteColorRect = { x = 0, y = 0, width = 129, height = 109 },
				textureRect = { x = 82, y = 152, width = 129, height = 109 },
				spriteSourceSize = { width = 129, height = 109 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

