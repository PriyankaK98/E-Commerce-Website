/****************************************************************************************
* Author : Priyanka
* Class Name : OrderTriggerHandler
* Purpose : It Handles the event actions of OrderTrigger
* **************************************************************************************/

public with sharing class OrderTriggerHandler {
    
    /******************************************************************************************
	* Author : Priyanka
	* method Name : afterInsertHandler
	* Purpose : It Updates the Remaining Quantity Of the Product Once the Order is confirmed
	* ****************************************************************************************/
    public static void afterInsertHandler(List<Order_Line_Item__c> newList){
        
        Map<Id,Double> productMap=new Map<Id,Double>();
        
        for(Order_Line_Item__c oli : newList)
            productMap.put(oli.Product__c,oli.Quantity__c);               
        System.debug(productMap);
        System.debug(productMap.keySet());
        List<Product2> productList=[SELECT Id, RemainingQuantity__c FROM Product2 WHERE Id IN : productMap.keySet()];        
        system.debug(productList);
        for(Product2 product : productList){
            Double qty=0;
            if(product.RemainingQuantity__c != null){             
                qty=product.RemainingQuantity__c - productMap.get(product.Id);
            	product.RemainingQuantity__c = qty;
            }
        }//for
         system.debug(productList);       
        try{
            update productList;
        } catch(Exception e){
            system.debug(e.getMessage());
        }
    }//afterInsertHandler
   
    /******************************************************************************************
	* Author : Priyanka
	* method Name : afterDeleteHandler
	* Purpose : It Updates the Remaining Quantity Of the Product on order cancellation
	* ****************************************************************************************/
    public static void afterDeleteHandler(List<Order__c> oldList){
       List<Order_Line_Item__c> itemList=[SELECT Product__c, Quantity__c, order__c FROM Order_Line_Item__c
                                         WHERE order__c IN : oldList];
        Map<Id,Double> productMap=new Map<Id,Double>();
        
        for(Order_Line_Item__c oli : itemList)
            productMap.put(oli.Product__c,oli.Quantity__c);
        System.debug(productMap);
        List<Product2> productList=[SELECT RemainingQuantity__c FROM Product2 WHERE Id IN : productMap.keySet()];
        system.debug(productList);
        for(Product2 product : productList){
            Double qty=0;
            if(product.RemainingQuantity__c != null){    
                system.debug(product.RemainingQuantity__c);
                qty=product.RemainingQuantity__c + productMap.get(product.Id);
                system.debug(productMap.get(product.Id));
                system.debug(qty);
            	product.RemainingQuantity__c = qty;
            }//if
        }//for
         system.debug(productList);       
        try{
            update productList;
        } catch(Exception e){
            system.debug(e.getMessage());
        }
    }//afterDeleteHandler
}