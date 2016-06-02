({
	getPersonalityProfile : function(component, event, helper) {

		var getProfileEvent = component.getEvent("updateProfileEvent");
		getProfileEvent.setParams({
			isRefresh: false
		});
		//console.log('getPersonalityProfile event');
		getProfileEvent.fire();

	}
})