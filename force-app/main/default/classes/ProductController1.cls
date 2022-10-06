public with sharing class ProductController1 {
    @auraEnabled(cacheable = true)
    public static List<Product2> getAllProducts(){
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,
               (SELECT URL__c FROM ProductImages__r  WHERE HeroImage__c = true) 
                FROM Product2];
    }
    
}