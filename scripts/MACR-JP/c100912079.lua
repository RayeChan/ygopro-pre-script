--醒めない悪夢
--Eternal Nightmares
--Script by dest
function c100912079.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100912079.target1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36970611,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c100912079.cost2)
	e2:SetTarget(c100912079.target2)
	e2:SetOperation(c100912079.operation)
	c:RegisterEffect(e2)
end
function c100912079.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c100912079.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c100912079.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc) end
	if chk==0 then return true end
	if c100912079.cost2(e,tp,eg,ep,ev,re,r,rp,0) and c100912079.target2(e,tp,eg,ep,ev,re,r,rp,0,chkc)
		and Duel.SelectYesNo(tp,94) then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c100912079.operation)
		c100912079.cost2(e,tp,eg,ep,ev,re,r,rp,1)
		c100912079.target2(e,tp,eg,ep,ev,re,r,rp,1,chkc)
	else
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c100912079.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and e:GetHandler():GetFlagEffect(100912079)==0 end
	Duel.PayLPCost(tp,1000)
	e:GetHandler():RegisterFlagEffect(100912079,RESET_CHAIN,0,1)
end
function c100912079.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c100912079.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100912079.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c100912079.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100912079.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
