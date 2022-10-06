/***********************************************************************************************
ClassName: AddToCartController
Author : Priyanka
CreatedDate : 24-03-2021
Purpose: Handles Add to cart functionality of product detail page
***********************************************************************************************/
public with sharing class AddToCartController {
    /********************************************************************************************
    *MethodName:addProductToCart
    *Parameters Accepted: (ProductId which is to be added to cart, Quantity of product)
    *Pupose: Add to product to cart and if product already exists in the cart increase the 
             quantity in the cart
    ********************************************************************************************/
    @AuraEnabled
    public static void addProductToCart(String Id,Double qty){
        
        cart_Item__c items;
        Id user = UserInfo.getUserId();
        cart__c cart = [SELECT CreatedById FROM cart__c WHERE CreatedById= :user];
        List<cart_Item__c> itemList = [SELECT Product__c,Quantity__c FROM cart_Item__c WHERE cart__c= :cart.Id];
        List<Id> idList = new List<ID>();
        for(cart_Item__c i: itemList){
            idList.add(i.product__c);
        }   
        try {
            if(cart.CreatedById==user){
                if(idList.contains(Id)){
                    
                    items=new cart_Item__c(cart__c=cart.Id,Product__c=Id,Quantity__c=qty);
                }else{
                 items=new cart_Item__c(cart__c=cart.Id,Product__c=Id,Quantity__c=qty);
                }
            }   
                upsert items;            
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}