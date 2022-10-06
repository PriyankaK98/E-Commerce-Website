import { api, LightningElement,track } from 'lwc';
//import insertAddress from '@salesforce/apex/AddressController.insertAddress';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import {displayToast} from 'c/util';

export default class AddNewAddress extends NavigationMixin(LightningElement) {
    @track customFormModal = false; 
    @api record;
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        this.customFormModal = false;
    }
    handleSuccess(){
        displayToast(this,"Address Created","Success","success");
        this.customFormModal = false;
        this.dispatchEvent(new CustomEvent('refresh'));
    }

   }