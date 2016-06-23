@isTest
private class PersonalityInsightsServiceCont_Test {
	//https://www.youtube.com/watch?v=nNn-wFbFPL8 
	@testSetup
	static void testDataSetup() {

		Account acc = TestDataFactory.createAccount('Test Account');
		insert acc;

		Contact cont = TestDataFactory.createContact('FirstName', 'LastName', '@TwitterName', acc.Id);
		insert cont;

	}

	@isTest
	static void serviceContr_Success_New_Profile() {

		Contact testContact = [Select Id, FirstName, LastName, Twitter_Name__c From Contact Where FirstName = 'FirstName' Limit 1];

		Test.startTest();
		Personality_Profile__c testpp = PersonalityProfileHelper.getPersonalityInsights(testContact.Id, false);
		Test.stopTest();

		Personality_Profile__c createdProfile = [Select Id From Personality_Profile__c Where Contact__c =: testContact.Id Limit 1];

		System.assert(createdProfile != null, 'PP Created Sucessedfully');

	}

	@isTest static void serviceContr_Success_Update_Exsisting_Profile() {
		//
	}

	@isTest static void serviceContr_Failure_Twitter_API() {
		// Implement test code
	}

	@isTest static void serviceContr_Failure_IBM_Watson_API() {
		// Implement test code
	}

	@isTest static void serviceContr_Failure_Twitter_JSON_Mismatch() {
		// Implement test code
	}

	@isTest static void serviceContr_Failure_IBM_Watson_JSON_Mismatch() {
		// Implement test code
	}

}
