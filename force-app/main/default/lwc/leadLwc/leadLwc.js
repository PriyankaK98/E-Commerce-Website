import { LightningElement, track, wire } from 'lwc';
import getLeads from '@salesforce/apex/LeadController.getLeads';
import saveTask from '@salesforce/apex/LeadController.saveTask';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class LeadLwc extends LightningElement {

    @track error;
    @track leadList;
    @track columns=[
        {label:'Name', fieldName: 'Name'},
        {label:'Mobile', fieldName: 'Phone'},
        {label:'Email Id', fieldName: 'Email'},
        {label:'Company', fieldName: 'Company'},
        {label:'Lead Status', fieldName: 'Status'},
        {label:'Task', type:'button', typeAttributes: {
            label: 'Log a call'}
        }
    ];
    @wire (getLeads) wiredLeads({error,data}) {
        if (data) {
            this.leadList = data;
        } else if (error) {
            this.error = error;
        }
    };

    @track customFormModal = false;
    @track name;
    @track subject;
    @track description;
    @track leadRow = {};

    get typePicklistValues(){
        return [
            {label:'Call', value:'Call'},
            {label:'Meeting', value:'Meeting'},
            {label:'Other', value:'Other'},
            {label:'Email', value:'Email'}
        ];
    }
    
    handleSubjectChange(event){
        this.subject = event.target.value;
    }
    handleDescriptionChange(event){
        this.description = event.target.value;
    }

    handleRowSelection(event) {
        const dataRow = event.detail.row;
      
        this.leadRow = dataRow;

        this.customFormModal = true;    

    }
    customHideModalPopup() {            
        this.customFormModal = false;
    }
    customSaveModelPopup(){
        this.customHideModalPopup();
    
        saveTask({subject: this.subject, description: this.description, lead: this.leadRow.Id })
        // eslint-disable-next-line no-unused-vars
        .then(task =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: "Task Created",
                    variant: "success"
                })
            );
        // eslint-disable-next-line no-unused-vars
        }).catch(error =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating a task',
                    message: "Error",
                    variant: "error"
                })
            );
        });
    }

    
}