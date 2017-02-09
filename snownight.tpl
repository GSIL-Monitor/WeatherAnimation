<canvas id="mh-scene-snownight"></canvas>
<canvas id="mh-scene-snownight-comp1"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.snownight',
		{
			sceneId:'mh-scene-snownight',
			sceneEle:{
				components:[
					/*moon*/
					{
						src:'http://p5.qhimg.com/t010b70f62f38f9170c.png',
						shape:{
							width:83,
							height:83
						},
						position:{
							left:300,
							top:20
						}
					},
					/*下雪*/
					{
						canvas:{
							id: 'mh-scene-snownight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							shape:'circle',
							rect: {
								random:0,
								width:.1,
								height:55,
							},
							circle: {
								random:1,
								r:2
							},
							rain:{
								speed:10,
								deadheight:210,
								drop_time: 0,
								drop_delay: 180,
								color: {
									r: '255',
									g: '255',
									b: '255',
									a: '1'
								},
								color_random: 1,
								rain_color: null,
								rain_color_clear: null,
								rain: [],
								rain_pool: [],
								drops: [],
								drop_pool: [],
								time_diff:15,
								wind: 3,
								direction_random:1
							},
							timeintval:20
						},
						init: function(){
							var _this = this;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var ctx = _this.canvas.ctx;
							var c = _this.animation.rain.color;
							var drop_time = _this.animation.rain.drop_time;
							var drop_delay = _this.animation.rain.drop_delay;
							var rain_pool = _this.animation.rain.rain_pool;
							var rain = _this.animation.rain.rain;
							var drops = _this.animation.rain.drops;
							_this.animation.rain.rain_color = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',' + c.a + ')';
							_this.animation.rain.rain_color_clear = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',0)';
							for (var i = rain.length - 1; i >= 0; i--) {
									rain.pop().recycle();
							}
							
							/*Rain definition*/
							_this.Rain = function (){
								this.x = 0;
								this.y = 0;
								this.z = 0;
								this.speed = _this.animation.rain.speed;
							};
							_this.Rain.prototype.init = function() {
								this.y = Math.random();
								this.z = Math.random() * 0.5 + 0.5;
								if(_this.animation.rain.color_random){
									var a = Math.random();
									_this.animation.rain.color.a = a;
								}
								this.color = 'rgba('+_this.animation.rain.color.r +','+_this.animation.rain.color.g+','+_this.animation.rain.color.b+','+_this.animation.rain.color.a+')';
								if(_this.animation.shape == 'rect'){
									var width = _this.animation.rect.width;
									var height = _this.animation.rect.height;
									if(_this.animation.rect.random){
										width += Math.random() * width;
										height += Math.random() * height;
									}
									this.width = width;
									this.height = height;
								}else if(_this.animation.shape == 'circle'){
									var r = _this.animation.circle.r;
									if(_this.animation.circle.random){
										r += r * Math.random();
									}
									this.r = r;
								}
								this.wind = _this.animation.rain.wind;
							};
							_this.Rain.prototype.recycle = function() {
								_this.animation.rain.rain_pool.push(this);
							};
						},
						animate: function(time){
							var _this = this;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var ctx = _this.canvas.ctx;
							var c = _this.animation.rain.color;
							var drop_time = _this.animation.rain.drop_time;
							var drop_delay = _this.animation.rain.drop_delay;
							var rain_pool = _this.animation.rain.rain_pool;
							var rain = _this.animation.rain.rain;
							var drops = _this.animation.drops;
							var speed = _this.animation.rain.speed;
							var multiplier = speed * 0.03;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var Rain = _this.Rain;
							var rain_height = _this.animation.rect.height;
							var rain_width = _this.animation.rect.width;
							var arc_r = _this.animation.circle.r;
							var dead_height = _this.animation.rain.deadheight;
							/*form particals according to time*/
							drop_time += _this.animation.timeintval;
							while (drop_time > drop_delay) {
								drop_time -= drop_delay;
								var new_rain = rain_pool.pop() || new Rain();
								new_rain.init();
								/*随机下落方向*/
								if(_this.animation.rain.direction_random){
									var wind = new_rain.wind;
										wind += (-1) * wind * 2;
									new_rain.wind = parseInt(wind,10);
									_this.animation.rain.wind = parseInt(wind,10);
								}
								var wind_expand = Math.abs(dead_height / new_rain.speed * new_rain.wind);
								var spawn_x = Math.random() * (width + wind_expand);
								if (new_rain.wind > 0) {
									spawn_x -= wind_expand;
								}
								new_rain.x = spawn_x;
								rain.push(new_rain);
							}
							_this.animation.rain.drop_time = drop_time;
							for (var i = rain.length - 1; i >= 0; i--) {
								var r = rain[i];
								r.y += r.speed * r.z * multiplier;
								r.x += r.z * r.wind * multiplier;
								/*remove rain when out of view*/
								if (r.y > dead_height + Rain.height * r.z || (r.wind < 0 && r.x < r.wind) || (r.wind > 0 && r.x > width + r.wind)) {
									r.recycle();
									rain.splice(i, 1);
								}
							}
							offctx.clearRect(0, 0, width, height);
							offctx.beginPath();
							for (var i = rain.length - 1; i >= 0; i--) {
								var r = rain[i];
								var real_x = r.x;
								var real_y = r.y;
								if(real_y <= dead_height){
									offctx.moveTo(real_x, real_y);
									if(_this.animation.shape == 'rect'){
										offctx.lineTo(real_x - r.wind *r.z * 1.5, real_y - rain_height * r.z);
										offctx.lineWidth = r.width;
										offctx.strokeStyle = r.color;
										offctx.stroke();
									}else if(_this.animation.shape == 'circle'){
										offctx.arc(real_x,real_y,r.r,0,2*Math.PI);
										offctx.fillStyle = r.color;
										offctx.fill();
									}
								}
								
							}
							
							ctx.clearRect(0,0,width,height);
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
				]
			}
		}
	);
</script>