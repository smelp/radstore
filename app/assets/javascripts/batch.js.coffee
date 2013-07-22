callCal = () ->
	$('#datetimepicker1').datetimepicker
  	language: 'fi'
		console.log("called datetimepicker")

callCal2 = () ->
	$('#datetimepicker2').datetimepicker
  	language: 'fi'
		console.log("called datetimepicker")

setTimeout(callCal, 200)
setTimeout(callCal2, 200)