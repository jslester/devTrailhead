public with sharing class RetrieveMessageSentiment {
    public static final string HUGGING_FACE_SENTIMENT_ENDPOINT = 'https://api-inference.huggingface.co/models/lxyuan/distilbert-base-multilingual-cased-sentiments-student';
	@AuraEnabled
    public static Object retrieveSentimentFromHuggingFace(String message){
        String resp;
        
        Http http = new http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(HUGGING_FACE_SENTIMENT_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer '+label.HuggingFaceApiToken);
        String inputs = message;
        request.setBody(JSON.serialize(new RequestBodyWrapper(inputs)));
        HttpResponse response = http.send(request);
        try{
            if(response.getStatusCode() == 200){
                List<Object> data = (List<Object>)JSON.deserializeUntyped(response.getBody());
                return data;
            }
            
        }catch(exception e){
            system.debug(e.getMessage());
        }
        
        return new map<String, string>{'error' => 'There was an error returning sentiment'};
    }
    
    public class RequestBodyWrapper{
        public string inputs;
        public RequestBodyWrapper(string inputs){
            this.inputs = inputs;
        }
    }
    
    public class ResponseBodyWrapper{
        public string label;
        public string score;
    }
}