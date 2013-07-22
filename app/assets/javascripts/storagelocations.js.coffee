# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


#// For fixed width containers
jQuery ->
	oTable = $('#myTable').dataTable
	  sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
	  sPaginationType: "bootstrap",
	  aaSorting: [[ 0, "asc" ], [1, "asc"]],
		aoColumns: [
			null,
			null,
			null,
			null
		]
	  , fnDrawCallback: ( oSettings ) ->
	    console.log("h")