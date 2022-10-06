import { LightningElement, track, wire } from 'lwc';
import getProduct from '@salesforce/apex/ProductController.getProduct';


export default class ProductsLWC extends LightningElement {
   // resource=resourceName;
    qty=1;
    productId;
    availability=false;
    catId;
    subscription=null;
    @track productList = [];
    @track Id;


    @wire(getProduct,{id : '$productId'})
    getProducts({data,error}){
        if(data){
            data.forEach((prod)=>{
                const catId=[];
                if(prod.ProductCategories__r){
                    prod.ProductCategories__r.forEach((cats)=>{
                        catId.push(cats.Category__c);
                    })
                }
                let stock=true;
                if(prod.RemainingQuantity__c > 0)
                    stock=false; 

                const Product ={
                    name: prod.Name,
                    description: prod.Description,
                    remQty:prod.RemainingQuantity__c,
                    price:prod.Price__c,
                    imgs:prod.ProductImages__r,
                    cat:catId,
                    Id: prod.Id,
                    availability : stock
                } 
                this.remQuantity=prod.RemainingQuantity__c;
                this.productList.push(Product);         
            });
        }else if(error){
            //
        }
    }
    connectedCallback() {
        let testURL = window.location.href;
        let newURL = new URL(testURL).searchParams;
        // eslint-disable-next-line no-console
        this.productId = newURL.get('productId');
    
        if(newURL.get('availability')){   
        this.availability = newURL.get('availability');
        }
        
    }
    addQty(){
        if(this.qty < this.remQuantity)
            this.qty=this.qty+1;
    }
    minusQty(){
        if(this.qty-1 >=1){
            this.qty=this.qty-1;
        }
    }
  
}