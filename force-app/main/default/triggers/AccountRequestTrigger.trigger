trigger AccountRequestTrigger on Account_Request__c (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            AccountRequestTriggerHandler.afterUpdateHandler(trigger.new);
        }
    }
}