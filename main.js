var five = require("johnny-five"), 
  board = new five.Board();

board.on("ready",function(){
  this.repl.inject({
    led: new five.Led(13)
  });
});
