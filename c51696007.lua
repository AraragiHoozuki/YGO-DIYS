--空龍 烏拉諾斯
function c51696007.initial_effect(c)
	--cannot special summon
	local e=Effect.CreateEffect(c)
	e:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(EFFECT_SPSUMMON_CONDITION)
	e:SetValue(aux.FALSE)
	c:RegisterEffect(e) 
	--indestructable
	--battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	e1:SetLabel(3)
	e1:SetCondition(c51696007.cond)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	e2:SetLabel(3)
	e2:SetCondition(c51696007.cond)
	c:RegisterEffect(e2)
	--Destroy M/T
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1353770,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(6)
	e3:SetCondition(c51696007.cond)
	e3:SetTarget(c51696007.e3tg)
	e3:SetOperation(c51696007.e3op)
	c:RegisterEffect(e3)
	--disable spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetLabel(9)
	e4:SetCondition(c51696007.cond)
	c:RegisterEffect(e4)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(88177324,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(PHASE_BATTLE_START)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetLabel(12)
	e5:SetCondition(c51696007.negcon)
	e5:SetTarget(c51696007.negtg)
	e5:SetOperation(c51696007.negop)
	c:RegisterEffect(e5)
	--
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_CHAIN_SOLVED)
	e6:SetCondition(c51696007.regcon)
	e6:SetOperation(c51696007.regop)
	c:RegisterEffect(e6)
end

function c51696007.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetLevel()>=e:GetLabel()
end

function c51696007.e3filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c51696007.e3tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c51696007.e3filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c51696007.e3filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c51696007.e3op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c51696007.e3filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(ct*800)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end

function c51696007.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetLevel()>=e:GetLabel()
end

function c51696007.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and not c:IsDisabled()
end
function c51696007.filter2(c)
	return c:IsFaceup() and (c:GetAttack()~=c:GetBaseAttack() or c:GetDefense()~=c:GetBaseDefense())
end
function c51696007.filter3(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c51696007.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		Duel.IsExistingMatchingCard(c51696007.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(c51696007.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
	end
end

function c51696007.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c51696007.filter3,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	g=Duel.GetMatchingGroup(c51696007.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	tc=g:GetFirst()
	while tc do
		if tc:GetAttack()~=tc:GetBaseAttack() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(tc:GetBaseAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		if tc:GetDefense()~=tc:GetBaseDefense() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e1:SetValue(tc:GetBaseDefense())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RegisterFlagEffect(51696007,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c51696007.regcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and e:GetHandler():GetFlagEffect(51696007)>0
end
function c51696007.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e2)
end