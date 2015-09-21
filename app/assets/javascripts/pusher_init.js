var pusher = new Pusher($('meta[name=pusher]').attr('key'));

if($('meta[name=current-player]').attr('id') && $('meta[name=current-player]').attr('name')) {
  var channel = pusher.subscribe('private-player-' + $('meta[name=current-player]').attr('id'))
  var presence_channel = pusher.subscribe('presence-player-' + $('meta[name=current-player]').attr('id'))
}