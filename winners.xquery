xquery version "3.1";

import schema default element namespace "" at "winners.xsd";

declare variable $file_name := "results.json";

let $data := fn:json-doc($file_name)?*,
    $names := fn:distinct-values($data?games?*?results?*[?medal eq 'G']?name)

return 
    validate {
        document {
            <WINNERS>
                {
                    for $name in $names
                        return <NAME>{ $name }</NAME>
                                
                }
            </WINNERS>
        }
    }