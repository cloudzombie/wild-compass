# The Hydropothecary Corp.
## Inventory Control System - RESTful API Documentation

### Original authors and developers : 
* Maxime Gauthier — maxime.gauthier88@gmail.com
* Jérémie St-Pierre Robitaille — jeremiesrobitaille@gmail.com

### Getting Started
The following document gives information about processing orders and adding customers to THC Inventory Control System (abbreviated ICS or THC-ICS).
  
### Orders

#### The Order Model
Orders are associated to a customer. A given customer can have multiple orders.
An order is composed of many order lines. An order line describes a physical product that should be shipped in the order.

For example, a jar of 25g of type X and 3 jars of 75g of type Y constitutes a order for customer John Doe. This would be modelised with a single object Order and two OrderLine objects.

Order
id: integer
customer_id: integer
ordered_at: datetime
shipped_at: datetime

OrderLine
id: integer
order_id: integer
product_type: string
product_id: integer
quantity: integer

#### Creating new order
Creating new order through RESTful API requires using an HTTP POST request.

##### Parameters:
* customer_id : integer
* customer : string (if its a new customer and doesn’t have an id)
* ordered_at : datetime (optional, set automatically at time processed if unspecified)
* shipped_at : datetime (optional)

##### Examples:
POST http://ics.thc.vc/orders/create?customer_id=1
Creates a new order for registered customer with ID 1.

POST http://ics.thc.vc/orders/create?customer=”John Doe"
Creates a new order for unregistered customer with no ID yet.

#### Updating an order
Updating an order is done through the RESTful API and requires using the HTTP PUT or PATCH request.

##### Parameters:
* id : integer (this order’s ID)
* customer_id : integer (optional, input only if the customer changed)
* ordered_at : datetime (optional, input only if the date changed)
* shipped_at : datetime (optional, input only if the date changed)

##### Examples:
PUT http://ics.thc.vc/orders/1?customer_id=1&ordered_at=2015-01-02T18:12:0=4-05:00
This would update order ID 1, change it’s customer’s ID to 1 and update the ordered date.

PATCH http://ics.thc.vc/orders/42?customer_id=3
This would update order ID 42, and change it’s customer’s ID to 3.

#### Deleting an order
Deleting order through RESTful API requires using the DELETE request.

##### Example:
http://ics.thc.vc/orders/create?customer_id=1

### Order Lines
OrderLine has one jar
OrderLine belongs to order

#### Creating a new OrderLine
Creating new order through RESTful API requires using the POST request.

##### Parameters:
* order_id: integer
* brand_id: integer
* quantity: integer

##### Example:
http://ics.thc.vc/order_lines/create?order_id=1&brand_id=1&quantity=7.0

#### Updating OrderLine
Updating order through RESTful API requires using the GET request.

##### Parameters:
* order_id: integer
* brand_id: integer
* quantity: integer

##### Example:
http://ics.thc.vc/order_lines/update?order_id=2&brand_id=3&quantity=7.0

#### Destroying an OrderLine
Destroying order through RESTful API requires using the DELETE request.

##### Examples:
http://ics.thc.vc/order_lines/1?destroy

#### Customers
Customer has many orders

##### Create new customer
Creating new customer through RESTful API requires using the POST request.

##### Parameters:
* first_name : string
* last_name : string
* shipping_adress : string
* billing_adress : string
* phone : string
* email : string

##### Example:
http://ics.thc.vc/order_lines/create?first_name=john&last_name=doe

#### Updating a customer
Updating customer through RESTful API requires using the GET request.

##### Parameters:
first_name: string
last_name: string
shipping_adress: string
billing_adress: string
phone: string
email: string

##### Example:
http://ics.thc.vc/order_lines/create?order_id=1&brand_id=1&quantity=7.0