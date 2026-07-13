# Research Questions

## 1. The N+1 Query Problem in Laravel

### What is the N+1 Query Problem?

The **N+1 Query Problem** occurs when Laravel executes one query to retrieve a collection of models, then executes one additional query for each model to retrieve its related data.

- 1 query → Get all users.
- N queries → Get posts for every user.

If there are 100 users, Laravel executes:

- 1 query for users
- 100 queries for posts

**Total** = 101 queries

This causes serious performance issues.

`ex`
```php
$users = User::all();

foreach ($users as $user) {
    echo $user->posts->count();
}
```
**Laravel executes :**
```php
SELECT * FROM users;
```
**Then for each user:**
```php
SELECT * FROM posts WHERE user_id = 1;

SELECT * FROM posts WHERE user_id = 2;

SELECT * FROM posts WHERE user_id = 3;

...
```
If there are 50 users: 1 + 50 = 51 queries

### Solution: Eager Loading
Use the `with()` method.

```php
$users = User::with('posts')->get();

foreach ($users as $user) {
    echo $user->posts->count();
}
```
Now Laravel performs only 2 queries:

```php
SELECT * FROM users;

SELECT * FROM posts
WHERE user_id IN (1,2,3,...);
```
---

## 2. Attaching, Syncing, and Detaching Related Records in Eloquent

These methods are used with Many-to-Many relationships.

`ex`
```php
Users
Roles

role_user (Pivot Table)

```
Relationship:
```php
class User extends Model
{
    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }
}

```

### attach()

Adds a relationship without removing existing ones.

```php
$user = User::find(1);

$user->roles()->attach(2);
```
Result :
User gets Role #2. If Role #3 already existed: Both remain.

### detach()

Removes relationship(s).

```php
$user->roles()->detach(2); // removes role 2
```
```php
$user->roles()->detach(); //removes all roles
```
### sync()

Makes database match exactly the provided IDs.

```php
$user->roles()->sync([1, 4]);
```
suppose user currently has `[1,2,3]` after sync roles 2 and 3 are removed

---

## 3. What is Livewire?

Livewire is a full-stack framework for Laravel that lets you build dynamic, interactive user interfaces using PHP, without writing much JavaScript.

It combines:

- Laravel
- Blade
- AJAX
- PHP

to create reactive web applications.

**Counter Component**
```php
class Counter extends Component
{
    public $count = 0;

    public function increment()
    {
        $this->count++;
    }

    public function render()
    {
        return view('livewire.counter');
    }
}
```
**Blade view**
```php
<div>
    <h1>{{ $count }}</h1>

    <button wire:click="increment">
        +
    </button>
</div>
```
When the button is clicked:

- No page refresh
- PHP method runs
- Count updates instantly

### Advantages

- Minimal JavaScript required.
- Easy integration with Laravel and Blade.
- Faster development for interactive interfaces.
- Built-in form handling and validation.
- Real-time UI updates without full page reloads.