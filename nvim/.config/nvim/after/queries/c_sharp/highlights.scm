; extends

;; Static method invocation: e.g. Console.WriteLine(...)
(invocation_expression
  (member_access_expression
    expression: (identifier) @type
    name: (identifier) @function.method.call)
  (#lua-match? @type "^[A-Z]")
  (#set! priority 130))

;; Member method invocation on any expression: obj.Method(...)
(invocation_expression
  (member_access_expression
    name: (identifier) @function.method.call)
  (#set! priority 125))

;; Direct function/method invocation: Method(...)
(invocation_expression
  (identifier) @function.method.call
  (#set! priority 125))

;; Static member access on PascalCase type: e.g. Math.PI, Console.Out
(member_access_expression
  expression: (identifier) @type
  (#lua-match? @type "^[A-Z]")
  (#set! priority 120))
