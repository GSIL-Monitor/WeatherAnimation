{%*<canvas id="mh-scene-cloudday"></canvas>
<canvas id="mh-scene-cloudday-comp1"></canvas>
<canvas id="mh-scene-cloudday-comp2"></canvas>
<canvas id="mh-scene-cloudday-comp3"></canvas>
<canvas id="mh-scene-cloudday-comp4"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.cloudday',
		{
			sceneId:'mh-scene-cloudday',
			sceneEle:{
				components:[
					/*sun*/
					{
						src:'http://p8.qhimg.com/t016e4c16b87177977e.png',
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
							id:'mh-scene-cloudday-comp1',
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
							id:'mh-scene-cloudday-comp1',
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
							id:'mh-scene-cloudday-comp1',
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
						src:'http://p3.qhimg.com/t01e7a7c4b7bccf7264.png',
						shape:{
							width:538,
							height:129
						},
						position:{
							left:18,
							top:138
						},
						canvas:{
							id:'mh-scene-cloudday-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:32,
							maxYshift:148,
							minXshift:13,
							minYshift:138,
							directionX:'right',
							directionY:'up',
							stepX:.1,
							stepY:.05,
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
					/*中层云*/
					{
						src:'http://p9.qhimg.com/t011365535f1b0721ce.png',
						shape:{
							width:540,
							height:106
						},
						position:{
							left:0,
							top:170
						},
						canvas:{
							id:'mh-scene-cloudday-comp3',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:0,
							maxYshift:170,
							minXshift:-15,
							minYshift:160,
							directionX:'right',
							directionY:'down',
							stepX:.1,
							stepY:.1,
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
					/*最前面云*/
					{
						src:'http://p4.qhimg.com/t01d4a8fe034f7d7dbf.png',
						shape:{
							width:275,
							height:72
						},
						position:{
							left:300,
							top:190
						},
						canvas:{
							id:'mh-scene-cloudday-comp4',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:320,
							maxYshift:200,
							minXshift:300,
							minYshift:190,
							directionX:'left',
							directionY:'down',
							stepX:.1,
							stepY:.02,
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
					}
				]
			}
		}
	);
</script>*%}
<style>
	#mohe-weather .mh-sun-wrap {
		width: 100px;
	    height: 100px;
	    position: absolute;
	    left: 250px;
	    top: 30px;
	}
	#mohe-weather .mh-cloudday-sun {
	    background: url(http://p8.qhimg.com/t016e4c16b87177977e.png) no-repeat;
	    width: 83px;
	    height: 83px;
	    position: absolute;
	    background-size: contain;
	    left: 0px;
	    top: 0px;
	    transition: all 2s;
	}
	#mohe-weather .mh-sun-wrap:hover .mh-cloudday-sun{
		transform: translateX(20px);
	}
	#mohe-weather .mh-cloudday-maincloud {
	    background: url(http://p3.qhimg.com/t016bb42ba4eaf5d553.png) no-repeat;
	    width: 88px;
	    height: 51px;
	    position: absolute;
	    background-size: contain;
	    left: 30px;
	    top: 30px;
	}
	#mohe-weather .mh-cloudday-cloud1 {
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
	#mohe-weather .mh-cloudday-cloud2 {
	    background: url(http://p2.qhimg.com/t012246d2b82dd72d42.png) no-repeat;
	    width: 31px;
	    height: 18px;
	    position: absolute;
	    background-size: contain;
	    left: 200px;
	    top: 120px;
	    animation: mh-weather-cloudday-cloud2 7s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud2 7s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud2 7s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud2 7s infinite linear alternate;
	}
	#mohe-weather .mh-cloudday-cloud3 {
	    background: url(http://p7.qhimg.com/t01af673db357802a2d.png) no-repeat;
	    width: 34px;
	    height: 20px;
	    position: absolute;
	    background-size: contain;
	    left: 450px;
	    top: 40px;
	}
	#mohe-weather .mh-cloudday-cloud-bottom {
	    background: url(http://p3.qhimg.com/t01e7a7c4b7bccf7264.png) no-repeat;
	    width: 538px;
	    height: 129px;
	    position: absolute;
	    background-size: contain;
	    left: 18px;
	    top: 138px;
	    animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud-bottom 1s infinite linear alternate;
	}
	#mohe-weather .mh-cloudday-cloud-middle {
	    background: url(http://p9.qhimg.com/t011365535f1b0721ce.png) no-repeat;
	    width: 540px;
	    height: 106px;
	    position: absolute;
	    background-size: contain;
	    left: 0px;
	    top: 170px;
	    animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud-middle 2s infinite linear alternate;
	}
	#mohe-weather .mh-cloudday-cloud-top {
		background: url(http://p4.qhimg.com/t01d4a8fe034f7d7dbf.png) no-repeat;
		width: 275px;
		height: 72px;
		position: absolute;
		background-size: contain;
		left: 270px;
		top: 207px;
		animation: mh-weather-cloudday-cloud-top 5s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud-top 5s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud-top 5s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud-top 5s infinite linear alternate;
	}
</style>
<div class="mh-dom-wraper">
	<div class="mh-sun-wrap">
		<div class="mh-cloudday-sun"></div>
		<div class="mh-cloudday-maincloud"></div>
	</div>
	<div class="mh-cloudday-cloud1"></div>
	<div class="mh-cloudday-cloud2"></div>
	<div class="mh-cloudday-cloud3"></div>
	<div class="mh-cloudday-cloud-bottom"></div>
	<div class="mh-cloudday-cloud-middle"></div>
	<div class="mh-cloudday-cloud-top"></div>
</div>