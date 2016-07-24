--龍騎士奧依菲
function c51696014.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c51696014.e1cond)
	c:RegisterEffect(e1)	
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_DRAGON))
	c:RegisterEffect(e2)
end
function c51696014.filter(c)
	return c:IsRace(RACE_DRAGON)
end
function c51696014.e1cond(e,c)
	if c==nil then return true end
	return Duel.GetMatchingGroupCount(c51696014.filter,c:GetControler(),LOCATION_MZONE,0,nil)>0 and Duel.GetMatchingGroupCount(c51696014.filter,c:GetControler(),LOCATION_MZONE,0,nil)==Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end