import { LightningElement, api } from 'lwc';
import fetchSummaryInfo from "@salesforce/apex/DisplaySummaryComponent.fetchSummaryInfo";//generateImage
import generateImage from "@salesforce/apex/DisplaySummaryComponent.generateImage";//
export default class DisplaySummaryComponent extends LightningElement {
    responseInfo;
    responseImage;
    question;
    imageRequest;
    @api recordId;
    getData(){
        this.responseInfo = '';
        fetchSummaryInfo({recordId: this.recordId, question: this.question}).then(resp =>{
            var parsedResposne= JSON.parse(resp);
            console.log(parsedResposne);
            this.responseInfo = parsedResposne.choices[0].text;


        })
    }
    generate(){
        generateImage({imageRequest:this.imageRequest})
            .then(resp =>{
                var respParse = JSON.parse(resp);
            this.responseImage = respParse.data[0].url;
            })
    }
    changeVal(evt){
        if(evt.target){
            this.question = evt.target.value;
        }
        
    }

    changeValImage(evt){
        if(evt.target){
            this.imageRequest = evt.target.value;
        }
    }
}