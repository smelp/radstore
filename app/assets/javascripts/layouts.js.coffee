window.callD = (e) ->
  $('.dropdown-toggle').dropdown()

window.updateTime = (e) ->
	d = new Date()
	_month = if d.getMonth() < 9 then ('0' + (d.getMonth()+1)) else (d.getMonth() + 1)
	_date = if d.getDate() < 10 then '0' + d.getDate() else d.getDate()
	_hours = if d.getHours() < 10 then '0' + d.getHours() else d.getHours()
	_minutes = if d.getMinutes() < 10 then '0' + d.getMinutes() else d.getMinutes()
	_seconds = if d.getSeconds() < 10 then '0' + d.getSeconds() else d.getSeconds()
	t = '| ' + _date + '.' + _month + '.' + d.getFullYear() + ' ' + _hours + ':' + _minutes + ':' + _seconds
	$('#cur-time').text(t)

setTimeout(callD, 200)
setInterval(updateTime, 1000)
