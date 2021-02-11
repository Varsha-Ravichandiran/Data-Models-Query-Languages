xquery version "3.1";

let $path :=doc("/db/q7_test.xml")
return <biblio>
   {
     for $i in distinct-values($path//title)
     let $book := ($path//book[data(title)=$i])[1]
     let $authors := (
           for $j in $path//book[data(title)=$i]
             return <author><name>{data($j/../*[.<<$j][1])}</name></author>
       )
       order by $book/@year descending
       return <book year="{data($book/@year)}">
       {$authors}
       {$book/title}
       {$book/price}
       </book>    
   }
  </biblio>