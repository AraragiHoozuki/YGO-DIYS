--歌姬型貝琳
function c10128052.initial_effect(c)
   --xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),3,2,nil,nil,5)
	c:EnableReviveLimit()
	--pos&atk
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(28150174,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c10128052.e1cost)
	e1:SetOperation(c10128052.e1op)
	c:RegisterEffect(e1)
end

function c10128052.e1cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end

function c10128052.e1op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local sc=g:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(3000)
			sc:RegisterEffect(e1)

			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_DEFENCE)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(3000)
			sc:RegisterEffect(e2)
			sc=g:GetNext()
		end
	end
end