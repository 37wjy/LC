--[[
-- added by wsh @ 2017-12-11
-- table扩展工具类，对table不支持的功能执行扩展
-- 注意：
-- 1、所有参数带hashtable的函数，将把table当做哈希表对待
-- 2、所有参数带array的函数，将把table当做可空值数组对待
-- 3、所有参数带tb的函数，对表通用，不管是哈希表还是数组
--]]

-- 计算哈希表长度
local function count(hashtable)
	local count = 0
	for _,_ in pairs(hashtable) do
		count = count + 1
	end
	return count
end

-- 计算数据长度
local function length(array)
	if array.n ~= nil then
		return array.n
	end
	
	local count = 0
	for i,_ in pairs(array) do
		if count < i then
			count = i
		end		
	end
	return count
end

-- 设置数组长度
local function setlen(array, n)
	array.n = n
end

-- 获取哈希表所有键
local function keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

-- 获取哈希表所有值
local function values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

-- 合并哈希表：将src_hashtable表合并到dest_hashtable表，相同键值执行覆盖
local function merge(dest_hashtable, src_hashtable)
    for k, v in pairs(src_hashtable) do
        dest_hashtable[k] = v
    end
end

-- 合并数组：将src_array数组从begin位置开始插入到dest_array数组
-- 注意：begin <= 0被认为没有指定起始位置，则将两个数组执行拼接
local function insertto(dest_array, src_array, begin)
	assert(begin == nil or type(begin) == "number")
	if begin == nil or begin <= 0 then
		begin = #dest_array + 1
	end

	local src_len = #src_array
	for i = 0, src_len - 1 do
		table.insert(dest_array,i + begin,src_array[i + 1])
		-- dest_array[i + begin] = src_array[i + 1]
	end
end

-- 从数组中查找指定值，返回其索引，没找到返回false
local function indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then 
			return i 
		end
    end
	return false
end

-- 从哈希表查找指定值，返回其键，没找到返回nil
-- 注意：
-- 1、containskey用hashtable[key] ~= nil快速判断
-- 2、containsvalue由本函数返回结果是否为nil判断
local function keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then 
			return k 
		end
    end
    return nil
end

-- 从数组中删除指定值，返回删除的值的个数
function table.removebyvalue(array, value, removeall)
    local remove_count = 0
	for i = #array, 1, -1 do
		if array[i] == value then
			table.remove(array, i)
			remove_count = remove_count + 1
            if not removeall then 
				break 
			end
		end
	end
	return remove_count
end

-- 遍历写：用函数返回值更新表格内容
local function map(tb, func)
    for k, v in pairs(tb) do
        tb[k] = func(k, v)
    end
end

-- 遍历读：不修改表格
local function walk(tb, func)
    for k,v in pairs(tb) do
        func(k, v)
    end
end

-- 按指定的排序方式遍历：不修改表格
local function walksort(tb, sort_func, walk_func)
	local keys = table.keys(tb)
	table.sort(keys, function(lkey, rkey)
		return sort_func(lkey, rkey)
	end)
	for i = 1, table.length(keys) do
		walk_func(keys[i], tb[keys[i]])
	end
end

-- 过滤掉不符合条件的项：不对原表执行操作
local function filter(tb, func)
	local filter = {}
    for k, v in pairs(tb) do
        if not func(k, v) then 
			filter[k] = v
		end
    end
	return filter
end

-- 筛选出符合条件的项：不对原表执行操作
local function choose(tb, func)
	local choose = {}
    for k, v in pairs(tb) do
        if func(k, v) then 
			choose[k] = v
		end
    end
	return choose
end

-- 获取数据循环器：用于循环数组遍历，每次调用走一步，到数组末尾从新从头开始
local function circulator(array)
	local i = 1
	local iter = function()
		i = i >= #array and 1 or i + 1
		return array[i]
	end
	return iter
end

local function equal(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do
			if b[k] then 
				if type(v) == "table" and type(b[k]) == "table" then
					if not equal(v, b[k]) then
						return false
					end
				else
					if b[k] ~= v then
						return false
					end
				end
			else
				return false
			end
		end

		for k, v in pairs(b) do
			if a[k] then 
				if type(v) == "table" and type(a[k]) == "table" then
					if not equal(v, a[k]) then
						return false
					end
				else
					if a[k] ~= v then
						return false
					end
				end
			else
				return false
			end
		end

		return true
	else
		return false
	end
end

-- dump表
local function dump(tb, dump_metatable, max_level)
	if type(tb) ~= "table" then return tb end
	local lookup_table = {}
	local level = 0
	local rep = string.rep
	local dump_metatable = dump_metatable
	local max_level = max_level or 1

	local function _dump(tb, level)
		local str = "\n" .. rep("\t", level) .. "{\n"
		for k,v in pairs(tb) do
			local k_is_str = type(k) == "string" and 1 or 0
			local v_is_str = type(v) == "string" and 1 or 0
			str = str..rep("\t", level + 1).."["..rep("\"", k_is_str)..(tostring(k) or type(k))..rep("\"", k_is_str).."]".." = "
			if type(v) == "table" then
				if not lookup_table[v] and ((not max_level) or level < max_level) then
					lookup_table[v] = true
					str = str.._dump(v, level + 1, dump_metatable).."\n"
				else
					-- str = str..(tostring(v) or type(v))..",\n"
					str = str.._dump(v, level + 1).."\n"
				end
			else
				str = str..rep("\"", v_is_str)..(tostring(v) or type(v))..rep("\"", v_is_str)..",\n"
			end
		end
		if dump_metatable then
			local mt = getmetatable(tb)
			if mt ~= nil and type(mt) == "table" then
				str = str..rep("\t", level + 1).."[\"__metatable\"]".." = "
				if not lookup_table[mt] and ((not max_level) or level < max_level) then
					lookup_table[mt] = true
					str = str.._dump(mt, level + 1, dump_metatable).."\n"
				else
					str = str..(tostring(v) or type(v))..",\n"
				end
			end
		end
		str = str..rep("\t", level) .. "},"
		return str
	end
	
	return _dump(tb, level)
end

local function contains(tb, val)
    for _, value in ipairs(tb) do
        if value == val then
            return true
        end
    end
    return false
end

local function removeElementByKey(tbl,key)
    --新建一个临时的table
    local tmp ={}

    --把每个key做一个下标，保存到临时的table中，转换成{1=a,2=c,3=b} 
    --组成一个有顺序的table，才能在while循环准备时使用#table
    for i in pairs(tbl) do
        table.insert(tmp,i)
    end

    local newTbl = {}
    --使用while循环剔除不需要的元素
    local i = 1
    while i <= #tmp do
        local val = tmp[i]
        if val == key then
            --如果是需要剔除则remove 
            table.remove(tmp,i)
         else
            --如果不是剔除，放入新的tabl中
            newTbl[val] = tbl[val]
            i = i + 1
         end
     end
    return newTbl
end


local function clone(object)
    local lookup_table = {}
    local function copy(object) 
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[copy(key)] = copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return copy(object)
end

-- 遍历查找 table 中第一个符合条件的元素，如果找到，返回 key, value ,否则返回 nil
--func: (v)=>bool 参数为tb中被查询元素，返回值为 bool 的匿名函数
local function some(tb, func)
	for k,v in pairs(tb) do
		if func(v) == true then
			return k,v
		end
	end
	return nil
end

local function picknumber(tb, default, ...)
	local tmp = tb
	for i,v in ipairs{...} do
		if type(tmp) == "table" then
			if tmp[v] then
				tmp = tmp[v]
			else
				return default or "nil"
			end
		else
			return tmp
		end
	end
	return tmp
end

local function pickint(tb, default, ...)
    local v = picknumber(tb, default, ...)
	if type(v) == "number" then 
		return math.floor(v)
	else
		return default or 0
	end
end

-- added by Hua Zeru, return max and min of a table
-- func -> return if the first arg is greater than the second
local function maxmin(tb, func, ...)
	if not tb or count(tb) == 0 then return nil, nil end
	if func == nil then
		func = function(a, b)
			return a > b
		end
	end
	local max = nil
	local min = nil
	for k, v in pairs(tb) do
		if max == nil then
			max = v
			min = v
		else
			if func(v, max, ...) then max = v end
			if func(min, v, ...) then min = v end
		end
	end
	return max, min
end

local function tojson(tb)
	local function _tojson(tb)
		local temp = {}
		for key, value in pairs(tb) do
			if type(value) ~= "table" then
				table.insert(temp, string.format("\"%s\":\"%s\"", key, value))
			else
				table.insert(temp, string.format("\"%s\":%s", key, _tojson(value)))
			end
		end
		local res = "{" .. table.concat(temp, ",") .. "}"
		return res
	end
	return _tojson(tb)
end

--add by wjy copy and return a shuffled table
local function shuffle(tb)
	local t=table.clone(tb)
	if type(t)~="table" then
        return
    end
    local tab={}
    local index=1
    while #t~=0 do
        local n=math.random(0,#t)
		if t[n]~=nil then
            tab[index]=table.remove(t,n)
            index=index+1
        end
	end
    return tab
end

local function slice(tb,first,last)
	if type(tb)~='table' then
		return
	end
	local temp={}
	if type(first)=='table' then
		for _, index in pairs(first) do
			table.insert(temp,tb[index])
		end
	else
		for i = first, last do
			table.insert(temp,tb[i])
		end
	end
	return temp
end

table.count = count
table.length = length
table.setlen = setlen
table.keys = keys
table.values = values
table.merge = merge
table.insertto = insertto
table.indexof = indexof
table.keyof = keyof
table.map = map
table.walk = walk
table.walksort = walksort
table.filter = filter
table.choose = choose
table.circulator = circulator
table.dump = dump
table.contains = contains
table.removeElementByKey = removeElementByKey
table.clone = clone
table.equal = equal
table.some = some
table.number = picknumber
table.int = pickint
table.maxmin = maxmin
table.tojson = tojson
table.shuffle = shuffle
table.slice = slice