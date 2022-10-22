# E-Commerce-Website
Online shopping website built on salesforce CRM with digitalized experience of community cloud where user can buy products based on categories, add the products to cart and place an order with cash on delivery option.

Data Model
1.	Account - Standard Salesforce Component which will be used as the Parent of End Customer ( Community User )
2.	Contact - Standard Salesforce Component which will be used to create the Community User in Salesforce.
3.	Order - Custom Salesforce Object to be used to store the order information. We can not use Standard Order Object as it requires to have the contract in order to create an Order record.
4.	Order Line Item - Custom Object which is a child of Order Object and will store the information about the Items to be included in order.
5.	Product - Standard Salesforce Object
6.	Account Request - Custom Salesforce Object which will be used to request a new account for the community.
7.	Address Book - Custom Salesforce Object to store the address information
8.	Payments - Custom Salesforce Object to store the information about the payment of order records.
9.	Coupons - Custom Objects to store the coupon and 
10.	Product Offers - Junction object between product and Coupons to indicate which product is eligible for the offer
11.	Product Images - A Child object to Product which will store the Images related to the Product.
12.	Cart - The custom object which will store the information about the current cart of the user
13.	Cart Items - The child of cart object associated with Master-Detail relationship and will contain all the information about the items which user has added into the cart.
14.	Categories - Custom objects hold the name of the category to which the product will be associated.
15.	Product Categories - Custom salesforce object which will be the child of category and product to link product and category.

OWD Settings for objects

Account - Private, Contact - Controlled By Parent	
Order - Private	
Order line - Controlled By Parent	
Product - Public Read Only	
Account Request - Public Read Only	
Address Book - Private	
Payment - Private	
Coupons - Public Read Only	
Product Offers - Controlled By Parent	
Product Images - Controlled By Parent	
Categories - Public Read Only	
Product Categories - Controlled By Parent	
