# Research Questions

### GET vs POST :

- **GET** :

    - Data sent in the URL `(name=value)`
    - Visible, limited size, stored in history
    - Use for searches or non-sensitive info
- **POST** :
    - Data sent in the request body
    - Not visible, can send more data
    - Use for sensitive info or actions that change server state    
    
- For `register.html` → use `POST` 

   - Because it sends username/password/email wich are sensitive
   - Correct method for creating new accounts

---
### Semantic HTML :

- Using semantic HTML tags like `<header>`, `<main>`, `<section>`, and `<footer>` is better than using only `<div>` because they describe the meaning and structure of the content.

---
### The Request/Response Cycle :

 1. **DNS Lookup**  
   When you type `google.com`, the browser asks a **DNS server** to translate the domain name into its **IP address**.

2. **Get the IP Address**  
   The DNS server returns the **IP address** of the server hosting the website.

3. **Send HTTP Request**  
   The browser sends an **HTTP request** to that IP address asking for the webpage.

4. **Server Response**  
   The server processes the request and sends back an **HTTP response** containing files like HTML, CSS, and JavaScript.

5. **Render the Page**  
   The browser reads these files and **renders the webpage** so you can see it.