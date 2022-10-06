import {LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPaymentMethods from '@salesforce/apex/OrderController.getPaymentMethods';
import createPayment from '@salesforce/apex/PaymentController.createPayment';
import updatePaymentMethod from '@salesforce/apex/OrderController.updatePaymentMethod';
import { displayToast } from 'c/util';
import Amount from '@salesforce/schema/Opportunity.Amount';

export default class PaymentDetails extends NavigationMixin(LightningElement) {
    amount;
    orderId;
    paymentMode;
    address;
    @wire(getPaymentMethods) methods;
    handleSelected(event) {
        //alert(event.target.value);
        this.paymentMode = event.target.value
    }
    connectedCallback() {
        let testURL = window.location.href;
        let newURL = new URL(testURL).searchParams;
        this.amount = newURL.get('amount');
        this.orderId=newURL.get("orderId");
        this.address=newURL.get("address")
    }

    proceedForOrder() {
        createPayment({ orderId: this.orderId, amount: this.amount })
        .then(()=>{
            updatePaymentMethod({orderId : this.orderId, method : this.paymentMode})
            .then(()=>{
                displayToast(this,"Thanks For Shopping With us", "Order In Process", "success");
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Order_Confirmation__c'
                    },
                    state:{
                        "orderId": this.orderId,
                        "proceed": true
                    }
                });
            })
            .catch((error)=>{
                displayToast(this, error.body.message, "ERROR", "error");
            })
        })
        .catch((error)=>{
            displayToast(this, error.body.message, "ERROR", "error");
        })
    }
}