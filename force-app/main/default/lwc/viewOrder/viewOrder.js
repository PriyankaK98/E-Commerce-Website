import { LightningElement, wire } from 'lwc';
import getOrderById from '@salesforce/apex/OrderController.getOrderById';
import { refreshApex } from '@salesforce/apex';
export default class ViewOrder extends LightningElement {
    orderId;
    amt;
    proceed=false;
    @wire(getOrderById,{orderID: '$orderId'}) orders;
    connectedCallback() {
        let testURL = window.location.href;
        let newURL = new URL(testURL).searchParams;
        // eslint-disable-next-line no-console
        this.orderId = newURL.get('orderId');
        this.amt=newURL.get('amt');
        this.proceed=newURL.get('proceed');
    }
    renderedCallback() {
        refreshApex(this.orders)
    }
}