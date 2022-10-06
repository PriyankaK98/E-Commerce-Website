/***********************************************************************************************
 * Author Name : Abhisek Paliwal, Sandesh Sawant
 * Class Name : OrderController
 * Purpose : Controller Class for Order__c Object related actions 
 * *********************************************************************************************/
public with sharing class OrderController {
    /*********************************************************************************************
     * Method Name : createOrder
     * Author Name : Abhishek Paliwal
     * purpose : Creates Order  And OrderLine items related to cart 
     * parameter : String addr Shipping Address
     * *******************************************************************************************/
    @AuraEnabled
    public static Id createOrder(Id cartId){
        System.debug('cartId : '+cartId);
        Order__c order;
        String userId=UserInfo.getUserId();
        Cart__c cart=[ SELECT  CreatedById, Quantity__c, Amount__c,
                (select Product__r.Name,Product__r.Description, Product__r.Price__c,Product__r.Id,Quantity__c,TotalAmount__c  
                From cart_Items__r) 
                FROM cart__c 
                WHERE Id = : cartId];
        Contact cust=[SELECT  Account.Id,Id FROM Contact WHERE OwnerId =: userId LIMIT 1];
        List<Order__c> orderList=[SELECT Id, Name, Customer__c,
                            Status__c, BillingAddress__c,
                          PaymentStatus__c, DeliveredDate__c,
                          ExpectedDate__c, PaymentMethod__c,
                          AccountName__c, Totalitems__c, Total__c,
                          AmountPaid__c, Shipping_Address__c 
                          FROM Order__c WHERE Status__c='Open,' AND
                         Customer__c = : cust.Id] ;
        List<Order_Line_Item__c> oliList=new List<Order_Line_Item__c>();
        if(orderList.size() > 0){
            order=orderList[0];
        }
        else {
            order=new Order__c(Customer__c=cust.Id,
                                Status__c='Open,',
                                //PaymentStatus__c= pymtMode,
    							//ExpectedDate__c=system.today().addDays(3),
                                //PaymentMethod__c= pymtMode,
                                AccountName__c=cust.Account.Id
                                //,Shipping_Address__c= addr
    							);
            insert order;
        }
            for(Cart_Item__c ci : cart.cart_Items__r){
                Order_Line_Item__c oli=new Order_Line_Item__c(
                Name=ci.Product__r.Name,
                Product__c=ci.Product__r.Id,
                Quantity__c=ci.Quantity__c,
                Total__c=ci.TotalAmount__c,
                UnitPrice__c=ci.Product__r.Price__c,
                Order__c =order.Id
                );
                oliList.add(oli);
            }
            insert oliList;
            cart.Status__c='Closed';
            update cart;
            return order.Id;
    }
    /*********************************************************************************************
     * Method Name : getOpenOrder
     * Author Name : Abhishek Paliwal
     * purpose : fetches Open Order Record Related to current user
     * parameter : no parameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOpenOrder(){
        Id uid=UserInfo.getUserId();
        List<Order__c> orderList=[SELECT Id,PaymentStatus__c, DeliveredDate__c, ExpectedDate__c, PaymentMethod__c, Totalitems__c, Total__c, AmountPaid__c, Shipping_Address__c 
                       ,(SELECT Id, Name, Product__c, Quantity__c, Total__c, ListPrice__c, UnitPrice__c, Order__c FROM Order_Line_Items__r)
                       FROM Order__c
                       WHERE Status__c='Open,' AND Customer__c IN (SELECT Id FROM Contact WHERE OwnerId= : uid)];
        return orderList;
        
    }

    /*********************************************************************************************
     * Method Name : updateOrderStatus
     * Author Name : Abhishek Paliwal
     * purpose : Updates The order Status 
     * parameter : 1. Id Of the Order, 2. Status Of the order
     * *******************************************************************************************/
    @AuraEnabled
    public static void updateOrderStatus(String id,String status){
        Order__c order=[SELECT Status__c FROM Order__c WHERE Id= :id];
        if(order.Status__c == 'Open,'){
            throw new CustomException('Order Not Placed Yet');
        }
        order.Status__c=status;
        update order;
    }
    /*********************************************************************************************
     * Method Name : getOrderDetail
     * Author Name : Sandesh Sawant
     * purpose : fetches Order Details, pagination  and also searching was done
     * parameter : 1. offset 2. Limit 3.SerachKey
     * *******************************************************************************************/
    @AuraEnabled(cacheable=True)
    public static List<Order__c> getOrderDetail(Integer offset, Integer l,String searchKey){
        Id uid=UserInfo.getUserId();
        String searchKeyword = '%' + searchKey + '%';
        

        List<Order__c> orderListRecord = new List<Order__c>();
        
        for(Order__c ordObj : [SELECT Name,ExpectedDate__c,Total__c,BillingAddress__c,Shipping_Address__c,Status__c
        FROM Order__c WHERE Name Like :searchKeyword AND  Customer__c IN (SELECT Id FROM Contact WHERE OwnerId= : uid )limit :l  offset :offset]){
            orderListRecord.add(ordObj);
        }
        return orderListRecord;
    }
    /************************************************************************************
     *  Method Name : getOrderByDate
     * Author Name : Sandesh Sawant
     * purpose : it fetches the data between two dates
     * parameter : 1.FirstDate  2. LastDate 
     
     *****************************************************************************************/
    @AuraEnabled(cacheable = true)
    public static List<Order__c> getOrderByDate(date FirstDate,date LastDate){
        return[SELECT Name,ExpectedDate__c,Total__c,BillingAddress__c,Shipping_Address__c,Status__c
        FROM Order__c WHERE (ExpectedDate__c >= :FirstDate AND ExpectedDate__c <= :LastDate)];
        
    }
    
    
    /*********************************************************************************************
     * Method Name : getOrderById
     * Author Name : Sandesh Sawant
     * purpose : fetches Order Details by id
     * parameter : 1. Takes OrderId as a parameter
     * *******************************************************************************************/
    @AuraEnabled(cacheable=True)
    public static List<Order__c> getOrderById(id orderID){
        return [SELECT Id,PaymentStatus__c, DeliveredDate__c, ExpectedDate__c, PaymentMethod__c, Totalitems__c, Total__c, AmountPaid__c, Shipping_Address__c 
        ,(SELECT Id, Name, Product__c, Quantity__c, Total__c FROM Order_Line_Items__r)
        FROM Order__c
        WHERE Id = :orderID];
        
    }

     /*********************************************************************************************
     * Method Name : getPaymentMethods
     * Author Name : Abhishek Paliwal
     * purpose : fetches All Payment Methods Of  Order Object
     * parameter : No
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<string> getPaymentMethods(){
        List<String> methods= new List<String>();
        schema.DescribeFieldResult fd = Order__c.PaymentMethod__c.getdescribe();
        list<schema.picklistentry> pc = fd.getpicklistvalues();
        
        for(schema.picklistentry f: pc){
        	system.debug('label  : '+ f.getlabel()+' Value : '+f.getvalue());
            methods.add(f.getvalue());
        }
        return methods;
    }
    
     /*********************************************************************************************
     * Method Name : updateAddr
     * Author Name : Abhishek Paliwal
     * purpose : Updates the addressh of the order
     * parameter : two parameters 1 Order Id 2. Address
     * *******************************************************************************************/
    @AuraEnabled
    public static void updateAddr(Id orderId, String addr){
       Order__c ord=[SELECT Shipping_Address__c FROM Order__c WHERE Id= :orderId];
       ord.Shipping_Address__c=addr;
       try {
           update ord;
       } catch (Exception e) {
           throw new CustomException('Cannot Deliver To this address');
       }
    }

     /*********************************************************************************************
     * Method Name : updatePaymentMethod
     * Author Name : Abhishek Paliwal
     * purpose : Updates the PaymentMethod ,status, delivery date,
     * parameter : two parameters 1 Order Id 2. Payment Method
     * *******************************************************************************************/
    @AuraEnabled
    public static void updatePaymentMethod(Id orderId,String method){
        Order__c ord=[SELECT PaymentStatus__c,Status__c,ExpectedDate__c, PaymentMethod__c FROM Order__c WHERE Id= : orderId];
        ord.PaymentStatus__c=method;
        ord.ExpectedDate__c=system.today().addDays(3);
        ord.PaymentMethod__c= method;
        ord.Status__c='In Process,';
        try {
            update ord;
        } catch (Exception e) {
            throw new CustomException('Cannot place order');
        }
    }
}