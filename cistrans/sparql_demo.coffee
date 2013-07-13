
# Since 4store's CORS and jsonp functionality is  not well documented, I just put together a
# proxy to handle the request. To get the endpoint directly with, eg, curl, you could use
# "http://localhost:8080/sparql/?soft-limit=5000&output=json&query=" as the query url;

query_url = "http://localhost:4567/doquery/";

probe_number = "513550"
marker = "rs6175633"

window.submitForm = (form) -> 
	probe_number = form.probe.value.toString()
	marker = form.marker.value.toString()
	reloadQueries()

reloadQueries = () ->
	document.getElementById("genotext").innerHTML = "Parsed Markers/LODs/gene for probe #{probe_number}";
	document.getElementById("phenotext").innerHTML = "Raw JSON for Pheno/Geno/individual for probe #{probe_number}, marker #{marker}";
	document.getElementById("probe").innerHTML = "Loading..."
	document.getElementById("pheno").innerHTML = "Loading..."

	$.ajax 'queries/probe.rq',
		type: 'GET',
		success:(data) ->
			$.ajax query_url + encodeURIComponent(data.replace(/497638/g,probe_number)),
				type: 'GET',
				success: (data) ->
					parsed = gene: data.results.bindings[0].gene.value;
					parsed.markers = data.results.bindings.map (b) -> b.marker.value ;
					parsed.lods = data.results.bindings.map (b) -> b.lod.value ;
					console.log "got probe,",parsed.markers.length ;
					document.getElementById("probe").innerHTML = JSON.stringify(parsed);

	$.ajax 'queries/pheno.rq',
		type: 'GET',
		success:(data) ->
			$.ajax query_url + encodeURIComponent(data.replace(/511932/g,probe_number).replace(/rs13475697/g,marker)),
				type: 'GET',
				success: (data) ->
					document.getElementById("pheno").innerHTML = JSON.stringify(data);



$(document).ready ->
	# reloadQueries()


