/***********************************************************************************************
 * Author Name : Abhisek Paliwal
 * Class Name : CategoryController
 * Purpose : Controller Class for Category__c  Object related actions 
 * *********************************************************************************************/
public with sharing class CategoryController {
    
    /*********************************************************************************************
     * Method Name : createOrder
     * Author Name : Abhishek Paliwal
     * purpose : Responsible For fetching Categories 
     * parameter : noparameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Category__c> getCategories(){
        return [SELECT Id, Name, ParentCategory__c, (SELECT Name,id FROM Categories__r) FROM Category__c WHERE ParentCategory__c = null];
    }
	
    /*********************************************************************************************
     * Method Name : createOrder
     * Author Name : Abhishek Paliwal
     * purpose : Responsible For fetching Product Category Using Category Id  
     * parameter : 1. String Id Id Of the Category
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product_Category__c> getProductsByCategory(String id){
        return [SELECT  Product__c FROM Product_Category__c WHERE  Category__c= : id];
    }
}