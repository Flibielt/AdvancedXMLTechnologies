xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
The biggest gold count by a single athlete
:)

declare function local:count-golds($athlete, $data)
{
    let $count := $data?games?*?results?*[?medal eq 'G'][?name eq $athlete] => count()
    
    return $count
};

let $data := fn:json-doc($file_name)?*,
    $max-count := $data?games?*?results?*[?medal eq 'G'] ! local:count-golds(?name, $data) => max()

return $max-count