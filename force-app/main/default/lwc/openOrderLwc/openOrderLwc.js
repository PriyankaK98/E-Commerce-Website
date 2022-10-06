import { LightningElement, wire } from 'lwc';
import getOpenOrder from '@salesforce/apex/OrderController.getOpenOrder';
import { refreshApex } from '@salesforce/apex';
export default class OpenOrderLwc extends LightningElement {
    @wire(getOpenOrder)orders;
    renderedCallback() {
        refreshApex(this.orders);
    }
}