import { LightningElement, track, wire } from 'lwc';
import getCategories from '@salesforce/apex/CategoryController.getCategories';
//import { publish, MessageContext } from 'lightning/messageService';
//import COUNT_UPDATED_CHANNEL from '@salesforce/messageChannel/Count_Updated__c';


export default class CategoriesLwc extends LightningElement {
    @track cat=[];
  //  @wire (MessageContext) messageContext;
    publisherMessage;
    publishCategory(event){
       // alert("category "+event.detail);
        const selectedEvent = new CustomEvent('sendid', { detail: event.detail});
        this.dispatchEvent(selectedEvent);
    }
    @wire (getCategories)
    getCategories({data,error}){
        if(data){
            console.log(JSON.stringify(data));
            data.forEach(parentCat => {
                const chilCats=[];
                if(parentCat.Categories__r){
                    parentCat.Categories__r.forEach(cat => {
                        const cCat={
                            label : cat.Name,
                            name : cat.Id,
                            expanded : false,
                            items :[]
                        }
                        chilCats.push(cCat);
                    });
                }
                const c={
                    label: parentCat.Name,
                    name : parentCat.Id,
                    expanded: false,
                    items: chilCats
                }
                this.cat.push(c);
            });
            console.log(JSON.stringify(this.cat));
        }
    }
}