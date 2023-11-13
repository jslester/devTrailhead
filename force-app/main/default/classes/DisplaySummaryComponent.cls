public without sharing class DisplaySummaryComponent {
    public DisplaySummaryComponent() {

    }
    
    @AuraEnabled
    public static string generateImage(string imageRequest){
        Http http = new Http();
        httpRequest request = new httpRequest();
        request.setEndpoint('https://api.openai.com/v1/images/generations');
        request.setHeader('Authorization', 'Bearer '+System.label.openAPIKey);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        
        
        wrapperRequest requestWrap = new wrapperRequest();
        //requestWrap.model = 'text-davinci-003';
        requestWrap.prompt = imageRequest;
       
           request.setBody(JSON.serialize(requestWrap, true));
        
        Httpresponse response = http.Send(request);
        system.debug(response.Getbody());
        return response.Getbody();
    }

    @AuraEnabled
    public static string fetchSummaryInfo(string recordId, string question){
        LivechatTranscript chatTranscript = [select Pre_chat_info__c from livechattranscript where id=: recordId];
        Http http = new Http();
        httpRequest request = new httpRequest();
        request.setEndpoint('https://api.openai.com/v1/completions');
        request.setHeader('Authorization', 'Bearer '+System.label.openAPIKey);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        
        
        wrapperRequest requestWrap = new wrapperRequest();
            requestWrap.model = 'text-davinci-003';
        requestWrap.prompt = 'Summarize the following array of questions and answers to a general request '+question;
        requestWrap.max_tokens = 50;
           request.setBody(JSON.serialize(requestWrap));
        
        Httpresponse response = http.Send(request);
        system.debug(response.Getbody());
        return response.Getbody();
    }
    
    public class wrapperRequest{
        public string model;
        public string prompt;
        public integer max_tokens;
        //public List<message> messages;
    }
    
}