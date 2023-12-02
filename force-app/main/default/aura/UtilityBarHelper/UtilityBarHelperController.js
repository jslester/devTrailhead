({
    onNewMessage: function(cmp, evt, helper) {
        let recordId = evt.getParam('recordId');
        var content = evt.getParam('content');
        var name = evt.getParam('name');
        var type = evt.getParam('type');
        var timestamp = evt.getParam('timestamp');

        var action = cmp.get("c.retrieveSentimentFromHuggingFace");
        action.setParams({ message: content });
        action.setCallback(this, function(Response) {
            var State = Response.getState();
            if (State === "SUCCESS") {
                var respVal = Response.getReturnValue();
                if(respVal && !respVal.error){                  
                    respVal[0].forEach(value =>{
                        if(value.label === 'negative' && value.score > .6){
                        	helper.raiseFlag(cmp, recordId);
                    	}
                    })
                }
                
            }
        });
        $A.enqueueAction(action);
    }
})