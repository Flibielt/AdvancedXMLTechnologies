xquery version "3.1";

import schema default element namespace "" at "games_list.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

(:
List every game type then within the games list by genders and locations
:)

declare function local:get-results($data, $game-name, $gender)
{
    let $gender-name := if ($gender = 'W')
        then 'Women'
        else 'Men'
    
    for $games in $data
    where $games?name = $game-name || ' ' || $gender-name
    return
        for $game in $games?games?*
        return
            <EVENT location="{$game?location}" year="{$game?year}">
            {
                for $result in $game?results?*
                where $games?gender = $gender
                return 
                    if (fn:empty($result?name))
                    then <TEAM nationality="{$result?nationality}" medal="{$result?medal}"/>
                    else <ATHLETE nationality="{$result?nationality}" medal="{$result?medal}">
                            { $result?name }
                        </ATHLETE>
            }
            </EVENT> 
};

declare variable $file_name := "results.json";

let $data := fn:json-doc($file_name)?*

let $game-names := (
    for $games in $data
    group by $game-name := fn:distinct-values(fn:replace($games?name, '( Men)|( Women)', ''))
    order by $game-name
    return $game-name)

return
    validate {
        document {
        <GAMES>
        {
            for $game-name in $game-names
            return 
                <GAME name="{$game-name}">
                {
                    <GENDERS>
                    <WOMEN>
                    {
                        local:get-results($data, $game-name, 'W')
                    }
                    </WOMEN>
                    <MEN>
                    {
                        local:get-results($data, $game-name, 'M') 
                    }
                    </MEN>
                    </GENDERS>
                    
                }
                </GAME>
        }
        </GAMES>
        }
    }