({
	doInit : function(component, event, helper) {
			var action = component.get("c.getPersonalityInsights");
  		helper.showPersonalityInsight(component);
	},

	updatePersonalityProfile: function(component, event, helper) {
    	var action = component.get("c.getPersonalityInsights");
    	helper.updatePersonalityInsight(component);
	},

	updateProfileEvent : function(component, event, helper) {
			helper.updatePersonalityInsight(component);
	},
})