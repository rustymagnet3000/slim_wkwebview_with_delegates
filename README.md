# Slimmed down WKWebView
### Background
I used the project as playground to understand `Delegate Methods` and `Javascript` inside a slim setup.  I avoided a  `Massive View Controller` by:

- connecting a  `WKNavigationDelegate` as a property.
- connecting a  `WKUIDelegate` as a property.

 I loaded a `local.html` file and inherited from `WKScriptMessageHandler` to see more Javascript code in action.

### Slim
- No `auto-layout` constraints.
- Only `Objective-C` code.
- One `View Controller` embedded inside a `Navigation Controller`.
- One `Refresh webview button`. Generated in code.
- No `Objects` added via the Storyboard.
- No `Outlets` connect the Storyboard to the code.
- No `SceneKit` .
