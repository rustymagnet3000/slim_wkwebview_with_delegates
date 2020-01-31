# Slimmed down WKWebView
### Goals
With `Objective-C`, avoid a  `Massive View Controller` by.
- connecting a  `WKNavigationDelegate` as a property.
- connecting a  `WKUIDelegate` as a property.

Use the project as a simple playground to show all large amount of  `Delegate Methods` and `Javascript` inside a slim WKWebView setup.

### Slim
- No `auto-layout` constraints.
- Only `Objective-C` code.
- One `View Controller` embedded inside a `Navigation Controller`.
- One `Refresh webview button`. Generated in code.
- No `Objects` added via the Storyboard.
- No `Outlets` connect the Storyboard to the code.
- No `SceneKit` .
