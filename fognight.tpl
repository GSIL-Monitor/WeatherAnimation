{%*<canvas id="mh-scene-fognight"></canvas>
<canvas id="mh-scene-fognight-comp4"></canvas>
<canvas id="mh-scene-fognight-comp3"></canvas>
<canvas id="mh-scene-fognight-comp2"></canvas>
<canvas id="mh-scene-fognight-comp1"></canvas>

<script>
	So.onebox.objective('So.onebox.weather.configs.fognight',
		{
			sceneId:'mh-scene-fognight',
			sceneEle:{
				components:[
					/*上层雾*/
					{
						src:'https://p0.ssl.qhimg.com/t013e3b1ac709298dca.png',
						canvas:{
							id:'mh-scene-fognight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							sumNum:60,
							velocity:1,
							eles:[],
							minPosX:-260,
							maxPosX:540,
							minPosY:-20,
							maxPosY:-10,
							timeintval:35
						},
						generateRandom:function(min,max){
							return Math.random() * (max - min) + min;
						},
						init:function(){
							var _this = this;
							var maxPosX = _this.animation.maxPosX;
							var minPosX = _this.animation.minPosX;
							var maxPosY = _this.animation.maxPosY;
							var minPosY = _this.animation.minPosY;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var fogCount = _this.animation.sumNum;
							var imgObj = new Image();
							imgObj.src = _this.src;
							_this.Fog = function(){
								this.x = 0;
								this.y = 0;
								this.xVelocity = 0;
								this.yVelocity = 0;
								this.maxVelocity = _this.animation.velocity;
							};
							_this.Fog.prototype.draw = function(){
								if(this.image){
									offctx.globalAlpha = this.alpha;
									var fillWidth = width/2, 
									fillHeight = fillWidth - fillWidth * (this.x/width * this.y/height);
									offctx.drawImage(this.image, 0, 0, this.imageWidth, this.imageHeight, this.x, this.y, fillWidth, fillHeight); 
								}
							};
							_this.Fog.prototype.update = function(){
								this.x += this.xVelocity;
								this.y += this.yVelocity;

								if (this.x >= maxPosX) {
									this.xVelocity = -this.xVelocity;
									this.x = width;
								}
								else if (this.x <= minPosX) {
									this.xVelocity = -this.xVelocity;
									this.x = minPosX;
								}

								if (this.y >= maxPosY) {
									this.yVelocity = -this.yVelocity;
									this.y = maxPosY;
								}
								else if (this.y <= minPosY) {
									this.yVelocity = -this.yVelocity;
									this.y = minPosY;
								}

								this.alpha = (1 - Math.abs(width*0.5 - this.x) / width) * (0.7 - Math.abs(height*0.5 - this.y) / height);
							};
							_this.Fog.prototype.setPosition = function(x,y){
								this.x = x;
								this.y = y;
							};
							_this.Fog.prototype.setVelocity = function(x, y) {
						    	this.xVelocity = x;
						    	this.yVelocity = y;
						    };
						    _this.Fog.prototype.setImage = function(image){
						    	this.imageWidth = image.width;
						    	this.imageHeight = image.height;
						    	this.image = image;
						    };
						    for(var i=0; i < fogCount; ++i){
						        var fog = new _this.Fog();
						        /*随机位置*/
						        fog.setPosition(_this.generateRandom(minPosX, maxPosX), _this.generateRandom(minPosY, maxPosY));
						        
						       /* 设置随机速度*/
						        fog.setVelocity(_this.generateRandom(-fog.maxVelocity, fog.maxVelocity), _this.generateRandom(-fog.maxVelocity, fog.maxVelocity));
						        _this.animation.eles.push(fog);            
						    };
						    imgObj.onload = function(){
								$.each(_this.animation.eles,function(key,item){
									item.setImage(imgObj);
								});
							};
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var cls = _this.animation.eles;
							$.each(cls,function(key,cl){
								cl.update();
							});
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							$.each(cls,function(key,cl){
								cl.draw();
							});
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					},
					/*探照灯*/
					{
						canvas:{
							id:'mh-scene-fognight-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						shape:{
							num:60,
							distance:100,
							raysAngle:30
						},
						position:{
							x:437,
							y:122
						},
						animation:{
							deg:130,
							speed:1,
							minDeg:130,
							maxDeg:270,
							timeintval:30
						},
						castLight:function(startAngle, raysAngle, distance, rays, x, y){
								Math.radians = function(degrees) {
								  return degrees * Math.PI / 180;
								};
								var _this = this;
								var angleBetweenRays = raysAngle/rays;
								var ctx = _this.canvas.ctx;
								var offcanvas = _this.canvas.offcanvas;
								var offctx = _this.canvas.offctx;
								for(var i=0;i<rays;i++){
								  var grad= offctx.createLinearGradient(x, y, x+Math.cos( Math.radians(startAngle+angleBetweenRays*i) )*distance, y-Math.sin( Math.radians(startAngle+angleBetweenRays*i) )*distance);
								      grad.addColorStop(0, "rgba(240,230,140,0.2)");
								      grad.addColorStop(1, "rgba(240,230,140,0)");

								  offctx.strokeStyle = grad;
								  offctx.lineWidth= 1;
								  offctx.beginPath();
								  offctx.moveTo(x, y);
								  offctx.lineTo( x+Math.cos( Math.radians(startAngle+angleBetweenRays*i) )*distance, y-Math.sin( Math.radians(startAngle+angleBetweenRays*i) )*distance );
								  
								  offctx.stroke();
								}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var posX = _this.position.x;
							var posY = _this.position.y;
							var raysNum = _this.shape.num;
							var raysAngle = _this.shape.raysAngle;
							var distance = _this.shape.distance;
							var deg = _this.animation.deg;
							var maxdeg = _this.animation.maxDeg;
							var mindeg = _this.animation.minDeg;
							var speed = _this.animation.speed;
							deg = _this.animation.deg + speed;
							if(deg >= maxdeg){
								_this.animation.speed = -_this.animation.speed;
								_this.animation.deg = maxdeg;
							}
							else if(deg <= mindeg ){
								_this.animation.speed = -_this.animation.speed;
								_this.animation.deg = mindeg;
							}
							_this.animation.deg = deg;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							_this.castLight(deg, raysAngle, distance, raysNum, posX, posY);
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					},
					/*海水*/
					{
						src:'https://p4.ssl.qhimg.com/t0115311282644f2e5c.png',
						shape:{
							width:560,
							height:104
						},
						position:{
							left:0,
							top:173
						}
						,
						canvas:{
							id:'mh-scene-fognight-comp3',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:0,
							maxYshift:170,
							minXshift:-13,
							minYshift:163,
							directionX:'right',
							directionY:'down',
							stepX:.2,
							stepY:.08,
							timeintval:0
						}
						,
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = _this.position.left;
							var ypos = _this.position.top;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var stepX = _this.animation.stepX;
							var stepY = _this.animation.stepY;
							if(_this.animation.stepX !== 0){
								if(_this.animation.directionX == 'left'){
									if(xpos <= _this.animation.minXshift){
										_this.animation.directionX = 'right';
										return;
									}else{
										xpos = xpos - stepX;
									}
								}else{
									if(xpos >= _this.animation.maxXshift){
										_this.animation.directionX = 'left';
										return;
									}else{
										xpos = xpos + stepX;
									}
								}
							}
							if(_this.animation.stepY !== 0){
								if(_this.animation.directionY == 'up'){
									if(ypos <= _this.animation.minYshift){
										_this.animation.directionY = 'down';
										return;
									}else{
										ypos = ypos - stepY;
									}
								}else{
									if(ypos >= _this.animation.maxYshift){
										_this.animation.directionY = 'up';
										return;
									}else{
										ypos = ypos + stepY;
									}
								}
							}
							img.src = this.src;
							img.onload = function(){
								offctx.save();
								offctx.clearRect(0,0,width,height);
								offctx.drawImage(img,xpos,ypos,_this.shape.width,_this.shape.height);
								offctx.restore();
								ctx.clearRect(0,0,width,height);
								ctx.drawImage(offcanvas,0,0,width,height);
							}
							_this.position.left = xpos;
							_this.position.top = ypos;
						}
					},
					/*海水*/
					{
						src:'https://p3.ssl.qhimg.com/t013d1c70800b05594a.png',
						shape:{
							width:560,
							height:104
						},
						position:{
							left:0,
							top:158
						}
						,
						canvas:{
							id:'mh-scene-fognight-comp4',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:0,
							maxYshift:160,
							minXshift:-13,
							minYshift:156,
							directionX:'left',
							directionY:'up',
							stepX:.3,
							stepY:.05,
							timeintval:0
						}
						,
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = _this.position.left;
							var ypos = _this.position.top;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var stepX = _this.animation.stepX;
							var stepY = _this.animation.stepY;
							if(_this.animation.stepX !== 0){
								if(_this.animation.directionX == 'left'){
									if(xpos <= _this.animation.minXshift){
										_this.animation.directionX = 'right';
										return;
									}else{
										xpos = xpos - stepX;
									}
								}else{
									if(xpos >= _this.animation.maxXshift){
										_this.animation.directionX = 'left';
										return;
									}else{
										xpos = xpos + stepX;
									}
								}
							}
							if(_this.animation.stepY !== 0){
								if(_this.animation.directionY == 'up'){
									if(ypos <= _this.animation.minYshift){
										_this.animation.directionY = 'down';
										return;
									}else{
										ypos = ypos - stepY;
									}
								}else{
									if(ypos >= _this.animation.maxYshift){
										_this.animation.directionY = 'up';
										return;
									}else{
										ypos = ypos + stepY;
									}
								}
							}
							img.src = this.src;
							img.onload = function(){
								offctx.save();
								offctx.clearRect(0,0,width,height);
								offctx.drawImage(img,xpos,ypos,_this.shape.width,_this.shape.height);
								offctx.restore();
								ctx.clearRect(0,0,width,height);
								ctx.drawImage(offcanvas,0,0,width,height);
							}
							_this.position.left = xpos;
							_this.position.top = ypos;
						}
					}
				]
			}
		}
	);
</script>*%}
<style>
	#mohe-weather .mh-fognight-seafront {
		background: url(https://p4.ssl.qhimg.com/t0115311282644f2e5c.png) no-repeat;
		width: 560px;
		height: 104px;
		position: absolute;
		background-size: contain;
		left: 0px;
		top: 173px;
		animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
	    -moz-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
	    -webkit-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
	    -o-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
	}
	#mohe-weather .mh-fognight-seabehind {
		background: url(https://p3.ssl.qhimg.com/t013d1c70800b05594a.png) no-repeat;
		width: 560px;
		height: 104px;
		position: absolute;
		background-size: contain;
		left: -10px;
		top: 168px;
		animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
	    -moz-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
	    -webkit-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
	    -o-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
		animation-delay:-3s;
	}
	#mohe-weather .mh-fognight-sealight {
		background: url(https://p0.ssl.qhimg.com/t01eda0b24a8e7d5c62.png) no-repeat;
		width: 64px;
		height: 64px;
		background-size: contain;
		left: 372px;
		top: 108px;
		z-index: 3;
		position: absolute;
		animation: mh-weather-fognight-sealightRotate 5s infinite ease-in-out alternate;
	    -moz-animation: mh-weather-fognight-sealightRotate 5s infinite ease-in-out alternate;
	    -webkit-animation: mh-weather-fognight-sealightRotate 5s infinite ease-in-out alternate;
	    -o-animation: mh-weather-fognight-sealightRotate 5s infinite ease-in-out alternate;
		transform-origin: 100% 20%;
	}
	#mohe-weather .mh-fognight-sealight:hover{
		animation-play-state: paused;
	}
</style>
<div class="mh-dom-wraper">
	<div class="mh-fognight-seabehind"></div>
	<div class="mh-fognight-seafront"></div>
	<div class="mh-fognight-sealight"></div>
</div>
<canvas id="mh-scene-fognight"></canvas>
<canvas id="mh-scene-fognight-comp1"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.fognight',
		{
			sceneId:'mh-scene-fognight',
			sceneEle:{
				components:[
					/*上层雾*/
					{
						src:'https://p0.ssl.qhimg.com/t013e3b1ac709298dca.png',
						canvas:{
							id:'mh-scene-fognight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							sumNum:60,
							velocity:1,
							eles:[],
							minPosX:-260,
							maxPosX:540,
							minPosY:-20,
							maxPosY:-10,
							timeintval:35
						},
						generateRandom:function(min,max){
							return Math.random() * (max - min) + min;
						},
						init:function(){
							var _this = this;
							var maxPosX = _this.animation.maxPosX;
							var minPosX = _this.animation.minPosX;
							var maxPosY = _this.animation.maxPosY;
							var minPosY = _this.animation.minPosY;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var fogCount = _this.animation.sumNum;
							var imgObj = new Image();
							imgObj.src = _this.src;
							_this.Fog = function(){
								this.x = 0;
								this.y = 0;
								this.xVelocity = 0;
								this.yVelocity = 0;
								this.maxVelocity = _this.animation.velocity;
							};
							_this.Fog.prototype.draw = function(){
								if(this.image){
									offctx.globalAlpha = this.alpha;
									var fillWidth = width/2, 
									fillHeight = fillWidth - fillWidth * (this.x/width * this.y/height);
									offctx.drawImage(this.image, 0, 0, this.imageWidth, this.imageHeight, this.x, this.y, fillWidth, fillHeight); 
								}
							};
							_this.Fog.prototype.update = function(){
								this.x += this.xVelocity;
								this.y += this.yVelocity;

								if (this.x >= maxPosX) {
									this.xVelocity = -this.xVelocity;
									this.x = width;
								}
								else if (this.x <= minPosX) {
									this.xVelocity = -this.xVelocity;
									this.x = minPosX;
								}

								if (this.y >= maxPosY) {
									this.yVelocity = -this.yVelocity;
									this.y = maxPosY;
								}
								else if (this.y <= minPosY) {
									this.yVelocity = -this.yVelocity;
									this.y = minPosY;
								}

								this.alpha = (1 - Math.abs(width*0.5 - this.x) / width) * (0.7 - Math.abs(height*0.5 - this.y) / height);
							};
							_this.Fog.prototype.setPosition = function(x,y){
								this.x = x;
								this.y = y;
							};
							_this.Fog.prototype.setVelocity = function(x, y) {
						    	this.xVelocity = x;
						    	this.yVelocity = y;
						    };
						    _this.Fog.prototype.setImage = function(image){
						    	this.imageWidth = image.width;
						    	this.imageHeight = image.height;
						    	this.image = image;
						    };
						    for(var i=0; i < fogCount; ++i){
						        var fog = new _this.Fog();
						        /*随机位置*/
						        fog.setPosition(_this.generateRandom(minPosX, maxPosX), _this.generateRandom(minPosY, maxPosY));
						        
						       /* 设置随机速度*/
						        fog.setVelocity(_this.generateRandom(-fog.maxVelocity, fog.maxVelocity), _this.generateRandom(-fog.maxVelocity, fog.maxVelocity));
						        _this.animation.eles.push(fog);            
						    };
						    imgObj.onload = function(){
								$.each(_this.animation.eles,function(key,item){
									item.setImage(imgObj);
								});
							};
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var cls = _this.animation.eles;
							$.each(cls,function(key,cl){
								cl.update();
							});
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							$.each(cls,function(key,cl){
								cl.draw();
							});
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
				]
			}
		}
	);
</script>