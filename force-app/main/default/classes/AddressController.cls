/***********************************************************************************************
 * Author Name : Priyanka Korade
 * Class Name : AddressController
 * Purpose : Controller Class for Address_Book__c  Object related actions 
 * *********************************************************************************************/
public with sharing class AddressController {
    /*********************************************************************************************
     * Method Name : getAddress
     * Author Name : Priyanka Korade
     * purpose : Responsible For fetching All Addresses Related to current user 
     * parameter : noparameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Address_Book__c> getAddress(){
        Id user = UserInfo.getUserId(); 
        // BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode,       
        return [SELECT Name,Street__c, City__c,Landmark__c,State__c , Country__c,PostalCode__c 
                FROM Address_Book__c WHERE CreatedById= :user];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getBillingAddress(){
        Id user = UserInfo.getUserId(); 
        return [SELECT Name,BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode
                FROM Account WHERE CreatedById= :user];
    }
	
}