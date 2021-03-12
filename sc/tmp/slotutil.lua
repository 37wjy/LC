local SlotUtils = {}

function SlotUtils.GetCoinsString(coin)
	if coin < 1e+3 then
		return string.format("%.0f",coin) 
	elseif coin >= 1e+3 and coin < 1e+6 then
		if coin%1e+3 >= 1e+2 then
			return string.format("%.1fK",coin/1e+3) 
		else
			return string.format("%.0fK",coin/1e+3) 
		end
	elseif coin >= 1e+6 and coin < 1e+9 then
		if coin%1e+6 >= 1e+5 then
			return string.format("%.1fM",coin/1e+6) 
		else
			return string.format("%.0fM",coin/1e+6) 
		end
	elseif coin >= 1e+9 and coin < 1e+12 then
		if coin%1e+9 >= 1e+8 then
			return string.format("%.1fB",coin/1e+9) 
		else
			return string.format("%.0fB",coin/1e+9) 
		end
	elseif coin >= 1e+12 and coin < 1e+15 then
		if coin%1e+12 >= 1e+11 then
			return string.format("%.1fT",coin/1e+12) 
		else
			return string.format("%.0fT",coin/1e+12) 
		end
	else
		if coin%1e+15 >= 1e+14 then
			return string.format("%.1fQ",coin/1e+15) 
		else
			return string.format("%.0fQ",coin/1e+15) 
		end
	end	
end

function SlotUtils.GetDollarString(coin)
	if coin < 1e+3 then
		return string.format("$%.0f",coin) 
	elseif coin >= 1e+3 and coin < 1e+6 then
		if coin%1e+3 >= 1e+2 then
			return string.format("$%.1fK",coin/1e+3) 
		else
			return string.format("$%.0fK",coin/1e+3) 
		end
	elseif coin >= 1e+6 and coin < 1e+9 then
		if coin%1e+6 >= 1e+5 then
			return string.format("$%.1fM",coin/1e+6) 
		else
			return string.format("$%.0fM",coin/1e+6) 
		end
	elseif coin >= 1e+9 and coin < 1e+12 then
		if coin%1e+9 >= 1e+8 then
			return string.format("$%.1fB",coin/1e+9) 
		else
			return string.format("$%.0fB",coin/1e+9) 
		end
	elseif coin >= 1e+12 and coin < 1e+15 then
		if coin%1e+12 >= 1e+11 then
			return string.format("$%.1fT",coin/1e+12) 
		else
			return string.format("$%.0fT",coin/1e+12) 
		end
	else
		if coin%1e+15 >= 1e+14 then
			return string.format("$%.1fQ",coin/1e+15) 
		else
			return string.format("$%.0fQ",coin/1e+15) 
		end
	end	
end

function SlotUtils.PreprocessConfig(config_lua, reels_object, theme_symbol_list, theme_icon_list)
	-- Set Sprite List
	config_lua.SYMBOL_SPRITE = {}
	config_lua.SYMBOL_SPRITE_SIZE = {}
	config_lua.SYMBOL_SPRITE_PIVOT = {}
	for symbol_id, list_index in pairs(config_lua.SYMBOL_LIST) do
		if theme_symbol_list[list_index] and theme_symbol_list[list_index].sprite then
			config_lua.SYMBOL_SPRITE[symbol_id] = theme_symbol_list[list_index].sprite
			config_lua.SYMBOL_SPRITE_SIZE[symbol_id] = theme_symbol_list[list_index].sprite.rect.size
			-- 生成的是比例,没有做任何的处理，保证了按照美术切的图的重心来摆放（在父容器中的位置）
			local pivot_x = theme_symbol_list[list_index].sprite.pivot.x / theme_symbol_list[list_index].sprite.rect.size.x
			local pivot_y = theme_symbol_list[list_index].sprite.pivot.y / theme_symbol_list[list_index].sprite.rect.size.y
			-- 长symbol特殊处理
			if config_lua.LONG_SYMBOL_PIVOT_LIST and config_lua.LONG_SYMBOL_PIVOT_LIST[symbol_id] then
				pivot_y = config_lua.LONG_SYMBOL_PIVOT_LIST[symbol_id]
			end
			config_lua.SYMBOL_SPRITE_PIVOT[symbol_id] = Vector2.New(pivot_x, pivot_y)
		else
			config_lua.SYMBOL_SPRITE[symbol_id] = nil
			config_lua.SYMBOL_SPRITE_SIZE[symbol_id] = nil
			config_lua.SYMBOL_SPRITE_PIVOT[symbol_id] = nil
		end
	end
    -- Set Icon List
	config_lua.ICON_SPRITE = {}
	config_lua.ICON_SPRITE_SIZE = {}
	config_lua.ICON_SPRITE_PIVOT = {}
	for icon_id, list_index in pairs(config_lua.SYMBOL_ICON_LIST) do
		config_lua.ICON_SPRITE[icon_id] = theme_icon_list[list_index].sprite
		config_lua.ICON_SPRITE_SIZE[icon_id] = theme_icon_list[list_index].sprite.rect.size
		config_lua.ICON_SPRITE_PIVOT[icon_id] = Vector2.New(
			theme_icon_list[list_index].sprite.pivot.x / theme_icon_list[list_index].sprite.rect.size.x,
			theme_icon_list[list_index].sprite.pivot.y / theme_icon_list[list_index].sprite.rect.size.y
		)
	end
	-- Reels List
	config_lua.REELS = {}
	local up_symbol_count = config_lua.BOARD_INFO.upSymbolCount
	local down_symbol_count = config_lua.BOARD_INFO.downSymbolCount
	local symbol_height = config_lua.BOARD_INFO.symbolHeight
	for reel_index = 0, reels_object.transform.childCount - 1 do
		local temp_reel = nil
		local mask_trans = UIUtil.FindTrans(reels_object.transform, "mask" .. (reel_index + 1))
		if mask_trans then
			temp_reel = mask_trans:GetChild(0)
		else
			temp_reel = reels_object.transform:GetChild(reel_index)
		end
		local symbol_positions = {}
		local symbols = {}
		for i = 0, temp_reel.childCount - 1 do
			local temp_symbol = temp_reel:GetChild(i)
			temp_symbol.transform.localPosition = Vector2.New(0, (((temp_reel.childCount + up_symbol_count - down_symbol_count) / 2 - i - 0.5) * symbol_height))
			--初始化静态字的trans
			local fix_text = nil
			if config_lua.FIX_TEXT_TABLE then
				fix_text={}
				for trans_path, _ in pairs(config_lua.FIX_TEXT_TABLE) do
					fix_text[trans_path]=UIUtil.FindText(temp_symbol, tostring(trans_path))
				end
			end

			table.insert(symbol_positions, temp_symbol.transform.localPosition)
			table.insert(symbols, {
				transform = temp_symbol.transform,
				gameObject = temp_symbol.gameObject,
				image = UIUtil.FindImage(temp_symbol, "Image"),
				icon = UIUtil.FindImage(temp_symbol, "Icon"),
				text = UIUtil.FindText(temp_symbol, "Text"),
				fix_text = fix_text,
			})
		end
		config_lua.REELS[reel_index + 1] = {
			REEL_GAME_OBJECT = temp_reel.gameObject,
			SYMBOLS = symbols,
			SYMBOL_HEIGHT = symbol_height,
			SYMBOL_POSITIONS = symbol_positions,
			UP_SYMBOL_COUNT = up_symbol_count,
			DOWN_SYMBOL_COUNT = down_symbol_count,
		}
	end
	return config_lua
end

return SlotUtils