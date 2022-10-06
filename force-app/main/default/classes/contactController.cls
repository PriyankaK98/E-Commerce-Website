/***********************************************************************************************
 * Author Name : Sandesh Sawant
 * Class Name : contactController
 * Purpose : Controller for Contact(Customer) Object related actions 
 * *********************************************************************************************/
public with sharing class contactController {
    /*********************************************************************************************
     * Method Name : upsertContact
     * Author Name : Sandesh Sawant
     * purpose : Responsible insert Contact Into the system 
     * parameter : accepts one parameter Contact 
     * *******************************************************************************************/
    @AuraEnabled
    public static Contact upsertContact(Contact con) {
        System.debug('con => '+con);
        upsert con;
        return con;
    }
     /*********************************************************************************************
     * Method Name : contactDetail
     * Author Name : Sandesh Sawant
     * purpose : Responsible for fetching Contact Information of the current User
     * parameter : no parameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactDetail(){
        Id userId = UserInfo.getUserId();
        return[SELECT Name, Email,Phone,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,Birthdate FROM Contact WHERE OwnerId = :userId];
    }
}