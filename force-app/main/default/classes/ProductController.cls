/***********************************************************************************************
 * Author Name : Abhisek Paliwal
 * Class Name : ProductController
 * Purpose : Controller Class for Product2 Object related actions 
 * *********************************************************************************************/
public class ProductController {
  /*  @AuraEnabled (cacheable=true)
    public static List<Product2> getAllProducts(){
            return [SELECT 	Name,ProductCode,Description,Family
                FROM Product2];
    }
*/
    /*********************************************************************************************
     * Method Name : getAllProducts
     * Author Name : Abhishek Paliwal, Sandesh Sawant
     * purpose : It Gives The All Product Details
     * *******************************************************************************************/
    @auraEnabled(cacheable = true)
    public static List<Product2> getAllProducts(Integer offset,Integer l){
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,
        (SELECT URL__c FROM ProductImages__r  WHERE HeroImage__c = true) 
         FROM Product2 LIMIT :l OFFSET : offset];
    }
    /*********************************************************************************************
     * Method Name : getProductByProductIds
     * Author Name : Abhishek Paliwal
     * purpose : It Gives The All Product Details By Ids
     * Parameters : 1. List Product Ids
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductByProductIds(List<String> ids){
        System.debug('ids : '+ids);
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,
                (SELECT URL__c FROM ProductImages__r  WHERE HeroImage__c = true) 
                FROM Product2 WHERE Id IN : ids];
    }
    
    
    /*********************************************************************************************
     * Method Name : getProductWithoutCategory
     * Author Name : Abhishek Paliwal
     * purpose : It Gives The All Product Details By single id
     * Parameters : 1. it accept one parameter which is id of the product
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductWithoutCategory(String id){
        System.debug(id);
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,
        (SELECT URL__c,Name FROM ProductImages__r WHERE HeroImage__c=true)
        FROM Product2 
        WHERE Id = : id ];
    }

	/*********************************************************************************************
     * Method Name : getProductWithoutCategory
     * Author Name : Abhishek Paliwal
     * purpose : It Gives The All Product Details By single id
     * Parameters : 1. it accept one parameter which is id of the product
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProduct(String id){
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,(SELECT URL__c,Name FROM ProductImages__r),
        (SELECT Category__c FROM ProductCategories__r)
        FROM Product2 
        WHERE Id = : id ];
    }
	/*********************************************************************************************
     * Method Name : getRelatedProduct
     * Author Name : Abhishek Paliwal
     * purpose : It Gives The All related Product Details By Category Id
     * Parameters : 1. it accept one parameter which is List Of Category Id
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product2> getRelatedProduct(List<String> categoryId){
        List<Category__c> catList= [SELECT id,(SELECT Product__c FROM  ProductCategories__r) FROM Category__c WHERE id IN : categoryId ];
        List<Id> plist=new List<Id>();
        for(Category__c cat : catList){
            for(Product_Category__c pc : cat.ProductCategories__r)
                plist.add(pc.Product__c);
        }
        return [SELECT Id, Name,RemainingQuantity__c,Description,Price__c,(SELECT URL__c,Name FROM ProductImages__r WHERE HeroImage__c=true)
                FROM Product2 
                WHERE Id IN :plist];
    }
    
    /*********************************************************************************************
     * Method Name : getSearchedProduct
     * Author Name : Abhishek Paliwal
     * purpose : It Gives The All Product Details By Search String
     * Parameters : 1. it accept one parameter which is String Product Name
     * *******************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Product2> getSearchedProduct(String searchProduct){
        List<Product2> prodList = [SELECT Id FROM Product2 
                                    WHERE Name LIKE : '%'+searchProduct+'%'];
        return prodList;
    }
}