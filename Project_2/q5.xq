xquery version "3.1";

let $path := doc("/db/books.xml")
let $result := (
for $a in distinct-values($path//title)
let $count := count($path//book[exists(fn:index-of(title,$a))])
return if ($count >= 2)
then <output>
 {for $i in $path//book[title=$a]
   return $i/../*[.<<$i][1]}
 {($path//book[title=$a])[1]}
 </output>
 else())
 
let $res := (for $book1 in $result, $book2 in $result
where $book1//title != $book2//title and deep-equal($book1/name, $book2/name)
return ($book1, $book2)
)
let $authors := (for $i in distinct-values($res/name)
return <name>{$i}</name>)
return <results>
<pair>{$authors}
{for $i in $res
return $i/book}
</pair>
</results>
