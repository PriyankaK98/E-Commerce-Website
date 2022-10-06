import { api, LightningElement } from 'lwc';

export default class Items extends LightningElement {
    @api maxQty;
    @api cartItem;
    
    f1(){
       // eslint-disable-next-line no-alert
       alert(JSON.stringify(this.cartItem)) ;
    }
    addQty(){
       this.cartItem.Quantity__c = this.cartItem.Quantity__c+1;    

    }
    minusQty(){       
        if(this.cartItem.Quantity__c-1 >=1){
            this.cartItem.Quantity__c = this.cartItem.Quantity__c-1;
        }
    }
}