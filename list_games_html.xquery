xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare variable $file_name := "results.json";

(:
Lists every game with its gender and the URL of the game description from olympic.org
The results are formatted into a HTML table
:)
let $games := fn:json-doc($file_name)?*
return document {
    <html>
        <head>
            <title>List of games</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
        </head>
        <body>
            <h1 class="text-center">Olympic Track and Field Games</h1>
            <table class="table table-bordered table-striped table-hover">
                <thead>
                        <tr>
                            <th class="text-center">#</th>
                            <th class="text-center">Gender</th>
                            <th>Game</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                <tbody>
                    {
                    for $game at $i in $games
                    return
                        <tr>
                            <td class="text-center">{ $i }.</td>
                            <td class="text-center">{ $game?gender }</td>
                            <td>{ $game?name }</td>
                            <td>
                                <a href="{$game?url}">{ $game?url }</a>
                            </td>
                        </tr>
                    }
                </tbody>
            </table>
        </body>
        
    </html>
}

