{%*<canvas id="mh-scene-windday"></canvas>
<canvas id="mh-scene-windday-comp1"></canvas>
<canvas id="mh-scene-windday-comp2"></canvas>
<canvas id="mh-scene-windday-comp4"></canvas>
<canvas id="mh-scene-windday-comp5"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.windday',
		{
			sceneId:'mh-scene-windday',
			sceneEle:{
				components:[
					/*sun*/
					{
						src:'http://p8.qhimg.com/t01b36d5fd1f967624d.png',
						shape:{
							width:98,
							height:98
						},
						position:{
							left:350,
							top:20
						}
					},
					/*沙尘最大的*/
					{
						src:'http://p7.qhimg.com/t0110050f0f98c11a91.png',
						shape:{
							width:338,
							height:96
						},
						position:{
							left:160,
							top:130
						}
					},
					/*沙尘太阳旁边*/
					{
						src:'http://p7.qhimg.com/t0110050f0f98c11a91.png',
						shape:{
							width:243,
							height:58
						},
						position:{
							left:300,
							top:40
						},
						canvas:{
							id:'mh-scene-windday-comp1',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							maxXshift:400,
							minXshift:210,
							maxYshift:200,
							minYshift:90,
							directionX:'left',
							directionY:'up',
							stepX:1,
							stepY:0,
							timeintval:100
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
					/*沙尘字后面的*/
					{
						src:'http://p7.qhimg.com/t0110050f0f98c11a91.png',
						shape:{
							width:279,
							height:68
						},
						position:{
							left:30,
							top:100
						}
					},
					/*树1*/
					{
						position:{
							left:300,
							top:193,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:100
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
									for (var j = 1; j <= 2; j++) {
										var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
										angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
										width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
										generation = pBranch.generation + j,
										newBranch = this.makeBranch(angle, length, width, generation);
										pBranch.children.push(newBranch);
										this.branch(newBranch);
									}
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
					,
					/*树2*/
					{
						position:{
							left:340,
							top:163,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp4',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:10
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
									for (var j = 1; j <= 2; j++) {
										var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
										angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
										width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
										generation = pBranch.generation + j,
										newBranch = this.makeBranch(angle, length, width, generation);
										pBranch.children.push(newBranch);
										this.branch(newBranch);
									}
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
					,
					/*树3*/
					{
						position:{
							left:400,
							top:163,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp5',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:10
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
								  for (var j = 1; j <= 2; j++) {
								    var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
								      angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
								      width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
								      generation = pBranch.generation + j,
								      newBranch = this.makeBranch(angle, length, width, generation);
								    pBranch.children.push(newBranch);
								    this.branch(newBranch);
								  }
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
				]
			}
		}
	);
</script>*%}
<style>
	#mohe-weather .mh-windday-sun {
	    background: url(http://p8.qhimg.com/t01b36d5fd1f967624d.png) no-repeat;
	    width: 98px;
	    height: 98px;
	    position: absolute;
	    background-size: contain;
	    left: 350px;
	    top: 20px;
	}
	#mohe-weather .mh-windday-cloudmoon {
		background: url(http://p7.qhimg.com/t0110050f0f98c11a91.png) no-repeat;
		width: 343px;
		height: 58px;
		position: absolute;
		background-size: contain;
		left: 230px;
		top: 40px;
		animation: mh-weather-cloudday-cloud2 3s infinite linear alternate;
		-moz-animation: mh-weather-cloudday-cloud2 3s infinite linear alternate;
		-webkit-animation: mh-weather-cloudday-cloud2 3s infinite linear alternate;
		-o-animation: mh-weather-cloudday-cloud2 3s infinite linear alternate;
	}
	#mohe-weather .mh-windday-cloudmax {
		background: url(http://p7.qhimg.com/t0110050f0f98c11a91.png) no-repeat;
		width: 450px;
		height: 160px;
		position: absolute;
		background-size: contain;
		left: 88px;
		top: 130px;
	}
	#mohe-weather .mh-windday-cloudfront {
		background: url(http://p7.qhimg.com/t0110050f0f98c11a91.png) no-repeat;
		width: 220px;
		height: 71px;
		position: absolute;
		background-size: contain;
		left: 30px;
		top: 180px;
	}
</style>
<div class="mh-dom-wraper">
	<div class="mh-windday-sun"></div>
	<div class="mh-windday-cloudmoon"></div>
	<div class="mh-windday-cloudmax"></div>
	<div class="mh-windday-cloudfront"></div>
</div>
<canvas id="mh-scene-windday"></canvas>
<canvas id="mh-scene-windday-comp1"></canvas>
<canvas id="mh-scene-windday-comp2"></canvas>
<canvas id="mh-scene-windday-comp4"></canvas>
<canvas id="mh-scene-windday-comp5"></canvas>
<script>
	So.onebox.objective('So.onebox.weather.configs.windday',
		{
			sceneId:'mh-scene-windday',
			sceneEle:{
				components:[
					/*树1*/
					{
						position:{
							left:300,
							top:193,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp2',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:100
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
									for (var j = 1; j <= 2; j++) {
										var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
										angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
										width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
										generation = pBranch.generation + j,
										newBranch = this.makeBranch(angle, length, width, generation);
										pBranch.children.push(newBranch);
										this.branch(newBranch);
									}
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
					,
					/*树2*/
					{
						position:{
							left:340,
							top:163,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp4',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:10
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
									for (var j = 1; j <= 2; j++) {
										var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
										angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
										width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
										generation = pBranch.generation + j,
										newBranch = this.makeBranch(angle, length, width, generation);
										pBranch.children.push(newBranch);
										this.branch(newBranch);
									}
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
					,
					/*树3*/
					{
						position:{
							left:400,
							top:163,
							spaceX:50,
							spaceY:-18
						},
						canvas:{
							id:'mh-scene-windday-comp5',
							width:540,
							height:260,
							left:0,
							top:0
						},
						animation:{
							treeNum:1,
							treeSize:10,
							treeColor:'#c27f42',
							treeBrunch:20,
							eles:[],
							timeintval:10
						},
						init:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var treeNum = _this.animation.treeNum;
							var treeSize = _this.animation.treeSize;
							var posX = _this.position.left;
							var posY = _this.position.top;
							var spaceX = _this.position.spaceX;
							var spaceY = _this.position.spaceY;
							var deviation = _this.animation.treeBrunch;
							_this.Tree = function(x, y, size, deviation, generations, minSplits, maxSplits){
								this.x = x;
								this.y = y;
								this.size = size;
								this.deviation = deviation;
								this.minSplits = minSplits;
								this.maxSplits = maxSplits;
								this.generations = generations;
								this.jitter = deviation / 5;
								this.grow();
							};
							_this.Tree.prototype.grow = function () {
							    this.layers = [];
							    this.layers.push(this.makeBranch(-90, this.size, this.size / 10, 0));
							    this.branch(this.layers[0]);
							};
							_this.Tree.prototype.branch = function (pBranch) {
								if (pBranch.generation >= this.generations) {
								  return;
								}
								var add = Math.ceil(pBranch.generation / 3),
								  max = this.maxSplits + add,
								  min = this.minSplits + add,
								  len = Math.round(Math.random() * (max - min) + min),
								  am = this.deviation / len;

								for (var i = 0; i < len; i++) {
								  for (var j = 1; j <= 2; j++) {
								    var length = pBranch.length * .66 / j + Math.random() * (this.jitter * 2) - this.jitter,
								      angle = pBranch.angle + (Math.random() * this.deviation * 2) - this.deviation,
								      width = (pBranch.generation < (this.generations / 2) ? pBranch.width * 1.33 : pBranch.width) * .45 / j,
								      generation = pBranch.generation + j,
								      newBranch = this.makeBranch(angle, length, width, generation);
								    pBranch.children.push(newBranch);
								    this.branch(newBranch);
								  }
								}
								if (Math.random() < .88) {
								  var angle = pBranch.angle + (Math.random() * this.deviation * 4) - this.deviation * 2,
								    length = pBranch.length * .25 + Math.random() * (this.jitter * 2) - this.jitter,
								    width = pBranch.width * .25,
								    generation = pBranch.generation + 2,
								    newBranch = this.makeBranch(angle, length, width, generation);
								  pBranch.children.push(newBranch);
								  this.branch(newBranch);
								}
							};
							_this.Tree.prototype.render = function (context, wind) {
									this.renderBranch(this.layers[0], 0, 0, wind);
							},
							_this.Tree.prototype.makeBranch = function (angle, length, width, generation) {
							    return {
							      angle: angle,
							      length: length,
							      width: width,
							      generation: generation,
							      children: []
							    };
							},
							_this.Tree.prototype.renderBranch = function (branch, x, y, w) {
							    var angle = typeof w === 'undefined' ? branch.angle : branch.angle + (w * Math.pow(branch.generation / this.generations), 3) + w * (branch.generation / this.generations);
							    var rads = angle * (Math.PI / 180),
								endX = x + branch.length * Math.cos(rads),
								endY = y + branch.length * Math.sin(rads);
							    offctx.beginPath();
							    offctx.strokeStyle = _this.animation.treeColor;
							    offctx.moveTo(this.x + x, this.y + y);
							    offctx.lineTo(this.x + endX, this.y + endY);
							    offctx.lineWidth = branch.width;
							    offctx.stroke();
							    offctx.closePath();
							    for (var i = 0; i < branch.children.length; i++) {
							      this.renderBranch(branch.children[i], endX, endY, w + .005);
							    }
							}
							for(var i=0; i<treeNum; i++){
								var tree = new _this.Tree(posX + i * spaceX, posY + i * spaceY, treeSize, deviation, 3, 2, 3);
								_this.animation.eles.push(tree);
							}
						},
						animate:function(){
							var _this = this;
							var width = _this.canvas.width;
							var height = _this.canvas.height;
							var ctx = _this.canvas.ctx;
							var offcanvas = _this.canvas.offcanvas;
							var offctx = _this.canvas.offctx;
							var trees = _this.animation.eles;
							var wind = Math.random() * 12 - 6;
							offctx.clearRect(0, 0, width, height);
							ctx.clearRect(0, 0, width, height);
							for(var i=0; i< trees.length; i++){
								trees[i].render(offctx, wind);
							}
							ctx.drawImage(offcanvas,0,0,width,height);
						}
					}
				]
			}
		}
	);
</script>