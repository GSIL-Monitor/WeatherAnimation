<canvas id="mh-scene-thunderstormday"></canvas>
<canvas id="mh-scene-thunderstormday-comp1"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.thunderstormday',
		{
			sceneId:'mh-scene-thunderstormday',
			sceneEle:{
				components:[
					/*后层云朵*/
					{
						src:'http://p5.qhimg.com/t016ac68167f6f78a91.png',
						shape:{
							width:265,
							height:100
						},
						position:{
							left:275,
							top:0
						}
					},
					/*中层云朵*/
					{
						src:'http://p6.qhimg.com/t01b7f04ad96d915f61.png',
						shape:{
							width:250,
							height:86
						},
						position:{
							left:290,
							top:0
						}
					},
					/*前层云朵*/
					{
						src:'http://p8.qhimg.com/t012992dc02d88f6134.png',
						shape:{
							width:221,
							height:67
						},
						position:{
							left:319,
							top:0
						}
					},
					/*闪电*/
					{
						position:{
							left:100,
							top:0
						},
						shape:{
							width:0,
							height:0,
							color:{
								r:'252',
								g:'255',
								b:'206',
								a:'.8'
							}
						},
						canvas:{
							id:'mh-scene-thunderstormday-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							eles:[],
							maxNum:1,
							numRandom:true,
							deadHeight:260,
							timeintval:30,
							boltFlashDuration:0.25,
							boltFadeDuration:0.25,
							bolts:[]
						},
						init: function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadHeight;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var ctx = _this.canvas.ctx;
							var shapeWidth = _this.shape.width;
							var shapeHeight = _this.shape.height;
							_this.Bolt = function(){
								this.width = 540;
								this.deadheight = 260;
								this.bolts = [];
								this.color = _this.shape.color;
								this.flashOpacity = 0.0;
								this.lastFrame = (new Date).getTime();
								this.totalBoltDuration = _this.animation.boltFlashDuration + _this.animation.boltFadeDuration;
								this.boltFlashDuration =  _this.animation.boltFlashDuration;
								this.boltFadeDuration = _this.animation.boltFadeDuration;
							};
							_this.Bolt.prototype.launchBolt = function(x, y, length, direction) {
								var boltCanvas, boltContext;
								this.flashOpacity = 0.15 + Math.random() * 0.2;
								boltCanvas = document.createElement("canvas");
								boltCanvas.width = this.width;
								boltCanvas.height = this.deadheight;
								boltContext = boltCanvas.getContextHidpi("2d");
								this.bolts.push({
								  canvas: boltCanvas,
								  duration: 0.0
								});
								this.recursiveLaunchBolt(x, y, length, direction, boltContext);
							};
							_this.Bolt.prototype.recursiveLaunchBolt = function(x, y, length, direction, boltContext) {
								var _this = this;
								var boltInterval, originalDirection;
								originalDirection = direction;
								return boltInterval = setInterval((function() {
									var alpha, i, x1, y1;
									if (length <= 0) {
										clearInterval(boltInterval);
										return;
									}
									i = 0;
									while (i++ < 45 && length > 0) {
										x1 = Math.floor(x);
										y1 = Math.floor(y);
										x += Math.cos(direction);
										y -= Math.sin(direction);
										length--;
										if (x1 !== Math.floor(x) || y1 !== Math.floor(y)) {
											alpha = Math.min(1.0, length / 350.0);
											boltContext.fillStyle = "rgba("+_this.color.r+","+_this.color.g+","+_this.color.b+"," + alpha + ")";
											boltContext.fillRect(x1, y1, 2, 2);
											direction = originalDirection + (-Math.PI / 8.0 + Math.random() * (Math.PI / 4.0));
											if (Math.random() > 0.98) {
											  _this.recursiveLaunchBolt(x1, y1, length * (0.3 + Math.random() * 0.4), originalDirection + (-Math.PI / 6.0 + Math.random() * (Math.PI / 3.0)), boltContext);
											} else if (Math.random() > 0.95) {
											  _this.recursiveLaunchBolt(x1, y1, length, originalDirection + (-Math.PI / 6.0 + Math.random() * (Math.PI / 3.0)), boltContext);
											  length = 0;
											}
										};
									};
									return void 0;
								}), 10);
							};
							_this.Bolt.prototype.setCanvasSize = function() {
								var bolt, j, len;
								var bolts = this.bolts;
								for (j = 0, len = bolts.length; j < len; j++) {
								  bolt = bolts[j];
								  bolt.canvas.width = width;
								  bolt.canvas.height = deadheight;
								}
								this.shapeWidth = Math.ceil(width);
								this.shapeHeight = Math.ceil(deadheight);
							};
							_this.Bolt.prototype.circul = function() {
								var bolt, elapsed, frame, i, j, len, length, x, y;
								frame = (new Date).getTime();
								/*调整闪电消失速度*/
								elapsed = (frame - this.lastFrame) / 1500.0;
								this.lastFrame = frame;
								ctx.clearRect(0,0,width,height);
								if (Math.random() > 0.96) {
									x = Math.floor(-10.0 + Math.random() * (this.shapeWidth + 20.0));
									y = Math.floor(5.0 + Math.random() * (this.shapeHeight / 3.0));
									length = Math.floor(this.shapeHeight / 2.0 + Math.random() * this.shapeHeight);
									this.launchBolt(x, y, length, Math.PI * 3.0 / 2.0);
								};
								/*反白效果控制*/
								if (this.flashOpacity > 0.0) {
									ctx.fillStyle = "rgba(255, 255, 255, " + this.flashOpacity + ")";
									ctx.fillRect(0.0, 0.0, width, deadheight);
									this.flashOpacity = Math.max(0.0, this.flashOpacity - 2.0 * elapsed);
								};
								var bolts = this.bolts;
							    for (i = j = 0, len = bolts.length; j < len; i = ++j) {
							    	bolt = bolts[i];
									bolt.duration += elapsed;
									
									if (bolt.duration >= this.totalBoltDuration) {
										this.bolts.splice(i, 1);
										i--;
										return;
									}
									ctx.globalAlpha = Math.max(0.0, Math.min(1.0,this.totalBoltDuration - bolt.duration) / this.boltFadeDuration);
									ctx.drawImage(bolt.canvas, 0, -76, width, height);
								};
							};
							var thunder = new this.Bolt();
							thunder.setCanvasSize();
							this.animation.ele = thunder;
							
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadHeight;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var shapeWidth = _this.shape.width;
							var shapeHeight = _this.shape.height;
							var ele = _this.animation.ele;
							ele.circul();
						}
					}
				]
			}
		}
	);
</script>