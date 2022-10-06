import { LightningElement, track } from 'lwc';
import { createMessageContext, releaseMessageContext,
    subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";

export default class LmsSub extends LightningElement {
    context = createMessageContext();
    subscription = null;
    @track receivedMessage = '';
   
    subscribeMC() {
       if (this.subscription) {
           return;
       }
       this.subscription = subscribe(this.context, SAMPLEMC, (message) => {
           this.handleMessage(message);
       });
    }
   
    unsubscribeMC() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
 
    handleMessage(message) {
        this.receivedMessage = message ? JSON.stringify(message, null, '\t') : 'no message payload';
        alert("Happening again");
    }
 
    disconnectedCallback() {
        releaseMessageContext(this.context);
    }
}