--龍之財寶
function c51696011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c51696011.target)
	e1:SetOperation(c51696011.activate)
	c:RegisterEffect(e1)	
end
function c51696011.filter(c)
	return c:GetLevel()>=2 and c:IsRace(RACE_DRAGON)
end
function c51696011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c51696011.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51696011.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c51696011.filter,tp,LOCATION_HAND,0,1,1,nil)
end
function c51696011.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(-1)
	e1:SetReset(RESET_TOGRAVE+RESET_REMOVE+RESET_TODECK)
	tc:RegisterEffect(e1)
	Duel.Draw(tp,1,REASON_EFFECT)
end