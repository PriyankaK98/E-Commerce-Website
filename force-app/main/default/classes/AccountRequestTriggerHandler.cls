/*******************************************************************************************
ClassName: AccountRequestTriggerHandler
Author : Priyanka
CreatedDate : 18-03-2021
Purpose: Its an handler class for Account Request trigger
*******************************************************************************************/
public with sharing class AccountRequestTriggerHandler {
    /***********************************************************************************
	*MethodName:afterUpdateHandler
	*Parameters Accepted: trigger.new
	*Pupose: Creating an account when Account request status changes to approved
	************************************************************************************/
    public static void afterUpdateHandler(list<Account_Request__c> newList){
        Account[] accts = new List<Account>();
        Contact[] conts = new List<Contact>();
        
        for(Account_Request__c accReq : newList){
            if(accReq.Status__c=='Approved,'){
                Account acc = new Account();     
                acc.Name = accReq.Name;
                acc.Phone = accReq.Phone__c;
                acc.EmailId__c = accReq.Email__c;
                acc.Description = accReq.Description__c;                                
                acc.BillingStreet = accReq.BillingStreet__c;
                acc.BillingCity =  accReq.BillingCity__c;
                acc.BillingState = accReq.BillingState__c;
                acc.BillingCountry = accReq.BillingCountry__c;
                acc.BillingPostalCode = accReq.BillingPostalCode__c;
                acc.ShippingStreet = accReq.ShippingStreet__c;
                acc.ShippingCity = accReq.ShippingCity__c; 
                acc.ShippingState = accReq.ShippingState__c;   
                acc.ShippingCountry = accReq.ShippingCountry__c;                                
                acc.ShippingPostalCode = accReq.ShippingPostalCode__c; 
                
                Contact con = new Contact();
                con.FirstName = accReq.FirstName__c;
                con.LastName = accReq.LastName__c;
                con.Email = accReq.PrimaryEmail__c;
                con.Phone = accReq.PrimaryPhone__c;
                con.Title = accReq.PrimaryTitle__c; 
                
                accts.add(acc);        
                conts.add(con);
            }
        }
        try{
            if(accts.size()>0)
            	insert accts;
        }catch(Exception e){
            system.debug(e.getMessage());
        } 
        for(Integer i=0 ; i<conts.size();i++){
            conts[i].AccountId=accts[i].id;
        }
        try{
            if(conts.size()>0)
            	insert conts;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
}