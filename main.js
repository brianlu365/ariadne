var five = require("johnny-five"), 
  board = new five.Board();

board.on("ready",function(){
  this.pinMode(8, five.Pin.INPUT);

  this.loop(500, function() {
    this.digitalRead(8, function(){
      console.log(value);
    })
  })
});
