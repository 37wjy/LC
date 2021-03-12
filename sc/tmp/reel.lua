local SlotGameReel = BaseClass("SlotGameReel")

local TRANSFORM = CS.SlotGameEngine.SlotLuaUtility.TransformLocalPositionY -- 改坐标函数封装
local NORMAL_COLOR = Color(1,1,1,1) -- 白色
local MASK_COLOR = Color(0.5,0.5,0.5,0.8) -- 压黑
local DEFAULT_SYMBOLE_SIZE = Vector2.New(10, 10) -- 默认尺寸
local DEFAULT_SYMBOLE_PIVOT = Vector2.New(0.5, 0.5) -- 默认锚点

function SlotGameReel.__init(cls_obj, board, reel_config, column)
	cls_obj.board = board -- 所依附的板子
	cls_obj.COLUMN = column -- 在所依附的板子中的列数 
	cls_obj.reelConfig = reel_config -- 该轴的相关配置，在SlotUtils.PreprocessConfig中自动生成
	
	cls_obj.reelTransform = cls_obj.reelConfig.REEL_GAME_OBJECT.transform -- 轴对象
	cls_obj.UP_SYMBOL_COUNT = cls_obj.reelConfig.UP_SYMBOL_COUNT -- 可视区域上方symbol数量
	cls_obj.DOWN_SYMBOL_COUNT = cls_obj.reelConfig.DOWN_SYMBOL_COUNT -- 可视区域下方symbol数量
	cls_obj.START_SYMBOL_INDEX = 1 - cls_obj.UP_SYMBOL_COUNT -- reel从上至下第一个symbol的index，可能为负值
	cls_obj.END_SYMBOL_INDEX = table.length(cls_obj.reelConfig.SYMBOLS) - cls_obj.UP_SYMBOL_COUNT -- reel从上至下最后一个symbol的index
	cls_obj.ROW_COUNT = table.length(cls_obj.reelConfig.SYMBOLS) - cls_obj.UP_SYMBOL_COUNT - cls_obj.DOWN_SYMBOL_COUNT -- 可视区域行数

	cls_obj.spinning = false
	cls_obj.stopping = false
	cls_obj.bouncing = false
	cls_obj.holding = false
	cls_obj.startTriggerNextReel = false
	cls_obj.symbolListIndex = math.random(1, #cls_obj.board.reelsSymbolTable[cls_obj.COLUMN])
	cls_obj.maskColor = nil

	-- 初始化symbol对象
	cls_obj.symbols = {}
	for index = 1, #cls_obj.reelConfig.SYMBOLS do
		cls_obj.symbols[index - cls_obj.UP_SYMBOL_COUNT] = cls_obj.reelConfig.SYMBOLS[index]
	end

	-- 初始化牌面
	cls_obj:GenerateNewReelSymbol()
end

function SlotGameReel.__delete(cls_obj)
	cls_obj:OnDestroy()
end

function SlotGameReel:OnDestroy()
	self.board = nil
	self.reelConfig = nil
	self.reelTransform = nil
	self.symbols = nil
end

-- 生成新的轮轴牌面
function SlotGameReel:GenerateNewReelSymbol()
	if self.board.configLua.BOARD_INIT_TABLE then
		local symbol_list_index = math.random(1, #self.board.configLua.BOARD_INIT_TABLE[self.COLUMN])
		local reel_symbol_list = self.board.configLua.BOARD_INIT_TABLE[self.COLUMN]
		for index = self.START_SYMBOL_INDEX, self.END_SYMBOL_INDEX do
			symbol_list_index = symbol_list_index % #reel_symbol_list + 1
			self:SetReelSymbol(index, reel_symbol_list[symbol_list_index])
		end
	else
		for index = self.START_SYMBOL_INDEX, self.END_SYMBOL_INDEX do
			self:SetReelSymbol(index, self:GenerateNewSymbolId())
		end
	end
end

-- 顺序取出table内的symbol id
function SlotGameReel:GenerateNewSymbolId()
	self.reelSymbolList = self.reelSymbolList or self.board.reelsSymbolTable[self.COLUMN]
	self.symbolListIndex = self.symbolListIndex % #self.reelSymbolList + 1
	return self.reelSymbolList[self.symbolListIndex]
end

function SlotGameReel:Update()
	if self.startTriggerNextReel then
		self.stopInterval = self.stopInterval - Time.deltaTime
	end

	if not self.spinning  then return end
	if self.holding then return end
	
	local dt = Time.deltaTime
	local current_y = self.symbols[1].transform.localPosition.y -- 当前可视区域第一个的位置
	local original_y = self.reelConfig.SYMBOL_POSITIONS[1 + self.UP_SYMBOL_COUNT].y -- 原始可视区域第一个的位置

	if self.stopping then
		if self.stopOffset <= (self.END_SYMBOL_INDEX - self.START_SYMBOL_INDEX) then
			self:SymbolStop(dt, current_y, original_y) -- 开始停止了
		else
			if self.bouncing then
				self:SymbolBounce(dt, current_y, original_y) -- 开始回弹了
			else
				self:SymbolDive(dt, current_y, original_y) -- 下潜开始了
			end
		end
	else
		local delta_distance = -1 * self.board.configLua.BOARD_SPIN_INFO.speed * dt
		for _, symbol in pairs(self.symbols) do
			TRANSFORM(symbol.transform, delta_distance)
		end
		if original_y - current_y - delta_distance >= self.reelConfig.SYMBOL_HEIGHT then
			self:SymbolShiftDown(self:GenerateNewSymbolId())
		end
	end
end

-- 停止
function SlotGameReel:SymbolStop(dt, current_y, original_y)
	local stop_speed = self.board.configLua.BOARD_SPIN_INFO.stopSpeed or self.board.configLua.BOARD_SPIN_INFO.speed
	if self.fastStopping then
		stop_speed = self.board.configLua.BOARD_SPIN_INFO.fastStopSpeed
	end
	local delta_distance = -1 * stop_speed * dt
	for _, symbol in pairs(self.symbols) do
		TRANSFORM(symbol.transform, delta_distance)
	end

	if original_y - current_y - delta_distance >= self.reelConfig.SYMBOL_HEIGHT then
		if self.reelStopStart then
			self.reelStopStart = false
			self.board.baseHandler:ReelBeforeStopStartHandler(self.COLUMN)
		end

		-- 按照stop offset的配置逐一停止
		local new_symbol_id = nil
		local new_icon_id = nil
		if self.stopOffset < self.DOWN_SYMBOL_COUNT and self.stopOffset >= self.DOWN_SYMBOL_COUNT - #self.resultDown then
			-- 设置可视区域下方symbol
			new_symbol_id = self.resultDown[self.DOWN_SYMBOL_COUNT - self.stopOffset]
		elseif self.stopOffset >= self.DOWN_SYMBOL_COUNT and self.stopOffset < self.ROW_COUNT + self.DOWN_SYMBOL_COUNT then
			-- 设置可视区域symbol
			new_symbol_id = self.result[self.ROW_COUNT + self.DOWN_SYMBOL_COUNT - self.stopOffset]
			new_icon_id = self.iconResult[self.ROW_COUNT + self.DOWN_SYMBOL_COUNT - self.stopOffset]
		elseif self.stopOffset >= self.ROW_COUNT + self.DOWN_SYMBOL_COUNT and self.stopOffset < self.ROW_COUNT + self.DOWN_SYMBOL_COUNT + #self.resultUp then
			-- 设置可视区域上方symbol
			new_symbol_id = self.resultUp[self.stopOffset - self.ROW_COUNT - self.DOWN_SYMBOL_COUNT + 1]
		else
			new_symbol_id = self:GenerateNewSymbolId()
		end
		self:SymbolShiftDown(new_symbol_id, new_icon_id)
		self.stopOffset = self.stopOffset + 1
		
		-- 停止结束开始下潜
		if self.stopOffset > (self.END_SYMBOL_INDEX - self.START_SYMBOL_INDEX) then
			for index, symbol in pairs(self.symbols) do
				symbol.transform.localPosition = self.reelConfig.SYMBOL_POSITIONS[index + self.UP_SYMBOL_COUNT]
			end
			self.board.baseHandler:ReelStopStartHandler(self.COLUMN)
		end
	end
end

-- 下潜
function SlotGameReel:SymbolDive(dt, current_y, original_y)
	local dive_speed = self.board.configLua.BOARD_SPIN_INFO.diveSpeed
	if self.fastStopping then
		dive_speed = self.board.configLua.BOARD_SPIN_INFO.fastStopDiveSpeed
	end

	local delta_distance = -1 * dive_speed * dt
	for _, symbol in pairs(self.symbols) do
		TRANSFORM(symbol.transform, delta_distance)
	end

	local dive_height = self.board.configLua.BOARD_SPIN_INFO.diveHeight
	if self.fastStopping then
		dive_height =  self.board.configLua.BOARD_SPIN_INFO.fastStopDiveHeight
	end
	if original_y - current_y - delta_distance >= dive_height then
		self.bouncing = true -- 下潜结束了，准备开始回弹
		for index, symbol in pairs(self.symbols) do
			symbol.transform.localPosition.y = self.reelConfig.SYMBOL_POSITIONS[index + self.UP_SYMBOL_COUNT].y - dive_height
		end
	end
end

-- 回弹
function SlotGameReel:SymbolBounce(dt, current_y, original_y)
	local bounce_speed = self.board.configLua.BOARD_SPIN_INFO.bounceSpeed
	if self.fastStopping then
		bounce_speed = self.board.configLua.BOARD_SPIN_INFO.fastStopBounceSpeed
	end
	if original_y - current_y > 0 then
		-- 开始回弹了
		local delta_distance = bounce_speed * dt
		for _, symbol in pairs(self.symbols) do
			TRANSFORM(symbol.transform, delta_distance)
		end
	else
		-- 回弹结束了
		for index, symbol in pairs(self.symbols) do
			symbol.transform.localPosition = self.reelConfig.SYMBOL_POSITIONS[index + self.UP_SYMBOL_COUNT]
		end
		self.stopping = false
		self.spinning = false
		self.fastStopping = false
		self.board.baseHandler:ReelStopCompleteHandler(self.COLUMN)
	end
end

-- 每移动一个格子的距离，就把最底部的symbol移动到最顶部，同时刷新最顶部symbol的图标和位置
-- up_symbol: (1 - self.UP_SYMBOL_COUNT, ..., 0)
-- symbol_window: (1, 2, ..., #self.reelConfig.SYMBOLS - self.UP_SYMBOL_COUNT - self.DOWN_SYMBOL_COUNT)
-- down_symbol: (#self.reelConfig.SYMBOLS - self.UP_SYMBOL_COUNT - self.DOWN_SYMBOL_COUNT + 1, ..., #self.reelConfig.SYMBOLS - self.UP_SYMBOL_COUNT)
function SlotGameReel:SymbolShiftDown(new_symbol_id, icon_id)
	local last_symbol = nil
	for index=self.END_SYMBOL_INDEX, self.START_SYMBOL_INDEX, -1 do
		if index == self.END_SYMBOL_INDEX then
			last_symbol = self.symbols[index] 
			self.symbols[index] = nil
		end
		if index == self.START_SYMBOL_INDEX then
			self.symbols[index] = last_symbol
			self:SetReelSymbol(index, new_symbol_id, icon_id)
			local position = self.symbols[index + 1].transform.localPosition
			self.symbols[index].transform.localPosition = Vector3.New(position.x, position.y + self.reelConfig.SYMBOL_HEIGHT, position.z)
		else
			self.symbols[index] = self.symbols[index - 1]
		end
	end
end

-- 设置symbol信息
function SlotGameReel:SetReelSymbol(row, new_symbol_id, icon_id)
	-- 移除symbol上的挂载特效
	EffectsManager:GetInstance():RemoveEffectByParent(self.symbols[row].transform)

	-- 设置新的symbol
	self.symbols[row].symbol_id = new_symbol_id
	self.symbols[row].image.sprite = self.board.configLua.SYMBOL_SPRITE[new_symbol_id]
	if self.board.configLua.SYMBOL_SPRITE[new_symbol_id] then
		self.symbols[row].image.transform.sizeDelta = self.board.configLua.SYMBOL_SPRITE_SIZE[new_symbol_id]
		self.symbols[row].image.transform.pivot = self.board.configLua.SYMBOL_SPRITE_PIVOT[new_symbol_id]
	else
		self.symbols[row].image.transform.sizeDelta = DEFAULT_SYMBOLE_SIZE
		self.symbols[row].image.transform.pivot = DEFAULT_SYMBOLE_PIVOT
	end
	self.symbols[row].gameObject:SetActive(true)
	
	-- 重置symbol上的icon
	self.symbols[row].icon.gameObject:SetActive(false)
	if icon_id and icon_id > 0 then
		self:RefreshSymbolIcon(row, icon_id)
	end

	-- 设置symbol上的动态文本
	if self.board.configLua.DYNAMIC_TEXT_TABLE[new_symbol_id] and ThemeData:GetInstance():GetSpinBet() > 0 then
		self.symbols[row].text.text = SlotUtils.GetCoinsString(ThemeData:GetInstance():GetSpinBet() * self.board.configLua.DYNAMIC_TEXT_TABLE[new_symbol_id])
	else
		self.symbols[row].text.text = ""
	end

	-- 设置symbol上的静态文本
	if self.board.configLua.FIX_TEXT_TABLE and self.symbols[row].fix_text then
		for path, text in pairs(self.symbols[row].fix_text) do
			text.text = self.board.configLua.FIX_TEXT_TABLE[path][new_symbol_id] or ''
		end
	end

	-- 根据条件选择 1=压黑 2=隐藏，其他正常
	if self.situationTable then
		if self.situationTable[new_symbol_id] == 1 then
			self.symbols[row].image.color = self.maskColor or MASK_COLOR
			self.symbols[row].text.color = self.maskColor or MASK_COLOR
		elseif self.situationTable[new_symbol_id] == 2 then
			self.symbols[row].gameObject:SetActive(false)
		else
			self.symbols[row].image.color = NORMAL_COLOR
			self.symbols[row].text.color = NORMAL_COLOR
			self.symbols[row].gameObject:SetActive(self.situationTable[new_symbol_id] ~= 2)
		end
	end

	-- 排序，如果为特殊symbol则特殊判断，如果为普通symbol 一律排到最上面；如果和上一个symbol相同，则排在上一个symbol上方
	local curr_symbol_sort_index = self.board.configLua.SYMBOL_SORT_TABLE[new_symbol_id] or 0
	if curr_symbol_sort_index > 10 then
		local last_symbol_sort_index = self.board.configLua.SYMBOL_SORT_TABLE[self.lastSymbolId] or 0
		if curr_symbol_sort_index <= last_symbol_sort_index and row < #self.symbols then
			local sibling_index = self.symbols[row + 1].transform:GetSiblingIndex()
			self.symbols[row].transform:SetSiblingIndex(sibling_index > 0 and sibling_index - 1 or 0) -- index start from 0
		else
			self.symbols[row].transform:SetAsLastSibling()
		end
	else
		self.symbols[row].transform:SetAsFirstSibling()
	end
	self.lastSymbolId = new_symbol_id

	-- 对当前symbol进行定制处理（注意：初始化时也会调用）
	self.board.baseHandler:RefreshSymbolHandler(self.symbols[row], new_symbol_id, self.COLUMN)
end

function SlotGameReel:Completed()
	if self.spinning or self.stopping then
		return false
	end
	return true
end

function SlotGameReel:Spin()
	if self.holding then return end
	self.stopOffset = -self.board.configLua.BOARD_SPIN_INFO.stopOffset
	self.stopInterval = self.board.configLua.BOARD_SPIN_INFO.stopInterval
	self.startTriggerNextReel = false
	self.fastStopping = false
	self.stopping = false
	self.bouncing = false
	self.spinning = true

	self.result = {}
	self.resultUp = {}
	self.resultDown = {}
	self.iconResult = {}
	self.reelStopStart = true
	self:ActiveSymbols(true)
end

function SlotGameReel:Stop()
	if self.holding then return end
	if not self.spinning then return end
	if self.stopping then return end

	self.stopping = true
	self.startTriggerNextReel = true
	if self.board:TriggerNextReelStopDelay(self.COLUMN) then
		self.stopInterval = self.stopInterval + self.board.configLua.BOARD_SPIN_INFO.stopIntervalDelay
	end
end

function SlotGameReel:QuickStop()
	if self.holding then return end
	if not self.spinning then return end
	if self.fastStopping then return end

	self.stopping = true
	self.fastStopping = true
	self.stopInterval = self.board.configLua.BOARD_SPIN_INFO.fastStopInterval
	self.stopOffset = self.stopOffset < (-self.COLUMN) and (-self.COLUMN) or self.stopOffset
end

-- 按照结果刷新可视区域symbol
function SlotGameReel:RefershReelSymbolByResult()
	for index = 1, #self.result do
		self:SetReelSymbol(index, self.result[index], false)
	end
end

-- 设置可视区域结果
function SlotGameReel:ApplyResultItem(result, iconResult)
	if self.holding then return end
	self.result = result
	if not self.iconResult and iconResult then
		self.iconResult = iconResult
	end
end

-- 设置可视区域上方区域结果
function SlotGameReel:ApplyResultItemUp(result)
	self.resultUp = result
end

-- 设置可视区域下方区域结果
function SlotGameReel:ApplyResultItemDown(result)
	self.resultDown = result
end

-- 设置icon结果
function SlotGameReel:SetIconResult(iconResult)
	self.iconResult = iconResult
end

-- 刷新自定义排面
function SlotGameReel:RefreshSymbolWithCustomResult(result_column)
	if not result_column then return end
	for index=1, #result_column do
		if self.iconResult and self.iconResult[index] then
			self:SetReelSymbol(index, result_column[index], self.iconResult[index])
		else
			self:SetReelSymbol(index, result_column[index], false)
		end
	end
end

-- 刷新动态文字
function SlotGameReel:RefreshReelAllSymbolDynamicText()
	for _, symbol in ipairs(self.symbols) do
		if self.board.configLua.DYNAMIC_TEXT_TABLE[symbol.symbol_id] then
			symbol.text.text = SlotUtils.GetCoinsString(ThemeData:GetInstance():GetSpinBet() * self.board.configLua.DYNAMIC_TEXT_TABLE[symbol.symbol_id])
		end
	end
end

-- 自己设置Icon
function SlotGameReel:RefreshSymbolIcon(row, icon_index)
	self.symbols[row].icon.sprite = self.board.configLua.ICON_SPRITE[icon_index]
	self.symbols[row].icon.transform.sizeDelta = self.board.configLua.ICON_SPRITE_SIZE[icon_index]
	self.symbols[row].icon.transform.pivot = self.board.configLua.ICON_SPRITE_PIVOT[icon_index]
	self.symbols[row].icon.gameObject:SetActive(true)
end

-- 选择定制条件
function SlotGameReel:SetSituationTable(index, mask_color)
	self.situationTable = self.board.configLua.SITUATION_TABLE[index]
	self.maskColor = mask_color
end

-- 取消定制条件
function SlotGameReel:UnSetSituationTable()
	self.situationTable = nil
	self.maskColor = nil
end

-- 是否激活蒙板
function SlotGameReel:ActiveMask(is_active)
	if is_active then
		for _, symbol in ipairs(self.symbols) do
			symbol.image.color = self.maskColor or MASK_COLOR
			symbol.text.color = self.maskColor or MASK_COLOR
		end
	else
		for _, symbol in ipairs(self.symbols) do
			symbol.image.color = NORMAL_COLOR
			symbol.text.color = NORMAL_COLOR
		end
	end
end

-- 指定symbol_id激活蒙板
function SlotGameReel:ActiveMaskById(symbol_id)
	for _, symbol in ipairs(self.symbols) do
		if symbol_id == symbol.symbol_id then
			symbol.image.color = self.maskColor or MASK_COLOR
		    symbol.text.color = self.maskColor or MASK_COLOR
		end
	end
end

-- 是否激活symbols
function SlotGameReel:ActiveSymbols(is_active)
	for _, symbol in ipairs(self.symbols) do
		symbol.gameObject:SetActive(is_active)
	end
end

-- 是否触发下一个停止
function SlotGameReel:TriggerNextReelToStop()
	if self.startTriggerNextReel and self.stopInterval <= 0 then
		self.startTriggerNextReel = false
		return true
	end
	if self.holding then
		return true
	end
	return false
end

-- 牌面位移
function SlotGameReel:NudgeReel(offset, duration)
	coroutine.startcoroutine("C_SlotGameReel", "NudgeReel", function ()
		-- Nudge
		for index = self.START_SYMBOL_INDEX, self.END_SYMBOL_INDEX do
			self.symbols[index].transform:DOAnchorPosY(self.symbols[index].transform.localPosition.y - offset * self.reelConfig.SYMBOL_HEIGHT, duration, false)
		end
		-- 等待
		coroutine.waitforseconds(duration)
		-- 重置牌面
		local count = self.END_SYMBOL_INDEX - self.START_SYMBOL_INDEX + 1
		local old_symbols = table.clone(self.symbols)
		for index = self.START_SYMBOL_INDEX, self.END_SYMBOL_INDEX do
			local new_index = index - offset
			if new_index < self.START_SYMBOL_INDEX then
				new_index = self.END_SYMBOL_INDEX + new_index - self.START_SYMBOL_INDEX + 1
			elseif new_index > self.END_SYMBOL_INDEX then
				new_index = self.START_SYMBOL_INDEX + new_index - self.END_SYMBOL_INDEX - 1
			end
			self.symbols[index] = old_symbols[new_index]
			self.symbols[index].transform.localPosition = self.reelConfig.SYMBOL_POSITIONS[index + self.UP_SYMBOL_COUNT]
		end
	end)
end

return SlotGameReel

------------------------------------------------------------------------------
-- if not self.spinning  then 
-- 	if self._is_nudgeReel then
-- 		local offset = self._offset
-- 		local duration = self._duration
-- 		local delta_distance = -1 * self.config.SYMBOL_HEIGHT * offset / duration  * dt
-- 		-- 后面基本上是复制的 普通spin的时候
-- 		for _, symbol in pairs(self.symbols) do
-- 			TRANSFORM(symbol.transform, delta_distance)
-- 		end
-- 		if math.abs(original_y - current_y - delta_distance) >= self.config.SYMBOL_HEIGHT then
-- 			self:SymbolShiftDown(self:GenerateNewSymbolId(), nil, offset<0)
-- 			self._rest_offset = self._rest_offset - 1
-- 			if self._rest_offset == 0 then 
-- 				self._is_nudgeReel = false
-- 				for index, symbol in pairs(self.symbols) do
-- 					symbol.transform.localPosition = self.reelConfig.SYMBOL_POSITIONS[index + self.UP_SYMBOL_COUNT]
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return 
-- end
