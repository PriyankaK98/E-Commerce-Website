import { api, LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ShowOrder extends NavigationMixin(LightningElement) {
    @api order;
    @api proceed;
    NavigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            }
        });
    }
    NavigateToAddress(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Address_Page__c'
            },
            state:{
                "deliveryButton":true,
                "amt" : this.order[0].Total__c,
                "orderId" : this.order[0].Id      
            }
        });
    }
}