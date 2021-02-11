xquery version "3.1";

<results>
{(let $books := doc("/db/books.xml")/biblio/author

for $i in ($books/book/title)
 let $book := ($books/book[title=$i])[1]
   order by xs:float($book/price) ascending
   return $book)}
</results>