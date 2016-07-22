--廷達利亞的巫女
function c51696002.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c51696002.e1con)
	c:RegisterEffect(e1)

	--atkdefchange
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c51696002.e2val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENCE_FINAL)
	e3:SetValue(c51696002.e3val)
	c:RegisterEffect(e3)	
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c51696002.e4cost)
	e4:SetCondition(c51696002.e4con)
	e4:SetTarget(c51696002.e4tg)
	e4:SetOperation(c51696002.e4op)
	c:RegisterEffect(e4)

	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(51696002,0))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c51696002.e5tg)
	e5:SetOperation(c51696002.e5op)
	c:RegisterEffect(e5)
end

--e1
function c51696002.e1filter(c)
	return c:IsRace(RACE_PLANT) and c:IsFaceup()
end

function c51696002.e1con(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c51696002.e1filter,c:GetControler(),LOCATION_MZONE,0,3,nil)
end

function c51696002.e2val(e,c)
	local g=Duel.GetMatchingGroup(c51696002.e1filter,0,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,nil)
	local atk=0
	local sc=g:GetFirst()
	while sc do
		local catk=sc:GetBaseAttack()
		if catk<0 then catk=0 end
		atk=atk+catk
		sc=g:GetNext()
	end
	return atk
end

function c51696002.e3val(e,c)
	local g=Duel.GetMatchingGroup(c51696002.e1filter,0,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,nil)
	local def=0
	local sc=g:GetFirst()
	while sc do
		local cdef=sc:GetBaseAttack()
		if cdef<0 then cdef=0 end
		def=def+cdef
		sc=g:GetNext()
	end
	return def
end

--e4
function c51696002.e4con(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return Duel.IsChainNegatable(ev)
end
function c51696002.costfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsAbleToRemoveAsCost()
end
function c51696002.e4cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51696002.costfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c51696002.costfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c51696002.e4tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c51696002.e4op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end

--e5
function c51696002.e5filter(c)
	return c:IsSetCard(0xff01) and c:IsAbleToHand()
end
function c51696002.e5tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51696002.e5filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51696002.e5op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51696002.e5filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end