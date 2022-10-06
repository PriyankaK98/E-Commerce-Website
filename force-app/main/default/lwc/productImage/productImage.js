import { api, LightningElement, wire } from 'lwc';
import getImageByProductId from '@salesforce/apex/ProductImageController.getImageByProductId';

export default class ProductImage extends LightningElement {
    @api prodId;
    url;
    name;
    @wire(getImageByProductId,{prodId : '$prodId'})
    getImage({data,error}){
        if(data){
            this.url=data.URL__c;
            this.name=data.Name;
        }
    }
}