xquery version "3.1";

<results>
{(let $path := doc("/db/books.xml")/biblio/author

for $x in $path
where $x/name ='Jeff' 
  let $book:=$x/book/title
for $y in $path
  where $y/name != 'Jeff'
   for $i in $y/book/title,
     $j in $book
  return if(data($i) = data($j))
  then <book>{$i}{$x/name}{$y/name}</book>
  else ())}
</results>