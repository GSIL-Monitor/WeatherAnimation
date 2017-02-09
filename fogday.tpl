{%*<canvas id="mh-scene-fogday"></canvas>
<canvas id="mh-scene-fogday-comp3"></canvas>
<canvas id="mh-scene-fogday-comp2"></canvas>
<canvas id="mh-scene-fogday-comp1"></canvas>

<script>
	So.onebox.objective('So.onebox.weather.configs.fogday',
		{
			sceneId:'mh-scene-fogday',
			sceneEle:{
				components:[
					
					/*上层雾*/
					{
						src:'https://p0.ssl.qhimg.com/t013e3b1ac709298dca.png',
						canvas:{
							id:'mh-scene-fogday-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							sumNum:100,
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
									/*算法的目的，对目标画布和原画布进行等比例缩放展示，目的：使场景边缘的雾气稀薄*/
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
						        
						        /*设置随机速度*/
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
					/*海水*/
					{
						src:'https://p2.ssl.qhimg.com/t019c6c510fcc26e0b7.png',
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
							id:'mh-scene-fogday-comp2',
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
					{
						src:'https://p5.ssl.qhimg.com/t01bbdecfebbed22f7c.png',
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
							id:'mh-scene-fogday-comp3',
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
	#mohe-weather .mh-fogday-seafront {
		background: url(https://p2.ssl.qhimg.com/t019c6c510fcc26e0b7.png) no-repeat;
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
	#mohe-weather .mh-fogday-seabehind {
		background: url(https://p5.ssl.qhimg.com/t01bbdecfebbed22f7c.png) no-repeat;
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
</style>
<div class="mh-dom-wraper">
	<div class="mh-fogday-seabehind"></div>
	<div class="mh-fogday-seafront"></div>
</div>
<canvas id="mh-scene-fogday"></canvas>
<canvas id="mh-scene-fogday-comp1"></canvas>

<script>
	So.onebox.objective('So.onebox.weather.configs.fogday',
		{
			sceneId:'mh-scene-fogday',
			sceneEle:{
				components:[
					
					/*上层雾*/
					{
						src:'https://p0.ssl.qhimg.com/t013e3b1ac709298dca.png',
						canvas:{
							id:'mh-scene-fogday-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							sumNum:100,
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
									/*算法的目的，对目标画布和原画布进行等比例缩放展示，目的：使场景边缘的雾气稀薄*/
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
						        
						        /*设置随机速度*/
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