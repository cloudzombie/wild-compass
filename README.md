# The Hydropothecary Corp.
## Inventory Control System - RESTful API Documentation

### Original authors and developers : 
* Maxime Gauthier (maxime.gauthier88@gmail.com)
* Jérémie St-Pierre Robitaille (jeremiesrobitaille@gmail.com)

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

#### Creating A New Order
Creating new order through RESTful API requires using an HTTP **POST** method.

##### Parameters:
* customer_id : integer
* ordered_at : datetime (optional, set automatically at time processed if unspecified)
* shipped_at : datetime (optional)

##### Examples:
**POST** http://ics.thc.vc/orders?customer_id=1
Creates a new order for registered customer with ID = 1.

**POST** http://ics.thc.vc/orders?customer_id=42
Creates a new order for registered customer with ID = 42.

#### Updating An Order
Updating an order is done through the RESTful API and requires using the HTTP **PUT** or **PATCH** method.

##### Parameters:
* id : integer (this order’s ID)
* customer_id : integer (optional, input only if the customer changed)
* ordered_at : datetime (optional, input only if the date changed)
* shipped_at : datetime (optional, input only if the date changed)

##### Examples:
**PUT** http://ics.thc.vc/orders/1?customer_id=1&ordered_at=2015-01-02T18:12:0=4-05:00
This would update order ID 1, change it’s customer’s ID to 1 and update the ordered date.

**PATCH** http://ics.thc.vc/orders/42?customer_id=3
This would update order ID 42, and change it’s customer’s ID to 3.

#### Deleting An Order
Deleting orders is done through the RESTful API requires using the **DELETE** HTTP method.

It is unnecessary to then delete all the order lines, because they will be automatically deleted by the dependence relationship between orders and their many order lines.

##### Examples:
**DELETE** http://ics.thc.vc/orders/1
This would delete order with ID = 1

**DELETE** http://ics.thc.vc/orders/42
This would delete order with ID = 42

### Order Lines
An order line represent a physical product. It is associated with a product type and ID, and a quantity.

#### Creating A New Order Line
Creating an order line is done through the RESTful API and requires using the **POST** method.

##### Parameters :
* order_id: integer
* product_id: integer
* product_type: integer
* quantity: integer (optional, assumed quantity is 1 if left empty)

##### Examples :
**POST** http://ics.thc.vc/order_lines?order_id=1&product_id=42&product_type=Jar&quantity=2
This method would create an OrderLine for Order with ID = 1, and place twice product type Jar with ID = 42 in said order.

**POST** http://ics.thc.vc/order_lines?order_id=42&product_id=1337&product_type=Foo
This method would create an OrderLine for Order with ID = 42, and place product type Foo with ID = 1337 in said order.

#### Updating An Order Line
Updating an order line is done through the RESTful API and requires using the **PUT** or **PATCH** HTTP method.

##### Parameters :
* id: integer (this order line’s ID)
* order_id: integer (optional, change only if modified)
* product_id: integer (optional, change only if modified)
* product_type: integer (optional, change only if modified)
* quantity: integer (optional, change only if modified)

##### Examples :
**PUT** http://ics.thc.vc/order_lines/1?order_id=42&product_id=3&quantity=3
This would change OrderLine with ID = 1, set order ownership to order with ID = 42, change the product and the quantity.

**PATCH** http://ics.thc.vc/order_lines/5?product_id=4
This would query for OrderLine with ID = 5 and change the product only.

#### Destroying An Order Line
Destroying an order line is done through the RESTful API and requires using the **DELETE** HTTP method.

Examples :
**DELETE** http://ics.thc.vc/order_lines/1
This would destroy order line with ID = 1

**DELETE** http://ics.thc.vc/order_lines/42
This would destroy order line with ID = 42

### Customers
A customer can have multiple orders.

#### Creating A New Customer
Creating new customer through the RESTful API requires using the **POST** method.

##### Parameters :
* first_name : string
* last_name : string
* shipping_adress : text
* billing_adress : text
* phone : string
* email : string

##### Examples :
**POST** http://ics.thc.vc/customers?first_name=john&last_name=doe
This would create a user with first name “John” and last name “Doe”. All fields are necessary this is just an example.

#### Updating A Customer
Updating customer through RESTful API requires using the **PUT** or **PATCH** HTTP method.

##### Parameters :
* id : integer
* first_name : string
* last_name : string
* shipping_address : text
* billing_address : text
* phone : string
* email : string

##### Examples :
**PUT** http://ics.thc.vc/customers/1?phone=18885555555
This would change customer with ID = 1 phone number to 1-888-555-5555

**PATCH** http://ics.thc.vc/customers/42?email=john.doe@example.com
This would update’s customer with ID = 42 email address to john.doe@example.com

#### Deleting A Customer
Deleting a customer is done through the RESTful API and requires using the **DELETE** HTTP method.

##### Parameters :
* id : integer (this customer’s ID)

##### Examples :
**DELETE** http://ics.thc.vc/customers/1
This would delete customer with ID = 1.

**DELETE** http://ics.thc.vc/customers/42
This would delete customer with ID = 42.

### Data Matrixes
In the scope of our application, a data matrix is a PNG image file encoding an encrypted identifier.

#### Querying A Jar’s Data Matrix
Querying a jar’s data matrix is done through the RESTful API and requires using the HTTP **GET** method.

##### Parameters :
* id : integer (the jar’s id)

##### Examples :
**GET** http://ics.thc.vc/jars/1/datamatrix
This would send the datamatrix PNG file for jar with ID = 1

**GET** http://ics.thc.vc/jars/42/datamatrix
This would send the datamatrix PNG file for jar with ID = 42