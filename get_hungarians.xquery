xquery version "3.1";

declare variable $file_name := "results.json";

let $data := fn:json-doc($file_name)?*

return document {
    <RESULTS>
        {
            for $games in $data
            return
                for $game in $games?games?*
                return 
                    for $result in $game?results?*
                    where $result?nationality eq 'HUN'
                    return
                        <RESULT>
                            <NAME>{ $result?name }</NAME>
                            <GENDER>{ $games?gender }</GENDER>
                            <LOCATION>{ $game?location }</LOCATION>
                            <YEAR>{ $game?year }</YEAR>
                            <MEDAL>{ $result?medal }</MEDAL>
                        </RESULT>
        }
    </RESULTS>
}