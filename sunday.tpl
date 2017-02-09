{%* <canvas id="mh-scene-sunday"></canvas>
<canvas id="mh-scene-sunday-comp1"></canvas>
<canvas id="mh-scene-sunday-comp2"></canvas>
<canvas id="mh-scene-sunday-comp3"></canvas> 

<script>
	So.onebox.objective('So.onebox.weather.configs.sunday',
		{
			sceneId:'mh-scene-sunday',
			sceneEle:{
				components:[
					/*大风车杆*/
					{
						src:'http://p8.qhimg.com/t0112c663f9aea1c70d.png',
						shape:{
							width:62,
							height:148
						},
						position:{
							left:440,
							top:135
						}
					},
					/*大风车轮*/
					{
						src:'http://p3.qhimg.com/t015f0762a9af6e36a5.png',
						shape:{
							width:82,
							height:82
						},
						position:{
							left:384,
							top:83,
							deg:0
						},
						canvas:{
							id:'mh-scene-sunday-comp1',
							width:120,
							height:120
						},
						animation:{
							timeintval:0
						},
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = width/2;
							var ypos = height/2;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var deg = _this.position.deg;
							if(deg == Math.PI){
								deg = 0;
							}else{
								deg = deg + Math.PI/250;
							}
							_this.position.deg = deg;
							img.src = this.src;
							img.onload = function(){
								offctx.save();
								offctx.clearRect(0,0,width,height);
								offctx.translate(xpos,ypos); 
								offctx.rotate(deg);
								offctx.translate(-xpos,-ypos); 
								offctx.drawImage(img,xpos - _this.shape.width/2,ypos - _this.shape.height/2,_this.shape.width,_this.shape.height);
								offctx.restore();
								ctx.clearRect(0,0,width,height);
								ctx.drawImage(offcanvas,0,0,width,height);
							}
						}
					},
					/*小风车杆*/
					{
						src:'http://p1.qhimg.com/t01610fa53ffe503eab.png',
						shape:{
							width:31,
							height:74
						},
						position:{
							left:353,
							top:170
						}
					},
					/*小风车轮*/
					{
						src:'http://p9.qhimg.com/t01dd512e436a75b4fc.png',
						shape:{
							width:48,
							height:48
						},
						position:{
							left:323,
							top:145,
							deg:0
						},
						canvas:{
							id:'mh-scene-sunday-comp2',
							width:62,
							height:62
						},
						animation:{
							timeintval:0
						},
						animate:function(){
							var _this = this;
							var img = new Image();
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var xpos = width/2;
							var ypos = height/2;
							var ctx = _this.canvas.ctx;
							var deg = _this.position.deg;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							if(deg == Math.PI){
								deg = 0;
							}else{
								deg = deg + Math.PI/250;
							}
							_this.position.deg = deg;
							img.src = this.src;
							img.onload = function(){
								offctx.save();
								offctx.clearRect(0,0,width,height);
								offctx.translate(xpos,ypos); 
								offctx.rotate(deg);
								offctx.translate(-xpos,-ypos); 
								offctx.drawImage(img,xpos - _this.shape.width/2,ypos - _this.shape.height/2,_this.shape.width,_this.shape.height);
								offctx.restore();
								ctx.clearRect(0,0,width,height);
								ctx.drawImage(offcanvas,0,0,width,height);
							}
						}
					},
					/*sun*/
					{
						src:'http://p8.qhimg.com/t016e4c16b87177977e.png',
						shape:{
							width:83,
							height:83
						},
						position:{
							left:280,
							top:20
						}
					},
					/*大雁*/
					{
						src:'http://p7.qhimg.com/t01fd502cb208e7cf92.png',
						shape:{
							width:66,
							height:30
						},
						position:{
							left:200,
							top:90
						}
					},
					/*sunshine*/
					{
						shape:{
							r:15,
							color:{
								r:'255',
								g:'255',
								b:'255',
								a:'.3'
							}
						},
						position:{
							left:0,
							top:0
						},
						canvas:{
							id:'mh-scene-sunday-comp3',
							width:540,
							height:260
						},
						animation:{
							numMax:2,
							posSpace:25,
							rSpace:15,
							numRandom:false,
							sunShineArr:[],
							speed:.01,
							timeintval:150
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var deadheight = _this.animation.deadHeight;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var ctx = _this.canvas.ctx;
							var arcNum = _this.animation.numMax;
							if(_this.animation.numRandom){
								arcNum = arcMum + arcMum * Math.random();
							}
							_this.Sunshine = function(){
								this.scale = 1000;
								this.r = _this.shape.r;
								this.sunShines = [];
								this.x = 390;
								this.y = 145;
								this.opacity = this.maxOp =  parseFloat(_this.shape.color.a,10)*this.scale;
								this.speed = _this.animation.speed*this.scale;
								this.drawS(this.x,this.y);
								this.flag = 0;
							};
							_this.Sunshine.prototype.drawS = function(x,y,r){
								if(this.opacity <= this.maxOp && this.flag){
									this.opacity += this.speed;
									if(this.opacity >= this.maxOp){
										this.flag = 0;
									}
									
								}else if(this.opacity >= 0 && !this.flag){
									this.opacity -= this.speed;
									if(this.opacity <= 0){
										this.flag = 1;
									}
									
								}
								offctx.beginPath();
								offctx.arc(x,y,r,0,2*Math.PI);
								offctx.closePath();
								offctx.fillStyle = 'rgba(' + _this.shape.color.r + ',' + _this.shape.color.g + ',' + _this.shape.color.b + ',' +this.opacity/this.scale+')';
								offctx.fill();
							};
							for(var i=0; i<arcNum; i++){
								var sunShine = new _this.Sunshine();
								_this.animation.sunShineArr.push(sunShine);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offctx = _this.canvas.offctx;
							var offcanvas = _this.canvas.offcanvas;
							var sunShineArr = _this.animation.sunShineArr;
							var posSpace = _this.animation.posSpace;
							var rSpace = _this.animation.rSpace;
							var r = _this.shape.r;
							offctx.clearRect(0,0,width,height);
							ctx.clearRect(0,0,width,height);
							$.each(sunShineArr,function(key,item){
								item.drawS(item.x + posSpace * key,item.y + posSpace * key,r + rSpace * key);
							});
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
				]
			}
		}
	);
</script>
*%}
<style>
#mohe-weather .mh-sunday-sun {
    background: url(http://p8.qhimg.com/t016e4c16b87177977e.png) no-repeat;
    width: 83px;
    height: 83px;
    position: absolute;
    background-size: contain;
    left: 280px;
    top: 20px;
    transition: all 1.5s;
}
#mohe-weather .mh-sunday-sun:hover{
	transform: scale(1.2);
}
#mohe-weather .mh-sunday-bird {
    background: url(http://p7.qhimg.com/t01fd502cb208e7cf92.png) no-repeat;
    width: 66px;
    height: 30px;
    position: absolute;
    background-size: contain;
    left: 200px;
    top: 90px;
}
#mohe-weather .mh-sunday-wildmillSmall {
    background: url(http://p8.qhimg.com/t0112c663f9aea1c70d.png) no-repeat;
    width: 31px;
    height: 74px;
    position: absolute;
    background-size: contain;
    left: 353px;
    top: 170px;
}
#mohe-weather .mh-sunday-wildmillBig {
    background: url(http://p8.qhimg.com/t0112c663f9aea1c70d.png) no-repeat;
    width: 62px;
    height: 148px;
    position: absolute;
    left: 440px;
    top: 135px;
}
#mohe-weather .mh-sunday-wheelBig {
    background: url(http://p3.qhimg.com/t015f0762a9af6e36a5.png) no-repeat;
    width: 82px;
    height: 82px;
    background-size: contain;
    position: absolute;
    left: 405px;
    top: 101px;
    animation: mh-weather-rotate 10s infinite linear;
    -moz-animation: mh-weather-rotate 10s infinite linear;
    -webkit-animation: mh-weather-rotate 10s infinite linear;
    -o-animation: mh-weather-rotate 10s infinite linear;
}
#mohe-weather .mh-sunday-wheelSmall {
    background: url(http://p3.qhimg.com/t015f0762a9af6e36a5.png) no-repeat;
    width: 41px;
    height: 41px;
    background-size: contain;
    position: absolute;
    left: 335px;
    top: 153px;
    animation: mh-weather-rotate 10s infinite linear;
    -moz-animation: mh-weather-rotate 10s infinite linear;
    -webkit-animation: mh-weather-rotate 10s infinite linear;
    -o-animation: mh-weather-rotate 10s infinite linear;
}
#mohe-weather .mh-sunday-sunshine {
    position: absolute;
    width: 100px;
    height: 80px;
    left: 372px;
    top: 125px;
}
#mohe-weather .mh-sunday-sunshine .mh-sunday-sunshine-arc1 {
    width: 30px;
    height: 30px;
    background: #fff;
    border-radius: 50%;
    animation: mh-weather-opacity 5s infinite linear alternate;
    -moz-animation: mh-weather-opacity 5s infinite linear alternate;
    -webkit-animation: mh-weather-opacity 5s infinite linear alternate;
    -o-animation: mh-weather-opacity 5s infinite linear alternate;
}
#mohe-weather .mh-sunday-sunshine .mh-sunday-sunshine-arc2 {
    width: 60px;
    height: 60px;
    background: #fff;
    border-radius: 50%;
    left: 10px;
    position: absolute;
    top: 12px;
    animation: mh-weather-opacity 5s infinite linear alternate;
    -moz-animation: mh-weather-opacity 5s infinite linear alternate;
    -webkit-animation: mh-weather-opacity 5s infinite linear alternate;
    -o-animation: mh-weather-opacity 5s infinite linear alternate;
}
</style>
<div class="mh-dom-wraper">
	<div class="mh-sunday-sun"></div>
	<div class="mh-sunday-bird"></div>
	<div class="mh-sunday-wildmillSmall"></div>
	<div class="mh-sunday-wildmillBig"></div>
	<div class="mh-sunday-wheelSmall"></div>
	<div class="mh-sunday-wheelBig"></div>
	<div class="mh-sunday-sunshine">
		<div class="mh-sunday-sunshine-arc1"></div>
		<div class="mh-sunday-sunshine-arc2"></div>
	</div>
</div>