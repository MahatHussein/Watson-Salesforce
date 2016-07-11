@isTest
public class TestDataFactory {

	public static Account createAccount(String AccountName) {

		Account acc = new Account();
		acc.Name = AccountName;
		return acc;

	}

	public static Contact createContact(String FirstName, String LastName, String TwitterName, Id AccountId ) {

		Contact cont = new Contact();
		cont.AccountId = AccountId;
		cont.FirstName = FirstName;
		cont.LastName = LastName;
		cont.Twitter_Name__c = TwitterName;
		return cont;

	}

 	public static Personality_Profile__c createPersonalityProfile(Id ContactId) {

		Personality_Profile__c pp = new Personality_Profile__c();
		pp.Source__c = 'Source';
		pp.Contact__c = ContactId;
		pp.Analysis_Summary__c = 'Summary';
		pp.Openness__c = 0.80;
		pp.Conscientiousness__c = 0.80;
		pp.Extraversion__c = 0.80;
		pp.Agreeableness__c = 0.80;
		pp.Neuroticism__c = 0.80;
		pp.Last_Updated__c = datetime.now();
		return pp;

	}

	public static IBM_Watson_PersonalityInsights__c createIBMWatsonAPISetings(){
		//IBM API
		IBM_Watson_PersonalityInsights__c IBMWatsonSettings = new IBM_Watson_PersonalityInsights__c();
		IBMWatsonSettings.Username__c = '1234567890';
		IBMWatsonSettings.Password__c = '1234567890';
		IBMWatsonSettings.Endpoint__c = 'https://gateway.watsonplatform.net/personality-insights/api/v2/profile';
		return IBMWatsonSettings;

	}

	public static Twitter_API__c createTwitterAPISetings(){
		//Twitter API
		Twitter_API__c TwitterAPI = new Twitter_API__c();
		TwitterAPI.App_Consumer_Key__c = '1234567890';
		TwitterAPI.App_Consumer_Seceret__c = '1234567890';
		TwitterAPI.Oath_2_Endpoint__c = 'https://api.twitter.com/oauth2/token';
		TwitterAPI.User_Timeline_Endpoint__c = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=';
	 	return TwitterAPI;

	}

}