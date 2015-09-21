var Moves = React.createClass({

  render: function() {
    var movesList = _.map(this.props.moves, function(move){
      return <Move move={move} key={Math.random()} />
    });

    return (
      <div className="moves text-center m-t-20">
        {movesList}
      </div>
    );
  }

});