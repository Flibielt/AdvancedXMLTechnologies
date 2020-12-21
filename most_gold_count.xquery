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

let $data := fn:json-doc($file_name)?*,
    $count-golds := function($athlete) { $data?games?*?results?*[?medal eq 'G'][?name eq $athlete] => count()},
    $max-count := $data?games?*?results?*[?medal eq 'G'] ! $count-golds(?name) => max()

return $max-count