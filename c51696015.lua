--天賜
function c51696015.initial_effect(c)
	--Activate
	local e=Effect.CreateEffect(c)
	e:SetType(EFFECT_TYPE_ACTIVATE)
	e:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e)   
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c51696015.e2tg)
	e2:SetOperation(c51696015.e2op)
	c:RegisterEffect(e2) 
	--draw2
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c51696015.e3cost)
	e3:SetOperation(c51696015.e3op)
	c:RegisterEffect(e3)  
end
function c51696015.e2tg(e,tp,eg,esp,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(eg:GetFirst():GetSummonPlayer())
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,eg:GetFirst():GetSummonPlayer(),1)
end
function c51696015.e2op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c51696015.costfilter(c,e,tp)
	return c:GetLevel()>=9 and c:IsReleasable()
end
function c51696015.e3cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c51696015.costfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,c51696015.costfilter,1,1,nil,e,tp)
	Duel.Release(g,REASON_COST)
end
function c51696015.e3op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Draw(tp,2,REASON_EFFECT)
end