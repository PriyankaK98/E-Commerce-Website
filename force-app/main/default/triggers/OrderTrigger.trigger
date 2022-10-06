trigger OrderTrigger on Order_Line_Item__c (after insert) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OrderTriggerHandler.afterInsertHandler(Trigger.New);
        }
    }
}