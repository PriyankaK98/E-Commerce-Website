import { api, LightningElement, track, wire } from 'lwc';
import getDetails from '@salesforce/apex/OrderController.getOrderDetail';
import getOrderByDate from '@salesforce/apex/OrderController.getOrderByDate';

import updateOrderStatus from '@salesforce/apex/OrderController.updateOrderStatus';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import {displayToast} from 'c/util';

export default class OrderLwc extends NavigationMixin(LightningElement) {
    searchValue = '';
    firstValue = '';
    secondValue = '';
    @track rowOffset = 0;
    @track tableLoadingState = false;
    @track err;
    @track offset = 0;
    @track Prevoffset = 0;
    limit = 10;
    currentRecordId;
    @api status;
 
    @track columns = [
        { label: 'Order Number', fieldName: 'Name', type: 'Number' },
        { label: 'Delivery Date', fieldName: 'ExpectedDate__c', type: 'date' },
        { label: 'Total Amount', fieldName: 'Total__c', type: 'Currency' },
        { label: 'Shipping Addres', fieldName: 'Shipping_Address__c', type: 'text' },
        { label: 'Status', fieldName: 'Status__c', type: 'Picklist' }
    ];
    searchKeyword(event){
        this.searchValue = event.target.value;
    }
    firstKeyword(event){
        this.firstValue = event.target.value;
    }
    secondKeyword(event){
        this.secondValue = event.target.value
    }
    @wire(getDetails, { offset: '$offset', l: '$limit',searchKey: '$searchValue' })Orders;
    handleOrderbyDate(){
        if(this.firstValue !== '' && this.secondValue !==''){
            getOrderByDate({
                FirstDate : this.firstValue,
                LastDate : this.secondValue
            })
            .then(result =>{
                this.orders = result;
            })
            .catch(error =>{
                this.orders = null;
            })
        }
    }

    handlePrev(_event) {
        if (this.offset - this.limit >= 0) {
            this.tableLoadingState = true;
            this.Prevoffset = this.offset;
            this.offset = this.offset - this.limit;
        }
    }

    handleNext(_event) {
        this.tableLoadingState = true;
        this.Prevoffset = this.offset;
        this.offset = this.offset + this.limit;
    }

    handleChange(event) {
        const selectedRows = event.detail.selectedRows;
        if (selectedRows.length > 0) {
            this.currentRecordId = selectedRows[0].Id;
            this.status = selectedRows[0].Status__c;
        }
    }

    handleDelete() {
        if (this.currentRecordId) {
            updateOrderStatus({ id: this.currentRecordId, status: 'Cancelled' })
                .then((result) => {
                    displayToast(this,'Order cancelled','CANCEL','error');
                    refreshApex(this.Orders)
                })
                .catch((error)=>{
                    displayToast(this,error.body.message,'ERROR','error');
                })
        }
        else {
            displayToast(this,'Please select order','WARNING','warning');
        }
    }

    viewOrder() {
        if (this.currentRecordId) {
            this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'Order_Confirmation__c'
                },
                state:{
                    "orderId": this.currentRecordId
                }
            });
        } else {
            displayToast(this,'Please select order','WARNING','warning');
        }
    }
}