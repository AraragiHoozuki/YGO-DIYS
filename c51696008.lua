--影龍 尼奧爾德
function c51696008.initial_effect(c)
	--cannot special summon
	local e=Effect.CreateEffect(c)
	e:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(EFFECT_SPSUMMON_CONDITION)
	e:SetValue(aux.FALSE)
	c:RegisterEffect(e) 
	--hand trap
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c51696008.e2cond)
	e2:SetTarget(c51696008.e2tg)
	e2:SetOperation(c51696008.e2op)
	c:RegisterEffect(e2)
	--summon with 0 tribute
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51696008,0))
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetCondition(c51696008.e3cond)
	e3:SetOperation(c51696008.e3op)
	--e3:SetValue(SUMMON_TYPE_ADVANCE+1)
	c:RegisterEffect(e3)
end

function c51696008.e2cond(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and e:GetHandler():GetLevel()>3
end
function c51696008.e2costfilter(c)
	return c:IsCode(c51696008)
end
function c51696008.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c51696008.e2op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(-2)
	e1:SetReset(RESET_TOGRAVE+RESET_REMOVE+RESET_TODECK)
	c:RegisterEffect(e1)  
end

function c51696008.e3cond(e,c)
	if c==nil then return true end
	return c:GetLevel()>=12
end
function c51696008.e3op(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(5000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)  
	e3:SetType(EFFECT_TYPE_SINGLE)  
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)  
	e3:SetRange(LOCATION_MZONE)  
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c51696008.immunefilter)   
	c:RegisterEffect(e3) 
end
function c51696008.immunefilter(e,re)  
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() 
end  