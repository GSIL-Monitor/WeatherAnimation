{%*<canvas id="mh-scene-cloudnight"></canvas>
<canvas id="mh-scene-cloudnight-comp1"></canvas>
<canvas id="mh-scene-cloudnight-comp2"></canvas>
<canvas id="mh-scene-cloudnight-comp3"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.cloudnight',
		{
			sceneId:'mh-scene-cloudnight',
			sceneEle:{
				components:[
					/*moon*/
					{
						src:'http://p7.qhimg.com/t010698e6a3f4dc5ee5.png',
						shape:{
							width:83,
							height:83
						},
						position:{
							left:250,
							top:30
						}
					},
					/*主云彩*/
					{
						src:'http://p3.qhimg.com/t016bb42ba4eaf5d553.png',
						shape:{
							width:88,
							height:51
						},
						position:{
							left:280,
							top:60
						}
					},
					/*云1*/
					{
						src:'http://p1.qhimg.com/t0157b690d484c70181.png',
						shape:{
							width:60,
							height:35
						},
						position:{
							left:400,
							top:90
						},
						canvas:{
							id:'mh-scene-cloudnight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:400,
							minXshift:360,
							maxYshift:200,
							minYshift:90,
							directionX:'left',
							directionY:'up',
							stepX:.05,
							stepY:0,
							timeintval:0
						},
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = _this.position.left;
							var ypos = _this.position.top;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
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
					/*云2*/
					{
						src:'http://p2.qhimg.com/t012246d2b82dd72d42.png',
						shape:{
							width:31,
							height:18
						},
						position:{
							left:200,
							top:120
						},
						canvas:{
							id:'mh-scene-cloudnight-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:250,
							maxYshift:120,
							minXshift:150,
							minYshift:120,
							directionX:'right',
							directionY:'up',
							stepX:.1,
							stepY:0,
							timeintval:0
						},
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = _this.position.left;
							var ypos = _this.position.top;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
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
					/*云3*/
					{
						src:'http://p7.qhimg.com/t01af673db357802a2d.png',
						shape:{
							width:34,
							height:20
						},
						position:{
							left:450,
							top:40
						},
						canvas:{
							id:'mh-scene-cloudnight-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:500,
							maxYshift:40,
							minXshift:400,
							minYshift:40,
							directionX:'left',
							directionY:'up',
							stepX:.1,
							stepY:0,
							timeintval:0
						},
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = _this.position.left;
							var ypos = _this.position.top;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
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
								offctx.clearRect(_this.animation.minXshift
									,_this.animation.minYshift
									,_this.animation.maxXshift+_this.shape.width-_this.animation.minXshift
									,_this.animation.maxYshift+_this.shape.height-_this.animation.minYshift);
								offctx.drawImage(img,xpos,ypos,_this.shape.width,_this.shape.height);
								offctx.restore();
								ctx.clearRect(_this.animation.minXshift
									,_this.animation.minYshift
									,_this.animation.maxXshift+_this.shape.width-_this.animation.minXshift
									,_this.animation.maxYshift+_this.shape.height-_this.animation.minYshift);
								ctx.drawImage(offcanvas,0,0,width,height);
							}
							_this.position.left = xpos;
							_this.position.top = ypos;
						}
					},
					/*后层云*/
					{
						src:'http://p9.qhimg.com/t0190adf606cdb25a41.png',
						shape:{
							width:538,
							height:129
						},
						position:{
							left:18,
							top:128
						}
					},
					/*中层云*/
					{
						src:'http://p5.qhimg.com/t0112a76d5afdc2164e.png',
						shape:{
							width:540,
							height:96
						},
						position:{
							left:0,
							top:168
						}
					},
					/*最前面云*/
					{
						src:'http://p4.qhimg.com/t0182685353667cd577.png',
						shape:{
							width:275,
							height:72
						},
						position:{
							left:300,
							top:190
						}
					}
				]
			}
		}
	);
</script>*%}
<style>
	#mohe-weather .mh-moon-wrap {
		width: 100px;
	    height: 100px;
	    position: absolute;
	    left: 250px;
	    top: 30px;
	}
	#mohe-weather .mh-cloudnight-moon {
	    background: url(http://p7.qhimg.com/t010698e6a3f4dc5ee5.png) no-repeat;
	    width: 83px;
	    height: 83px;
	    position: absolute;
	    background-size: contain;
	    left: 0px;
	    top: 0px;
	    transition: all 2s;
	}
	#mohe-weather .mh-moon-wrap:hover .mh-cloudnight-moon{
		transform: translateX(20px);
	}
	#mohe-weather .mh-cloudnight-maincloud {
	    background: url(http://p3.qhimg.com/t016bb42ba4eaf5d553.png) no-repeat;
	    width: 88px;
	    height: 51px;
	    position: absolute;
	    background-size: contain;
	    left: 30px;
	    top: 30px;
	}
	#mohe-weather .mh-cloudnight-cloud1 {
	    background: url(http://p1.qhimg.com/t0157b690d484c70181.png) no-repeat;
	    width: 60px;
	    height: 35px;
	    position: absolute;
	    background-size: contain;
	    left: 400px;
	    top: 90px;
	    animation: mh-weather-cloudday-cloud1 5s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud1 5s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud1 5s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud1 5s infinite linear alternate;
	}
	#mohe-weather .mh-cloudnight-cloud2 {
	    background: url(http://p2.qhimg.com/t012246d2b82dd72d42.png) no-repeat;
	    width: 31px;
	    height: 18px;
	    position: absolute;
	    background-size: contain;
	    left: 200px;
	    top: 120px;
	    animation: mh-weather-cloudday-cloud2 5s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud2 5s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud2 5s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud2 5s infinite linear alternate;
	}
	#mohe-weather .mh-cloudnight-cloud3 {
	    background: url(http://p7.qhimg.com/t01af673db357802a2d.png) no-repeat;
	    width: 34px;
	    height: 20px;
	    position: absolute;
	    background-size: contain;
	    left: 450px;
	    top: 40px;
	}
	#mohe-weather .mh-cloudnight-cloud-bottom {
	    background: url(http://p9.qhimg.com/t0190adf606cdb25a41.png) no-repeat;
	    width: 538px;
	    height: 129px;
	    position: absolute;
	    background-size: contain;
	    left: 18px;
	    top: 138px;
	}
	#mohe-weather .mh-cloudnight-cloud-middle {
	    background: url(http://p5.qhimg.com/t0112a76d5afdc2164e.png) no-repeat;
	    width: 540px;
	    height: 106px;
	    position: absolute;
	    background-size: contain;
	    left: 0px;
	    top: 170px;
	}
	#mohe-weather .mh-cloudnight-cloud-top {
		background: url(http://p4.qhimg.com/t0182685353667cd577.png) no-repeat;
		width: 275px;
		height: 72px;
		position: absolute;
		background-size: contain;
		left: 270px;
		top: 207px;
	}
</style>
<div class="mh-dom-wraper">
	<div class="mh-moon-wrap">
		<div class="mh-cloudnight-moon"></div>
		<div class="mh-cloudnight-maincloud"></div>
	</div>
	<div class="mh-cloudnight-cloud1"></div>
	<div class="mh-cloudnight-cloud2"></div>
	<div class="mh-cloudnight-cloud3"></div>
	<div class="mh-cloudnight-cloud-bottom"></div>
	<div class="mh-cloudnight-cloud-middle"></div>
	<div class="mh-cloudnight-cloud-top"></div>
</div>
