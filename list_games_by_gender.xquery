xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
List of games by gender
:)

let $games := json-doc($file_name)?*,
    $genders := distinct-values($games?gender)

return map:merge(for $gender in $genders 
    return map:entry($gender, array{ $games[?gender eq $gender]?name })) => serialize(map{'method': 'json'})
