public with sharing class PersonalityInsightsServiceController {

	public Personality_Profile__c getPersonalityInsights(String twitterHandle, String contactId){

		IBM_Watson_PersonalityInsights__c IBMWatsonSettings = IBM_Watson_PersonalityInsights__c.getOrgDefaults();
		HttpOutboundCallHelper httpHelper = new HttpOutboundCallHelper();
		String authHeader = httpHelper.createAuthHeader(IBMWatsonSettings.Username__c, IBMWatsonSettings.Password__c);

		TwitterInterfaceHandler tw = new TwitterInterfaceHandler();
		List<ContentItemsJSON.contentItem> userTweets = tw.getUserTimeline(twitterHandle, 200);

		JSONGenerator generator = JSON.createGenerator(true);
		generator.writeStartObject();
		generator.writeObjectField('contentItems', userTweets);
		generator.writeEndObject();
		String body = generator.getAsString();

		HttpResponse calloutResponse = httpHelper.httpRequestCallout(authHeader, 'POST', body, IBMWatsonSettings.Endpoint__c, 'application/json');

		PersonalityProfileResponse personalityProfile = PersonalityProfileResponse.parse(calloutResponse.getBody());
    //System.debug('PersonalityProfileResponse: '+personalityProfile);
		Personality_Profile__c pp = storePersonalityProfile(personalityProfile, contactId);

		return pp;
	}

	private Personality_Profile__c storePersonalityProfile(PersonalityProfileResponse personalityProfile, String contactId){

		Personality_Profile__c pp = new Personality_Profile__c();
		pp.Source__c = personalityProfile.source;
		pp.Contact__c = contactId;
		pp.Analysis_Summary__c = personalityProfile.word_count_message;
		pp.Openness__c = personalityProfile.Tree.children[0].children[0].children[0].percentage * 100;
		pp.Conscientiousness__c = personalityProfile.Tree.children[0].children[0].children[1].percentage * 100;
		pp.Extraversion__c = personalityProfile.Tree.children[0].children[0].children[2].percentage * 100;
		pp.Agreeableness__c = personalityProfile.Tree.children[0].children[0].children[3].percentage * 100;
		pp.Neuroticism__c = personalityProfile.Tree.children[0].children[0].children[4].percentage * 100;
		pp.Last_Updated__c = datetime.now();

		Personality_Profile__c exsistingPP;

		try{
    	exsistingPP = [Select Id From Personality_Profile__c Where Contact__c =: contactId Limit 1];
    }catch(Exception e){
    	exsistingPP = null;
    }

		if( exsistingPP != null){
			pp.Id = exsistingPP.Id;
			update pp;
		}else{
			insert pp;
		}

		return pp;

	}

}
