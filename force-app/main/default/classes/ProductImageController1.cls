/***********************************************************************************************
 * Author Name : Priyanka Korade
 * Class Name : ProductImageController1
 * Purpose : Controller for Product_Image__c object Controller Object related actions 
 * *********************************************************************************************/

public with sharing class ProductImageController1 {
     /*********************************************************************************************
     * Method Name : getAllProducts
     * Author Name : Priyanka Korade
     * purpose : Responsible fetching all Product Images
     * parameter : noparameter
     * *******************************************************************************************/
    @auraEnabled(cacheable = true)
    public static List<Product_Image__c> getAllProducts(){
        return [SELECT Product__r.Name,Product__r.Description, URL__c FROM Product_Image__c 
                WHERE HeroImage__c = true];
    }
}