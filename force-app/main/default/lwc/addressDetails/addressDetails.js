import { api, LightningElement, track, wire } from 'lwc';
import getAddress from '@salesforce/apex/AddressController.getAddress';
import updateAddr from '@salesforce/apex/OrderController.updateAddr';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import {displayToast} from 'c/util';

export default class AddressDetails extends NavigationMixin(LightningElement) {
    @track selectedValue;
    amt;
    cartId;
    deliveryButton = false;
    payment=false;
    orderId;
    @track selectedValue;
    @wire(getAddress) address;


    //for Refreshing the page
    refreshPage() {
        refreshApex(this.address);
    }

    //for handling selected address
    handleSelected(event) {
        const addr =event.target.value;
        this.addrId=addr;
        this.address.data.forEach( add => {
            if(add.Id === addr){
                this.selectedValue = add.Name + ", \n" + add.Street__c + " " + add.City__c + ", \n" +
                add.Landmark__c + " " + add.State__c + " \n" + add.Country__c + " " + add.PostalCode__c;
            }
        });
    }
    connectedCallback() {
        let testURL = window.location.href;
        let newURL = new URL(testURL).searchParams;
        // eslint-disable-next-line no-console
        this.cartId = newURL.get('cartId');
          
        this.deliveryButton = newURL.get('deliveryButton');
        this.amt = newURL.get('amt');
        this.orderId=newURL.get("orderId");
       // this.urlParam = newURL.get('category');
       //alert(newURL.get('category'));
        
    }
    proceedForPayment() {
        if (this.selectedValue) {
            this.payment=true;
            updateAddr({orderId : this.orderId , addr : this.selectedValue})
            .then(()=>{
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Payment__c'
                    },
                    state:{
                        "orderId": this.orderId,
                        "amount" : this.amt,
                        "address" : this.selectedValue
                    }
                });
            })
            .catch((error)=>{
                displayToast(this,error.body.message,"ERROR","error");
            })
        }else{
            displayToast(this,"Please Select An Address","Warning","warning");
        }
    }
}