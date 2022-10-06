import { api, LightningElement } from 'lwc';

export default class ConfirmationLwc extends LightningElement {
    @api positiveLabel;
    @api buttonLabel;
    @api message;
    customFormModal
    positiveAction(){
        const saveEvent = new CustomEvent('save');
        this.customFormModal = false;
        this.dispatchEvent(saveEvent);
    }
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        this.customFormModal = false;
    }
}