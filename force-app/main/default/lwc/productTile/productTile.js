import { api, LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class ProductTile extends NavigationMixin(LightningElement) {
    @api product;
    @api actions=false;
    qty = 1;
    
    sendId(event){
        
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Product_Detail__c'
            },
            state:{
                "productId": event.target.value,
                "availability" : this.product.availability
            }
        });
        /*var comp= {
            componentDef: "c:productsLWC",
            attributes: {
                productId: event.target.value,
                availability : this.product.availability
            }
    };
    var encodedComp= btoa(JSON.stringify(comp));
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: '/one/one.app#' + encodedComp
                }
            });*/
    }


    addQty(event){
            if(this.qty < event.target.value )
                this.qty=this.qty+1;
    }
    minusQty(){
        if(this.qty-1 >0){
            this.qty=this.qty-1;
        }
    }
    

    
}