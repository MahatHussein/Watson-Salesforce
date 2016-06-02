public class PersonalityProfileHelper {

    @auraEnabled
    public static Personality_Profile__c getPersonalityInsights(String contactId, Boolean isRefresh){
    	PersonalityProfileHelper pp = new PersonalityProfileHelper();
      String twitterHandle = pp.getTwitterHandle(contactId);
    	//System.debug('twitterHandle: '+twitterHandle);
    	if(twitterHandle != null){
        Personality_Profile__c personalityProfile;
        try{
          personalityProfile = pp.getPersonalityProfile(contactId);
        }
        catch(Exception e){
          return null;
        }


        if( personalityProfile != null && !isRefresh){
    			return personalityProfile;
    		}
        else{
					if(isRefresh){
						PersonalityInsightsServiceController ps = new PersonalityInsightsServiceController();
						return ps.getPersonalityInsights(twitterHandle, contactId);
					}else{
						return null;
					}
    		}
    	}
      else{
    		return null;
    	}
    }

    public String getTwitterHandle(String contactId){
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

    public Personality_Profile__c getPersonalityProfile(String contactId){
    	if(contactId != null){
    		Personality_Profile__c personalityProfile;
    		try{
    			personalityProfile = [Select Id, Last_Updated__c, Contact__c, Agreeableness__c, Analysis_Summary__c, Conscientiousness__c, Extraversion__c, Neuroticism__c, Openness__c
                                  From Personality_Profile__c
                                  Where Contact__c =: contactId];
    		}
        catch(Exception e){
    			return null;
    		}

    		return personalityProfile;
    	}
      else{
    		return null;
    	}

    }
}