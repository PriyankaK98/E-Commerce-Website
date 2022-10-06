@isTest
private class AccountRequestTriggerTestClass {
    static testMethod void validateAccountRequestTriggerHandler(){
        Account_Request__c acc= new Account_Request__c(Id='a085g000000tNlyAAE',Name='Priyanka',Status__c='Approved,');
        upsert acc;
        system.debug(acc.Name);
        List<Account> a = [SELECT Name FROM Account WHERE Name = :acc.Name];
        system.debug(a);
        system.assertEquals('Priyanka',a[0].Name);
    }
}