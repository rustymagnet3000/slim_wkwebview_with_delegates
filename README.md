# Slimmed down WKWebView
### Background
Playground to understand Apple's rich `WKWebView Delegates` and how to configure `Javascript`.  

I tried to keep the project slim.  Avoided a  `Massive View Controller` by:

- connecting a  `WKNavigationDelegate` as a property.
- connecting a  `WKUIDelegate` as a property.

Loaded a `local.html` file and inherited from `WKScriptMessageHandler` to see more `Javascript` code in action.

### Slim
- No `auto-layout` constraints.
- Only `Objective-C` code.
- One `View Controller` embedded inside a `Navigation Controller`.
- One `Refresh webview button`. Generated in code.
- No `Objects` added via the Storyboard.
- No `Outlets` connect the Storyboard to the code.
- No `SceneKit` .

### HTTP Security Headers
If you loaded `https://www.apple.com` and then hit the button to load local content (`file:///../WKWebView.app/local.html`) it would not load the local content.  This did not happen with my local web server.  I wondered if it was `Secure HTTP Header`.

```
/*      response www.apple.com     */
Strict-Transport-Security: max-age=31536000; includeSubDomains
x-frame-options: SAMEORIGIN
x-content-type-options: nosniff
x-xss-protection: 1; mode=block
```
What error was recorded?  I used `Console.app` but there was no obvious error. 
```
WebPageProxy::decidePolicyForNavigationAction, swapping process 11933 with process 0 for navigation, reason: Navigation is cross-site
```
That was not actually an error.  If you followed the logs.  I added the following lines to `Nginx`:
```
add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;";
add_header X-Content-Type-Options nosniff;
add_header X-Frame-Options SAMEORIGIN;
add_header X-XSS-Protection "1; mode=block";
```
No of these headers helped. My local web server always worked when you switched to a `local.html` file.



