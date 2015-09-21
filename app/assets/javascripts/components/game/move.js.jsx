var Move = React.createClass({

  render: function() {
    if(this.props.move.played) {
        var move_class = "fa " +  "fa-hand-" + this.props.move.choice + "-o";
        if(this.props.move.draw) {
          var result = "Draw";
        } else {
          if(this.props.move.completed) {
            var result = this.props.move.result;
          } else {
            var result = "Played";
          }
        }
      } else {
        var result = "Pending";
      }

    return (
      <p className="fs-22">
        <span className={move_class}></span> {result}
      </p>
    );
  }

});