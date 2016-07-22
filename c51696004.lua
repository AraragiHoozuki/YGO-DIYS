--真龙觉醒
function c51696004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--level up
	local lvlup=Effect.CreateEffect(c)
	--lvlup:SetDescription(aux.Stringid(82971335,0))
	lvlup:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	lvlup:SetRange(LOCATION_FZONE)
	lvlup:SetCountLimit(1)
	lvlup:SetCode(EVENT_PHASE+PHASE_END)
	lvlup:SetCondition(c51696004.lvcon)
	lvlup:SetOperation(c51696004.lvop)
	c:RegisterEffect(lvlup)
	--Return
	local return_hand=Effect.CreateEffect(c)
	return_hand:SetCategory(CATEGORY_TOHAND)
	return_hand:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	return_hand:SetCode(EVENT_DESTROYED)
	return_hand:SetCost(c51696004.toHandcost)
	return_hand:SetCondition(c51696004.toHandcon)
	return_hand:SetTarget(c51696004.toHandtg)
	return_hand:SetOperation(c51696004.toHandop)
	c:RegisterEffect(return_hand)

end
-- level up
function c51696004.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c51696004.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
	local tc=hg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_TOGRAVE+RESET_REMOVE+RESET_TODECK)
		tc:RegisterEffect(e1)
		tc=hg:GetNext()
	end
end
-- return
function c51696004.costfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToGraveAsCost()
end
function c51696004.toHandcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51696004.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler()) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)  
	local g=Duel.SelectMatchingCard(tp,c51696004.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler())  
	Duel.SendtoGrave(g,REASON_COST)
end
function c51696004.toHandcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c51696004.toHandtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c51696004.toHandop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
