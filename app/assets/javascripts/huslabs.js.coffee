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
    button.innerText = 'Kirjaa'
    button.type = 'submit'
    select.name = 'result'
    select.innerHTML = "<option value='OK'>OK</option><option value='Ei OK'>Ei OK</option>"

    $(form).append(input,select, button)
    $('#qualityCheckContainer').empty()
    $('#qualityCheckContainer').append(form)


