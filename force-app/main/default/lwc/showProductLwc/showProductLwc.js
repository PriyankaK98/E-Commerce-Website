import { LightningElement, track } from 'lwc';
import getProductsByCategory from '@salesforce/apex/CategoryController.getProductsByCategory';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShowProductLwc extends LightningElement {
    catId;
    @track productIds=[];

    get prodId() {
        return this.productIds;
    }
    searchProduct(event){
        this.productIds=event.detail;
    }
    
    connectedCallback() {
        let testURL = window.location.href;
        let newURL = new URL(testURL).searchParams;
        // eslint-disable-next-line no-console
        console.log('id ===> '+newURL.get('category')); 
       // this.urlParam = newURL.get('category');
       //alert(newURL.get('category'));
        
    }

    

    getId(event){
        getProductsByCategory({id : event.detail})
        .then((data)=>{
            this.productIds=[];
            data.forEach(product => {
                this.productIds.push(product.Product__c);
            });
        }).catch((error)=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error in getting Record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        })
    }
}