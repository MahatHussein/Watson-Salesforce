public with sharing class PersonalityInsightsServiceController {

	public Personality_Profile__c getPersonalityInsights(String twitterHandle, String contactId){
		System.debug('getPersonalityInsights: getPersonalityInsights: ');

		IBM_Watson_PersonalityInsights__c IBMWatsonSettings = IBM_Watson_PersonalityInsights__c.getOrgDefaults();
		HttpOutboundCallHelper httpHelper = new HttpOutboundCallHelper();
		String authHeader = httpHelper.createAuthHeader(IBMWatsonSettings.Username__c, IBMWatsonSettings.Password__c);

		System.debug('getPersonalityInsights: createAuthHeader: '+authHeader);

		TwitterInterfaceHandler tw = new TwitterInterfaceHandler();
		List<ContentItemsJSON.contentItem> userTweets = tw.getUserTimeline(twitterHandle, 200);

		System.debug('getPersonalityInsights: getUserTimeline: '+userTweets);

		Personality_Profile__c pp = null;

		if(userTweets != null){

			JSONGenerator generator = JSON.createGenerator(true);
			generator.writeStartObject();
			generator.writeObjectField('contentItems', userTweets);
			generator.writeEndObject();
			String body = generator.getAsString();

			HttpResponse calloutResponse = httpHelper.httpRequestCallout(authHeader, 'POST', body, IBMWatsonSettings.Endpoint__c, 'application/json');

			System.debug('getPersonalityInsights: calloutResponse: '+calloutResponse.getBody());

			if(containsErrors(calloutResponse.getBody()) == false ){

				PersonalityProfileResponse personalityProfile = PersonalityProfileResponse.parse(calloutResponse.getBody());

				System.debug('getPersonalityInsights: PersonalityProfileResponse: '+personalityProfile);

				pp = storePersonalityProfile(personalityProfile, contactId);

				System.debug('getPersonalityInsights: personality profile: '+pp);
			}

		}

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

	private Boolean containsErrors(String IBMWatsonAPIResponseBody){
		Boolean hasErrors = false;

		if(String.isNotEmpty(IBMWatsonAPIResponseBody)){
			JSONParser parser = JSON.createParser(IBMWatsonAPIResponseBody);
			while(parser.nextToken() != null){
				if(parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'error'){
					System.debug('Response has errors: '+parser.getText());
					hasErrors = true;
				}
			}

		}

		return hasErrors;
	}

}