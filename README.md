## Example of a custom Qualtrics Web Service

This is a short proof of concept of a custom Qualtrics Web Service. It returns its results in a number of valid formats that Qualtrics recognizes and saves as Embedded Data.

It is written in Sinatra and immediately deployable to Heroku. An instance is running at <https://salty-meadow-86558.herokuapp.com/>. Point your Web Service block in the Survey Flow to this URL and be treated to baroque pop in URI form.

**Formats that Qualtrics can process are:**

* Key-value as presented in a URI query, e.g. `key1=value&key2=value`, as shown at `/`
* JSON, as shown at `/json`
* Well-formed XML, as shown at `/xml` and `/xml_undeclared`
