xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:indent "yes";

declare function local:depth($element as element()) as xs:integer
{
if (empty($element/*)) then 1
else fn:max(for $child in $element/* return 1 + local:depth($child))
};

declare function local:list_games() as xs:string
{
let $countries := fn:json-doc("results.json")?*
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

let $countries := fn:json-doc("results.json")?*
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


