# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  select = $('#substance_substanceType')
  select.change ->
    labelHL = $('label[for=substance_half_life]')
    inputHL = $('#substance_half_life')
    labelDays = $('label[for=substance_alert_days]')
    inputDays = $('#substance_alert_days')
    if select.val() == 'Muu'
      labelDays.hide()
      inputDays.hide()
      labelHL.hide()
      inputHL.hide()
    else if select.val() == 'Kitti'
      labelDays.show()
      inputDays.show()
      labelHL.hide()
      inputHL.hide()
    else if select.val() == 'Generaattori'
      labelDays.show()
      inputDays.show()
      labelHL.show()
      inputHL.show()
