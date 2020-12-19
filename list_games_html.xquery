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
        <table class="table table-bordered table-striped table-hover">
            <thead>
                    <tr>
                        <th>#</th>
                        <th>Game</th>
                        <th>Gender</th>
                        <th>Description</th>
                    </tr>
                </thead>
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
}

