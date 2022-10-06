import { api, LightningElement, track } from 'lwc';

export default class EditAddress extends LightningElement {
    @api address;
    @track customFormModal = false; 
    
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        
        this.customFormModal = false;
    }
    customSaveModelPopup(){
        this.customHideModalPopup();
    }
}