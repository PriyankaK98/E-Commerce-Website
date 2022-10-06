/***********************************************************************************************
 * Author Name : Abhishek Paliwal
 * Class Name : CartController
 * Purpose : Controller Class for Cart__c  Object related actions 
 * *********************************************************************************************/
public with sharing class CartController {
    
    /*********************************************************************************************
     * Method Name : addItemToCart
     * Author Name : Abhishek Paliwal
     * purpose : Responsible Adding Item to the cart 
     * parameter : 1. String prodId Id Of the Product to add
     * 			   2. Quantity Of the product
     * *******************************************************************************************/
    @AuraEnabled
    public static Boolean addItemToCart(String prodId,Integer quantity){
        Product2 prod=[SELECT Id, Name, TotalQuantity__c, RemainingQuantity__c, Discount__c, Price__c FROM Product2 WHERE id=:prodId ];
            String userId =UserInfo.getUserId();
            List<Contact> cust=[SELECT id FROM Contact WHERE OwnerId= : userId LIMIT 1];
            List<Cart__c> cartlist=[SELECT Name,Quantity__c,Amount__c 
                            FROM Cart__c 
                            WHERE Status__c='Open' AND
                            Customer__c IN : cust
                            LIMIT 1];
            if(cartlist.size()>0){
                String cartId =cartlist[0].id;
                double amount=prod.Price__c;
                Integer qty=quantity;
                Cart_Item__c item=new Cart_Item__c(Cart__c=cartId,Amount__c=amount,Quantity__c=qty,Product__c=prod.Id);
                try {
                    insert item;
                } catch (Exception e) {
                    system.System.debug(e.getMessage());
                }
            }else{
                Cart__c cart=new Cart__c(Status__c='Open',Customer__c= cust[0].id);
                try{
                    insert cart;
                }catch(Exception e){
                    system.debug(e.getMessage());
                }
                String cartId =cart.Id;
                double amount=prod.Price__c;
                Integer qty=quantity;
                Cart_Item__c item=new Cart_Item__c(Cart__c=cartId,Amount__c=amount,Quantity__c=qty,Product__c=prod.Id);
                    try {
                    insert item;
                } catch (Exception e) {
                    system.System.debug(e.getMessage());
                }
            }
            return true;
    }
	
    /*********************************************************************************************
     * Method Name : getOpenCart
     * Author Name : Abhishek Paliwal
     * purpose : It Fetches The Open cart Information with Cart Item
     * parameter : noparameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Cart__c> getOpenCart(){
        String userId= UserInfo.getUserId();
        return [SELECT  CreatedById, Quantity__c, Amount__c,(select Product__r.Name,Product__r.Description, Product__r.Price__c,Amount__c,Product__r.Id,Quantity__c,TotalAmount__c  From cart_Items__r) 
        FROM cart__c WHERE Status__c='Open' AND Customer__c IN (SELECT id FROM Contact WHERE OwnerId =: userId) LIMIT 1];
    }

 /*   @AuraEnabled
    public static void closeTheCart(){
        String uid =UserInfo.getUserId();
        Cart__c cart=[SELECT Status__c FROM Cart__c WHERE Status__c='Open' AND Customer__c IN (SELECT Id FROM Contact WHERE OwnerId= : uid  ) LIMIT 1];
        cart.Status__c='Closed';
        update cart;
    }
   */ 

}