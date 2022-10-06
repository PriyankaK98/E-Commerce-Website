import { api, LightningElement } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import {displayToast} from 'c/util';
export default class DeleteRecord extends LightningElement {
    @api recordId;
    deleteThisRecord(){
        deleteRecord(this.recordId)
            .then(() => {
                displayToast(this,"Record deleted","DELETE","error");
                this.dispatchEvent(new CustomEvent('refresh'));
            })
            .catch(error => {
                displayToast(this,error.body.message,"DELETE","error");
            });
    }
}