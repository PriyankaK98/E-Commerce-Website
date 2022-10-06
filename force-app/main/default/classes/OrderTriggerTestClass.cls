@isTest
private class OrderTriggerTestClass {
    
    static testMethod void validateOrderTriggerHandler(){
         Account ac= new Account(Name='Pri');
        insert ac;
        Order__c ord = new Order__c(Customer__c='', AccountName__c=ac.Id);
        insert ord;
 		Id oid = ord.Id;
        Product2 prodt = new Product2(Name='Crop Top',Price__c=699,TotalQuantity__c=500,RemainingQuantity__c=500,
                                    ProductCode='Top-01');
        insert prodt;        
        Order_Line_Item__c order= new Order_Line_Item__c(Name='order1',Product__c=prodt.Id,
                                                         Quantity__c=2,order__c=oid);

        system.debug('order'+[SELECT Id FROM order__c WHERE Id = 'a065g000007Xar5AAC']);
        system.debug('Before insert'+order);
        insert order;
        Product2 prod = [SELECT RemainingQuantity__c FROM Product2 WHERE Id = '01t5g000000i93mAAA'];
        system.debug(prod);
        system.debug('After insert quantity left'+prod.RemainingQuantity__c);  
        System.assertEquals(498,prod.RemainingQuantity__c);
	}
}