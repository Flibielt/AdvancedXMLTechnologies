xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare variable $file_name := "results.json";

declare function local:list_games() as element()*
{
    let $countries := fn:json-doc($file_name)?*
    return
        <html>
            <table>
                <tbody>
                    {
                    for $country at $i in $countries
                    return
                        <tr>
                            <td>{ $i }</td>
                            <td>{ $country?name }</td>
                            <td>{ $country?gender }</td>
                            <td>{ $country?url }</td>
                        </tr>
                    }
                </tbody>
            </table>
        </html>
};

local:list_games()

