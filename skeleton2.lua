-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:f77322e2bb8a73ff423f20e60c5a6edf$
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
				name = "1.png",
				spriteColorRect = { x = 0, y = 0, width = 69, height = 82 },
				textureRect = { x = 181, y = 72, width = 69, height = 82 },
				spriteSourceSize = { width = 69, height = 82 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "2.png",
				spriteColorRect = { x = 0, y = 0, width = 75, height = 82 },
				textureRect = { x = 2, y = 156, width = 75, height = 82 },
				spriteSourceSize = { width = 75, height = 82 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "3.png",
				spriteColorRect = { x = 0, y = 0, width = 108, height = 79 },
				textureRect = { x = 139, y = 156, width = 108, height = 79 },
				spriteSourceSize = { width = 108, height = 79 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "4.png",
				spriteColorRect = { x = 0, y = 0, width = 177, height = 81 },
				textureRect = { x = 2, y = 2, width = 177, height = 81 },
				spriteSourceSize = { width = 177, height = 81 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "5.png",
				spriteColorRect = { x = 0, y = 0, width = 58, height = 81 },
				textureRect = { x = 79, y = 156, width = 58, height = 81 },
				spriteSourceSize = { width = 58, height = 81 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "6.png",
				spriteColorRect = { x = 0, y = 0, width = 73, height = 68 },
				textureRect = { x = 181, y = 2, width = 73, height = 68 },
				spriteSourceSize = { width = 73, height = 68 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "7.png",
				spriteColorRect = { x = 0, y = 0, width = 85, height = 13 },
				textureRect = { x = 2, y = 240, width = 85, height = 13 },
				spriteSourceSize = { width = 85, height = 13 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

