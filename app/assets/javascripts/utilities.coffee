$(document).on 'ready page:change', (event) ->
  $.each flashMessages, (key, value) ->
    $.snackbar
      content: value
      style: key
      timeout: 10000
    return
  return
