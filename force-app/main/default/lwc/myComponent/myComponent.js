import { LightningElement } from 'lwc';

export default class MyComponent extends LightningElement {
    contactIcon;
    accountIcon;
    addressIcon;
    ordersIcon;
    cartIcon;
    connectedCallback(){
        this.contactIcon= "standard:customers";
        this.accountIcon= "standard:account";
        this.addressIcon= "standard:address";
        this.ordersIcon="standard:orders";
        this.cartIcon="standard:checkout"
    }
    
}