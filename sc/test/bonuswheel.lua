--[[
BonusWheel.lua
Author: wjy
Date: 2020/
Description:就是个lua版本转轮
            欲用此包
            先加BonusWheel 或 SpinWheel
            你若不加 #滑稽
--]]

local BonusWheel = BaseClass("BonusWheel", Updatable)

--[[
    参数：
    duration    转动时间，同脚本
    prizeCount  转盘分区数，同脚本
    round       转几圈，同脚本
    onWheelStop 转盘停止callback，同脚本
    offset      转盘偏移，左加右减

    若想调曲线 
    c#脚本加这个，用完记得删了
    public bool Debug=false;
    public int curveIndex=0;
    
    TODO 加入持续转动功能
]]


    --[[ lua 淦 c艹艹 ]]
function BonusWheel.__init(cls_obj,target_trans,params)
    cls_obj._transform=target_trans
    cls_obj._spinning = false
    cls_obj._component = UIUtil.FindComponent(target_trans,typeof(CS.Bole.BonusWheel)) or UIUtil.FindComponent(target_trans,typeof(CS.Bole.SpinWheel)) or error ('BonusWheel 或 SpinWheel 脚本丢啦  _(:ι」∠)_')

    cls_obj._animationCurves=cls_obj._component.animationCurves
    local resetRotationOnEnable = cls_obj._component.resetRotationOnEnable or false

    cls_obj.duration = params.duration or cls_obj._component.duration
    cls_obj.prizeCount = params.prizeCount or cls_obj._component.prizeCount
    cls_obj.round = params.round or cls_obj._component.round
    cls_obj.onWheelStop = params.onWheelStop or nil
    cls_obj.offset= params.offset or 0
    cls_obj.updateHandler=params.updateHandler

    cls_obj._anglePerItem = 360 / cls_obj.prizeCount
    if resetRotationOnEnable then
        target_trans.localEulerAngles=Vector3.zero
    end
end

function BonusWheel.__delete(cls_obj)
	cls_obj:OnDestroy()
end

function BonusWheel:OnDestroy()
end



--[[
        1
    2       8 
   3         7
    4       6
        5         这样的 ]]
function BonusWheel:StartSpin(targetIndex,curveIndex)

    --调试模式 便于调表现
    if self._component.Debug then
        curveIndex=self._component.curveIndex 
        self.duration=self._component.duration or self.duration
        self.round=self._component.round
        self._animationCurves=self._component.animationCurves
    end

    local angleToRotate = -self.round * 360.0 - ((targetIndex - 1) * self._anglePerItem)+self.offset
    self._animationCurves=self._component.animationCurves  --debug 模式 自己在cs里加变量
    self._spinning = true
    self._timer = 0.0
    self._startAngle = self._transform.localEulerAngles.z
    self._targetAngle = angleToRotate
    if Config.Debug and Config.Debug_System then
        Logger.Log("bonus wheel tar "..targetIndex.." tar angle "..(angleToRotate%360).." angle diff "..angleToRotate - self._startAngle.." #傻笑")
    end
    self._targetCurve = self._animationCurves[math.random(0, self._animationCurves.Count-1)]
    if curveIndex and curveIndex<self._animationCurves.Count and self._animationCurves.Count>=0 then
        self._targetCurve = self._animationCurves[math.floor(curveIndex)]
    end
    return self._targetAngle
end

--[[ 
    持续转动，可沿用速度曲线
    param: 
 ]]
function BonusWheel:Rotate(params)
    --设定初始速度或者沿用上个状态的瞬时速度
    local Va=params.angleSpd or ((self._targetAngle-self._startAngle) * self._targetCurve:Evaluate( self._timer / self.duration)-(self._targetAngle-self._startAngle) * self._targetCurve:Evaluate( (self._timer - Time.deltaTime)/ self.duration))/Time.deltaTime
end


function BonusWheel:Update()
   
    if not  self._spinning then
        return
    end
    if self._timer < self.duration then
        self._timer = Time.deltaTime + self._timer
        local sampledAngle , angleDelta = (self._targetAngle-self._startAngle) * self._targetCurve:Evaluate( self._timer / self.duration) , (self._targetAngle-self._startAngle) * self._targetCurve:Evaluate( self._timer / self.duration)-(self._targetAngle-self._startAngle) * self._targetCurve:Evaluate( (self._timer - Time.deltaTime)/ self.duration)

         if not self._transform then
            self:OnDestroy()
         end
         self._transform.localEulerAngles = Vector3.New(0.0, 0.0, self._startAngle + sampledAngle)
         
         if self.updateHandler then
             self.updateHandler(self,sampledAngle,angleDelta)
         end
    else
         self._spinning = false
         if not self._transform then
            self:OnDestroy()
         end
         self._transform.localEulerAngles=Vector3.New(0,0,self._targetAngle)--要不直接转歪了
        if self.onWheelStop ~= nil then
            self.onWheelStop()
        end
    end
end

return BonusWheel