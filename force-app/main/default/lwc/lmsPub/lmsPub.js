import { LightningElement } from 'lwc';
import { createMessageContext, releaseMessageContext,
    publish } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";

export default class LmsPub extends LightningElement {
    context = createMessageContext();
     
    publishMC() {
        const message = {
            recordId: "some string",
            recordData: { value: "some value" }
        };

        publish(this.context, SAMPLEMC, message);
        alert("happening")
    }
     
    disconnectedCallback() {
        releaseMessageContext(this.context);
    }
}