import { api, LightningElement, wire } from 'lwc';
import getCoupon from '@salesforce/apex/CouponController.getCoupon';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {displayToast} from 'c/util';

export default class CouponLwc extends LightningElement {
    coupon;
    couponName;
    @api quantity;
    @api amount;
    discountedAmount;
    customFormModal;
    handleChange(event){
        this.couponName=event.target.value;
    }

    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        this.customFormModal = false;
    }

    validateCoupon(){
        getCoupon({couponCode : this.couponName})
        .then((cpn)=>{
            if(cpn){
                if(cpn.RemainingQuantity__c >= this.quantity){
                    this.discountedAmount=this.amount-(this.amount*(cpn.Discount__c/100));
                    this.dispatchEvent(new CustomEvent("discount",{detail : this.discountedAmount}));
                    displayToast(this,"Coupon Applied Discounted Amount : "+this.discountedAmount,"Coupon Validation","success")
                    this.customFormModal = false;
                }
                else{
                    displayToast(this,"You Can Have Only "+cpn.RemainingQuantity__c+" items per order","copon Validation","error")
                }
            }
        })
        .catch(error => {
            displayToast(this,"Coupon Invalid Or Expired","copon Validation","error")
        })
    }
}