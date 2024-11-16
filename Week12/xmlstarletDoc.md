# XMLStarlet

**`xmlstarlet`** is a command-line tool to help parse and format XML files. For example

This command, piped to an output or , formats HTML data into XML data and tries to recover any lost information. `2>` redirects errors to `/dev/null`
    cat <inputFile> | xmlstarlet format --html --recover 2> /dev/null
    OR
    xmlstarlet format --html --recover <inputfile>  2> /dev/null

This other command selects all nodes with the specified XPath expression. XPath expressions are used to select nodes from an XML file, for instance any node with an ID attribute. There might be several nodes that share the same expression but XPath returns a collection of all of them.
    xmlstarlet select --template --copy-of "//html//body//div//div/table//tr" <inputFile>
> The difference between `--copy-of` and `--value-of` is similar but important. `--copy-of` will print a copy of the XPath expression, but not the nodes that are returned from the command. `--value-of` will print the return value of the XPath expression which is, as mentioned above, a collection of nodes that match the given expression. 
