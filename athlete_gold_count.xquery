xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
List of athletes with the count of their gold medal
:)

let $data := fn:json-doc($file_name)?*,
    $athletes := fn:distinct-values($data?games?*?results?*[?medal eq 'G']?name)

return map:merge(for $athlete in $athletes return 
    map:entry($athlete, count($data?games?*?results?*[?medal eq 'G'][?name eq $athlete])))