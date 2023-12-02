@IsTest
private class RetrieveMessageSentimentTest {
    private static final List<String> sentiments = new List<String>{'negative', 'neutral', 'positive'};
	private class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint

            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"label":"negative", "score":0.5},{"label":"neutral", "score":0.25},{"label":"positive", "score":0.25}]');
            res.setStatusCode(200);
            return res;
        }
    }
    private static testmethod void VerifySentimentReturn(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.StartTest();
        List<Object> response = (List<Object>)RetrieveMessageSentiment.retrieveSentimentFromHuggingFace('This is an angry message!');
        Test.StopTest();
        system.debug(response);
        for(object obj : response){
            Map<String, string> parsedObj = (Map<String, string>)obj;
            system.assertEquals(true, sentiments.contains(parsedObj.get('label')));
            
        }
        
    }
}