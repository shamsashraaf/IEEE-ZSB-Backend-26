# Documentation

## 1. HTTP & API Fundamentals

### Core Principles
- **Statelessness:** HTTP has no memory of past interactions. Every request is treated as an independent event and must contain all necessary data (e.g., authentication tokens, session IDs) for the server to process it.
- **Client-Server Model:** Communication is strictly one-way initiation. A client (typically a browser or frontend app) must send a request before a server can send a response.
- **Methods & Idempotency:** HTTP methods define the semantic intent of the request.
    - `GET`, `PUT` (full replacement), and `DELETE` are **idempotent**. Executing them multiple times yields the exact same state on the server as doing it once.
    - `POST` (creation) is **non-idempotent**. Sending it multiple times will create multiple distinct resources.
    - `PATCH` is used for partial updates (can be non-idempotent depending on implementation).
- **CORS (Cross-Origin Resource Sharing):** A browser security mechanism that restricts web pages from making unauthorized API requests to domains other than their own.
    - **Simple Requests:** Browser checks response for an `Access-Control-Allow-Origin` header.
    - **Pre-flight Requests (`OPTIONS`):** For complex requests (e.g., sending JSON data), the browser automatically sends a preliminary `OPTIONS` request to ask the server for capabilities and permission before sending the actual payload.

### Handling Data & Performance
- **Large Data:** Uploads use `multipart/form-data` to slice binary data into chunks separated by a unique boundary code. Downloads can be streamed continuously using chunked text event streams.
- **Compression & Negotiation:** Clients use headers like `Accept` (JSON vs XML) and `Accept-Language`. Clients can also send an `Accept-Encoding` header requesting compressed data (like `gzip`), which can dramatically shrink payloads (e.g., reducing a 26MB file to 4MB).
- **Security (HTTPS & TLS):** HTTPS routes standard HTTP through an encrypted TLS tunnel, ensuring that intercepted traffic appears as unreadable gibberish.

---

## 2. Serialization & Deserialization

When two machines communicate over a network, they are often written in different languages with different data types (e.g., a JavaScript frontend communicating with a Rust backend).

- **The Concept:** Serialization converts language-specific data structures into a common, standardized format for transmission. Deserialization converts it back into the receiving machine's native data structures.
- **JSON (JavaScript Object Notation):** The most popular text-based serialization standard for HTTP APIs. It is human-readable. Keys must be double-quoted strings, and values can be strings, numbers, booleans, arrays, or nested objects.
- **Other Standards:** 
    - *Text-based:* YAML and XML.
    - *Binary-based:* Protobuf (Protocol Buffers) or Avro, used for high-performance, internal microservice communication (e.g., gRPC).

---

## 3. Caching: The Secret to High Performance

Caching decreases latency and server load by storing a subset of frequently accessed data in a location that is much faster or cheaper to query.

### Levels of Caching
1.  **Network Level:** 
    - **CDNs (Content Delivery Networks):** Distributes heavy assets to "Edge servers" geographically close to the user to minimize buffering and latency.
    - **DNS Caching:** Storing IP addresses locally (in the OS, browser, or ISP resolver) so your computer doesn't have to recursively query root servers every time you type a URL.
2. **Hardware Level:** L1, L2, L3 caches inside the CPU, which are infinitely faster than querying the main memory or hard drive.
3. **In-Memory Databases (Software Level):** Technologies like **Redis** or **Memcached**. They store data in RAM (primary storage) rather than on a disk (secondary storage), making reads and writes incredibly fast.

### Caching Strategies & Eviction
- **Lazy Caching (Cache-Aside):** The application checks the cache first. If it's a "miss", it queries the database, saves the result to the cache, and returns it.
- **Write-Through:** Every time the database is updated, the cache is updated simultaneously. Ensures data is never stale but adds overhead to write operations.
- **Eviction Policies:**
    - **LRU (Least Recently Used):** Deletes the data that hasn't been accessed in the longest time.
    - **LFU (Least Frequently Used):** Deletes the data with the lowest total access count.
    - **TTL (Time To Live):** Automatically invalidates and deletes data after a set time.

---

## 4. Software Architecture & UML

Visualizing architecture creates a shared mental model, reducing miscommunication within engineering teams.

### UML Class Diagrams
- **Class Structure:** Drawn as a box with three sections: Name (top), Attributes/Properties (middle), and Methods/Behaviors (bottom).
- **Visibility:** `+` (Public), `-` (Private), `#` (Protected), `~` (Package).
-   **Key Relationships:**
    - **Inheritance (Open Arrow):** A child class inherits attributes from a parent (e.g., `Customer` inherits from `User`).
    - **Aggregation (Open Diamond):** The whole and its parts, but the parts can exist independently.
    - **Composition (Closed Diamond):** The part *cannot* exist without the whole (e.g., If a `Customer` account is deleted, their `Order History` is also destroyed).

---

## 5. The Observer Design Pattern

A behavioral pattern perfect for event-driven systems (e.g., building a notification system for an online marketplace).

- **The Problem:** Hardcoding notifications (tightly coupling the `Marketplace` class with complex `if-else` statements checking if a user wants product alerts, job alerts, or offer alerts) violates the Open-Closed Principle and becomes a maintenance nightmare.
- **The Solution:** The Publisher (Marketplace) maintains a dynamic list of Subscribers. You create a shared `Subscriber` Interface with a `notify()` method. Whenever an event happens, the Publisher simply iterates through the list and calls `.notify()` on everyone subscribed to that specific event.
- **Benefit:** You can easily add new subscriber types (like a `ShippingCompany` or a `JobSeeker`) dynamically without ever modifying the core Marketplace code.

---

## 6. Real-World System Design Principles

System design in the real world is fundamentally about business constraints, communication, and managing trade-offs.

### The 3 Core Questions (Discovery Phase)
Before designing anything, ask:
1. **What?** What is the business strategy? What exact problem are we trying to solve?
2. **Why?** Ask "why" repeatedly to reach the root cause. This breaks down knowledge silos and ensures the engineering team builds the right solution.
3. **When?** Understand the project management constraints: **Time vs. Scope vs. Resources**. You cannot lock in all three. If the deadline is fixed, you must either cut features (scope) or add budget (resources).

### Managing Uncertainty & Trade-offs
- **The Golden Law of Architecture:** Everything is a trade-off. There are no perfect solutions, only acceptable compromises. "Why" you chose a solution is always more important than "How" you built it.
- **Diagrams as Communication:** Use Flowcharts, Sequence Diagrams, or C4 models not as static paperwork, but as communication tools to align the team's mental models before writing code.
- **Iterative Learning:** Real-world architecture isn't about getting it perfect on a whiteboard on day one. It's about building, observing the bottlenecks, and evolving the system dynamically.