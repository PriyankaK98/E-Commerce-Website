import { LightningElement, wire } from 'lwc';
import accountDetail from '@salesforce/apex/accountController.accountDetail'

export default class MyAccount extends LightningElement {
    
    @wire(accountDetail) account;

    
}