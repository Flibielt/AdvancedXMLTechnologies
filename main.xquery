xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
Lists every game with its gender and the URL of the game description from olympic.org
The results are formatted into a HTML table
:)
declare function local:list_games() as element()*
{
    let $games := fn:json-doc($file_name)?*
    return
        <html>
            <table>
                <tbody>
                    {
                    for $game at $i in $games
                    return
                        <tr>
                            <td>{ $i }</td>
                            <td>{ $game?name }</td>
                            <td>{ $game?gender }</td>
                            <td>{ $game?url }</td>
                        </tr>
                    }
                </tbody>
            </table>
        </html>
};

(:
Gets the longest game name
:)
declare function local:get_longest_name() as xs:string*
{
    let $games := fn:json-doc($file_name)?*,
    $count-chars := function($s, $c) {
        string-to-codepoints($s)[. eq string-to-codepoints($c)] => count()
    },
    $count-chars-insensitive := function($s, $c) {
        $count-chars(lower-case($s), lower-case($c))
    },
    $max-count := $games ! fn:string-length(?name) => max()
    return $games[fn:string-length(?name) eq $max-count]?name
};

(:
local:list_games(),
:)

local:get_longest_name()
