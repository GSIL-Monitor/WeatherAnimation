{%strip%}
<style>
	#mohe-weather .mh-temp-chart{
		position: relative;
		top:5px;
		height: 150px;
	}
	#mohe-weather .mh-hover-arc {
		position: absolute;
	    width: 15px;
	    height: 15px;
	    border-radius: 50%;
	    display: none;
	    margin-top: -7px;
	    margin-left: -7px;
	    background-image: radial-gradient(circle,rgba(255,255,255,0),rgba(255,255,255,1));
	}
	#mohe-weather .mh-temp-chart-wrap {
		position: relative;
		left: 40px;
		top: 5px;
	}
	#mohe-weather .mh-coordinate-Y {
	    position: absolute;
	    top: 5px;
	    left: 10px;
	}
	#mohe-weather .mh-coordinate-Y .mh-item-y {
	    width: 20px;
	    text-align: center;
	    height: 23px;
	    line-height: 23px;
	}
	#mohe-weather .mh-coordinate-X {
	    position: absolute;
		width: 444px;
		height: 20px;
		left: 42px;
		bottom: 10px;
	}
	#mohe-weather .mh-coordinate-X .mh-item-x {
	    position: absolute;
	    top:0;
	}
</style>
{%$f3h_data = $result.f3h%}
{%$time = []%}
{%$temp = []%}
{%foreach $f3h_data.temperature as $key=>$item%}
	{%$time[] = $item.jg%}
	{%$temp[] = $item.jb%}
{%/foreach%}
<div class="mh-temp-chart">
	<div class="mh-temp-chart-wrap js-rain-chart-wrap">
		<div class="mh-hover-arc js-hover-arc"></div>
	</div>
	<div class="mh-coordinate-Y js-mh-coordinateY"></div>
	<div class="mh-coordinate-X js-mh-coordinateX">
		{%foreach $time as $item%}
			{%if $item@first%}
				<div class="mh-item-x">
					<span class="mh-text">现在</span>
				</div>
			{%else%}
				<div class="mh-item-x mh-item-x{%$item@index%}">
					<span class="mh-text">{%$item|date_format:"H"%}点</span>
				</div>
			{%/if%}
		{%/foreach%}
	</div>
</div>
<script>
(function(){
		var modules = ['jquery'];

		{%*<!--处理retina屏下canvas显示模糊-->*%}
		{%*<!--https://github.com/jondavidjohn/hidpi-canvas-polyfill-->*%}
		{%*<!--src\fe\onebox\jsplugins\stock_fund\hidpi-HTMLCanvasElement.js-->*%}
		if(window.devicePixelRatio > 1){
			_loader.add('hidpiCanva', 'https://s1.ssl.qhres.com/static/1fab0bd1befc10ca.js');
			modules.push('hidpiCanva');
		}
		if(/MSIE/.test(navigator.userAgent) && !window.addEventListener){
			{%*<!--每次加载前先清除脚本，保证onebox每次加载时都会执行一遍这个脚本-->*%}
			_loader.remove('excanvas');
			_loader.add('excanvas', 'http://s6.qhimg.com/!244d5ddb/2.js');
			modules.push('excanvas');
		}
		_loader.use(modules.join(','),function(){
		var root = $('#mohe-weather');
		var data = {
			faultVal:3,
			lineNum:5,
			extend:{
				initCoordinateY:initCoordinateY,
				initCoordinateX:initCoordinateX
			}
		};
		data.time = $.parseJSON('{%json_encode($time)|escape:"javascript"%}');
		data.temp = $.parseJSON('{%json_encode($temp)|escape:"javascript"%}');
		function Chart(config){
			var _this = this;
			_this.ele= {
				canvasWrap:'#mohe-weather .js-rain-chart-wrap',
				width:444,
				height:105
			},
			_this.chart = {
				width:415,
				height:90,
				offsetLeft:15,
				offsetTop:10,
				bgLineColor:'rgba(255,255,255,.2)',
				bgLineWidth:1.0,
				pointColor:'#fff',
				pointRadio:5,
				curveColor:'#fff',
				curveWidth:2.0
			},
			_this.data = config;
			_this.initCoordinateY = _this.data.extend.initCoordinateY;
			_this.initCoordinateX = _this.data.extend.initCoordinateX;
			_this.initCanvas();
		}
		Chart.prototype = {
			constructor: Chart,
			initCanvas: function(){
				var _this = this;
				var canvasEle = document.createElement('canvas');
				var width = _this.ele.width;
				var height = _this.ele.height;
				var canvasWrap = $(_this.ele.canvasWrap);
				$(canvasEle).width(width)
							.height(height)
							.attr('width',width)
							.attr('height',height)
							.addClass('js-mh-temp-chart');
				/*针对IE8以下低版本浏览器的处理*/
				if(/MSIE/.test(navigator.userAgent) && !window.addEventListener){
					canvasEle=window.G_vmlCanvasManager.initElement(canvasEle);
				}
				
				var canvas = $('.js-mh-temp-chart',canvasWrap);
				_this.ele.canvasWrap = canvasWrap;
				_this.ele.canvasWrap.append(canvasEle);
				_this.ele.canvas = $('.js-mh-temp-chart',canvasWrap)[0];
				/*绘制画布*/
				_this.drawCanvas();
				/*处理数据*/
				_this.detailData();
				/*绘制背景线*/
				_this.drawBgLine();
				/*绘制曲线*/
				_this.drawDataCurve();
				/*绘制关键点*/
				_this.drawPoints();
				/*绘制hover的点*/
				_this.drawhoverPoints();
				/*初始化Y轴数据*/
				_this.initCoordinateY();
				/*初始化X轴样式*/
				_this.initCoordinateX();

			},
			drawCanvas: function(){
				var _this = this;
				if(window.devicePixelRatio > 1){
					var ctx = _this.ele.canvas.getContextHidpi('2d');
				}else{
					var ctx = _this.ele.canvas.getContext('2d');
				}
				_this.ele.ctx = ctx;
				_this.ele.ctx.translate(0.5,0.5);
			},
			detailData: function(){
				var sortNumber = function(a,b)
				{
					return a - b;
				};
				var _this = this;
				/*处理温度数据*/
				var temp = _this.data.temp.slice(0).sort(sortNumber);
				var maxTemp = temp[temp.length-1];
				var minTemp = temp[0];
				_this.data.temp.maxTemp = parseInt(maxTemp)+_this.data.faultVal;
				_this.data.temp.minTemp = parseInt(minTemp)-_this.data.faultVal;
				_this.data.temp.diffTemp = _this.data.temp.maxTemp - _this.data.temp.minTemp;
			},
			getPosition: function(){
				var _this = this;
				var temp = _this.data.temp;
				var time = _this.data.time;
				var posY = 0;
				var posX = 0;
				var posArr = [];
				var posMap ={};
				var xSpace = parseInt(_this.chart.width/(time.length-1));
				for(var i=0 ;i<temp.length;i++){
					posY = parseInt((temp.maxTemp - temp[i])*_this.chart.height/_this.data.temp.diffTemp);
					posX = xSpace * i;
					posX = isNaN(posX) ? 0 : posX + _this.chart.offsetLeft;
					posY = isNaN(posY) ? 0 : posY + _this.chart.offsetLeft;
					posArr.push([posX,posY]);
					posMap[posX] = posY;
				}
				_this.data.position = posArr;
				_this.data.posMap = posMap;
			},
			drawBgLine: function(){
				var _this = this;
				var lineSpace = _this.chart.height/(_this.data.lineNum-1);
				var ctx = _this.ele.ctx;
				var lineY = 0;
				ctx.beginPath();
				ctx.strokeStyle = _this.chart.bgLineColor;
				ctx.lineWidth = _this.chart.bgLineWidth;
				for(var i = 0; i<_this.data.lineNum; i++){
					lineY = parseInt(i * lineSpace)+_this.chart.offsetTop;
					ctx.moveTo(0,lineY);
					ctx.lineTo(_this.ele.width,lineY);
				}
				ctx.stroke();
			},
			drawDataCurve: function(){
				var _this = this;
				_this.getPosition();
				var pointsPos = _this.data.position;
				var ctx = _this.ele.ctx;
				ctx.beginPath();
				ctx.strokeStyle = _this.chart.curveColor;
				ctx.lineWidth = _this.chart.curveWidth;
				for(var i=0; i< pointsPos.length-1; i++){
					ctx.moveTo(pointsPos[i][0],pointsPos[i][1]);
					ctx.lineTo(pointsPos[i+1][0],pointsPos[i+1][1]);
				}
				ctx.stroke();
			},
			drawPoints: function(){
				var _this = this;
				var ctx = _this.ele.ctx;
				_this.getPosition();
				var pointsPos = _this.data.position;
				for(var i=0; i< pointsPos.length; i++){
					ctx.beginPath();
					ctx.fillStyle = _this.chart.pointColor;
					ctx.arc(pointsPos[i][0],pointsPos[i][1],_this.chart.pointRadio,0,Math.PI*2,true);
					ctx.font="12px Arial";
					ctx.fillText(_this.data.temp[i]+'℃',pointsPos[i][0]-15,pointsPos[i][1]-15);
					ctx.fill();
				}
			},
			drawhoverPoints: function(){
				var _this = this;
				_this.getPosition();
				var pointsXpos = _this.data.posMap;
				var mouseP =0;
				var canvasWrap = $('.js-rain-chart-wrap',root);
				var canvasOffsetTop = 0;
				var canvasOffsetLeft = 0;
				var rangeXarr = [];
				var range = 6;
				$.each(_this.data.posMap,function(index,item){
					index = parseInt(index);
					var max = index+range;
					var min = index-range;
					rangeXarr.push([max,min]);
				});
				canvasWrap.on('mousemove',function(e){
					canvasOffsetLeft = canvasWrap.offset().left;
					mouseP = e.clientX-canvasOffsetLeft;
					for(var i= 0; i<rangeXarr.length; i++){
						if(mouseP >= rangeXarr[i][1] && mouseP <= rangeXarr[i][0]){
							$('.js-hover-arc',root).show().css('left',_this.data.position[i][0]).css('top',_this.data.position[i][1]);
							break;
						}
					}
				})
				.on('mouseleave',function(){
					$('.js-hover-arc',root).hide();
				});
			},
			initExtend: function(){
				var _this = this;
				_this.Extend.apply(_this, [].slice.call(arguments));
			}
		};
		function initCoordinateY(){
			var _this = this;
			var dataYnum = 5;
			var dataY = _this.data.temp;
			var dataYspan = '';
			dataySpace = parseInt(dataY.diffTemp/(dataYnum-1));
			var coodinateyWrap = $('.js-mh-coordinateY',root);
			for(var i=0; i< dataYnum; i++){
				dataYspan += '<div class="mh-item-y"><span class="mh-text">'+(dataY.maxTemp-(i*dataySpace))+'</span></div>';
			}
			coodinateyWrap.append(dataYspan);
		};
		function initCoordinateX(){
			var _this = this;
			var dataPos = _this.data.position;
			var widthSpace = dataPos[1][0] - dataPos[0][0];
			var itemXdom = $('.mh-item-x',root);
			for(var i =0; i< 9; i++){
				itemXdom.eq(i).css('left',widthSpace*i);
			}
		};
		/*针对IE8低版本兼容,将不兼容IE的canvas移除*/
		if(/MSIE ([0-8])/.test(navigator.userAgent) && !window.addEventListener){
			$('.mh-canvas-wrap-box',root).find('canvas').remove();
		}
		new Chart(data);
		/*针对IE8低版本兼容，在隐藏状态下无法初始化折线图*/
		$('.mh-temp24-chart-wrap',root).addClass('mh-hidden');
		$('.mh-temp24-chart-wrap',root).css('position','static');
	});
})();
</script>
{%/strip%}