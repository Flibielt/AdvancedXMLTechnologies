xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
List countries with its results and medal count in HTML
:)

declare function local:get_medal_count($data, $nationality, $medal) as xs:integer
{
    let $count := $data?games?*?results?*[?medal eq $medal][?nationality eq $nationality] => count()
    return $count
};

let $data := fn:json-doc($file_name)?*,
    $country-codes := fn:distinct-values($data?games?*?results?*?nationality)

return document {
    <html>
    <head>
        <title>List of games</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"/>
        <link rel="stylesheet" href="olympics.css"/>
    </head>
    <body>
    <div class="container">
    <h1 class="text-center">Olympic Track and Field Results</h1>
    <div class="panel-group">
    {
        for $country-code in $country-codes
        order by $country-code
        return
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapse{$country-code}">{$country-code}</a>
                </h4>
            </div>
            <div id="collapse{$country-code}" class="panel-collapse collapse">
                <div class="panel-body">
                <p>Gold medals: {local:get_medal_count($data, $country-code, 'G')}</p>
                <p>Silver medals: {local:get_medal_count($data, $country-code, 'S')}</p>
                <p>Bronze medals: {local:get_medal_count($data, $country-code, 'B')}</p>
                <table class="table table-striped table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Game</th>
                        <th>Location</th>
                        <th>Year</th>
                        <th>Medal</th>
                    </tr>
                </thead>
                    {
                    let $current-players := fn:distinct-values(
                        for $games in $data
                        return
                            for $game in $games?games?*
                            return 
                                for $result in $game?results?*
                                where $result?nationality = $country-code
                                order by $result?name
                                return $result?name)
                    
                    
                    for $player in $current-players
                    order by $player
                    return
                        for $games in $data
                        return
                            for $game in $games?games?*
                            return 
                                for $result in $game?results?*
                                where $result?nationality eq $country-code
                                where $result?name eq $player
                                return
                                <tr>
                                    <td>{$result?name}</td>
                                    <td>{$games?name}</td>
                                    <td>{$game?location}</td>
                                    <td>{$game?year}</td>
                                    {
                                        if ($result?medal eq "G")
                                        then <td>{$result?medal}</td>
                                        else if ($result?medal eq "S")
                                        then <td>{$result?medal}</td>
                                        else <td>{$result?medal}</td>
                                    }
                                </tr>
                    }
                    </table>
                </div>
            </div>
        </div>
                
    }
    </div>
    </div>
    </body>
    </html>
}


