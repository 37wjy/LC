local EffectsManager     = BaseClass("EffectsManager", Singleton)
local BaseSpineAnimation = require "Framework.Effect.BaseSpineAnimation"
local BaseUnityEffect    = require "Framework.Effect.BaseUnityEffect"
local BaseUnityAnimation = require "Framework.Effect.BaseUnityAnimation"

local spineList = {}
local unityEffects = {}
local unityAnimations = {}

-- local extra_params = {
-- 	path = nil, 
-- 	position = nil, 
-- 	world_stays = nil, 
-- 	animation_name = nil, 
-- 	loop = nil, 
-- 	duration = nil,
-- 	fly_info = nil,  
-- 	create_callback = nil, 
-- 	destroy_callback = nil, 
-- 	force_callback = nil
-- }

local function AddEffect(effect_type, parent_trans, prefab_obj, extra_params)
	if effect_type == 0 then
		local spine = BaseSpineAnimation.New(parent_trans, prefab_obj, extra_params)
		spineList[spine] = parent_trans
		return spine
--[[ 		if extra_params.fly_info and extra_params.fly_info.target_trans then
			spineList[spine] = extra_params.fly_info.target_trans
		else ]]
	--	end
	elseif effect_type == 1 then
		local effect = BaseUnityEffect.New(parent_trans, prefab_obj, extra_params)
		unityEffects[effect] = parent_trans
		return effect
--[[ 		if extra_params.fly_info and extra_params.fly_info.target_trans then
			unityEffects[effect] = extra_params.fly_info.target_trans
		else ]]
		--end
	elseif effect_type == 2 then
		local animation = BaseUnityAnimation.New(parent_trans.gameObject, prefab_obj, extra_params)
		unityAnimations[animation] = parent_trans
		return animation
	end
end

local function GetUILayerObject(layer, parent)
	if layer == CS.SlotGameEngine.EffectLayer.UI_BackGround_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.BackgroundLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.UI_Normal_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.NormalLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.UI_Top_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.TopLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.Above_All_Board_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.AboveAllBoardLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.Just_Above_All_Board_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.JustAboveAllBoardLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.UI_Footer_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.FooterLayer).transform
	elseif layer == CS.SlotGameEngine.EffectLayer.UI_Header_Layer then
		return UIManager:GetInstance():GetLayer(UILayers.HeaderLayer).transform
	else
		return parent
	end	
end

function EffectsManager:AddEffectByPath(effect_type, parent_trans, prefab_path)
	return AddEffect(effect_type, parent_trans, nil, {path = prefab_path})
end

function EffectsManager:AddEffectByConfig(parent, effect_config, extra_params, ...)
	if not effect_config then
		return
	end
	extra_params = extra_params or {}
	extra_params.duration = (effect_config.loop and 0 or effect_config.duration)
	extra_params.position = (extra_params.position and not IsNull(extra_params.position)) and extra_params.position  or parent.position 

	local prefab_obj = effect_config.prefab
	local parent_trans = nil
	if extra_params.board then
		parent_trans = extra_params.board:GetBoardLayerObject(effect_config.layer, parent)
	else
		parent_trans = GetUILayerObject(effect_config.layer, parent)
	end

	local effect_type = nil
	if effect_config.type == CS.SlotGameEngine.EffectType.SpineAnimation then
		effect_type = 0
	elseif effect_config.type == CS.SlotGameEngine.EffectType.UnityEffect then
		effect_type = 1
	elseif effect_config.type == CS.SlotGameEngine.EffectType.UnityAnimation then
		effect_type = 2
		parent_trans = parent
		prefab_obj = effect_config.clip
	end

	-- 创建回调
	extra_params.new_create_callback =  function (effect, gameobject)
		if extra_params.create_callback then
			extra_params.create_callback(effect, gameobject)
		end
	end
	-- 销毁回调
	local params = SafePack(...)
	extra_params.new_destroy_callback = function ()
		if extra_params.destroy_callback then
			extra_params.destroy_callback(SafeUnpack(params))
		end
	end

	return AddEffect(effect_type, parent_trans, prefab_obj, extra_params)
end

function EffectsManager:AddEffectList(parent, effect_config_list, extra_params, ...)
	if not effect_config_list then
		return
	end

	local effect_instance_list = {}
	for i = 0, effect_config_list.Count - 1 do
		table.insert(effect_instance_list, self:AddEffectByConfig(parent, effect_config_list[i], extra_params, ...))
	end

	return effect_instance_list
end

function EffectsManager:DeleteEffectList(effect_instance_list)
	if effect_instance_list then
		for _, v in ipairs(effect_instance_list) do
			self:RemoveEffect(v)
		end
	end
	effect_instance_list = nil
end

function EffectsManager:RemoveEffect(effect)
	if effect then
		effect:DisableAutoDestroySelf()
		effect:Delete()
	end
end

function EffectsManager:RemoveEffectByParent(parent_trans)
	local choose = {}
	table.merge(choose, table.choose(unityEffects, function(k, v)
		return v == parent_trans
	end))
	table.merge(choose, table.choose(unityAnimations, function(k, v)--value指的父节点
		return v == parent_trans
	end))
	table.merge(choose, table.choose(spineList, function(k, v)
		return v == parent_trans
	end))

	for k,v in pairs(choose) do
		k:DisableAutoDestroySelf()
		k:Delete()
	end
end

function EffectsManager:RemoveAllEffects()
	for k, _ in pairs(unityEffects) do
		k:DisableAutoDestroySelf()
		k:Delete()
	end
	unityEffects = {}
	for k, _ in pairs(unityAnimations) do
		k:DisableAutoDestroySelf()
		k:Delete()
	end
	unityAnimations = {}
	for k, _ in pairs(spineList) do
		k:DisableAutoDestroySelf()
		k:Delete()
	end
	spineList = {}
end

function EffectsManager:RemoveSpine(spine)
	spineList = table.removeElementByKey(spineList, spine)
end

function EffectsManager:RemoveUnityEffect(effect)
	unityEffects = table.removeElementByKey(unityEffects, effect)
end

function EffectsManager:RemoveAnimation(animation)
	unityAnimations = table.removeElementByKey(unityAnimations, animation)
end

return EffectsManager