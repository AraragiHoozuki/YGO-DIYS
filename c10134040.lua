--[[【戰士族／效果】
①：這張卡不會被破壞、不受這張卡以外卡的效果影響。
②：這張卡可以解放1, 2, 或3隻怪獸通常召喚，召喚成功時根據解放怪獸的數量發動以下效果：●1隻：場上的卡全部破壞。
●2隻：除此卡外雙方手卡和場上的卡全部送往墓地。
●3隻：對方場上的卡和手卡全部從遊戲中除外
--]]

--無毀的湖光
function c10134040.initial_effect(c)

	--unaffectable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)

	--summon with 1 tribute
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10134040,0))
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SUMMON_PROC)
	e4:SetCondition(c10134040.ttcon1)
	e4:SetOperation(c10134040.ttop1)
	e4:SetValue(SUMMON_TYPE_ADVANCE+1)
	c:RegisterEffect(e4)

	--destroy1
	local e5=Effect.CreateEffect(c)
	--e5:SetDescription(aux.Stringid(10134040,0))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetCondition(c10134040.descon1)
	e5:SetTarget(c10134040.destg1)
	e5:SetOperation(c10134040.desop1)
	c:RegisterEffect(e5)

	--summon with 2 tribute
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10134040,1))
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SUMMON_PROC)
	e6:SetCondition(c10134040.ttcon2)
	e6:SetOperation(c10134040.ttop2)
	e6:SetValue(SUMMON_TYPE_ADVANCE+2)
	c:RegisterEffect(e6)

	--destroy2
	local e7=Effect.CreateEffect(c)
	--e7:SetDescription(aux.Stringid(10134040,1))
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_SUMMON_SUCCESS)
	e7:SetCondition(c10134040.descon2)
	e7:SetTarget(c10134040.destg2)
	e7:SetOperation(c10134040.desop2)
	c:RegisterEffect(e7)

	--summon with 3 tribute
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(10134040,2))
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SUMMON_PROC)
	e8:SetCondition(c10134040.ttcon3)
	e8:SetOperation(c10134040.ttop3)
	e8:SetValue(SUMMON_TYPE_ADVANCE+3)
	c:RegisterEffect(e8)

	--destroy3
	local e9=Effect.CreateEffect(c)
	--e9:SetDescription(aux.Stringid(10134040,1))
	e9:SetCategory(CATEGORY_DESTROY)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_SUMMON_SUCCESS)
	e9:SetCondition(c10134040.descon3)
	e9:SetTarget(c10134040.destg3)
	e9:SetOperation(c10134040.desop3)
	c:RegisterEffect(e9)

end
-- 1 tribute
function c10134040.ttcon1(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=1
end

function c10134040.ttop1(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end

-- destroy1
function c10134040.descon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+1
end

function c10134040.destg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end

function c10134040.desop1(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(dg,REASON_EFFECT)
end

-- 2 tribute
function c10134040.ttcon2(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=2
end

function c10134040.ttop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,2,2)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end

-- destroy2
function c10134040.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+2
end

function c10134040.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD+LOCATION_HAND,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end

function c10134040.desop2(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD+LOCATION_HAND,LOCATION_ONFIELD+LOCATION_HAND,e:GetHandler())
	Duel.Destroy(dg,REASON_EFFECT)
end


-- 3 tribute
function c10134040.ttcon3(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=3
end

function c10134040.ttop3(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end

-- destroy3
function c10134040.descon3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+3
end

function c10134040.destg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end

function c10134040.desop3(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
end