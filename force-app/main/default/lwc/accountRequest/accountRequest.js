import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



export default class AccountRequest extends LightningElement {
    
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

    handleChange(event){
        this.dispatchEvent(
            new ShowToastEvent({
                    title : 'success',
                    message : event.detail.apiName + 'Created',
                    variant: 'success',

            }),
        );

    }
}