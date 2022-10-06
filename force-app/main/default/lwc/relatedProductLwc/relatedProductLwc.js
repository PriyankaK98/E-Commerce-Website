import { api, LightningElement, track, wire } from 'lwc';
import getRelatedProduct from '@salesforce/apex/ProductController.getRelatedProduct';


export default class RelatedProductLwc extends LightningElement {
    @api cat;
    @track productList=[];
    @wire(getRelatedProduct,{categoryId : "$cat"}) products({data,error}){
        if(data){
            if(data.length > 0){
                this.productList=[];
            data.forEach(prod => {
                let stock=true;
                if(prod.RemainingQuantity__c > 0)
                    stock=false;
                const product={
                    Name : prod.Name,
                    Price__c : prod.Price__c,
                    Description : prod.Description,
                    availability : stock,
                    ProductImages__r : prod.ProductImages__r,
                    RemainingQuantity__c : prod.RemainingQuantity__c,
                    Id : prod.Id
                }
                this.productList.push(product);
            });
            console.log(this.productList);
            }
        }
    };

}