# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	document.getElementById('q_pubList_id_eq').value = ('[]');
	document.getElementById('route_pubList_id_eq').value = ('[]');

$(document).ready(ready)
$(document).on('page:load', ready)