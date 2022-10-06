import { api, LightningElement, wire } from 'lwc';
import getProductWithoutCategory from '@salesforce/apex/ProductController.getProductWithoutCategory';
import updateCartItem from '@salesforce/apex/cartItems.updateCartItem';
import updateAmount from '@salesforce/apex/cartItems.updateAmount';
import {displayToast} from 'c/util';

export default class CartItem extends LightningElement {
    @api cartItem;
    @api prodId;
    @wire(getProductWithoutCategory,{id : '$prodId' })product;
    addQty(event){
        let quant = 1+parseInt(event.target.value)
        updateCartItem({id:this.cartItem.Id ,qty :quant})
        .then(() =>{
            displayToast(this,"Increased","Increase Quantity","success")
            this.dispatchEvent(new CustomEvent('loadpage'));
        }).catch(error =>{
            displayToast(this,error.body.message,"ERROR","error")
        })
    }
    minusQty(event){
        let quant = parseInt(event.target.value) - 1;
        updateCartItem({id:this.cartItem.Id ,qty :quant})
        .then(() =>{
            displayToast(this,"Decreased","Decrease Quantity","success")
            this.dispatchEvent(new CustomEvent('loadpage'));
        }).catch(error =>{
            displayToast(this,error.body.message,"ERROR","error")
        })
    }
    refreshPage(){
        this.dispatchEvent(new CustomEvent('loadpage'));
    }
    getDiscountedAmount(event){
       // this.discountedAmount=event.detail;
       updateAmount({item : this.cartItem,amount : event.detail})
       .then((result)=>{
           this.refreshPage();
       })
       .catch((error)=>{
            displayToast(this,error.body.message,"ERROR","error")
       })
    } 
}