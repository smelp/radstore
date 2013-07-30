window.add_user_to_firm = (e) ->
  choice = $('#post_user_id').get(0)
  val = choice.value
  elem = document.createElement('input')
  list_elem = document.createElement('span')
  list_elem.innerHTML = $(choice).children('[value=' + val + ']').text()
  elem.type = "hidden"
  elem.name = "users[" + val + "]"
  elem.value = val
  $('#firm_users').append elem
  $('#firm_users').append list_elem
