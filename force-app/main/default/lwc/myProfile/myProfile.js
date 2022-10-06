import { LightningElement, wire } from 'lwc';
import contactDetail from '@salesforce/apex/contactController.contactDetail';


export default class MyProfile extends LightningElement {
    @wire(contactDetail) contact;
   
}