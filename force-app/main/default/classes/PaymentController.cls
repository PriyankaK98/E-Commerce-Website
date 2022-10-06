/****************************************************************************
 * Class Name : PaymentController
 * Author Name : Abhishek Paliwal
 * Purpose : An Controller class For Payment Object
 ****************************************************************************/
public with sharing class PaymentController {
    /**************************************************************************************
     * Method Name : createPayment
     * Purpose : Creates Payment Class Object
     * Parameter : it accepts two parameter 1. order Id 2. Payment amount
     **************************************************************************************/
    @AuraEnabled
    public static Id createPayment(String orderId,Double amount){
        Id uid = UserInfo.getUserId();
        Contact cust=[SELECT Id,Name FROM Contact WHERE OwnerId = : uid LIMIT 1];
        Payment__c pymt=new Payment__c(Name=cust.Name,Customer__c=cust.Id,Order__c=orderId,
                              Status__c='Created',Amount__c=amount,Date__c= System.today());
        try {
            insert pymt;
        } catch (Exception e) {
            throw new CustomException('Payment Failed Cannot Proceed');
        }
        return pymt.Id;
    }
}