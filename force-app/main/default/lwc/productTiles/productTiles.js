import { api, LightningElement, track, wire } from 'lwc';
import getAllProducts from '@salesforce/apex/ProductController.getAllProducts';
import getProductByProductIds from '@salesforce/apex/ProductController.getProductByProductIds';

export default class ProductTiles extends LightningElement {
    products;
    @track productList=[];
    @api prodIds;
    PrevRows=0;
    skipRows = 0;
    limit = 9;

    @wire(getAllProducts,{offset : '$skipRows', l : '$limit'})
    getProduct({data,error}){
        if(data){
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
    @wire(getProductByProductIds,{ids : '$prodIds'})
    getCategoryProduct({data,error}){
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
    }
    previousRecords(){
        if(this.skipRows - this.limit >=0)
        {
            this.PrevRows=this.skipRows;
            this.skipRows = this.skipRows - this.limit;
        }
    }
    nextRecords(){
        this.PrevRows=this.skipRows;
        this.skipRows = this.skipRows + this.limit;
    }
}