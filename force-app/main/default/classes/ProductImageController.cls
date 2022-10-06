public with sharing class ProductImageController {
    @AuraEnabled(cacheable=true)
    public static List<Product_Image__c> getImage(){
        return[SELECT URL__c FROM Product_Image__c];
    }

    @AuraEnabled(cacheable=true)
    public static Product_Image__c getImageByProductId(Id prodId){
       return [SELECT URL__c,Name FROM Product_Image__c WHERE Product__c= : prodId AND HeroImage__c=true LIMIT 1 ];
    }
}