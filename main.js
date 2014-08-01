var five = require("johnny-five"), 
  board = new five.Board({
    port: "/dev/ttyACM0"
  });

board.on("ready",function(){
  this.repl.inject({
    led: new five.Led(13);
  });
});
