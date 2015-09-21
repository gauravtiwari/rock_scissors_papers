var Messages = React.createClass({

  getInitialState: function() {
    var data = JSON.parse(this.props.messages)
    return {
      messages: data
    }
  },

  componentDidMount: function() {
    if(this.isMounted()){
      this.subscribeMessage();
      this._scrollToBottom();
    }
  },

  sendMessage: function(formData, text){
    $.post(this.props.path, formData, function(data, textStatus, xhr) {
      var new_messages = this.state.messages.concat(data.message)
      this.setState({messages: new_messages});
    }.bind(this), "json");
  },

  subscribeMessage: function(formData, text){
    if(_.findWhere(pusher.allChannels(), {name: this.props.game_channel}) === undefined) {
      var game_channel = pusher.subscribe(this.props.game_channel);
      if(game_channel) {
        game_channel.bind('new_message', function(data){
          var response = JSON.parse(data.data);
          var message = response.message;
          if(presence_channel.members.me.id != message.sender_id) {
            var new_messages = this.state.messages.concat(message)
            this.setState({messages: new_messages});
          }
        }.bind(this));
      }
    }
  },

  render: function() {
    var messagesList = _.map(this.state.messages, function(message){
      return <Message message={message} key={message.id} />
    });

    return (
      <div className="col-sm-3">
        <h3>Chat</h3>
        <ul ref="messageList" className="no-style no-padding m-t-20 messages_list">
          {messagesList}
        </ul>
        <MessageForm sendMessage={this.sendMessage} />
      </div>
    );
  },

  componentDidUpdate: function() {
    this._scrollToBottom();
  },

  _scrollToBottom: function() {
    var ul = this.refs.messageList.getDOMNode();
    ul.scrollTop = ul.scrollHeight;
  },

});
