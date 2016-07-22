--[[
【戰士族／特殊召喚／效果】
這張卡不能通常召喚。從自己墓地把暗屬性和水屬性的怪獸各1隻除外的場合才能特殊召喚。
①：這張卡不會被戰鬥破壞。進行戰鬥使控制者受到的戰鬥傷害變成0。
②：只要這張卡在場上正面表示存在，每次有卡進入墓地時，給予對方1000點傷害。
--]]

--羅恩格林
function c10134066.initial_effect(c)
	c:EnableReviveLimit()

	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10134066,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c10134066.spcon)
	e2:SetOperation(c10134066.spop)
	c:RegisterEffect(e2)

	--battle
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)

	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c10134066.damop)
	c:RegisterEffect(e5)
end

function c10134066.spfilter(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost()
end
function c10134066.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10134066.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_WATER)
		and Duel.IsExistingMatchingCard(c10134066.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_DARK)
end
function c10134066.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c10134066.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_WATER)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c10134066.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_DARK)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end


function c10134066.damop(e,tp,eg,ep,ev,re,r,rp)
	local d1=eg:FilterCount(aux.TRUE,nil,tp)*1000
	Duel.Damage(1-tp,d1,REASON_EFFECT)
end