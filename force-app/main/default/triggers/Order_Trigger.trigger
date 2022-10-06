trigger Order_Trigger on Order__c (after delete) {
	if(Trigger.isDelete){
            OrderTriggerHandler.afterDeleteHandler(Trigger.old);
        }
}