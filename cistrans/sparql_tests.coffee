console.log 'running!'
query_url = "http://localhost:8080/sparql/?soft-limit=5000&output=json";

# probe_query =    "http://localhost:8080/sparql/?soft-limit=5000&output=json";

pheno_query =  "http://localhost:8080/sparql/?soft-limit=1000&output=json&query=PREFIX%20f2gns%3A%20%20%20%20%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2Fdataset%2Ff2g%23%3E%20%20PREFIX%20phenons%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2Fdataset%2Fislet_mlratio%23%3E%20%20PREFIX%20qb%3A%20%20%20%3Chttp%3A%2F%2Fpurl.org%2Flinked-data%2Fcube%23%3E%20%20%20PREFIX%20rdf%3A%20%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%20%20%20PREFIX%20rdfs%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%20%20%20PREFIX%20prop%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fdc%2Fproperties%2F%3E%20%20%20PREFIX%20cs%3A%20%20%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fdc%2Fcs%2F%3E%20%20PREFIX%20skos%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2004%2F02%2Fskos%2Fcore%23%3E%20%20%20%20%20SELECT%20DISTINCT%20%3Fmouse%20%3Fpheno%20%3Fgeno%20WHERE%20%7B%20%20%09%3Fs%20qb%3AdataSet%20phenons%3Adataset-islet_mlratio%3B%20%20%20%09%09prop%3Aindividual%20%3Fmouse%3B%20%20%09%09prop%3Aprobe%20%22511932%22%5E%5E%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23integer%3E%3B%20%20%09%09prop%3Apheno%20%3Fpheno.%20%20%20%20%09%3Ft%20qb%3AdataSet%20f2gns%3Adataset-f2g%3B%20%20%09%09prop%3Amarker%20%22rs13475697%22%3B%20%20%09%09prop%3AMouseNum%20%3Fmouse2%3B%20%20%09%09prop%3Agenotype%20%3Fgeno.%20%20%20%20%09FILTER(%3Fmouse2%20%3D%20%3Fmouse)%20%20%7D%20%20LIMIT%20200"

# probe_query = "&query=PREFIX%20f2gns%3A%20%20%20%20%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2Fdataset%2Ff2g%23%3E%20%20PREFIX%20phenons%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2Fdataset%2Fislet_mlratio%23%3E%20%20PREFIX%20scanns%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2Fdataset%2Fscan_islet%23%3E%20%20PREFIX%20annons%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fns%2F%23%3E%20%20PREFIX%20qb%3A%20%20%20%3Chttp%3A%2F%2Fpurl.org%2Flinked-data%2Fcube%23%3E%20%20%20PREFIX%20rdf%3A%20%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%20%20%20PREFIX%20rdfs%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%20%20%20PREFIX%20prop%3A%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fdc%2Fproperties%2F%3E%20%20%20PREFIX%20cs%3A%20%20%20%3Chttp%3A%2F%2Fwww.rqtl.org%2Fdc%2Fcs%2F%3E%20%20PREFIX%20skos%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2004%2F02%2Fskos%2Fcore%23%3E%20%20%20%20%20%20%20SELECT%20%3Fmarker%20%3Flod%20%3Fgene%20WHERE%20%7B%20%20%20%3Fs%20qb%3AdataSet%20scanns%3Adataset-scan_islet%3B%20%20%20%20%20%20prop%3Aprobe%20%22497638%22%5E%5E%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23integer%3E%3B%20%20%20%20%20%20prop%3Amarker%20%3Fmarker%3B%20%20%20%20%20%20prop%3Alod%20%3Flod.%20%20%20%20%20%20%20%3Ft%20qb%3AdataSet%20annons%3Adataset-annot%3B%20%20%20%20%20rdfs%3Alabel%20%22497638%22%3B%20%20%20%20%20prop%3Agene%20%3Fgene.%20%20%7D%20%20ORDER%20BY(%3Fmarker)%20%20LIMIT%205000";

probe_query = 'PREFIX f2gns:     <http://www.rqtl.org/ns/dataset/f2g#>
PREFIX phenons: <http://www.rqtl.org/ns/dataset/islet_mlratio#>
PREFIX scanns: <http://www.rqtl.org/ns/dataset/scan_islet#>
PREFIX annons: <http://www.rqtl.org/ns/#>
PREFIX qb:   <http://purl.org/linked-data/cube#> 
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
PREFIX prop: <http://www.rqtl.org/dc/properties/> 
PREFIX cs:   <http://www.rqtl.org/dc/cs/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#> 


SELECT ?marker ?lod ?gene WHERE {
 ?s qb:dataSet scanns:dataset-scan_islet;
    prop:probe "497638"^^<http://www.w3.org/2001/XMLSchema#integer>;
    prop:marker ?marker;
    prop:lod ?lod.

 FILTER (STRSTARTS(?marker, "r"))

 ?t qb:dataSet annons:dataset-annot;
   rdfs:label "497638";
   prop:gene ?gene.
}
ORDER BY(?marker)
LIMIT 5000'

$(document).ready ->

	$.ajax query_url + "&query=" + encodeURIComponent(plain_query),
		type: 'GET',
		success: (data) ->
	  	parsed = gene: data.results.bindings[0].gene.value	
	  	parsed.markers = data.results.bindings.map (b) -> b.marker.value
	  	parsed.lods = data.results.bindings.map (b) -> b.lod.value

	  	console.log "got probe,",parsed.markers.length 
	  	document.getElementById("probe").innerHTML = JSON.stringify(parsed);
	
	# $.ajax pheno_query,
	# 	type: 'GET',
	# 	processData: true,
	# 	data: {},
	# 	dataType: "json",
	# 	error: (jqXHR, textStatus, errorThrown) ->
	# 		$('body').append "AJAX Error: #{textStatus} #{errorThrown}";
	# 	success: (data) ->
	#   	document.getElementById("pheno").innerHTML = JSON.stringify(data);
	#   	console.log "got phenotypes."

