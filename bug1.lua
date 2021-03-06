-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:9c341ee39109747a16c109800931e3ce$
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
				spriteColorRect = { x = 0, y = 0, width = 60, height = 38 },
				textureRect = { x = 2, y = 86, width = 60, height = 38 },
				spriteSourceSize = { width = 60, height = 38 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "1.png",
				spriteColorRect = { x = 0, y = 0, width = 63, height = 38 },
				textureRect = { x = 2, y = 46, width = 63, height = 38 },
				spriteSourceSize = { width = 63, height = 38 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "2.png",
				spriteColorRect = { x = 0, y = 0, width = 69, height = 42 },
				textureRect = { x = 2, y = 2, width = 69, height = 42 },
				spriteSourceSize = { width = 69, height = 42 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet

