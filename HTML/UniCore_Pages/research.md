
## 1. GET vs POST

The main difference between **GET** and **POST** is how the data is sent from the browser to the server.

**GET**

* Sends data through the URL as query parameters.
* The data becomes visible in the browser address bar.
* It is mainly used for retrieving data from the server.
* It has a size limitation and is less secure for sensitive information.

Example:

```
example.com/register?name=Ahmed&email=test@gmail.com
```

**POST**

* Sends data inside the HTTP request body instead of the URL.
* The data is not visible in the address bar.
* It is used when submitting sensitive or large data.
* It is more secure than GET for forms like login or registration.

**Which one to use for `register.html`?**

For the registration form, **POST** should be used because the form contains sensitive information such as passwords and personal details. Sending this data in the request body is safer than exposing it in the URL.

---

## 2. Semantic HTML

Semantic HTML uses meaningful tags such as:

* `<header>`
* `<main>`
* `<section>`
* `<footer>`

instead of using only `<div>` elements.

Using semantic tags is better because:

* It makes the structure of the page clearer and easier to understand.
* It improves accessibility for screen readers.
* It helps search engines (SEO) understand the content of the page.
* It makes the code more organized and easier to maintain.

---

## 3. The Request/Response Cycle

When you type **google.com** in the browser and press Enter, the following steps happen:

1. The browser checks if the IP address of the domain is already cached.
2. If it is not cached, the browser sends a request to a **DNS (Domain Name System) server** to translate the domain name `google.com` into an **IP address**.
3. The DNS server returns the IP address of Google's server.
4. The browser sends an **HTTP request** to that IP address asking for the webpage.
5. The web server processes the request and sends back an **HTTP response** containing the HTML, CSS, and JavaScript files.
6. The browser receives the response and renders the page for the user.
