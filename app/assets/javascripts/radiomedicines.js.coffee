window.add_generator = (e) ->
  choice = $('#post_generator_id').get(0)
  amount = $('#generator_amount').get(0).value
  createAddition(choice, amount, "generators")

window.add_other = (e) ->
  choice = $('#post_other_id').get(0)
  amount = $('#other_amount').get(0).value
  createAddition(choice, amount, "others")

window.add_kit = (e) ->
  choice = $('#post_kit_id').get(0)
  amount = $('#other_amount').get(0).value
  createAddition(choice, amount, "kits")

window.add_eluate = (e) ->
  choice = $('#post_eluate_id').get(0)
  amount = 1
  createAddition(choice, amount, "eluates")

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
    if option.value == val && option.innerHTML != "Valitse raaka-aine" && amount != ""
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
