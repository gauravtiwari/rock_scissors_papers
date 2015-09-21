var ENTER_KEY_CODE = 13;

var MessageForm = React.createClass({

  getInitialState: function() {
    return {text: ''};
  },

  render: function() {
    return (
      <form ref="message_form" className="form-horizontal p-l-15 p-r-15 p-t-20" role="form">
        <div className="form-group">
          <textarea
          className="form-control"
          name="message[body]"
          value={this.state.text}
          onChange={this._onChange}
          onKeyDown={this._onKeyDown} />
        </div>
      </form>
    );
  },

  _onChange: function(event, value) {
    this.setState({text: event.target.value});
  },

  _onKeyDown: function(event) {
    if (event.keyCode === ENTER_KEY_CODE) {
      event.preventDefault();
      var text = this.state.text.trim();
      var formData = $( this.refs.message_form.getDOMNode() ).serialize();
      if (text) {
        this.props.sendMessage(formData, text);
      }
      this.setState({text: ''});
    }
  }

});
