public with sharing class TwitterInterfaceHandler {

	public List<ContentItemsJSON.contentItem> getUserTimeline(String twitterHandle, Integer count) {
				
		Twitter_API__c TwitterAPISettings = Twitter_API__c.getOrgDefaults();

		HttpOutboundCallHelper httpHelper = new HttpOutboundCallHelper();
		String authHeader = 'Bearer ' + getTwitterBearerToken();
		String endpoint = TwitterAPISettings.User_Timeline_Endpoint__c+twitterHandle+'&count='+String.valueOf(count);
		HttpResponse calloutResponse = httpHelper.httpRequestCallout(authHeader, 'GET', null, endpoint, null);


		List<TwitterResponse> twitterResponse = (List<TwitterResponse>)JSON.deserialize( calloutResponse.getBody() , List<TwitterResponse>.class);

		List<ContentItemsJSON.contentItem> contentItems = new List<ContentItemsJSON.contentItem>();

		if(twitterResponse.isEmpty() != true){
			for(TwitterResponse tweet : twitterResponse){
				ContentItemsJSON.contentItem contentItem = new ContentItemsJSON.contentItem();
				contentItem.id = tweet.id_str;
				contentItem.userid = twitterHandle;
				contentItem.sourceid = 'twitter';
				contentItem.created = (Integer)Datetime.now().getTime();
				contentItem.updated = (Integer)Datetime.now().getTime();
				contentItem.contenttype = 'text/plain';
				contentItem.charset = 'UTF-8';
				contentItem.language = 'en-us';
				contentItem.content = tweet.text;
				contentItem.parentid = '';
				contentItem.reply = false;
				contentItem.forward = false;
				contentItems.add(contentItem);
			}

		}
		return contentItems;
	}

	private String getTwitterBearerToken() {

		HttpOutboundCallHelper httpHelper = new HttpOutboundCallHelper();
		Twitter_API__c TwitterAPISettings = Twitter_API__c.getOrgDefaults();

		String authHeader = httpHelper.createAuthHeader(TwitterAPISettings.App_Consumer_Key__c, TwitterAPISettings.App_Consumer_Seceret__c);

		String stoken;
		//Parse JSON for Bearer Token
		String body = 'grant_type=client_credentials';
		HttpResponse calloutResponse = httpHelper.httpRequestCallout(authHeader, 'POST', body, TwitterAPISettings.Oath_2_Endpoint__c, null);
		JSONParser parser = JSON.createParser(calloutResponse.getBody());
		while (parser.nextToken() != null) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'access_token'){
				parser.nextToken();
				stoken = parser.getText();
			}
		}
		//Return Token so it can be used in next call
		return stoken;
	}


}