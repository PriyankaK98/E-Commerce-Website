import { LightningElement, track } from 'lwc';
import getSearchedProduct from '@salesforce/apex/ProductController.getSearchedProduct';
import {displayToast} from 'c/util';
export default class SearchProduct extends LightningElement {
    @track prodIDList = [];
    searchValue = '';
 
    // update searchValue var when input field value change
    searchKeyword(event) {
        this.searchValue = event.target.value;
    }
 
    // call apex method on button click 
    handleSearchKeyword() {
        if (this.searchValue !== '') {
            getSearchedProduct({searchProduct : this.searchValue})
                .then(result => {
                    this.prodIDList=[];
                    result.forEach(product => {
                        this.prodIDList.push(product.Id);
                    });
                    const searchEvent = new CustomEvent('search', { detail: this.prodIDList });
                    this.dispatchEvent(searchEvent);                     
                })
                .catch(error => {
                    displayToast(this,error.body.message,"ERROR","error");
                    console.log(error);   
                    this.prodIDList = undefined;
                });
        }
    }
}