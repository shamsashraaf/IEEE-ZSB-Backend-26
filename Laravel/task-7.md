## 1. Design Patterns

### 1. Strategy Pattern
- **Classification:** Behavioral Design Pattern.
- **Mechanism:** Encapsulates interchangeable algorithms inside separate classes that implement a shared interface.
- **Trigger Condition:** When a class contains massive `if/else` or `switch` statements solely to select different variations of the same fundamental behavior.

**Component Roles:**
| Component | Structural Role | Example |
|---|---|---|
| **Context** | Maintains a reference to the Strategy interface and delegates execution. | `OrderService` |
| **Interface** | Declares the strict method signature all strategies must implement. | `IOrderNotifier` |
| **Strategy** | Contains the isolated implementation of one algorithm/behavior. | `EmailNotifier` |

**System Impact:** 
Achieves the Open/Closed Principle by allowing infinite new variations (like adding a `PushNotifier`) without modifying the tested Context class. 

### 2. Factory Method Pattern
- **Classification:** Creational Design Pattern.
- **Mechanism:** Provides an interface for creating instances of a class, but delegates the actual instantiation logic to its subclasses.
- **Trigger Condition:** When your codebase is tightly coupled to concrete classes (e.g., hardcoding `TextDocument`), and adding a new type (e.g., `PDFDocument`) requires injecting conditions throughout the entire application.

**Component Roles:**
| Component | Structural Role | Example |
|---|---|---|
| **Product Interface** | Defines the generic methods the created objects will share. | `IDocument` |
| **Factory Interface** | Declares the `create()` method returning the Product interface. | `IDocumentFactory` |
| **Concrete Product** | A specific implementation of the Product interface. | `PDFDocument` |
| **Concrete Factory** | Overrides the `create()` method to instantiate a specific product. | `PDFFactory` |

**System Impact:**
Separates object creation from business logic. Clients depend strictly on the Factory interface, providing loose coupling. A primary disadvantage is "class explosion," as every new product requires its own dedicated factory class.

---

## 2. Concurrency & Multi-threading 

### 1. Architecture Overview
- **Processes vs. Threads:** A process operates in an isolated virtual address space. Threads run within a single process and share the same memory space (heap/data). 
- **The Multi-Core Advantage:** Modern CPUs execute multiple threads simultaneously across different physical cores. This drastically reduces computation time for heavy workloads by splitting datasets across parallel threads.
- **The Danger:** Because threads share the same memory, concurrent access to the same memory addresses introduces severe runtime instability.

### 2. Race Conditions
- **Definition:** A critical flaw that occurs when multiple threads attempt to access and modify the exact same shared resource (memory address) simultaneously.
- **Mechanism of Failure:** Modifying a variable (e.g., `sum += 1`) is not atomic; it requires reading the value, modifying it, and writing it back. If Thread A and Thread B read the value simultaneously, one thread's modification will silently overwrite the other's, resulting in lost data and unpredictable output.

**Resolution Strategy (Mutual Exclusion):**
1. **Mutex (`std::mutex`):** Implement a lock around the critical section (the shared resource). Only one thread can hold the mutex at a time; others must wait until it is released.
2. **RAII Locks (`std::lock_guard`):** Never lock and unlock a mutex manually. Wrap the mutex in a scoped lock guard to guarantee the lock is automatically released when the function exits or throws an exception.

### 3. Deadlocks
- **Definition:** A catastrophic state where two or more threads are permanently blocked, each waiting for the other to release a lock.
- **Mechanism of Failure:** Thread A locks Mutex 1 and needs Mutex 2 to proceed. Thread B locks Mutex 2 and needs Mutex 1 to proceed. Both threads freeze indefinitely.

**Resolution Strategies:**
1. **Consistent Lock Ordering:** Establish a strict, universal hierarchy for acquiring locks across the entire codebase. If every thread always requests Mutex 1 *before* Mutex 2, the circular dependency is broken.
2. **Try-Lock with Backoff:** Instead of waiting infinitely, a thread uses a non-blocking `try_lock()`. If the thread fails to acquire the second lock, it immediately unlocks its first lock, yields execution, and restarts the attempt from the beginning. 

---

## 3. RESTful API Architecture

### 1. Core Architectural Principles
- **Classification:** Architectural style for networked applications.
- **Statelessness:** The server strictly stores no session state about the client session. Every request is completely independent and must contain all necessary information (e.g., authentication tokens) to be processed.
- **Resource-Based Routing:** URLs must represent resources (nouns), not actions (verbs). They should consistently use plural naming conventions (e.g., `api/users`, not `api/get-users`).

### 2. HTTP Protocol Standards

**Method Matrix:**
| Method | Operational Role | Typical Status Code |
|---|---|---|
| **GET** | Read/retrieve a resource or list of resources. | `200 OK` |
| **POST** | Create a new resource. | `201 Created` |
| **PUT** | Completely replace an existing resource. | `200 OK` |
| **PATCH** | Partially update an existing resource. | `200 OK` |
| **DELETE** | Remove a resource. | `204 No Content` |

**Critical Status Codes:**
- **2xx (Success):** `200` (OK), `201` (Created), `204` (No Content - typically used after successful DELETE).
- **4xx (Client Error):** `400` (Bad Request), `401` (Unauthorized - missing/invalid token), `403` (Forbidden - lacks permissions), `404` (Not Found), `422` (Unprocessable Content - validation failed).
- **5xx (Server Error):** `500` (Internal Server Error).

### 3. Application Component Roles (API Scope)

| Component | Structural Role | Concept Example |
|---|---|---|
| **Resource Controller** | Receives the HTTP request, delegates validation, interacts with the model, and returns the response. | `PostController` |
| **Form Request Class** | Encapsulates and isolates all incoming data validation rules and authorization logic away from the controller. | `StorePostRequest` |
| **Model** | Represents the database table and manages relationships. Defines mass-assignment protections. | `Post` |
| **API Resource** | A transformation layer that dictates exactly how a Model is serialized into a JSON response. | `PostResource` |

### 4. Implementation Protocol & Best Practices

1. **Explicit API Versioning:** 
   Always prefix routes and namespace controllers with versions (`api/v1/posts`) to satisfy the Open/Closed Principle at an architectural level. This prevents breaking existing mobile or third-party clients when core data structures change in the future.
2. **Strict Request/Response Headers:**
   - **Request:** Clients must send `Content-Type: application/json` (identifying payload format) and `Accept: application/json` (forcing the framework to return JSON errors instead of HTML pages).
3. **Isolate Validation (Form Requests):** 
   Never write validation logic inside the controller. Generate dedicated Request classes that automatically intercept the incoming payload, apply structural rules, and throw a `422` error before the controller is executed.
4. **Mass Assignment Protection:**
   Inside the database Model, strictly define fillable arrays. This whitelists exactly which database columns can be populated from an incoming request array, preventing malicious payload injection.
5. **Data Transformation (API Resources):**
   Never return raw database models directly to the client. Route models through an API Resource class to:
   - Strip out sensitive data (like password hashes or internal metadata).
   - Ensure consistent formatting (e.g., standardizing timestamp outputs).
   - Conditionally load relationships to prevent N+1 query problems.