/*************************************************************************************
 * Author Name : Abhishek Paliwal
 * Class Name : CouponController
 * Purpose : Controller for coupon related actions
 ************************************************************************************/
public with sharing class CouponController {
    
    /***************************************************************************************
     * Method Name : validateCoupon
     * Purpose : returns Coupon by name
     * Parameter : one parameter Coupon name
     ******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static Coupon__c getCoupon(String couponCode){
        return [SELECT id,Discount__c,RemainingQuantity__c,Expired__c FROM Coupon__c WHERE Name = : couponCode AND Expired__c != true  LIMIT 1];
    } 
}