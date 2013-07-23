
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

parseResults = (genojson, phenojson) ->
	probeobj = {
		probe: probe_number,
		pheno: [],
		lod: []
	}

	genoobj = {
		geno: {}
	}
	genoobj.geno[marker] = []

	genojson.results.bindings.map (b) ->
		probeobj.lod.push +b.lod.value
	
	phenojson.results.bindings.map (b) ->
		probeobj.pheno.push +b.pheno.value
		genoobj.geno[marker].push +b.geno.value

	[probeobj, genoobj]

reloadQueries = () ->
	document.getElementById("genotext").innerHTML = "Parsed phenotypes and LODs for probe #{probe_number}";
	document.getElementById("phenoparsedtext").innerHTML = "Genotypes for #{probe_number}, marker #{marker}";
	document.getElementById("genoraw").innerHTML = "Raw Markers/LODs/gene for probe #{probe_number}";
	document.getElementById("phenotext").innerHTML = "Raw JSON for Pheno/Geno/individual for probe #{probe_number}, marker #{marker}";

	document.getElementById("probeparsed").innerHTML = "Loading Query..."
	document.getElementById("probe").innerHTML = "Loading Query..."
	document.getElementById("phenoparsed").innerHTML = "Waiting..."
	document.getElementById("pheno").innerHTML = "Waiting..."

	$.ajax 'queries/probe.rq',
		type: 'GET',
		success:(data) ->
			document.getElementById("probe").innerHTML = "Querying probe data..."
			document.getElementById("probeparsed").innerHTML = "Querying probe data..."
			$.ajax query_url + encodeURIComponent(data.replace(/497638/g,probe_number)),
				type: 'GET',
				success: (data) ->
					genodata = data
					document.getElementById("probe").innerHTML = "Waiting for pheno results"
					document.getElementById("probeparsed").innerHTML = "Waiting for pheno results"
					document.getElementById("pheno").innerHTML = "Querying pheno data..."
					document.getElementById("phenoparsed").innerHTML = "Querying pheno data..."
					$.ajax 'queries/pheno.rq',
						type: 'GET',
						success:(data) ->
							$.ajax query_url + encodeURIComponent(data.replace(/511932/g,probe_number).replace(/rs13475697/g,marker)),
								type: 'GET',
								success: (data) ->
									parsed = parseResults(genodata, data)
									document.getElementById("probeparsed").innerHTML = JSON.stringify(parsed[0], null, "  ")
									document.getElementById("probe").innerHTML = JSON.stringify(genodata);
									document.getElementById("phenoparsed").innerHTML = JSON.stringify(parsed[1], null, "  ")
									document.getElementById("pheno").innerHTML = JSON.stringify(data);


$(document).ready ->
	# reloadQueries()


