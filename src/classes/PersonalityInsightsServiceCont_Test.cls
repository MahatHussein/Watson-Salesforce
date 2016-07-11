@isTest
private class PersonalityInsightsServiceCont_Test {

	@testSetup
	private static void testDataSetup() {

		Account acc = TestDataFactory.createAccount('Test Account');
		insert acc;

		Contact cont = TestDataFactory.createContact('FirstName', 'LastName', '@TwitterName', acc.Id);
		insert cont;

		IBM_Watson_PersonalityInsights__c IBMWatsonAPISettings = TestDataFactory.createIBMWatsonAPISetings();
		insert IBMWatsonAPISettings;

		Twitter_API__c twitterAPISettings = TestDataFactory.createTwitterAPISetings();
		insert twitterAPISettings;

	}

	@isTest
	private static void serviceContr_Success_New_Profile() {
		// Mock static resource: IBMPersonality_Insights_Success_1, Twitter_OAuth_Success, Twitter_Timeline_Success_1

		Contact testContact = [Select Id, FirstName, LastName, Twitter_Name__c From Contact Where FirstName = 'FirstName' Limit 1];

		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
		multimock.setStaticResource('https://gateway.watsonplatform.net/personality-insights/api/v2/profile', 'IBMPersonality_Insights_Success_1');
		multimock.setStaticResource('https://api.twitter.com/oauth2/token', 'Twitter_OAuth_Success');
		multimock.setStaticResource('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name='+testContact.Twitter_Name__c+'&count=200', 'Twitter_Timeline_Success_1');
		multimock.setStatusCode(200);
		multimock.setHeader('Content-Type', 'application/json');

		Test.setMock(HttpCalloutMock.class, multimock);

		Test.startTest();
		Personality_Profile__c testpp = PersonalityProfileHelper.getPersonalityInsights(testContact.Id, false);
		Test.stopTest();

		Personality_Profile__c[] createdProfiles = [Select Id From Personality_Profile__c Where Contact__c =: testContact.Id Limit 1];
		System.debug('createdProfiles: '+createdProfiles);
		System.assert(createdProfiles.size() == 1, 'PP Created Sucessedfully');

	}


	@isTest
	private static void serviceContr_Success_Update_Exsisting_Profile() {
		// Mock static resource: IBMPersonality_Insights_Success_1, Twitter_OAuth_Success, Twitter_Timeline_Success_1

		Contact testContact = [Select Id, FirstName, LastName, Twitter_Name__c From Contact Where FirstName = 'FirstName' Limit 1];

		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
		multimock.setStaticResource('https://gateway.watsonplatform.net/personality-insights/api/v2/profile', 'IBMPersonality_Insights_Success_1');
		multimock.setStaticResource('https://api.twitter.com/oauth2/token', 'Twitter_OAuth_Success');
		multimock.setStaticResource('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name='+testContact.Twitter_Name__c+'&count=200', 'Twitter_Timeline_Success_1');
		multimock.setStatusCode(200);
		multimock.setHeader('Content-Type', 'application/json');

		Test.setMock(HttpCalloutMock.class, multimock);

		// create profile
		Personality_Profile__c pp = TestDataFactory.createPersonalityProfile(testContact.Id);
		insert pp;

		Test.startTest();

		// update exsisting profile
		pp = PersonalityProfileHelper.getPersonalityInsights(testContact.Id, true);
		Test.stopTest();

		Personality_Profile__c[] createdProfiles = [Select Id From Personality_Profile__c Where Contact__c =: testContact.Id Limit 1];
		System.debug('createdProfiles: '+createdProfiles);
		System.assert(createdProfiles.size() == 1, 'PP Updated Sucessedfully');
	}

	@isTest
	private static void serviceContr_Failure_Twitter_API() {
		// Mock static resource: IBMWatsonAPI_Success, TwitterOAuth_Success, TwitterTimeline_Failure

		Contact testContact = [Select Id, FirstName, LastName, Twitter_Name__c From Contact Where FirstName = 'FirstName' Limit 1];

		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
		multimock.setStaticResource('https://gateway.watsonplatform.net/personality-insights/api/v2/profile', 'IBMPersonality_Insights_Success_1');
		multimock.setStaticResource('https://api.twitter.com/oauth2/token', 'Twitter_OAuth_Success');
		multimock.setStaticResource('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name='+testContact.Twitter_Name__c+'&count=200', 'Twitter_Timeline_Error');
		multimock.setStatusCode(200);
		multimock.setHeader('Content-Type', 'application/json');

		Test.setMock(HttpCalloutMock.class, multimock);

		Test.startTest();
		Personality_Profile__c testpp = PersonalityProfileHelper.getPersonalityInsights(testContact.Id, false);
		Test.stopTest();

		Personality_Profile__c[] createdProfiles = [Select Id From Personality_Profile__c Where Contact__c =: testContact.Id Limit 1];
		System.debug('createdProfiles: '+createdProfiles);
		System.assert(createdProfiles.size() == 0, 'Unable to create Personality Profile');

	}

	@isTest
	private static void serviceContr_Failure_IBM_Watson_API() {
		// Mock static resource: IBMWatsonAPI_Failure, TwitterOAuth_Success, TwitterTimeline_Success
		Contact testContact = [Select Id, FirstName, LastName, Twitter_Name__c From Contact Where FirstName = 'FirstName' Limit 1];

		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
		multimock.setStaticResource('https://gateway.watsonplatform.net/personality-insights/api/v2/profile', 'IBMPersonality_Insights_Error');
		multimock.setStaticResource('https://api.twitter.com/oauth2/token', 'Twitter_OAuth_Success');
		multimock.setStaticResource('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name='+testContact.Twitter_Name__c+'&count=200', 'Twitter_Timeline_Success_1');
		multimock.setStatusCode(200);
		multimock.setHeader('Content-Type', 'application/json');

		Test.setMock(HttpCalloutMock.class, multimock);

		Test.startTest();
		Personality_Profile__c testpp = PersonalityProfileHelper.getPersonalityInsights(testContact.Id, false);
		Test.stopTest();

		Personality_Profile__c[] createdProfiles = [Select Id From Personality_Profile__c Where Contact__c =: testContact.Id Limit 1];
		System.debug('createdProfiles: '+createdProfiles);
		System.assert(createdProfiles.size() == 0, 'Unable to create Personality Profile');
	}


}