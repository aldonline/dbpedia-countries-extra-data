sparql = require 'sparql'
fs = require 'fs'

data = fs.readFileSync 'scraper-output.js', 'utf8'
countries = JSON.parse data

# print URIs ( to be used in a filter() clause )
uris = ( "<http://dbpedia.org/resource/#{c[0]}>" for c in countries ).join(', ')

q = """
prefix g: <http://www.geonames.org/ontology#>
construct { 
  ?same g:countryCode ?cc
} where {
    ?s owl:sameAs ?same ; g:countryCode ?cc
    filter( ?same in ( """ + uris + """ ) )
}
"""
cli = sparql.cli 'http://lod.openlinksw.com/sparql'

cli.construct q, (err, res) -> console.log res


