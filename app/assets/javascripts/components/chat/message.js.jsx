var Message = React.createClass({

  render: function() {
    if($('meta[name=current-player]').attr('id') === this.props.message.sender_id.toString()) {
      var classes = "pull-left";
    } else {
      var classes = "pull-right";
    }

    return (
      <li>
        <p className={classes}>
          <span className="semi-bold">{this.props.message.sender_name}: </span>
          <span dangerouslySetInnerHTML={{__html: this.props.message.body}}></span>
        </p>
      </li>
    );
  }

});
