--[[
-- added by wsh @ 2017-11-30
-- Lua面向对象设计
--]]

--保存类类型的虚表
local _class = {}
 
-- added by wsh @ 2017-12-09
-- 自定义类型
ClassType = {
	class = 1,
	instance = 2,
}
 
function BaseClass(classname, super)
	assert(type(classname) == "string" and #classname > 0)
	-- 生成一个类类型
	local class_type = {}
	
	-- 在创建对象的时候自动调用
	class_type.__init = false
	class_type.__delete = false
	class_type.__cname = classname
	class_type.__ctype = ClassType.class
	
	class_type.super = super
	class_type.New = function(...)
		-- 生成一个类实例对象
		local cls_obj = {}
		cls_obj._class_type = class_type
		cls_obj.__ctype = ClassType.instance

		-- 在初始化之前注册基类方法
		setmetatable(cls_obj, { __index = _class[class_type]})

		-- 调用初始化方法
		do
			local create
			create = function(c, ...)
				if c.super then
					create(c.super, ...)
				end
				if c.__init then
					c.__init(cls_obj, ...)
				end
			end
			create(class_type, ...)
		end

		-- 注册一个delete方法
		function cls_obj:Delete()
			local now_super = self._class_type 
			while now_super ~= nil do	
				if now_super.__delete then
					now_super.__delete(self)
				end
				now_super = now_super.super
			end
		end

		return cls_obj
	end

	local vtbl = {}
	-- added by wsh @ 2017-12-08
	assert(_class[class_type] == nil, "Aready defined class : ", classname)
	_class[class_type] = vtbl
 
	setmetatable(class_type, {
		__newindex = function(t,k,v)
			vtbl[k] = v
		end
		, 
		--For call parent method
		__index = vtbl,
	})
 
	if super then
		setmetatable(vtbl, {
			__index = function(t,k)
				local ret = _class[super][k]
				--do not do accept, make hot update work right!
				--vtbl[k] = ret
				return ret
			end
		})
	end
 
	return class_type
end


-- 如果欧有机会和时间按照下面的方式重构成真的继承
-- function Class(classname, ...)
--     local cls = {__cname = classname}

--     local supers = {...}
--     for _, super in ipairs(supers) do
--         local superType = type(super)
--         assert(superType == "nil" or superType == "table" or superType == "function",
--             string.format("class() - create class \"%s\" with invalid super class type \"%s\"",
--                 classname, superType))

--         if superType == "function" then
--             assert(cls.__create == nil,
--                 string.format("class() - create class \"%s\" with more than one creating function",
--                     classname));
--             -- if super is function, set it to __create
--             cls.__create = super
--         elseif superType == "table" then
--             if super[".isclass"] then
--                 -- super is native class
--                 assert(cls.__create == nil,
--                     string.format("class() - create class \"%s\" with more than one creating function or native class",
--                         classname));
--                 cls.__create = function() return super:create() end
--             else
--                 -- super is pure lua class
--                 cls.__supers = cls.__supers or {}
--                 cls.__supers[#cls.__supers + 1] = super
--                 if not cls.super then
--                     -- set first super pure lua class as class.super
--                     cls.super = super
--                 end
--             end
--         else
--             error(string.format("class() - create class \"%s\" with invalid super type",
--                         classname), 0)
--         end
--     end

--     cls.__index = cls
--     if not cls.__supers or #cls.__supers == 1 then
--         setmetatable(cls, {__index = cls.super})
--     else
--         setmetatable(cls, {__index = function(_, key)
--             local supers = cls.__supers
--             for i = 1, #supers do
--                 local super = supers[i]
--                 if super[key] then return super[key] end
--             end
--         end})
--     end

--     if not cls.__ctor then
--         -- add default constructor
--         cls.__ctor = function() end
-- 	end

-- 	if not cls.__dtor then
--         -- add default destructor
--         cls.__dtor = function() end
-- 	end

--     cls.create = function(...)
--         local instance
--         if cls.__create then
--             instance = cls.__create(...)
--         else
--             instance = {}
--         end
--         setmetatableindex(instance, cls)
--         instance.class = cls
--         instance:__ctor(...)
--         return instance
-- 	end
	
--     cls.New = function(_, ...)
--         return cls.create(...)
-- 	end

--     return cls
-- end