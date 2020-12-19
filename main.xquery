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

local:list_games()

