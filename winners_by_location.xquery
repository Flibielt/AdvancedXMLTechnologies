xquery version "3.1";

import schema default element namespace "" at "winners_by_location.xsd";

declare variable $file_name := "results.json";

(:
List every location with the winners
:)
let $data := fn:json-doc($file_name)?*,
    $locations := fn:distinct-values($data?games?*?location)

return 
    validate {
        document {
            <LOCATIONS>
            {
                for $location in $locations
                return
                    <LOCATION name="{$location}">
                    {
                    for $games in $data
                    return
                        for $game in $games?games?*
                        where $game?location = $location
                        return 
                                for $result in $game?results?*
                                where $result?medal = 'G'
                                return
                                    <GAME name="{$games?name}" year="{$game?year}">
                                        <ATHLETE nationality="{$result?nationality}" gender="{$games?gender}">
                                            { $result?name }
                                        </ATHLETE>
                                    </GAME>
                    }
                    </LOCATION>
            }
            </LOCATIONS>
        }
    }
