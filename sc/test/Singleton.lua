--[[
-- added by wsh @ 2017-12-05
-- 单例类
--]]

local Singleton = BaseClass("Singleton");

function Singleton.__init(cls_obj)
	assert(rawget(cls_obj._class_type, "Instance") == nil, cls_obj._class_type.__cname.." to create singleton twice!")
	rawset(cls_obj._class_type, "Instance", cls_obj)
end

function Singleton.__delete(cls_obj)
	rawset(cls_obj._class_type, "Instance", nil)
end

-- 不要重写
function Singleton:GetInstance()
	if rawget(self, "Instance") == nil then
		rawset(self, "Instance", self.New())
	end
	assert(self.Instance ~= nil)
	return self.Instance
end

-- 只是用于启动模块
function Singleton:Startup()
end

-- 不要重写
function Singleton:Destory()
	self.Instance = nil
end

return Singleton;