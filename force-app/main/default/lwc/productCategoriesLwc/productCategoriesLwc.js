import { api, LightningElement } from 'lwc';

export default class ProductCategoriesLwc extends LightningElement {
    @api cats;
    publishCategory(event){
        const selectedEvent = new CustomEvent('selected', { detail: event.detail.name });
        this.dispatchEvent(selectedEvent);
    }
}