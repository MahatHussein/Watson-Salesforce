public with sharing class HttpOutboundCallHelper {

	public String createAuthHeader(String username, String password){
		Blob headerValue = Blob.valueOf(username + ':' + password);
		String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
		return authorizationHeader;
	}

	public HttpResponse httpRequestCallout(String authHeader, String method, String body, String endpoint, String contentType){

		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint);
		req.setMethod(method);
		req.setHeader('Authorization', authHeader);

		if(contentType != null){
			req.setHeader('Content-Type', contentType);
		}

		if(body != null){
			req.setBody(body);
		}

		Http http = new Http();
		HttpResponse response;

		try{
			//System.debug('Callout Body: '+req.getBody());
			response = http.send(req);
			//System.debug('Callout Response: '+response.getBody());
		}catch(CalloutException e){
			System.debug('Callout Exception: '+e);
			return null;
		}
		return response;
	}

}