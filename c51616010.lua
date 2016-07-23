--煌龍 埃特爾
function c51616010.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),12,2,nil,nil,5)
	c:EnableReviveLimit()
	--cannot disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c51616010.e1cond)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c51616010.e2cond)
	e2:SetOperation(c51616010.e2op)
	c:RegisterEffect(e2)
	--cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA+LOCATION_REMOVED)
	e3:SetTarget(c51616010.e3tg)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(51616010,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c51616010.e4cost)
	e4:SetTarget(c51616010.e4tg)
	e4:SetOperation(c51616010.e4op)
	c:RegisterEffect(e4)
end

function c51616010.e1cond(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end

function c51616010.e2cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c51616010.e2op(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c51616010.chlimit)
end
function c51616010.chlimit(e,ep,tp)
	return tp==ep
end

function c51616010.e3tg(e,c)
	return c:IsType(TYPE_EFFECT) or c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)
end

function c51616010.e4cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c51616010.e4filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToHand()
end
function c51616010.e4tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE+LOCATION_DECK+LOCATION_REMOVED) and c51616010.e4filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51616010.e4filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c51616010.e4filter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c51616010.e4op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	  Duel.SendtoHand(tc,nil,REASON_EFFECT)
	  local e1=Effect.CreateEffect(c)
	  e1:SetType(EFFECT_TYPE_SINGLE)
	  e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
	  e1:SetValue(12)
	  e1:SetReset(RESET_TOGRAVE+RESET_REMOVE+RESET_TODECK)
	  tc:RegisterEffect(e1)

	  --summon with 0 tribute
	  local e2=Effect.CreateEffect(c)
	  e2:SetDescription(aux.Stringid(51616010,1))
	  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	  e2:SetType(EFFECT_TYPE_SINGLE)
	  e2:SetCode(EFFECT_SUMMON_PROC)
	  e2:SetReset(RESET_TOGRAVE+RESET_REMOVE+RESET_TODECK)
	  --e3:SetValue(SUMMON_TYPE_ADVANCE+1)
	  tc:RegisterEffect(e2)
	end
end