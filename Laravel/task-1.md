# Research  Questions

## 1.Blade Templates and How They Work

**Blade** is Laravel's templating engine. It allows you to write dynamic HTML using simple syntax.

**ex** :

``` php
<!-- resources/views/welcome.blade.php -->

<h1>Hello, {{ $name }}</h1>

@if($age >= 18)
    <p>Adult</p>
@else
    <p>Minor</p>
@endif

```
**Controller :**

```php
public function index()
{
    return view('welcome', [
        'name' => 'Shams',
        'age' => 19
    ]);
}
```
Output:
```html
<h1>Hello, Shams</h1>
<p>Adult</p>
```
---
## What is ORM and Why is it Useful ?

**ORM**(*Object Relational Mapping*) is a technique that allows you to interact with database tables using objects instead of writing raw SQL.

Laravel uses **Eloquent ORM**.

**Without ORM** 
```php
select * from users where is = 1 ;
```
**With Eloquent**
```
$user = User::find(1);
``` 
### Why is it useful ?

- Less SQL code.
- Easier relationships.
- More readable and maintainable.
- Database-independent.

---
## 3.Facade Design Pattern and How Laravel Uses It .

A **Facade** provides a simple interface to complex subsystem.

Laravel Facades are static-looking classes that access services from the Service Container.

**ex :**

```php
use Illuminate\Support\Facades\Cache;

Cache::put('name','Shams',60) 

```
Looks like a static method call, but internally Laravel resolves the Cache service from the container.

**Behind the Scenes**

```php

app('cache')->put('name', 'Shams', 60); 

```
**Common Facades :**

- Cache
- DB
- Auth
- Route
- Log


## 4.Factory Design Pattern

The **Factory Pattern** creates objects without exposing the creation logic to the client.

**instead of**

```php
$user = new User();
```
**we use a factory :**

```php
$user = UserFactory::create()
```

---

## 5. SOLID Principles 

**SOLID** is a set of five object-oriented design principles.

[jump to summary](#summary-)

### S --> Single Responsibility Principle (SRP)

A class should have only one reason to change.

```php
class User
{
    public function saveToDatabase() {}
    public function sendEmail() {}
}
```
The class handles both database and email responsibilties... this isn't cool :)

```php
class User
{
    public function save() {}
}

class EmailService
{
    public function send() {}
}

```
sounds cool to me .

### O --> Open/Closed Princeple(OCP)

Software entities should be Open for extension, closed for modification.

```php
class Payment
{
    public function pay($type)
    {
        if ($type == 'paypal') {}
        elseif ($type == 'visa') {}
    }
}
```
Every new payment method requires modifying the class.

```php
interface PaymentMethod
{
    public function pay();
}

```
```php
class PaypalPayment implements PaymentMethod
{
    public function pay()
    {
        echo "PayPal";
    }
}
```
```php
class VisaPayment implements PaymentMethod
{
    public function pay()
    {
        echo "Visa";
    }
}

```
now that's better

### L --> Liskov Substitution Principle (LSP)

A child class should be able to replace its parent without breaking the program.

```php
class Bird
{
    public function fly() {}
}

class Penguin extends Bird
{
    public function fly()
    {
        throw new Exception();
    }
}

```
Penguins cannot fly :) .

```php
class Bird {}
```

```php
interface Flyable
{
    public function fly();
}
```

```php
class Eagle extends Bird implements Flyable
{
    public function fly() {}
}
```
make sense right ?
### I --> Interface Segregation Principle (ISP)

Clients should not depend on methods they do not use.

```php
interface Worker
{
    public function work();
    public function eat();
}
```
```php
class Robot implements Worker
{
    public function work() {}
    public function eat() {}
}

```
A robot does not eat :)

```php
interface Workable
{
    public function work();
}
```

```php
interface Eatable
{
    public function eat();
}
```

```php
class Robot implements Workable
{
    public function work() {}
}

```
that's better .

### D --> Dependency Inversion Principle (DIP)

Depend on abstractions, not concrete classes.

```php
class MySQLDatabase
{
    public function connect() {}
}

class UserService
{
    private $db;

    public function __construct()
    {
        $this->db = new MySQLDatabase();
    }
}
```
`UserService` is tightly coupled to MySQL.

```php
interface Database
{
    public function connect();
}

```

```php
class MySQLDatabase implements Database
{
    public function connect() {}
}
```

```php
class UserService
{
    private Database $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }
}
```
**Usage:**

```php
$userService = new UserService(new MySQLDatabase());
```
Benefit

You can switch to another database without changing `UserService`.

### Summary :

|Principle|Meaning|
|:----|:----|
|SRP|One class -> one responsibility|
|OCP|Extend behavior without modifying existing code|
|LSP|Child classes should safely replace parents|
|ISP|Create small, focused interfaces|
|DIP|Depend on abstractions, not implementations|

AAAAAAnd ,that's it :D