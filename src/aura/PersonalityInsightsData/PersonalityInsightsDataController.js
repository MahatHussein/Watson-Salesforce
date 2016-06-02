({
	getPersonalityProfile : function(component, event, helper) {
		var getProfileEvent = component.getEvent("updateProfileEvent");
		getProfileEvent.setParams({
			isRefresh: true
		});
		getProfileEvent.fire();
	}
})