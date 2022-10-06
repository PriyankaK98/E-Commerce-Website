import { LightningElement } from 'lwc';
import myResource from '@salesforce/resourceUrl/myResource';
import { NavigationMixin } from 'lightning/navigation';

export default class WelcomeComp extends NavigationMixin(LightningElement) {
    Women = myResource+'/Women-clothing.jpg';
    Men = myResource+'/mens-clothing.jpg';
    Electronics = myResource+'/Electronics.jpg';
    Footwear = myResource+'/formal-and-casual-wear.jpg';
    Cosmetics = myResource+'/cosmetics.png';

    goToProductList(){
        
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Products_1__c'
            },
        });
    }
}