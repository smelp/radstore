$(document).ready ->
  $('#datetimepicker-radiomedicine').datetimepicker
    language: 'fi'
  $('#radiomedicine_radioactivity').change (e) ->
    return  if isNaN(parseFloat(@value))
    temp = parseFloat(@value.replace(/\,/g, '.')).toFixed(2)
    @value = temp.replace(/\./g, ',')

  $('#radiomedicine_volume').change (e) ->
    return  if isNaN(parseFloat(@value))
    temp = parseFloat(@value.replace(/\,/g, '.')).toFixed(2)
    @value = temp.replace(/\./g, ',')

window.revealRemoval = (event,controller,targetID) ->
  event.preventDefault()
  form = document.createElement('form')
  signature = document.createElement('input')
  button = document.createElement('button')

  form.action = controller+'/destroy/'+targetID
  form.method = 'post'

  signature.name = 'signature'
  signature.type = 'text'
  signature.placeholder = 'Nimikirjaimet'

  button.innerHTML = 'Poista'
  button.type = 'submit'

  $(form).append(signature, button)
  $('#removalContainer').empty()
  $('#removalContainer').append(form)

window.ShowOldEluates = (cb) ->
    d = new Date()
    day = d.getDate()
    month = d.getMonth()+1
    year = d.getFullYear()
    date = day+'.'+month+'.'+year

    $('#radiomedicine_eluate_id > option').each ->
      elemDate = ($(this).text().split(':')[1]).trim()
      if(elemDate != date)
        $(this).toggle()


