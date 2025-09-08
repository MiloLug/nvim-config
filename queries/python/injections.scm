;; extends

(call
    function: (identifier) @name (#eq? @name "sql")
    arguments: (argument_list
        (string
            (string_content) @injection.content
                (#set! injection.combined)
                (#set! injection.language "sql"))))
