
# Since 4store's CORS and jsonp functionality is  not well documented, I just put together a
# proxy to handle the request. To get the endpoint directly with, eg, curl, you could use
# "http://localhost:8080/sparql/?soft-limit=5000&output=json&query=" as the query url;

query_url = "http://#{window.location.host}/doquery/";

probe_number = "497638"
marker = "rs6175633"

window.submitForm = (form) -> 
	probe_number = form.probe.value.toString()
	marker = form.marker.value.toString()
	reloadQueries()

reloadQueries = () ->
	document.getElementById("genotext").innerHTML = "Parsed Markers/LODs/gene for probe #{probe_number}";
	document.getElementById("phenoparsedtext").innerHTML = "Parsed Pheno/Geno/individual for probe #{probe_number}, marker #{marker}";
	document.getElementById("phenotext").innerHTML = "Raw JSON for Pheno/Geno/individual for probe #{probe_number}, marker #{marker}";
	document.getElementById("probe").innerHTML = "Loading Query..."
	document.getElementById("phenoparsed").innerHTML = "Loading Query..."
	document.getElementById("pheno").innerHTML = "Loading Query..."

	$.ajax 'queries/probe.rq',
		type: 'GET',
		success:(data) ->
			document.getElementById("probe").innerHTML = "Querying..."
			$.ajax query_url + encodeURIComponent(data.replace(/497638/g,probe_number)),
				type: 'GET',
				success: (data) ->
					document.getElementById("probe").innerHTML = "Parsing..."
					parsed = []
					if data.results.bindings[0].gene
						parsed.push {gene: data.results.bindings[0].gene.value}
						data.results.bindings.map (b) ->
							parsed.push 
								marker: b.marker.value,
								lod: b.lod.value,

						document.getElementById("probe").innerHTML = JSON.stringify(parsed);
					else
						document.getElementById("probe").innerHTML = "no data for #{probe_number}";
						


	$.ajax 'queries/pheno.rq',
		type: 'GET',
		success:(data) ->
			document.getElementById("phenoparsed").innerHTML = "Querying..."
			$.ajax query_url + encodeURIComponent(data.replace(/511932/g,probe_number).replace(/rs13475697/g,marker)),
				type: 'GET',
				success: (data) ->
					document.getElementById("phenoparsed").innerHTML = "Parsing..."
					parsed = []
					data.results.bindings.map (b) ->
						parsed.push 
							mouse: b.mouse.value,
							pheno: b.pheno.value,
							sex: b.sex.value,
							geno: b.geno.value

					document.getElementById("phenoparsed").innerHTML = JSON.stringify(parsed);
					document.getElementById("pheno").innerHTML = JSON.stringify(data);



$(document).ready ->
	# reloadQueries()


