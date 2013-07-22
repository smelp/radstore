window.add_generator = (e) ->
  choice = $('#post_generator_id').get(0)
  amount = $('#generator_amount').get(0).value
  createAddition(choice, amount, "generators")
  $('#generator_amount').get(0).value = ''

window.add_other = (e) ->
  choice = $('#post_other_id').get(0)
  amount = $('#other_amount').get(0).value
  createAddition(choice, amount, "others")
  $('#other_amount').get(0).value = ''

window.add_kit = (e) ->
  choice = $('#post_kit_id').get(0)
  amount = $('#kit_amount').get(0).value
  createAddition(choice, amount, "kits")
  $('#kit_amount').get(0).value = ''

window.add_storagelocation = (e) ->
  choice = $('#post_storagelocation_id').get(0)
  amount = $('#storagelocation_amount').get(0).value
  createAddition(choice, amount, "storagelocations")

createAddition = (choice, amount, typeString) ->
  val = choice.value
  div = document.createElement('div')
  div.setAttribute("id", val + "_hidden")
  elem = document.createElement('input')


  tr_elem = document.createElement('tr')
  tr_elem.id = val
  td_elem = document.createElement('td')

  td_elem_remove = document.createElement('td')
  a_elem = document.createElement('a')
  i_elem = document.createElement('i')
  i_elem.setAttribute("class", "icon-remove")

  for option in choice
    if option.value == val && option.innerHTML.indexOf('Valitse') != 1 && amount != ""
      td_elem.innerHTML = option.innerHTML + ", " + amount + "</br>"
      a_elem.href = "#"
      a_elem.setAttribute("class","nav-link")
      a_elem.setAttribute("onclick","remove_table_element(#{val})")

      other = [val, amount]
      elem.type = "hidden"
      elem.name = "new_"+typeString+"[" + other + "]"
      elem.value = amount

      $('#product_'+typeString).append tr_elem
      $('#product_'+typeString).append div
      $(div).append elem
      $(tr_elem).append td_elem
      $(tr_elem).append td_elem_remove
      $(td_elem_remove).append a_elem
      $(a_elem).append i_elem

  console.log div
  console.log amount

callEluateCal = () ->
  $('#datetimepicker-eluate').datetimepicker
    language: 'fi'
    
setTimeout(callEluateCal, 200)