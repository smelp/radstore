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
  $('#removalContainer'+targetID).empty()
  $('#removalContainer'+targetID).append(form)

window.ShowOldEluates = (cb) ->
    d = new Date()
    date = new Date(d.getFullYear(), d.getMonth(), d.getDate())

    $('#radiomedicine_eluate_id > option').each ->
      if( $(this).text() != '')
        elemDate = ($(this).text().split(' ')[2]).trim()
        from = elemDate.split(".");
        f = new Date(from[2], from[1] - 1, from[0])

        if(f.toDateString() != date.toDateString())
          $(this).toggle()

    $('#radiomedicine_eluate_id').val($('#radiomedicine_eluate_id option:first').val())

window.submit_radmed = (event) ->
  if ($("#product_kits tr").length <= 1)
    alert("Muista kirjata kitti!")
  else if ($("#radiomedicine_eluate_id").val() == '')
    alert("Muista valita eluaatti!")
  else
    $("#radmedsubmit").click()
