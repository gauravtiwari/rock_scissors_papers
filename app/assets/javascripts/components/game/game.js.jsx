var Game = React.createClass({

  getInitialState: function() {
    var data = JSON.parse(this.props.play);
    return {
      play: data.play,
      player_moves: data.play.player_moves,
      opponent_moves: data.play.opponent_moves,
      player_score: data.play.player_score,
      isOpponent: data.play.is_opponent,
      opponent_score: data.play.opponent_score,
      move_completed: true,
      opponent_status: data.play.opponent_status,
      player_status: data.play.player_status,
      game_completed: data.play.game_completed
    }
  },

  componentDidMount: function() {
    if(this.isMounted()) {
      this.syncMoves();
    }
  },

  syncMoves: function() {
    if(_.findWhere(pusher.allChannels(), {name: this.props.game_channel}) === undefined) {
      var game_channel = pusher.subscribe(this.props.game_channel);
        game_channel.bind('sync_moves', function(data){
        var response = JSON.parse(data.data);
        if(response.move.player_status != undefined) {
          var player_status = response.move.player_status;
          var opponent_status = response.move.opponent_status
        }
         this.setState({
           move_completed: response.move.completed,
           player_score: response.move.player_score,
           opponent_score: response.move.opponent_score,
           opponent_status: opponent_status,
           player_status: player_status,
           game_completed: response.move.game_completed,
           player_moves: response.move.player_moves,
           opponent_moves: response.move.opponent_moves
         });
        }.bind(this));
    }
  },

  makeMove: function(choice) {
    var data = this.state.isOpponent? {move: {opponent_choice: choice}} : {move: {player_choice: choice}}
    $.post(this.props.path, data, function(data, textStatus, xhr) {
      if(data.error) {
        $.snackbar({content: data.error, style: "error", timeout: 5000});
      } else {
        this.setState({
          move_completed: data.move.completed,
          player_score: data.move.player_score,
          opponent_score: data.move.opponent_score,
          game_completed: data.move.game_completed,
          player_moves: data.move.player_moves,
          opponent_moves: data.move.opponent_moves
        });
      }
    }.bind(this), "json");
  },

  render: function() {
    if(this.state.game_completed) {
      var game_moves = <h3 className="text-center text-success">Game completed </h3>
    } else {
      var game_moves =  <div className="text-center m-t-50 p-r-25">
             <div className="inline m-r-25">
               <h4>Choose your move: </h4>
             </div>
             <div className="inline m-r-10">
               <a className="fa fa-hand-rock-o fs-22" onClick={this.makeMove.bind(this, "rock")}></a>
             </div>
             <div className="inline m-r-10">
               <a className="fa fa-hand-lizard-o fs-22" onClick={this.makeMove.bind(this, "lizard")}></a>
             </div>
             <div className="inline m-r-10">
               <a className="fa fa-hand-spock-o fs-22" onClick={this.makeMove.bind(this, "spock")}></a>
             </div>
             <div className="inline m-r-10">
               <a className="fa fa-hand-paper-o fs-22" onClick={this.makeMove.bind(this, "paper")}></a>
             </div>
             <div className="inline m-r-10">
               <a className="fa fa-hand-scissors-o fs-22" onClick={this.makeMove.bind(this, "scissors")}></a>
            </div>
          </div>;
    }
    return (
      <div className="col-sm-offset-1 new_play col-sm-8" id="game">
        <div className="text-center p-b-20 disabled">
          <h1 className="fs-22 label label-danger">Game on</h1>
        </div>

         <div className="col-sm-5 m-t-10 text-center">
           <span className="placeholder thumbnail-wrapper d48 circular m-r-10">
             {this.state.play.player_badge}
           </span>
           <span className="name cleafix displayblock">
             {this.state.play.player_name}
             <span className="fa fa-circle m-l-5 text-success" data-toggle="tooltip" title="online"> {this.state.player_status} </span>
           </span>
           <Moves moves={this.state.player_moves} isOpponent={this.state.isOpponent} />
         </div>
         <div className="col-sm-2 text-center fs-22 m-t-20">
          <div> vs
            <span className="displayblock small">{this.state.player_score}:{this.state.opponent_score}</span>
          </div>
         </div>

         <div className="col-sm-5 m-t-10 text-center">
           <span className="placeholder thumbnail-wrapper d48 circular">
             {this.state.play.opponent_badge}
           </span>
           <span className="name displayblock">
             {this.state.play.opponent_name}
             <span className="fa fa-circle m-l-5 text-danger" data-toggle="tooltip" title="offline"> {this.state.opponent_status} </span>
           </span>
           <Moves moves={this.state.opponent_moves}  />
         </div>

          <div className="clearfix"></div>
          {game_moves}
      </div>
    );
  }

});
