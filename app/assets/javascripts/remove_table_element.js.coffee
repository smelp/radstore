window.remove_table_element = (id) ->
  choice = $("##{id}").get(0);
  hidden_choice = $("##{id}_hidden").get(0);
  choice.parentElement.removeChild(choice);
  if hidden_choice
    hidden_choice.parentElement.removeChild(hidden_choice);
  sumTotal()