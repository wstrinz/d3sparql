
query_url = "http://localhost:8080/sparql/?soft-limit=5000&output=json";

$(document).ready ->

	$.ajax 'queries/probe.rq',
		type: 'GET',
		success:(data) ->
			$.ajax query_url + "&query=" + encodeURIComponent(data),
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
			$.ajax query_url + "&query=" + encodeURIComponent(data),
				type: 'GET',
				success: (data) ->
					document.getElementById("pheno").innerHTML = JSON.stringify(data);


