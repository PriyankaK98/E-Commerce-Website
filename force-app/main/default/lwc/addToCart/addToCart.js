import { api, LightningElement } from 'lwc';
import addItemToCart from '@salesforce/apex/CartController.addItemToCart';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AddToCart extends LightningElement {
    @api product;
    @api quantity;
    @api availability=false;
    handleClick(){
        addItemToCart({prodId: this.product,quantity : this.quantity})
        .then((result) => {
            const evt = new ShowToastEvent({
                title: 'Add To Cart',
                message: 'Item Added To Cart',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        })
        .catch((error) => {
            const evt = new ShowToastEvent({
                title: 'Failed Add To Cart',
                message: error.message,
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        });
    }
}