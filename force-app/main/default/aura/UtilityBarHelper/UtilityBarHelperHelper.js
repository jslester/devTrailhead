({
	raiseFlag : function(cmp, recordId) {
		var omniAPI = cmp.find("omniToolkit");
        omniAPI.getAgentWorks().then(function(result) {           
            var works = JSON.parse(result.works);
            works.forEach(work =>{
                if(work.workItemId && recordId == work.workItemId){
                	omniAPI.raiseAgentWorkFlag({workId: work.workId, message: "Raising flag for negative customer messages"}).then(function(res) {
                        if (res) {
                            console.log("Flag raised successfully");
                        } 
                    }).catch(function(error) {
                        console.log(error);
                    });
            	}
                
            })
            
        }); 
	}
})