# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.revealQualityCheckForm = (event,id) ->
    event.preventDefault()
    form = document.createElement('form')
    input = document.createElement('input')
    button = document.createElement('button')
    select = document.createElement('select')

    form.action = '/batches/qualityCheck/'+id
    form.method = 'post'
    input.name = 'signature'
    input.type = 'text'
    input.placeholder = 'Nimikirjaimet'
    button.innerText = 'Kirjaa'
    button.type = 'submit'
    select.name = 'result'
    select.innerHTML = "<option value='OK'>OK</option><option value='Ei OK'>Ei OK</option>"

    $(form).append(input,select, button)
    $('#qualityCheckContainer').empty()
    $('#qualityCheckContainer').append(form)

window.revealRemovalForm = (event, batchID, storageIDs) ->
  event.preventDefault()
  form = document.createElement('form')
  signature = document.createElement('input')
  batchID = document.createElement('input')
  date = document.createElement('input')
  amount = document.createElement('input')
  button = document.createElement('button')
  select = document.createElement('select')

  form.action = '/batches/remove_from/'
  form.method = 'post'

  signature.name = 'signature'
  signature.type = 'text'
  signature.placeholder = 'Nimikirjaimet'

  amount.name = 'amount'
  amount.type = 'number'
  amount.placeholder = 'Määrä'

  button.innerText = 'Poista'
  button.type = 'submit'
  select.name = 'target'
  for temp in storageIDs
    data = temp.split(';')
    select.options.add(new Option(data[0], data[1]))


  $(form).append(signature,amount,select, button)
  $('#removalContainer').empty()
  $('#removalContainer').append(form)


window.calcActivity = (created, volume, activity, decayConst) ->
  timeDiff = ((new Date().getTime() - Date.parse(created))  / 1000 / 60 / 60)
  actNow = activity*Math.pow(2.718282,-decayConst*timeDiff)
  concetrat = actNow / volume
  console.log concetrat


