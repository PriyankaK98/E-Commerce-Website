/***********************************************************************************************
ClassName: cartItems
Author : Priyanka
CreatedDate : 22-03-2021
Purpose: Handles cart Items page
***********************************************************************************************/
public with sharing class cartItems {
    /********************************************************************************************
    *MethodName:getAllCartItems
    *Parameters Accepted: None
    *Pupose: Handles cart details page
    ********************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Cart__c> getAllCartItems(){
        Id user = UserInfo.getUserId();
        List<Cart__c> cartList = [SELECT  CreatedById, Quantity__c, Amount__c,(select Product__r.Name,Product__r.Description, Product__r.Price__c From cart_Items__r) 
                                        FROM cart__c WHERE CreatedById = : user ];
        return cartList ;                               
    }
    /********************************************************************************************
    *MethodName:getCoupons
    *Parameters Accepted: None
    *Pupose: Fetches all the coupons available in the system 
    ********************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Coupon__c> getCoupons(){
        List<Coupon__c> coupons = [SELECT Name, Expired__c, Type__c FROM Coupon__c];
        return coupons;
    }
    
    /********************************************************************************************
    *MethodName:updateAmount
    *Parameters Accepted: None
    *Purpose: update the cart Item with given Quantity
    ********************************************************************************************/
    @AuraEnabled
    public static void updateAmount(Cart_Item__c item,Double amount){
        system.debug('item : '+item);
        item.Amount__c=amount;
        update item;
    }



    /********************************************************************************************
    *MethodName:updateCartItem
    *Parameters Accepted: None
    *Purpose: update the cart Item with given Quantity
    ********************************************************************************************/
    @AuraEnabled
    public static void updateCartItem(String id,Integer qty){
        system.debug(id + '  '+qty);
        Cart_Item__c ci=[SELECT Quantity__c,Product__r.RemainingQuantity__c FROM Cart_Item__c WHERE Id= : id];
        
        if(qty <= ci.Product__r.RemainingQuantity__c && qty > 0){
            ci.Quantity__c=qty;
            update ci;
        }
        else
            throw new CustomException('Product Out Of stocks');
    }
}