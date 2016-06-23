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

}
