public class PersonalityProfileHelper {
    //MH: use static methods
    @auraEnabled
    public static Personality_Profile__c getPersonalityInsights(String contactId, Boolean isRefresh){
      String twitterHandle = PersonalityProfileHelper.getTwitterHandle(contactId);
    	System.debug('twitterHandle: '+twitterHandle);
    	if(twitterHandle != null){
        Personality_Profile__c personalityProfile;
        try{
          personalityProfile = PersonalityProfileHelper.getPersonalityProfile(contactId);
          System.debug('getPersonalityProfile: returned profile: '+personalityProfile);
        }
        catch(Exception e){
          System.debug('Exception: '+e);
          return null;
        }

        if(personalityProfile != null && !isRefresh){
    			return personalityProfile;
    		}
        else{
					if(isRefresh){
						PersonalityInsightsServiceController ps = new PersonalityInsightsServiceController();
						return ps.getPersonalityInsights(twitterHandle, contactId);
					}else{
            PersonalityInsightsServiceController ps = new PersonalityInsightsServiceController();
						return ps.getPersonalityInsights(twitterHandle, contactId);
					}
    		}
    	}
      else{
    		return null;
    	}
    }

    public static String getTwitterHandle(String contactId){
    	if(contactId != null){
    		Contact contact = [Select Id, Twitter_Name__c
                            From Contact
                            Where Id =: contactId];

    		return contact.Twitter_Name__c;
    	}
      else{
    		return null;
    	}

    }

    public static Personality_Profile__c getPersonalityProfile(String contactId){
    	if(contactId != null){
    		Personality_Profile__c[] personalityProfiles;
    		personalityProfiles = [Select Id, Last_Updated__c, Contact__c, Agreeableness__c, Analysis_Summary__c, Conscientiousness__c, Extraversion__c, Neuroticism__c, Openness__c
                                  From Personality_Profile__c
                                  Where Contact__c =: contactId];

        if(personalityProfiles.size() > 0){
          return personalityProfiles[0];
        }else{
          return null;
        }
    	}
      else{
    		return null;
    	}

    }
}