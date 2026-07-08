# Research Questions

## 1. Laravel Gates

###  What are Gates?

Laravel Gates are a simple authorization system used to determine whether a user can perform a specific action.

Think of a Gate as:

> “Can this user do this action?”

`ex`

Suppose only admins can delete posts.

In `AppServiceProvider`:

```php
use Illuminate\Support\Facades\Gate;

Gate::define('delete-post', function ($user) {
    return $user->role === 'admin';
});
```

Checking the Gate:

```php
if (Gate::allows('delete-post')) {
    // Delete the post
}
```
in a controller :

```php
$this->authorize('delete-post');
```
### How Gates work internally

1. You define a Gate.

```php
Gate::define(...)
```
2. Laravel stores it.
3. When you call

```php
Gate::allows(...)
```
**Laravel:**
- gets the authenticated user
- executes the Gate callback
- returns `true` or `false`

---

## 2. Sanctum vs Passport

|Sanctum|Passport|
|:---|:---|
|Lightweight authentication|Full OAuth2 authentication|
|Best for SPAs and mobile apps|Best for third-party applications|
|Uses API Tokens|Uses OAuth2 Access Tokens|
|Easy to set up|More complex|
|Doesn't require OAuth flow|Supports OAuth2 flows|
|Faster and simpler|More features|

### Use Sanctum when:
 - SPA
 - Mobile app
 - Your own frontend and backend

### Use Passport when:
 - Third-party developers access your API
 - OAuth2 is required
 - Applications like Google Login or GitHub Login

---

## 3. CSRF vs XSRF

actually **CSRF** and **XSRF** are the same attack

- **CSRF** = Cross-Site Request Forgery
- **XSRF** = Cross-Site Request Forgery ("X" avoids confusion with CSS)

### What is CSRF?

Suppose you're logged into your bank.

Another malicious website secretly submits:

` POST /transfer-money`

Because your browser automatically sends your cookies, the bank thinks you made the request.

#### Protection in Laravel

**Laravel** generates a **CSRF** token.

Forms include: `@csrf`

which generates

```php
<input type="hidden" name="_token" ...>
```

Laravel checks the token before accepting the request.

If **invalid**: `419 Page Expired`

### XSRF Token

When using AJAX (Axios, Vue, React), Laravel sends an `XSRF-TOKEN` cookie. <br>
JavaScript sends it back as `X-XSRF-TOKEN` header.

Laravel verifies it automatically.

---

## 4. Defining Relationships in Eloquent Models

Eloquent relationships define how database tables are connected.

### One To One 

One user has one profile.

```php
class User extends Model
{
    public function profile()
    {
        return $this->hasOne(Profile::class);
    }
}
```
```php
$user->profile;
```
### One To Many

One user has many posts.

```php
class User extends Model
{
    public function posts()
    {
        return $this->hasMany(Post::class);
    }
}
```
```php
$user->posts;
```
### Belongs To

Each post belongs to one user.

```php
class Post extends Model
{
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
```
```php
$post->user;
```

### Many To Many

Students enroll in many courses.

Courses contain many students.

```php
class Student extends Model
{
    public function courses()
    {
        return $this->belongsToMany(Course::class);
    }
}
```
```php
$student->courses;
```
Requires a pivot table: `course_student`

### Has One Through

Access a related model through an intermediate model.

`ex`
```
Country
    ↓
User
    ↓
Post

```
Country gets all posts through its users.

