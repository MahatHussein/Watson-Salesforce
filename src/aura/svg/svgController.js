({
	afterScriptsLoaded: function(component, event, helper) {

		/*if (typeof jQuery !== "undefined" && typeof $j === "undefined") {
    	$j = jQuery.noConflict(true);
    }*/

		var iconId = component.get("v.tooltipId");

		if(iconId !== ''){
			jQuery('#container_'+iconId ).hover(
			  function() {
			    jQuery('#'+iconId).removeClass('slds-hide');
			  }, function() {
			    jQuery('#'+iconId).addClass('slds-hide');
			  }
			);
		}
	}
})