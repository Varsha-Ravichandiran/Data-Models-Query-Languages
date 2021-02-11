xquery version "3.1";

let $path :=doc("/db/books.xml")
let $titles := distinct-values($path//title)
let $books := (for $i in $titles
let $global := ($path//book[title=$i])[1]
return $global)
let $global_avg := avg($books//price)
return <results><global_average>{$global_avg}</global_average>
{
for $i in distinct-values($path//category)
 let $cat_books := $books[category=$i]
 let $cat_avg := avg($cat_books/price)
 where $cat_avg>$global_avg
 let $max_price := max($cat_books/price)

 let $book2 := $books[category=$i and price=$max_price]
 return <category id="{$i}">
    <category_average>{$cat_avg}</category_average>
     {for $i in $book2
        return <book year="{$i/@year}">{$i/title}{$i/price}</book>
     }
     </category>
}
</results>
