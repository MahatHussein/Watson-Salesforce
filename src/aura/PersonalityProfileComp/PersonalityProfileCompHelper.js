({
	showPersonalityInsight: function(component) {
		var action = component.get("c.getPersonalityInsights");
		action.setParams({
			contactId : component.get("v.recordId"),
			isRefresh : false
		});
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				component.set("v.personalityProfile", response.getReturnValue());
				this.toggleCard(component, 'spinner');
				this.toggleCard(component, 'insightsDataCard');
				this.toggleCard(component, 'insightsIntroCard');

			}
		});
		$A.enqueueAction(action);
	},
	updatePersonalityInsight: function(component) {
		this.toggleCard(component, 'spinner');
		this.toggleCard(component, 'insightsDataCard');
		this.toggleCard(component, 'insightsIntroCard');

		var action = component.get("c.getPersonalityInsights");
		action.setParams({
			contactId : component.get("v.recordId"),
			isRefresh : true
		});
		action.setCallback(this, function(response) {

			var state = response.getState();
			if (state === "SUCCESS") {
				component.set("v.personalityProfile", response.getReturnValue());
				console.log('SUCCESS RESPONSE');
				this.toggleCard(component, 'spinner');
				this.toggleCard(component, 'insightsDataCard');
			}

		});
		$A.enqueueAction(action);
	},

	toggleCard: function(component, cardId){
		var card = component.find(cardId);
		//console.log('Value of card in toggle function: '+cardId);

		if($A.util.hasClass(card, 'slds-show')){
			$A.util.removeClass(card, 'slds-show');
			$A.util.addClass(card, 'slds-hide');
		}else{
			$A.util.removeClass(card, 'slds-hide');
			$A.util.addClass(card, 'slds-show');
		}
	}

})