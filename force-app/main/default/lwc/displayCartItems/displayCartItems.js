import { LightningElement, wire } from 'lwc';
import getOpenCart from '@salesforce/apex/CartController.getOpenCart';
import createOrder from '@salesforce/apex/OrderController.createOrder';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import {displayToast} from 'c/util';
/*
import getCoupons from '@salesforce/apex/cartItems.getCoupons';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import { displayToast } from "c/util";
*/
export default class DisplayCartItems extends NavigationMixin(LightningElement) {
    qty=1;
    nocart=false;
    orderId;
    @wire(getOpenCart) carts;
    
    proceedToOrder(event){
        createOrder({cartId : event.target.value})
        .then((ordId) => {
            this.orderId=ordId;
            this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'Order_Confirmation__c'
                },
                state:{
                    "orderId": this.orderId ,
                    "amt" :  this.carts.data[0].Amount__c
                }
            });
        })
        .catch((error)=>{
            displayToast(this,error.body.message,"ERROR","error");
        })

        /*var comp= {
            componentDef: "c:addressDetails",
            attributes: {
                cartId: event.target.value,
                deliveryButton:true,
                amt : this.carts.data[0].Amount__c,
                cartId: this.carts.data[0].Id
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
    renderedCallback() {
        this.loadPage();
    }
    loadPage(){
        refreshApex(this.carts);
    }      
}