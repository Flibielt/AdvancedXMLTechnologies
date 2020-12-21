xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
Longest game name
:)

declare function local:get_longest_name() as xs:string*
{
    let $games := fn:json-doc($file_name)?*,
    $max-count := $games ! fn:string-length(?name) => max()
    return $games[fn:string-length(?name) eq $max-count]?name
};

local:get_longest_name()
