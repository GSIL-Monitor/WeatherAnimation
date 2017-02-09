{%*<canvas id="mh-scene-sunnight"></canvas>
<canvas id="mh-scene-sunnight-comp1"></canvas>
<canvas id="mh-scene-sunnight-comp2"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.sunnight',
		{
			sceneId:'mh-scene-sunnight',
			sceneEle:{
				components:[
					/*star*/
					{
						shape:{
							num:30,
							color: {
								r: '255',
								g: '255',
								b: '200',
							},
							showdowColor:'#ffff33',
							showdowBlur:5,
							minsideLength:1
						},
						canvas:{
							id:'mh-scene-sunnight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							deadheight:120,
							timeintval:20,
							/*星星展示上下高度容错*/
							errHeight:3
						},
						init: function(){
							var _this = this;
							var ctx = _this.canvas.ctx;
							var star_pool = [];
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadheight;
							var numStars = _this.shape.num;
							var stars = [];
							var errHeight = _this.animation.errHeight;
							_this.Star = function(x, y, length, opacity) {
								this.x = parseInt(x);
								this.y = parseInt(y);
								this.length = parseInt(length);
								this.opacity = opacity;
								this.factor = 1;
								this.increment = Math.random() * .03;
							};
							for(var i = 0; i < numStars; i++) {
								var x = Math.round(Math.random() * width);
								var y = Math.round(Math.random() * deadheight);
								/*容错空间*/
								if(deadheight - y < errHeight || y < errHeight){
									--i;
									continue;
								}
								var length = _this.shape.minsideLength + Math.random() * 2;
								var opacity = Math.random();
								var star = new _this.Star(x, y, length, opacity);
								stars.push(star);
							};
							_this.stars = stars;
						},
						animate: function(){
							var _this = this;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var posY = _this.animation.posY;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadheight;
							var stars = _this.stars;
							offctx.save();
							offctx.clearRect(0,0,width,height);
							for(var j=0; j<stars.length; j++){
								var s = stars[j];
								offctx.save();
								offctx.translate(s.x, s.y);
								if(s.opacity > 1) {
									s.factor = -1;
								}
								else if(s.opacity <= 0) {
									s.factor = 1;
									s.x = Math.round(Math.random() * width);
									s.y = Math.round(Math.random() * deadheight);
								}
								s.opacity += s.increment * s.factor;
								offctx.beginPath()
								for (var i = 5; i--;) {
									offctx.lineTo(0, s.length);
									offctx.translate(0, s.length);
									offctx.rotate((Math.PI * 2 / 10));
									offctx.lineTo(0, - s.length);
									offctx.translate(0, - s.length);
									offctx.rotate(-(Math.PI * 6 / 10));
								}
								offctx.lineTo(0, s.length);
								offctx.closePath();
								offctx.fillStyle = "rgba("+_this.shape.color.r+","+_this.shape.color.g+","+_this.shape.color.b+"," + s.opacity + ")";
								offctx.shadowBlur = _this.shape.color.shadowBlur;
								offctx.shadowColor = _this.shape.color.shadowColor;
								offctx.fill();
								offctx.restore();
							}
							ctx.clearRect(0,0,width,height);
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					},
					/*moon*/
					{
						src:'http://p7.qhimg.com/t010698e6a3f4dc5ee5.png',
						shape:{
							width:83,
							height:83
						},
						position:{
							left:320,
							top:30
						}
					},
					/*meteor*/
					{
						canvas:{
							id: 'mh-scene-sunnight-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							shape:'rect',
							rect: {
								width:.2,
								height:35,
							},
							circle: {
								r:5
							},
							rain:{
								speed:25,
								deadheight:150,
								drop_time: 0,
								drop_delay: 750,
								wind: -30,
								color: {
									r: '255',
									g: '255',
									b: '255',
									a: '1'
								},
								rain_color: null,
								rain_color_clear: null,
								rain: [],
								rain_pool: [],
								drops: [],
								drop_pool: [],
								splashed:false,
								time_diff:15
							},
							splash:{
								w:30,
								h:10,
								vw:3,
								vh:1,
							},
							timeintval:30
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
							for (var i = drops.length - 1; i >= 0; i--) {
									drops.pop().recycle();
							}
							
							_this.Rain = function (){
								this.x = 260;
								this.y = 0;
								this.z = 0;
								this.speed = _this.animation.rain.speed;
								this.splashed = _this.animation.rain.splashed;
							};
							_this.Rain.width = _this.animation.rect.width;
							_this.Rain.height = _this.animation.rect.height;
							_this.Rain.prototype.init = function() {
								this.y = Math.random() * -100;
								this.z = Math.random() * 0.5 + 0.5;
								this.splashed = _this.animation.rain.splashed;
								this.splash.a = _this.animation.splash.a;
								this.splash.w = _this.animation.splash.w;
								this.splash.h = _this.animation.splash.h;
								this.splash.vw = _this.animation.splash.vw;
								this.splash.vh = _this.animation.splash.vh;
							};
							_this.Rain.prototype.recycle = function() {
								_this.animation.rain.rain_pool.push(this);
							};
							/*recycle rain particle and create a burst of droplets*/
							_this.Rain.prototype.splash = function() {
								if (this.splashed) {
									this.splash.w += this.splash.vw;
									this.splash.h += this.splash.vh;
								}
							};
							_this.Drop = function() {
								this.x = 0;
								this.y = 0;
								this.radius = Math.round(Math.random() * 2 + 1);
								this.speed_x = 0;
								this.speed_y = 0;
								this.canvas = document.createElement('canvas');
								this.ctx = this.canvas.getContextHidpi('2d');
								
								/*render once and cache*/
								var diameter = this.radius * 2;
								this.canvas.width = diameter;
								this.canvas.height = diameter;

								var grd = this.ctx.createRadialGradient(this.radius, this.radius , 1, this.radius, this.radius, this.radius);
								grd.addColorStop(0, _this.animation.rain.rain_color);
								grd.addColorStop(1, _this.animation.rain.rain_color_clear);
								this.ctx.fillStyle = grd;
								this.ctx.fillRect(0, 0, diameter, diameter);
							}

							_this.Drop.max_speed = 2;

							_this.Drop.prototype.init = function(x) {
								this.x = x;
								this.y = _this.canvas.height;
								var angle = Math.random() * Math.PI - (Math.PI * 0.5);
								var speed = Math.random() * _this.Drop.max_speed;
								this.speed_x = Math.sin(angle) * speed;
								this.speed_y = -Math.cos(angle) * speed;
							}
							_this.Drop.prototype.recycle = function() {
								_this.animation.rain.drop_pool.push(this);
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
							var Drop = _this.Drop;
							var wind = _this.animation.rain.wind;
							var rain_height = _this.animation.rect.height;
							var rain_width = _this.animation.rect.width;
							var arc_r = _this.animation.circle.r;
							var dead_height = _this.animation.rain.deadheight;
							_this.animation.rain.rain_color = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',' + c.a + ')';
							_this.animation.rain.rain_color_clear = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',0)';
							
							drop_time += _this.animation.timeintval + _this.animation.rain.time_diff;
							while (drop_time > drop_delay) {
								drop_time -= drop_delay;
								var new_rain = rain_pool.pop() || new Rain();
								new_rain.init();
								var wind_expand = Math.abs(height / new_rain.speed * wind); 
								var spawn_x = Math.random() * (width + wind_expand);
								if (wind > 0) spawn_x -= wind_expand;
								new_rain.x = spawn_x;
								rain.push(new_rain);
							}
							_this.animation.rain.drop_time = drop_time;
							/*rain physics*/
							for (var i = rain.length - 1; i >= 0; i--) {
								var r = rain[i];
								r.y += r.speed * r.z * multiplier;
								r.x += r.z * wind * multiplier;
								if (r.y > dead_height + Rain.height * r.z || (wind < 0 && r.x < wind) || (wind > 0 && r.x > width + wind)) {
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
								if (real_y > dead_height && _this.animation.rain.splashed) {
									r.splash();
									offctx.moveTo(r.x, r.y - r.splash.h /2);
									offctx.bezierCurveTo(
										r.x + r.splash.w / 2, 
										r.y - r.splash.h / 2,
										r.x + r.splash.w / 2, 
										r.y + r.splash.h / 2,
										r.x, 
										r.y + r.splash.h / 2);

									offctx.bezierCurveTo(
										r.x - r.splash.w / 2, 
										r.y + r.splash.h / 2,
										r.x - r.splash.w / 2, 
										r.y - r.splash.h / 2,
										r.x, 
										r.y - r.splash.h / 2);
									offctx.lineWidth = .5;
									offctx.strokeStyle = '#ffffff';
									offctx.stroke();
									offctx.closePath();
									r.splash();
								}else if(real_y <= dead_height){
									offctx.moveTo(real_x, real_y);
									if(_this.animation.shape == 'rect'){
										offctx.lineTo(real_x - wind *r.z * 1.5, real_y - rain_height * r.z);
										offctx.lineWidth = Rain.width;
										offctx.strokeStyle = _this.animation.rain.rain_color;
										offctx.stroke();
									}else if(_this.animation.shape == 'circle'){
										offctx.arc(real_x,real_y,arc_r,0,2*Math.PI);
										offctx.fillStyle = '#ffffff';
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
</script>*%}
<style>
	#mohe-weather .mh-sunnight-moon {
		background: url(http://p7.qhimg.com/t010698e6a3f4dc5ee5.png) no-repeat;
		width: 83px;
		height: 83px;
		position: absolute;
		background-size: contain;
		left: 300px;
		top: 20px;
		z-index:10;
	}
	#mohe-weather .mh-sunnight-moon:hover{
		animation: mh-weather-cloudday-swing 5s 1 linear;
	}
</style>
<div class="mh-dom-wraper">
	<div class="mh-sunnight-moon"></div>
</div>
<canvas id="mh-scene-sunnight"></canvas>
<canvas id="mh-scene-sunnight-comp1"></canvas>
<canvas id="mh-scene-sunnight-comp2"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.sunnight',
		{
			sceneId:'mh-scene-sunnight',
			sceneEle:{
				components:[
					/*star*/
					{
						shape:{
							num:30,
							color: {
								r: '255',
								g: '255',
								b: '200',
							},
							showdowColor:'#ffff33',
							showdowBlur:5,
							minsideLength:1
						},
						canvas:{
							id:'mh-scene-sunnight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							deadheight:120,
							timeintval:20,
							/*星星展示上下高度容错*/
							errHeight:3
						},
						init: function(){
							var _this = this;
							var ctx = _this.canvas.ctx;
							var star_pool = [];
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadheight;
							var numStars = _this.shape.num;
							var stars = [];
							var errHeight = _this.animation.errHeight;
							_this.Star = function(x, y, length, opacity) {
								this.x = parseInt(x);
								this.y = parseInt(y);
								this.length = parseInt(length);
								this.opacity = opacity;
								this.factor = 1;
								this.increment = Math.random() * .03;
							};
							for(var i = 0; i < numStars; i++) {
								var x = Math.round(Math.random() * width);
								var y = Math.round(Math.random() * deadheight);
								/*容错空间*/
								if(deadheight - y < errHeight || y < errHeight){
									--i;
									continue;
								}
								var length = _this.shape.minsideLength + Math.random() * 2;
								var opacity = Math.random();
								var star = new _this.Star(x, y, length, opacity);
								stars.push(star);
							};
							_this.stars = stars;
						},
						animate: function(){
							var _this = this;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var posY = _this.animation.posY;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadheight;
							var stars = _this.stars;
							offctx.save();
							offctx.clearRect(0,0,width,height);
							for(var j=0; j<stars.length; j++){
								var s = stars[j];
								offctx.save();
								offctx.translate(s.x, s.y);
								if(s.opacity > 1) {
									s.factor = -1;
								}
								else if(s.opacity <= 0) {
									s.factor = 1;
									s.x = Math.round(Math.random() * width);
									s.y = Math.round(Math.random() * deadheight);
								}
								s.opacity += s.increment * s.factor;
								offctx.beginPath()
								for (var i = 5; i--;) {
									offctx.lineTo(0, s.length);
									offctx.translate(0, s.length);
									offctx.rotate((Math.PI * 2 / 10));
									offctx.lineTo(0, - s.length);
									offctx.translate(0, - s.length);
									offctx.rotate(-(Math.PI * 6 / 10));
								}
								offctx.lineTo(0, s.length);
								offctx.closePath();
								offctx.fillStyle = "rgba("+_this.shape.color.r+","+_this.shape.color.g+","+_this.shape.color.b+"," + s.opacity + ")";
								offctx.shadowBlur = _this.shape.color.shadowBlur;
								offctx.shadowColor = _this.shape.color.shadowColor;
								offctx.fill();
								offctx.restore();
							}
							ctx.clearRect(0,0,width,height);
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					},
					/*meteor*/
					{
						canvas:{
							id: 'mh-scene-sunnight-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							shape:'rect',
							rect: {
								width:.2,
								height:35,
							},
							circle: {
								r:5
							},
							rain:{
								speed:25,
								deadheight:150,
								drop_time: 0,
								drop_delay: 750,
								wind: -30,
								color: {
									r: '255',
									g: '255',
									b: '255',
									a: '1'
								},
								rain_color: null,
								rain_color_clear: null,
								rain: [],
								rain_pool: [],
								drops: [],
								drop_pool: [],
								splashed:false,
								time_diff:15
							},
							splash:{
								w:30,
								h:10,
								vw:3,
								vh:1,
							},
							timeintval:30
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
							for (var i = drops.length - 1; i >= 0; i--) {
									drops.pop().recycle();
							}
							
							_this.Rain = function (){
								this.x = 260;
								this.y = 0;
								this.z = 0;
								this.speed = _this.animation.rain.speed;
								this.splashed = _this.animation.rain.splashed;
							};
							_this.Rain.width = _this.animation.rect.width;
							_this.Rain.height = _this.animation.rect.height;
							_this.Rain.prototype.init = function() {
								this.y = Math.random() * -100;
								this.z = Math.random() * 0.5 + 0.5;
								this.splashed = _this.animation.rain.splashed;
								this.splash.a = _this.animation.splash.a;
								this.splash.w = _this.animation.splash.w;
								this.splash.h = _this.animation.splash.h;
								this.splash.vw = _this.animation.splash.vw;
								this.splash.vh = _this.animation.splash.vh;
							};
							_this.Rain.prototype.recycle = function() {
								_this.animation.rain.rain_pool.push(this);
							};
							/*recycle rain particle and create a burst of droplets*/
							_this.Rain.prototype.splash = function() {
								if (this.splashed) {
									this.splash.w += this.splash.vw;
									this.splash.h += this.splash.vh;
								}
							};
							_this.Drop = function() {
								this.x = 0;
								this.y = 0;
								this.radius = Math.round(Math.random() * 2 + 1);
								this.speed_x = 0;
								this.speed_y = 0;
								this.canvas = document.createElement('canvas');
								this.ctx = this.canvas.getContextHidpi('2d');
								
								/*render once and cache*/
								var diameter = this.radius * 2;
								this.canvas.width = diameter;
								this.canvas.height = diameter;

								var grd = this.ctx.createRadialGradient(this.radius, this.radius , 1, this.radius, this.radius, this.radius);
								grd.addColorStop(0, _this.animation.rain.rain_color);
								grd.addColorStop(1, _this.animation.rain.rain_color_clear);
								this.ctx.fillStyle = grd;
								this.ctx.fillRect(0, 0, diameter, diameter);
							}

							_this.Drop.max_speed = 2;

							_this.Drop.prototype.init = function(x) {
								this.x = x;
								this.y = _this.canvas.height;
								var angle = Math.random() * Math.PI - (Math.PI * 0.5);
								var speed = Math.random() * _this.Drop.max_speed;
								this.speed_x = Math.sin(angle) * speed;
								this.speed_y = -Math.cos(angle) * speed;
							}
							_this.Drop.prototype.recycle = function() {
								_this.animation.rain.drop_pool.push(this);
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
							var Drop = _this.Drop;
							var wind = _this.animation.rain.wind;
							var rain_height = _this.animation.rect.height;
							var rain_width = _this.animation.rect.width;
							var arc_r = _this.animation.circle.r;
							var dead_height = _this.animation.rain.deadheight;
							_this.animation.rain.rain_color = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',' + c.a + ')';
							_this.animation.rain.rain_color_clear = 'rgba(' + c.r + ',' + c.g + ',' + c.b + ',0)';
							
							drop_time += _this.animation.timeintval + _this.animation.rain.time_diff;
							while (drop_time > drop_delay) {
								drop_time -= drop_delay;
								var new_rain = rain_pool.pop() || new Rain();
								new_rain.init();
								var wind_expand = Math.abs(height / new_rain.speed * wind); 
								var spawn_x = Math.random() * (width + wind_expand);
								if (wind > 0) spawn_x -= wind_expand;
								new_rain.x = spawn_x;
								rain.push(new_rain);
							}
							_this.animation.rain.drop_time = drop_time;
							/*rain physics*/
							for (var i = rain.length - 1; i >= 0; i--) {
								var r = rain[i];
								r.y += r.speed * r.z * multiplier;
								r.x += r.z * wind * multiplier;
								if (r.y > dead_height + Rain.height * r.z || (wind < 0 && r.x < wind) || (wind > 0 && r.x > width + wind)) {
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
								if (real_y > dead_height && _this.animation.rain.splashed) {
									r.splash();
									offctx.moveTo(r.x, r.y - r.splash.h /2);
									offctx.bezierCurveTo(
										r.x + r.splash.w / 2, 
										r.y - r.splash.h / 2,
										r.x + r.splash.w / 2, 
										r.y + r.splash.h / 2,
										r.x, 
										r.y + r.splash.h / 2);

									offctx.bezierCurveTo(
										r.x - r.splash.w / 2, 
										r.y + r.splash.h / 2,
										r.x - r.splash.w / 2, 
										r.y - r.splash.h / 2,
										r.x, 
										r.y - r.splash.h / 2);
									offctx.lineWidth = .5;
									offctx.strokeStyle = '#ffffff';
									offctx.stroke();
									offctx.closePath();
									r.splash();
								}else if(real_y <= dead_height){
									offctx.moveTo(real_x, real_y);
									if(_this.animation.shape == 'rect'){
										offctx.lineTo(real_x - wind *r.z * 1.5, real_y - rain_height * r.z);
										offctx.lineWidth = Rain.width;
										offctx.strokeStyle = _this.animation.rain.rain_color;
										offctx.stroke();
									}else if(_this.animation.shape == 'circle'){
										offctx.arc(real_x,real_y,arc_r,0,2*Math.PI);
										offctx.fillStyle = '#ffffff';
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