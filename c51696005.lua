--海龙 赫朗格尼尔
--[[①：每次自己的結束階段發動。自己場上·手牌的龍族怪獸等級上升1。②：場上的這張卡被破壞時，將自己手牌·場上的1隻龍族怪獸送入墓地才能發動。這張卡回到手卡。]]--
function c51696005.initial_effect(c)
	--atk/def  
	local e1=Effect.CreateEffect(c)  
	e1:SetType(EFFECT_TYPE_SINGLE)  
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)  
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCode(EFFECT_UPDATE_ATTACK)  
	e1:SetValue(2000)  
	e1:SetCondition(c51696005.UPcon)  
	c:RegisterEffect(e1)  
	local e2=e1:Clone()  
	e2:SetCode(EFFECT_UPDATE_DEFENCE)  
	c:RegisterEffect(e2)
	--immune  
	local e3=Effect.CreateEffect(c)  
	e3:SetType(EFFECT_TYPE_SINGLE)  
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)  
	e3:SetRange(LOCATION_MZONE)  
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c51696005.efilter)  
	e3:SetCondition(c51696005.Immunecon)  
	c:RegisterEffect(e3) 
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c51696005.e4eval)
	e4:SetCondition(c51696005.Doublecon) 
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	e5:SetValue(c51696005.e5eval)
	c:RegisterEffect(e5) 
	--directattack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	e6:SetCondition(c51696005.DAcon)
	c:RegisterEffect(e6)
end

function c51696005.UPcon(e,tp,eg,ep,ev,re,r,rp)  
	return e:GetHandler():GetLevel()>=4  
end  
function c51696005.efilter(e,re)  
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() 
end  
function c51696005.Immunecon(e,tp,eg,ep,ev,re,r,rp) 
	return e:GetHandler():GetLevel()>=6
end
function c51696005.Doublecon(e,tp,eg,ep,ev,re,r,rp) 
	return e:GetHandler():GetLevel()>=10
end
function c51696005.DAcon(e,tp,eg,ep,ev,re,r,rp) 
	return e:GetHandler():GetLevel()>=12
end
function c51696005.e4eval(e,tp,eg,ep,ev,re,r,rp) 
	return e:GetHandler():GetAttack()
end
function c51696005.e5eval(e,tp,eg,ep,ev,re,r,rp) 
	return e:GetHandler():GetDefense()
end
