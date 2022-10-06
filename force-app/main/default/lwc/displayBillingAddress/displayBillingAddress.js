import { LightningElement, wire } from 'lwc';
import getBillingAddress from '@salesforce/apex/AddressController.getBillingAddress';
export default class DisplayBillingAddress extends LightningElement {
    @wire(getBillingAddress)bill;
}