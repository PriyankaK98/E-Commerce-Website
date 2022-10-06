import  { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { getFieldValue, getFieldDisplayValue } from 'lightning/uiRecordApi';

const _getDisplay = function(data,field){
    return getFieldDisplayValue(data,field)?
                   getFieldDisplayValue(data,field):
                   getFieldValue(data,field);


}
const displayToast = function(thisArg,toastMessage,toastTitle,toastVariant){
     const eventRef = new ShowToastEvent({
        title: toastTitle,
        message: toastMessage,
        variant: toastVariant
    });
 thisArg.dispatchEvent(eventRef);
}

export{
    displayToast,
    _getDisplay
}