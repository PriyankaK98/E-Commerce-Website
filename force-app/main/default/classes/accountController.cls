/***********************************************************************************************
 * Author Name : Sandesh Sawant
 * Class Name : accountController
 * Purpose : Controller Class for account related actions 
 * *********************************************************************************************/
public with sharing class accountController {
    /*********************************************************************************************
     * Method Name : accountDetail
     * Author Name : Sandesh Sawant
     * purpose : It Gives The All Account Details Related to current User 
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Account> accountDetail(){
        Id userId = UserInfo.getUserId();
        return[SELECT Name, Phone, Description,EmailId__c FROM Account WHERE OwnerId = :userId];
    }
}