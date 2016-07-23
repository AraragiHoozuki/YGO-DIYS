--淨龍 艾爾德爾
function c51696009.initial_effect(c)
	--cannot special summon
	local e=Effect.CreateEffect(c)
	e:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(EFFECT_SPSUMMON_CONDITION)
	e:SetValue(aux.FALSE)
	c:RegisterEffect(e) 
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	e1:SetLabel(3)
	e1:SetCondition(c51696009.cond)
	c:RegisterEffect(e1)
	--cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE)
	e2:SetTarget(c51696009.e2tg)
	e2:SetLabel(5)
	e2:SetCondition(c51696009.cond)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c51696009.e3val)
	e3:SetLabel(8)
	e3:SetCondition(c51696009.cond)
	c:RegisterEffect(e3)  
	--destruir
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetLabel(12)
	e4:SetCondition(c51696009.cond)
	e4:SetTarget(c51696009.e4tg)
	e4:SetOperation(c51696009.e4op)
	c:RegisterEffect(e4) 
end
function c51696009.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetLevel()>=e:GetLabel()
end
function c51696009.e2tg(e,c)
	return c:IsType(TYPE_EFFECT)
end

function c51696009.e3filter(c)
	return c:IsType(TYPE_MONSTER)
end

function c51696009.e3val(e,c)
	return Duel.GetMatchingGroupCount(c51696009.e3filter,0,LOCATION_GRAVE,LOCATION_GRAVE,nil)*900
end

function c51696009.e4tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c51696009.e4op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end