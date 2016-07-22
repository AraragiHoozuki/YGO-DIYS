--深渊之刃
function c51696003.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c51696003.boostAtk)
	c:RegisterEffect(e1)	
end

function c51696003.boostAtk(e,c)
	local tp=c:GetControler()
	return Duel.GetLP(1-tp)
end