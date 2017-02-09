{%**
 * @新版天气
 * @desc 数据接口wiki: http://add.corp.qihoo.net/pages/viewpage.action?pageId=5901762
 * @desc 模板逻辑wiki: http://wiki.bangbangde.com/pages/viewpage.action?pageId=8195691
**%}
{%extends 'modules/inc/base.tpl'%}
{%block 'id'%}weather{%/block%}
{%block 'css'%}
<style>
	#mohe-weather {
		position: relative;
		*zoom:1;
		width: 540px;
	}
	#mohe-weather h3.title {
		padding-bottom: 3px;
	}
	#mohe-weather .mh-history {
		font-size: 12px;
		line-height: initial;
		color: #999;
	}
	#mohe-weather .mh-cont {
		font-size: 12px;
		position: relative;
		padding-top: .1px;
		*zoom:1;
	}
	#mohe-weather .mh-hidden{
		display: none;
	}
	#mohe-weather .mh-cont a{
		color:#fff;
		text-decoration: none;
		display:block;
	}
	#mohe-weather .mh-dom-wraper{
		display:none;
	}
	/*动画*/
	/*旋转*/
	@keyframes mh-weather-rotate{
		to{
			transform: rotate(1turn);
		}
	}
	@-moz-keyframes mh-weather-rotate{
		to{
			transform: rotate(1turn);
		}
	}
	@-webkit-keyframes mh-weather-rotate{
		to{
			transform: rotate(1turn);
		}
	}
	@-o-keyframes mh-weather-rotate{
		to{
			transform: rotate(1turn);
		}
	}
	
	@keyframes mh-weather-fognight-sealightRotate{
		0%{
			transform: rotate(30deg);
		}
		100%{
			transform: rotate(-30deg);
		}
	}
	@-moz-keyframes mh-weather-fognight-sealightRotate{
		0%{
			transform: rotate(30deg);
		}
		100%{
			transform: rotate(-30deg);
		}
	}
	@-webkit-keyframes mh-weather-fognight-sealightRotate{
		0%{
			transform: rotate(30deg);
		}
		100%{
			transform: rotate(-30deg);
		}
	}
	@-o-keyframes mh-weather-fognight-sealightRotate{
		0%{
			transform: rotate(30deg);
		}
		100%{
			transform: rotate(-30deg);
		}
	}
	
	/*透明度*/
	@keyframes mh-weather-opacity{
		from{
			opacity: 0.3;
		}
		to{
			opacity: 0;
		}
	}
	@-moz-keyframes mh-weather-opacity{
		from{
			opacity: 0.3;
		}
		to{
			opacity: 0;
		}
	}
	@-webkit-keyframes mh-weather-opacity{
		from{
			opacity: 0.3;
		}
		to{
			opacity: 0;
		}
	}
	@-o-keyframes mh-weather-opacity{
		from{
			opacity: 0.3;
		}
		to{
			opacity: 0;
		}
	}
	
	/*缩放*/
	@keyframes mh-weather-scale{
		from{
			transform:scale(0);
		}
		to{
			transform:scale(1);
		}
	}
	@-moz-keyframes mh-weather-scale{
		from{
			transform:scale(0);
		}
		to{
			transform:scale(1);
		}
	}
	@-webkit-keyframes mh-weather-scale{
		from{
			transform:scale(0);
		}
		to{
			transform:scale(1);
		}
	}
	@-o-keyframes mh-weather-scale{
		from{
			transform:scale(0);
		}
		to{
			transform:scale(1);
		}
	}
	
	@keyframes mh-weather-fognight-sealightScale{
		0%{
			transform: scale(.3);
		}
		100%{
			transform: scale(1.3);
		}
	}
	@-moz-keyframes mh-weather-fognight-sealightScale{
		0%{
			transform: scale(.3);
		}
		100%{
			transform: scale(1.3);
		}
	}
	@-webkit-keyframes mh-weather-fognight-sealightScale{
		0%{
			transform: scale(.3);
		}
		100%{
			transform: scale(1.3);
		}
	}
	@-o-keyframes mh-weather-fognight-sealightScale{
		0%{
			transform: scale(.3);
		}
		100%{
			transform: scale(1.3);
		}
	}
	/*平移*/
	@keyframes mh-weather-cloudday-cloud-top{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,-10px,0);
		}
	}
	@-moz-keyframes mh-weather-cloudday-cloud-top{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,-10px,0);
		}
	}
	@-webkit-keyframes mh-weather-cloudday-cloud-top{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,-10px,0);
		}
	}
	@-o-keyframes mh-weather-cloudday-cloud-top{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,-10px,0);
		}
	}
	
	@keyframes mh-weather-cloudday-cloud-middle{
		0%{
			transform: translate3d(-15px,0px,0);
		}
		100%{
			transform: translate3d(0px,10px,0);
		}
	}
	@-moz-keyframes mh-weather-cloudday-cloud-middle{
		0%{
			transform: translate3d(-15px,0px,0);
		}
		100%{
			transform: translate3d(0px,10px,0);
		}
	}
	@-webkit-keyframes mh-weather-cloudday-cloud-middle{
		0%{
			transform: translate3d(-15px,0px,0);
		}
		100%{
			transform: translate3d(0px,10px,0);
		}
	}
	@-o-keyframes mh-weather-cloudday-cloud-middle{
		0%{
			transform: translate3d(-15px,0px,0);
		}
		100%{
			transform: translate3d(0px,10px,0);
		}
	}
	
	@keyframes mh-weather-cloudday-cloud-bottom{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-moz-keyframes mh-weather-cloudday-cloud-bottom{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-webkit-keyframes mh-weather-cloudday-cloud-bottom{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-o-keyframes mh-weather-cloudday-cloud-bottom{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	
	@keyframes mh-weather-cloudday-cloud1{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(20px,0px,0);
		}
	}
	@-moz-keyframes mh-weather-cloudday-cloud1{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(20px,0px,0);
		}
	}
	@-webkit-keyframes mh-weather-cloudday-cloud1{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(20px,0px,0);
		}
	}
	@-o-keyframes mh-weather-cloudday-cloud1{
		0%{
			transform: translate3d(0px,0px,0);
		}
		100%{
			transform: translate3d(20px,0px,0);
		}
	}
	
	@keyframes mh-weather-cloudday-cloud2{
		0%{
			transform: translate3d(-10px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-moz-keyframes mh-weather-cloudday-cloud2{
		0%{
			transform: translate3d(-10px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-webkit-keyframes mh-weather-cloudday-cloud2{
		0%{
			transform: translate3d(-10px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	@-o-keyframes mh-weather-cloudday-cloud2{
		0%{
			transform: translate3d(-10px,0px,0);
		}
		100%{
			transform: translate3d(10px,0px,0);
		}
	}
	/*swing*/
	@-moz-keyframes mh-weather-cloudday-swing {
	  20% {
	    -webkit-transform: rotate3d(0, 0, 1, 15deg);
	    transform: rotate3d(0, 0, 1, 15deg);
	  }

	  40% {
	    -webkit-transform: rotate3d(0, 0, 1, -10deg);
	    transform: rotate3d(0, 0, 1, -10deg);
	  }

	  60% {
	    -webkit-transform: rotate3d(0, 0, 1, 5deg);
	    transform: rotate3d(0, 0, 1, 5deg);
	  }

	  80% {
	    -webkit-transform: rotate3d(0, 0, 1, -5deg);
	    transform: rotate3d(0, 0, 1, -5deg);
	  }

	  to {
	    -webkit-transform: rotate3d(0, 0, 1, 0deg);
	    transform: rotate3d(0, 0, 1, 0deg);
	  }
	}
	@-o-keyframes mh-weather-cloudday-swing {
	  20% {
	    -webkit-transform: rotate3d(0, 0, 1, 15deg);
	    transform: rotate3d(0, 0, 1, 15deg);
	  }

	  40% {
	    -webkit-transform: rotate3d(0, 0, 1, -10deg);
	    transform: rotate3d(0, 0, 1, -10deg);
	  }

	  60% {
	    -webkit-transform: rotate3d(0, 0, 1, 5deg);
	    transform: rotate3d(0, 0, 1, 5deg);
	  }

	  80% {
	    -webkit-transform: rotate3d(0, 0, 1, -5deg);
	    transform: rotate3d(0, 0, 1, -5deg);
	  }

	  to {
	    -webkit-transform: rotate3d(0, 0, 1, 0deg);
	    transform: rotate3d(0, 0, 1, 0deg);
	  }
	}
	@-webkit-keyframes mh-weather-cloudday-swing {
	  20% {
	    -webkit-transform: rotate3d(0, 0, 1, 15deg);
	    transform: rotate3d(0, 0, 1, 15deg);
	  }

	  40% {
	    -webkit-transform: rotate3d(0, 0, 1, -10deg);
	    transform: rotate3d(0, 0, 1, -10deg);
	  }

	  60% {
	    -webkit-transform: rotate3d(0, 0, 1, 5deg);
	    transform: rotate3d(0, 0, 1, 5deg);
	  }

	  80% {
	    -webkit-transform: rotate3d(0, 0, 1, -5deg);
	    transform: rotate3d(0, 0, 1, -5deg);
	  }

	  to {
	    -webkit-transform: rotate3d(0, 0, 1, 0deg);
	    transform: rotate3d(0, 0, 1, 0deg);
	  }
	}
	@keyframes swing {
	  20% {
	    -webkit-transform: rotate3d(0, 0, 1, 15deg);
	    transform: rotate3d(0, 0, 1, 15deg);
	  }

	  40% {
	    -webkit-transform: rotate3d(0, 0, 1, -10deg);
	    transform: rotate3d(0, 0, 1, -10deg);
	  }

	  60% {
	    -webkit-transform: rotate3d(0, 0, 1, 5deg);
	    transform: rotate3d(0, 0, 1, 5deg);
	  }

	  80% {
	    -webkit-transform: rotate3d(0, 0, 1, -5deg);
	    transform: rotate3d(0, 0, 1, -5deg);
	  }

	  to {
	    -webkit-transform: rotate3d(0, 0, 1, 0deg);
	    transform: rotate3d(0, 0, 1, 0deg);
	  }
	}
	
	/* 背景图 */
	#mohe-weather .mh-bg-img-sunday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sunday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sunday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sundayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-sunnight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sunnight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sunnight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/sunnightx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-cloudday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/cloudday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/cloudday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/clouddayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-cloudnight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/cloudnight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/cloudnight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/cloudnightx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-windday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/windday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/windday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/winddayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-windnight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/windnight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/windnight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/windnightx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-thunderstormday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormdayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-thunderstormnight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormnight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormnight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/thunderstormnightx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-snowday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snowday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snowday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snowdayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-snownight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snownight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snownight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/snownightx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-fogday{
		background-image: url(https://p0.ssl.qhimg.com/t019a21cff640d24f45.png);
		background-image: -webkit-image-set(url(https://p0.ssl.qhimg.com/t019a21cff640d24f45.png) 1x,url(https://p2.ssl.qhimg.com/t01508c4b53e8686dbb.png) 2x);
	}
	#mohe-weather .mh-bg-img-fognight{
		background-image: url(https://p3.ssl.qhimg.com/t0153a7bdba43def9d1.png);
		background-image: -webkit-image-set(url(https://p3.ssl.qhimg.com/t0153a7bdba43def9d1.png) 1x,url(https://p0.ssl.qhimg.com/t019a6a1ec100baee47.png) 2x);
	}
	#mohe-weather .mh-bg-img-rainday{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/rainday.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/rainday.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/raindayx2.png) 2x);
	}
	#mohe-weather .mh-bg-img-rainnight{
		background-image: url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/rainnight.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/rainnight.png) 1x,url(http://p0.qhimg.com/d/inn/d5d7fbcb/bg-s/rainnightx2.png) 2x);
	}
	
	#mohe-weather .mh-bg-img-nocanvas-sunday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-sunnight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunnight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunnight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunnight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunnight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/sunnight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-cloudday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-cloudnight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudnight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudnight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudnight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudnight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/cloudnight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-windday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-windnight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windnight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windnight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windnight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windnight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/windnight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-thunderstormday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-thunderstormnight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormnight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormnight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormnight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormnight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/thunderstormnight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-snowday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snowday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snowday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snowday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snowday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snowday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-snownight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snownight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snownight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snownight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snownight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/snownight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-fogday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fogday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fogday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fogday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fogday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fogday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-fognight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fognight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fognight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fognight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fognight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/fognight.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-rainday{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainday.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainday.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainday.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainday.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainday.png);
	}
	#mohe-weather .mh-bg-img-nocanvas-rainnight{
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainnight.png)\0;
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainnight.png)\9;
		*background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainnight.png);
		_background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainnight.png);
		background-image:url(http://p2.qhimg.com/d/inn/ef209efd/bg-s-ie/rainnight.png);
	}
	/* 今天天气 */
	
	#mohe-weather .mh-date-wraper {
	    position: relative;
	    z-index: 2;
	    margin-top: 260px;
	    padding: 20px;
	}
	#mohe-weather .mh-date-wraper .mh-active {
		display: block;
	}
	#mohe-weather .mh-date {
		position: relative;
		display: none;
		top:-270px;
	}
	
	/* 日期描述 */
	#mohe-weather .mh-time-mask-wrap {
		position: absolute;
		top: 5px;
		font: 12px/1.2 "Microsoft Yahei";
		color: #fcfcfc;
		text-shadow: 1px 1px 2px rgba(0,0,0,.2);
	}
	#mohe-weather .mh-txt {
		display: inline-block;
		padding: 5px 10px 5px 0px;
		background: #fff;
		position: relative;
		width: 92px;
		left: 14px;
		height: 24px;
	}
	#mohe-weather .mh-txt-wrap {
		overflow: hidden;
		width: 100px;
		position: relative;
		left: 36px;
		opacity: .2;
		height: 24px;
		top: 3px;
	}
	#mohe-weather .mh-txt-wrap:before {
		content: '';
		display: inline-block;
		width: 20px;
		height: 26px;
		border-radius: 50%;
		border: 11px solid #fff;
		margin-left: -62px;
		margin-top: -31px;
		position: absolute;
		top: 19px;
		left: 37px;
	}
	#mohe-weather .mh-rl-icon {
		display: inline-block;
		width: 16px;
		height: 16px;
		background: rgba(255,255,255,.2);
		background-image: url(http://p0.qhimg.com/d/inn/09afb3a3/lx_20160831172845.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/09afb3a3/lx_20160831172845.png) 1x,url(http://p0.qhimg.com/d/inn/09afb3a3/lx_20160831172905.png) 2x);
		vertical-align: -2px;
		position: absolute;
		left: 4px;
		padding: 7px;
		background-repeat: no-repeat;
		border-radius: 50%;
		background-position: 7px;
		background-size: 16px;
	}
	#mohe-weather .mh-rl-icon-bg {
	    display: inline-block;
	    width: 22px;
	    height: 22px;
	    border-radius: 50%;
	    background: rgba(255,255,255,.4);
	}
	#mohe-weather .mh-time {
	    position: absolute;
	    color: #fff;
	    top: 28px;
	    right: 5px;
	    height: 20px;
	    width: 80px;
	    overflow: hidden;
	}
	#mohe-weather .mh-time-list{
	    position: relative;
	}
	#mohe-weather .mh-time-list .mh-time-item {
		position: absolute;
		width: 80px;
		height: 20px;
	}
	#mohe-weather .mh-time  .mh-time-item{
		cursor: default;
	}
	#mohe-weather .mh-time-list .mh-time-item:nth-child(2){
		top: 20px;
	}
	#mohe-weather .mh-date-wraper .mh-tab-cont .mh-active {
		display: block;
		background-image: linear-gradient(to bottom,rgba(255,255,255,0) 0%,rgba(255,255,255,.1) 10%,rgba(255,255,255,.2) 20%,rgba(255,255,255,.1) 90%,rgba(255,255,255,0) 100%);
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#10ffffff, endColorstr=#10ffffff);
	}
	#mohe-weather .mh-date .mh-desc {
		position: absolute;
		left: 5px;
		top: 28px;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-h {
		font: 60px/1 "Microsoft Yahei";
		color: #fff;
		text-shadow: 2px 4px 9px rgba(0,0,0,.2);
		margin-right: 10px;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-1 {
		font: 54px/1 "Microsoft Yahei";
		color: #fdfdfd;
		text-shadow: 1px 2px 2px rgba(0,0,0,.1);
		float: left;
		margin-right: 6px;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-1 .ico-temp {
		padding:0 3px;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-1 .mh-ico-temp{
		*display: inline-block;
		display: inline-block\9;
		_display: inline-block;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-1 .mh-ico-num {
	    font-size: 60px;
	    *display: inline-block;
	    display: inline-block\9;
	    _display: inline-block;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-1 .mh-ico-unit {
		margin-left: 2px;
		font-size: 24px;
		line-height: 34px;
		vertical-align: top;
		 *display: inline-block;
	    display: inline-block\9;
	    _display: inline-block;
	}
	#mohe-weather .mh-date .mh-desc .mh-right-txt{
		float:left;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-3,
	#mohe-weather .mh-date .mh-desc .mh-desc-4
	{
		font: 14px/1.2 "Microsoft Yahei";
		color: #fdfdfd;
		text-shadow: 1px 1px 1px rgba(0,0,0,.2) ;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-3 {
		white-space: nowrap;
		margin-top: 8px;
		*margin-top: 12px;
		margin-top: 8px\9;
	}
	#mohe-weather .mh-date .mh-desc .mh-desc-4 {
	    width: 100px;
	    margin-top: 9px;
	    
	}
	#mohe-weather .mh-date .mh-desc.mh-desc-margin,#mohe-weather .mh-date .mh-desc.mh-desc-margin .mh-desc-1{
		width: 300px;
		*height: 60px;
		height: 60px\9;
		_height: 60px;
	}
	#mohe-weather .mh-date .mh-desc-PM {
		font: 16px "Microsoft Yahei";
		position: absolute;
		top: 90px;
		left: 5px;
		font-size: 16px;
	}
	#mohe-weather .mh-pm25 {
		display: inline-block;
		max-width: 80px;
		*width:80px;
		height: 20px;
		line-height: 20px;
		text-align: center;
		color: #fff;
		border-radius: 2px;
		text-shadow: 1px 2px 2px rgba(0,0,0,0);
		padding: 0px 6px;
	}
	#mohe-weather .mh-pm25-level-1 {
		background-color: #72d572;
	}
	#mohe-weather .mh-pm25-level-2 {
		background-color: #ffc107;
	}
	#mohe-weather .mh-pm25-level-3 {
		background-color: #ff6900;
	}
	#mohe-weather .mh-pm25-level-4 {
		background-color: #ee001c;
	}
	#mohe-weather .mh-pm25-level-5 {
		background-color: #ad0016;
	}
	#mohe-weather .mh-pm25-level-6 {
		background-color: #7c0549;
	}
	#mohe-weather .mh-dressing-wrap,#mohe-weather .mh-rainning-wrap,#mohe-weather .mh-temp24-chart-wrap,#mohe-weather .mh-date-list {
	    background: rgba(255,255,255,.2);
	    filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#10ffffff, endColorstr=#10ffffff);
	    *opacity: .2;
	    height: 150px;
	    color:#fff;
	}
	#mohe-weather .mh-temp24-chart-wrap{
		position:absolute;
	}
	/*降水*/
	#mohe-weather .mh-rain-list {
	    padding-top: 25px;
	}
	#mohe-weather .mh-rain-item {
	    float: left;
	    width: 55px;
	    text-align: center;
	    position: relative;
	}
	#mohe-weather .mh-rain-item:not(:last-child):after {
	    content: '';
	    display: inline-block;
	    width: 1px;
	    height: 60px;
	    background: rgba(255,255,255,.2);
	    position: absolute;
	    right: 0;
	    top: 20px;
	}
	#mohe-weather .mh-rain-icon {
	    width: 26px;
	    height: 28px;
	    margin: 20px auto;
	    background-repeat: no-repeat;
	    background-size: cover;
	    background-image: url(http://p0.qhimg.com/d/inn/84f9b032/rain2.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/84f9b032/rain2.png) 1x,url(http://p0.qhimg.com/d/inn/ca468dd5/rainx2.png) 2x);
	}
	#mohe-weather .mh-rain-icon.mh-rain-level1 {
	    background-position: 5px -31px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level2 {
	    background-position: 5px -62px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level3 {
	    background-position: 5px -93px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level4 {
	    background-position: 5px -124px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level5 {
	    background-position: 5px -154px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level6 {
	    background-position: 5px -186px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level7 {
	    background-position: 5px -216px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level8 {
	    background-position: 5px -247px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level9 {
	    background-position: 5px -277px;
	}
	#mohe-weather .mh-rain-icon.mh-rain-level10 {
	    background-position: 5px -308px;
	}
	/* 日期列表 */
	#mohe-weather .mh-date-list li {
		float: left;
	    width: 20%;
	    text-align: center;
	    cursor: pointer;
	    margin-top: 10px;
	}
	#mohe-weather .mh-date-list li .mh-desc {
		height: 124px;
		margin: 0 3px;
	}
	#mohe-weather .mh-date-list p {
		white-space: nowrap;
		overflow: hidden;
		text-overflow:ellipsis;
	}
	#mohe-weather .mh-bg-weather{
		display: inline-block;
		width: 42px;
		height: 42px;
	}
	/*相关指数*/
	#mohe-weather .mh-dressing-li {
		float: left;
		width: 215px;
		height: 40px;
		line-height: 40px;
        *border-bottom: 1px solid #fff;
        _border-bottom: 1px solid #fff;
        border-bottom: 1px solid #fff\0;
        border-bottom: 1px solid rgba(255,255,255,.2);
		color: #fff;
		margin-left: 23px;
		position: relative;
	}
	#mohe-weather .mh-hover-wrap {
	    width: 303px;
	    background: rgba(255,255,255,.9);
	    background: #ffffff\9;
	    _background: #ffffff;
	    *background: #ffffff;
	    *zoom:1;
	    color: #333;
	    z-index: 999;
	    position: absolute;
	    left: -14px;
	    top: 40px;
	    padding: 10px;
	    height: 80px;
	    box-shadow: 1px 2px 2px rgba(0,0,0,.1);
	    display:none;
	}
	#mohe-weather .mh-dressing-li .mh-dress-txt:hover +.mh-hover-wrap{
		display:block;
	}
	#mohe-weather .mh-hover-wrap:before {
	    content: '';
	    display: inline-block;
	    position: absolute;
	    top: -6px;
	    border: 6px solid rgba(255,255,255,.9);
	    -webkit-transform: rotateZ(45deg);
	    -moz-transform: rotateZ(45deg);
	    -ms-transform: rotateZ(45deg);
	    -o-transform: rotateZ(45deg);
	    transform: rotateZ(45deg);
	    border:none\9;
	    left: 17px;
	    border-right-color: transparent;
	    border-bottom-color: transparent;
	}
	#mohe-weather .mh-hover-wrap p {
	    line-height: 20px;
	    height: 20px;
	    padding-bottom: 4px;
	}
	#mohe-weather .mh-hover-title {
	    font-weight: bold;
	    font-size: 13px;
	}
	#mohe-weather .mh-dress-list{
		padding-top:3px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-txt{
		background-image: url(http://p0.qhimg.com/d/inn/fa3eb07f/icon55.png);
		background-image: -webkit-image-set(url(http://p0.qhimg.com/d/inn/fa3eb07f/icon55.png) 1x,url(http://p0.qhimg.com/t01770a2592be4afd7f.png) 2x);
	    background-size: 20px;
	    background-repeat: no-repeat;
	    line-height: 22px;
	    height: 22px;
	    display: inline-block;
	    padding-left: 30px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-chuanyi{
		background-position:0 -70px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-ganmao {
	    background-position: 0 -94px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-wuran {
	    background-position: 0 -23px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-xiche {
	    background-position: 0 -119px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-yundong {
	    background-position: 0 -144px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-yinliao {
	    background-position: 0 -47px;
	}
	#mohe-weather .mh-dressing-li .mh-dress-ziwaixian {
		background-position: 0 -170px;
	}
	/*场景*/
	#mohe-weather .mh-canvas-mod,#mohe-weather .mh-canvas-wrap {
		position: absolute;
	    top: 0px;
	    left: 0px;
	}
	#mohe-weather .mh-canvas-wrap {
	    line-height: 0;
	    background-repeat: no-repeat;
	    background-size: contain;
	    width: 540px;
		height: 260px;
		position: absolute;
	}
	#mohe-weather .mh-canvas-wrap .mh-canvas-wrap-box{
		position: absolute;
		z-index: 2;
		width: 540px;
		height: 260px;
		overflow: hidden;
	}
	#mohe-weather .mh-bg {
	    width: 540px;
	    height: 480px;
	    position: absolute;
	}
	/*预警报告*/
	/*预警icon*/
	#mohe-weather .mh-alert {
	    font-size: 13px;
		color: #fff;
		height: 34px;
		width: 100%;
		line-height: 34px;
		background: rgba(0,0,0,.2);
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#20000000, endColorstr=#20000000);
		position: absolute;
		top: -260px;
		left: 0px;
	}
	#mohe-weather .mh-alert .mh-alert-txt {
	    padding-left: 31px;
	    display: inline-block;
	    height: 34px;
	    line-height: 34px;
	    margin-left: 10px;
	    background-size: 24px;
	    background-repeat: no-repeat;
	    background-position: 0 4px;
	}
	/*背景色*/
	#mohe-weather .mh-bg-sunday{
		background-color:#1bacad;
	}
	#mohe-weather .mh-bg-sunnight{
		background-color:#0d4c7c;
	}
	#mohe-weather .mh-bg-cloudday{
		background-color:#5492c8;
	}
	#mohe-weather .mh-bg-cloudnight{
		background-color:#2BA8E1;
	}
	#mohe-weather .mh-bg-rainday{
		background-color:#0d4c80;
	}
	#mohe-weather .mh-bg-rainnight{
		background-color:#11379b;
	}
	#mohe-weather .mh-bg-thunderstormday{
		background-color:#1b1948;
	}
	#mohe-weather .mh-bg-thunderstormnight{
		background-color:#491e2f;
	}
	#mohe-weather .mh-bg-snowday{
		background-color:#80aac4;
	}
	#mohe-weather .mh-bg-snownight{
		background-color:#789fb9;
	}
	#mohe-weather .mh-bg-windday{
		background-color:#e2ac6b;
	}
	#mohe-weather .mh-bg-windnight{
		background-color:#727473;
	}
	#mohe-weather .mh-bg-fogday{
		background-color:#92afae;
	}
	#mohe-weather .mh-bg-fognight{
		background-color:#2b4057;
	}
	/*tab切换*/
	#mohe-weather .mh-tab-wrap {
	    color: #fff;
	}
	#mohe-weather .mh-tab-wrap li{
		float: left;
		width: 124.2px;
		*width: 124px;
		width: 124px\9;
		_width: 124px;
		margin-left: 1px\9;
		*margin-left: 1px;
		height: 30px;
		line-height: 30px;
		text-align: center;
		background: rgba(255,255,255,.4);
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#30ffffff, endColorstr=#30ffffff);
		*zoom:1;
	}
	#mohe-weather .mh-tab-wrap li:hover{
		cursor: pointer;
	}
	#mohe-weather .mh-tab-wrap li:not(:first-child){
		margin-left: 1px;
	}
	#mohe-weather .mh-tab-wrap li.mh-tab-active{
		background: rgba(255,255,255,.2);
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#20ffffff, endColorstr=#20ffffff);
	}
	/*切换城市*/
	#mohe-weather .mh-setting{
	    margin-top: 5px;
	}
	#mohe-weather .mh-label {
	    float: left;
	    color:#999;
	    padding-right: 10px;
	}
	#mohe-weather input.mh-done {
	    background: #33c25f;
	    border: none;
	    color: #fff;
	    display: inline-block;
	    width: 40px;
	    line-height: 20px;
	    margin-left: 5px;
	    border-radius: 2px;
	}
	#mohe-weather .sel-cont select {
	    color: #666;
	}
	#mohe-weather .mh-info {
	    margin-top: 5px;
	    color: #666;
	}
</style>
{%/block%}
{%block 'content'%}
{%if $rank <= 3%}
<script>
	 (function(){
		 var objective = function(objStr,value){
			var argsNum = arguments.length;
			if(argsNum === 0)return;
			var keys = objStr.split('.');
			var len = keys.length;
			var fnBody = [];
			var i = 0;
			if(argsNum === 1){
				fnBody.push('try{return ' + objStr + ';}catch(e){}');
			}else{
				while(i++ < len - 1){
					var key = keys.slice(0,i).join('.');
					if(i === 1){
						fnBody.push('window["' + key + '"] = window["' + key + '"] || {}');
					}else{
						fnBody.push(key + ' = ' + key + ' || {}');
					}
				};
				fnBody.push(objStr + '= __value__');
			}
			return (new Function('__value__',fnBody.join(';')))(value);
		};
	 	objective('So.onebox.objective',objective);
	}());
</script>
<div>
	<div class="mh-tempcont js-mh-tempcont">
		{%include file="ajax/weather_ajax.tpl"%}
	</div>
	{%*<!--切换城市-->*%}
	{%if $result.isForeign !== 1 && empty($result.jingqutq)%}
		<div class="mh-setting g-clearfix">
			<div class="mh-label">切换城市 -  </div>
			<div class="sel-cont">
				<select name="weather-prov" class="js-weather-prov"></select>
				<select name="weather-city" class="js-weather-city"></select>
				<select name="weather-town" class="js-weather-town"></select>
				<input type="button" value="更换" class="mh-done js-get-weather" data-md='{"p":"change"}'>
			</div>
		</div>
	{%/if%}
	<p class="mh-info">
		中国气象局
		{%if !empty($result.realtime.date) && !empty($result.realtime.time)%}
			{%$result.realtime.date|date_format:'Y年m月d日'%}
			{%substr($result.realtime.time, 0, 2)%}时
		{%else if !empty($result.pubtime) && !empty($result.pubdate)%}
			{%$result.pubdate|date_format:'Y年m月d日'%}
			{%substr($result.pubtime, 0, 2)%}时
		{%/if%}
		发布&nbsp;&nbsp;<a target='_blank' href="http://www.weather.com.cn/weather/{%$result.area[2][1]%}.shtml" class="js-mh-more-weather">7天预报</a>&nbsp;&nbsp;<a target='_blank' href="http://www.weather.com.cn/weather15d/{%$result.area[2][1]%}.shtml" class="js-mh-more-weather">8-15天预报</a>&nbsp;&nbsp;<a target='_blank' href="http://info.so.360.cn/feedback.html?src=tianqi" class="mh-feedback">建议</a>
		{%* <a target='_blank' href="http://www.weather.com.cn/weather/{%$result.area[2][1]%}.shtml#7d" class="js-mh-more-weather">未来多天预报</a> -  <a target='_blank' href="http://tq.360.cn/">更多城市</a> *%}
	</p>
	<cite>www.weather.com.cn/ {%$smarty.now|date_format:'Y-m-d'%}</cite>
</div>
{%else%}
<!-- {%*弱展现*%} -->
{%include file="modules/inc/weather/weather_weak.tpl"%}
{%/if%}
{%/block%}
{%block 'js'%}
{%if $rank <= 3%}
<script>
	try{
		PageLine.fill({"cat":'weather-moni',"md-p":"strong-pv"});
	}catch(ex){}
</script>
<script>

_loader.add('json2','http://s3.qhimg.com/static/70cdb7b6494e61b5/json2.js');
_loader.add('cookie','http://s2.qhimg.com/static/8718dededc520733/cookie.js');
(function(){
	var modules = ['jquery'];
	if(!/MSIE/.test(navigator.userAgent)){
		_loader.add('hidpiCanva', 'https://s1.ssl.qhres.com/static/1fab0bd1befc10ca.js');
		modules.push('hidpiCanva');
	}
	_loader.use(modules.join(','), function(){
		var root = $('#mohe-weather'),
		weatherEl = $('.js-mh-bg-img', root),
		dateEl = $('.js-mh-date', root),
		SceneMap = $.parseJSON('{%json_encode($SceneMap)|escape:"javascript"%}');
		So.onebox.weather = !So.onebox.weather ? {} : So.onebox.weather;
		So.onebox.weather.sceneArr = {};
		var lastTime = 0;
		if(!/MSIE/.test(navigator.userAgent)){
			if($('.mh-dom-wraper')){
				$('.mh-dom-wraper').show();
			}
		}
		if(window.addEventListener && document.createElement('canvas').getContextHidpi('2d')){
			/*
			 * 加载场景画布
			 */
			So.onebox.objective('So.onebox.weather.load', function(data){
				$.each(data,function(key,val){
					var n = new Scene(So.onebox.weather.configs[key]);
					n.initCanvas();
					So.onebox.weather.sceneArr[key] = n;
				});
			});
			So.onebox.objective('So.onebox.weather.init', function(){
				/*处理数据*/
				if(So.onebox.weather.configs !== undefined && So.onebox.weather.configs !== null){
					So.onebox.weather.load(So.onebox.weather.configs);
					setTimeout(function(){
						stopAllAni();
						changeScene(0);
					},3600);
					visibleListen();
				}
			});
			/*
			 * 场景画布
			 */
			var Scene = function(config){
				var _this = this;
				_this.ele = {
					canvasWrap:'#mohe-weather .js-mh-canvas-wrap',
					width:540,
					height:260
				},
				_this.scene = config;
				_this.sceneDataArr = [];
				_this.extend = {};
				$.each(_this.scene.sceneEle.components,function(index,item){
					_this.sceneDataArr.push([item]);
				});
			}
			Scene.prototype = {
				constructor:Scene,
				initCanvas: function(){
					var _this = this;
					var canvasWrap = $(_this.ele.canvasWrap);
					var canvasId = _this.scene.sceneId;
					var canvas = document.getElementById(canvasId);
					var width = _this.ele.width;
					var height = _this.ele.height;
					_this.ele.canvas = canvas;
					$(canvas).width(width)
							.height(height)
							.attr('width',width)
							.attr('height',height);
					/*绘制场景*/
					_this.drawScene().then(function(){
						_this.loadCompAnimate();
					});
					
				},
				drawScene: function(){
					var _this = this;
					var ctx = _this.ele.canvas.getContextHidpi('2d');
					_this.ele.ctx = ctx;
					return _this.loadImgs(_this.sceneDataArr);
				},
				/*加载图片*/
				loadImgs: function(imgs){
					var _this = this;
					var deferreds = [];
					var callbacks = [];
					imgs = $.isArray(imgs) ? imgs : [imgs];
					$.each(imgs,function(index,item){
						/*有动画的效果的组件先不加载*/
						if(item[0].canvas !== undefined){
							return;
						}
						var cur = _this._loadImg.apply(_this,item);
						deferreds.push(cur.deferred);
						callbacks.push(cur.callback);
					});
					return $.when.apply($,deferreds).then(function(){
						$.each(callbacks,function(i,fn){
							fn();
						});
					});
				},
				_loadImg: function(img){
					var _this = this;
					var bgimg = new Image();
					var deferred = $.Deferred();
					var imgw = img.shape.width;
					var imgh = img.shape.height;
					var imgdx = img.position.left;
					var imgdy = img.position.top;
					bgimg.src = img.src;
					if(bgimg.complete){
						deferred.resolve(1);
					}else{
						bgimg.onload = function(){
							deferred.resolve(1);
						}
						bgimg.onerror = function(){
							deferred.resolve(1);
						}
					}
					return {
						deferred: deferred,
						callback: function(){
							_this.ele.ctx.drawImage(bgimg,imgdx,imgdy,imgw,imgh);
						}
					};
					
				},
				/*加载组件动画*/
				loadCompAnimate: function(){
					var _this = this;
					var components = _this.scene.sceneEle.components;
					_this.scene.complist = [];
					$.each(components,function(index,item){
						if(item.canvas !== undefined){
							_this.scene.complist.push(new Comp(item));
						}
					});
					// console.log(_this);
				}
			}
			/*
			 * 单个动画组件
			 */
			var Comp = function(config){
				var _this = this;
				_this.data = config;
				_this.initCanvas();
			};
			Comp.prototype = {
				constructor:Comp,
				initCanvas: function(){
					var _this = this;
					var width = _this.data.canvas.width;
					var height = _this.data.canvas.height;
					var left = _this.data.canvas.left == undefined ? this.data.position.left : _this.data.canvas.left;
					var top = _this.data.canvas.top == undefined ? this.data.position.top : _this.data.canvas.top;
					var canvas = document.getElementById(_this.data.canvas.id);
					var offScreenCanvas = document.createElement('canvas');
					_this.data.last_timestamp = 0;
					$(canvas).width(width)
							.height(height)
							.attr('width',width)
							.attr('height',height)
							.css({'position':'absolute','left':left,'top':top});
					$(offScreenCanvas).width(width)
							.height(height)
							.attr('width',width)
							.attr('height',height)
							.css({'position':'absolute','left':left,'top':top});
					var ctx = canvas.getContextHidpi('2d');
					var offScreenContext = offScreenCanvas.getContextHidpi('2d');
					_this.data.canvas.ctx = ctx;

					_this.data.canvas.offctx = offScreenContext;

					_this.data.canvas.offcanvas = offScreenCanvas;
					if(_this.data.init){
						_this.data.init();
					}
					if(_this.data.animate){
						_this.excutAnimate();
					}
					/*$('body').append(_this.data.canvas.offcanvas);*/
				},
				excutAnimate: function(){
					var _this = this;
					var execute = function(){
					    var callback = function(timestamp){
							var frame_time = timestamp - _this.data.last_timestamp;
							_this.myReq = execute();
							if(frame_time > _this.data.animation.timeintval){
								_this.data.last_timestamp = timestamp;
								_this.data.animate(frame_time);
							}
						};
						return requestAnimationFrame(callback);	
					};
					
					var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                        window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
					_this.myReq = execute();
					return _this.myReq;
				},
				stopAnimate: function(myReq){
					var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
					cancelAnimationFrame(myReq);
				}
			}

			So.onebox.weather.init();
			
			/*关于优化*/
			/*
			 * 启动某一场景动画
			 */
			function startAni(Scene){
				var complist = Scene.scene.complist;
				for(var i = 0; i < complist.length; i++){
					var comp = complist[i];
					comp.excutAnimate();
				}
			}
			/*
			 * 暂停某一场景动画
			 */
			function pauseAni(Scene){
				var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
				var complist = Scene.scene.complist;
				for(var i = 0; i < complist.length; i++){
					cancelAnimationFrame(complist[i].myReq);
				}
			}
			/*
			 * 停止所有动画
			 */
			function stopAllAni(){
				var scene = So.onebox.weather.sceneArr;
				for(var i in scene){
					pauseAni(scene[i]);
				}
			}
			
			/*page Visibility*/
			function visibleListen(){
				var hidden, visibilityChange; 
				if (typeof document.hidden !== "undefined") {
					hidden = "hidden";
					visibilityChange = "visibilitychange";
				} else if (typeof document.msHidden !== "undefined") {
					hidden = "msHidden";
					visibilityChange = "msvisibilitychange";
				} else if (typeof document.webkitHidden !== "undefined") {
					hidden = "webkitHidden";
					visibilityChange = "webkitvisibilitychange";
				}
				document.addEventListener(visibilityChange,function(){
					if (document[hidden]) {
						stopAllAni()
					} else {
						var weatherType = changeScene(0);
						if(So.onebox.weather.sceneArr[weatherType]){
							startAni(So.onebox.weather.sceneArr[weatherType]);
						}
					}
				});
			}
		}else{
			changeBgImg();
			/* 不支持canvas打点*/
			try {
				PageLine.fill({"cat":'weather-moni',"md-b":"app","md-p":"nosuppot"});
			} catch(ex){}
		};
		/*
		 * 针对不支持canvas的浏览器单独加载背景图
		 */
		function changeBgImg(){
			var wraps = $('.js-mh-canvas-wrap',root);
			var sceneName = '';
			$.each(wraps,function(index,item){
				sceneName = $(item).data('scene');
				$(item).find('.mh-canvas-wrap-box').removeClass('mh-bg-img-'+sceneName).addClass('mh-bg-img-nocanvas-'+sceneName);
			});
		}
		/*
		 * 处理场景切换
		 */
		var currScene = $('.js-mh-date',root).eq(0).data('scene');
		var timer = 0;
		root.on('mouseenter','.js-weekly .js-mh-date',function(e){
			var me = $(this);
			e.stopPropagation();
			timer = setTimeout(function(){
				changeScene(me.index());
			},30);
		}).on('mouseleave','.js-weekly .js-mh-date',function(e){
			clearTimeout(timer);
		});
		root.on('mouseleave','.js-weekly',function(e){
			e.stopPropagation();
			timer = setTimeout(function(){
				changeScene(0);
			},30);
		});
		function changeScene(index){
			var date = $('.js-weekly>.js-mh-date',root);
			var me = date.eq(index);
			var desc = $('.js-mh-date',root);
			var currDesc = desc.eq(index);
			var weatherType = me.data('scene');
			var scene = $('.js-mh-canvas-wrap[data-scene="'+weatherType+'"]',root);
			if(!currDesc.hasClass('mh-active')){
				/*切换时间*/
				me.addClass('mh-active').siblings('.mh-active').removeClass('mh-active');
				/*切换文案*/
				currDesc.addClass('mh-active').siblings('.mh-active').removeClass('mh-active');
			}
			if(currScene !== weatherType){
				/*替换场景*/
				if(/MSIE/.test(navigator.userAgent) && !window.addEventListener){
					scene.show().siblings(':visible').hide();
				}else{
					scene.siblings(':visible').stop(true,true).fadeOut('slow');
					scene.stop(true,true).fadeIn('slow');
					if(So.onebox.weather.sceneArr[weatherType]){
						stopAllAni();
						startAni(So.onebox.weather.sceneArr[weatherType]);
					}
				}
				currScene = weatherType;
			}
			return weatherType;
		};
		
		/*
		 * 处理tab切换
		 */
		/*tab个数等于1时不展示tab*/
		if($('.js-mh-tab',root).find('li').length > 1){
			$('.js-mh-tab',root).show();
			/*背景高度设置*/
			$('.js-mh-cont-bg',root).css('height','480');
		}else{
			$('.js-mh-tab',root).hide();
			$('.js-mh-cont-bg',root).css('height','450');
		};
		root.on('click','.js-mh-tab .mh-tab',function(){
			var me = $(this);
			var className = me.data('tabname');
			var contMod = $('.'+className,root);
			if(contMod.hasClass('mh-hidden')){
				me.addClass('mh-tab-active').siblings('.mh-tab-active').removeClass('mh-tab-active');
				contMod.removeClass('mh-hidden').siblings().addClass('mh-hidden');
			}
		});
		/*
		 * 处理城市筛选数据
		 */
		var isForeign = parseInt("{%$result.isForeign%}",10),
			__p = "{%$result.area[0][1]%}", 
			__c = "{%$result.area[1][1]%}", 
			__x = "{%$result.area[2][1]%}"; 

		function HttpGenerator(url){
			if(location.protocol == 'https:'){
				return "https://XXXXXX.com/api/proxy?__url__="+encodeURIComponent(url);
			}
			return url;
		};
		function getProvince(){
			return $.ajax({
				url: HttpGenerator("http://XXXXXXX.cn/sed_api_area_query.php"),
				data:{grade:'province',app:'guideEngine','_t':parseInt((new Date)*1/1800000)},
				dataType:'jsonp',
				jsonpCallback : '__jsonp6',
				jsonp:"_jsonp",
				cache : true,
				success:function(data){
					if(data && $.isArray(data)){
						var html='';
						for(var i=0,len=data.length;i<len;i++){
							html+="<option value='"+data[i][1]+"'>"+data[i][0]+"</option>";
						}
						$('.js-weather-prov', root).html(html);
					}
				}
			});
		};
		function getCity(code){
			return $.ajax({
				url: HttpGenerator("XXXXXXX.cn/sed_api_area_query.php"),
				data:{grade:'city',code:code,app:'guideEngine','_t':parseInt((new Date)*1/1800000)},
				dataType:'jsonp',
				jsonpCallback : '__jsonp7',
				jsonp:"_jsonp",
				cache : true,
				success:function(data){
					if(data && $.isArray(data)){
						var html='';
						for(var i=0,len=data.length;i<len;i++){
							html+="<option value='"+data[i][1]+"'>"+data[i][0]+"</option>";
						}
						$('.js-weather-city', root).html(html);
					}
				}
			});
		};
		function getTown(code){
			return $.ajax({
				url: HttpGenerator("http://XXXXXXXXXX.cn/sed_api_area_query.php"),
				data:{grade:'town',code:code,app:'guideEngine','_t':parseInt((new Date)*1/1800000)},
				dataType:'jsonp',
				jsonpCallback : '__jsonp8',
				jsonp:"_jsonp",
				mimeType:'text/jsonp',
				cache : true,
				success:function(data){
					if(data && typeof data === 'object'){
						var html='';
						for(var i=0,len=data.length;i<len;i++){
							html+='<option value="'+data[i][1]+'">'+data[i][0]+'</option>'
						}
						$('.js-weather-town', root).html(html);
					}
				}
			});
		};
		var initHistoryCity = function(){};
		
		/*
		 * 初始化城市选择，非国外天气
		 */
		if(isForeign === 0){
			getProvince().then(function(){
				setTimeout(function(){
					$('.js-weather-prov option[value='+__p+']').attr('selected',true);
				},0);
			});
			getCity(__p).then(function(){
				setTimeout(function(){
					$('.js-weather-city option[value='+__c+']').attr('selected',true);
				},0);
			});
			getTown(__c).then(function(){
				setTimeout(function(){
					$('.js-weather-town option[value='+__x+']').attr('selected',true);
				},0)
			});
		};
		/**
		 * [尝试：因有更多的依赖，单独提出，使其余能更快初始化。]
		 * 测试有效
		 */
		_loader.use('cookie,json2', function(){
			initHistoryCity = function(){
				var cookieName = "mh-weather",
					city = $('input[name=city]', root).val(),
					cityInfo, showCity;

				var prevCityEl = $('.js-mh-prevcity', root),
					historyEl = $('.js-mh-history', root);

				var sourl = 'http://www.so.com/s?src=weather&q=';

				try {
					cityInfo = JSON.parse(Cookie.get(cookieName));
				} catch (e){
					cityInfo = {
						"prev": "",
						"curr": ""
					};
				}

				if (city != cityInfo.curr) {
					showCity = cityInfo.curr;
					cityInfo.prev = cityInfo.curr;
					cityInfo.curr = city;

					!!city && Cookie.set(cookieName, JSON.stringify(cityInfo) ,{
						expires: 30*24*60*60*1000,
						path: '/'
					});
				} else {
					showCity = cityInfo.prev;
				}

				if (showCity) {
					prevCityEl.text(showCity+'天气').attr('href', sourl+encodeURIComponent(showCity+'天气'));
					historyEl.show();
				}
			};
			initHistoryCity();
		});
		
		
		/*城市选择*/
		root.on('change','.js-weather-prov', function(){
			var code = $(this).val();
			getCity(code);
			getTown(code+"01");
		}).on('change','.js-weather-city', function(){
			var code = $(this).val();
			getTown(code);
		}).on('click','.js-get-weather', function(){
			var code = $('.js-weather-town', root).val(),
				title = $('.js-change-title', root);
			$.ajax({
				url:'http://open.onebox.so.com/dataApi',
				data:{
					"query": '北京天气',
					"url": 'http://cdn.weather.hao.360.cn/sed_api_weather_info.php?app=guideEngine&fmt=json&code='+code,
					"type": 'weather',
					"src": 'onebox',
					'tpl': 1
				},
				dataType:'jsonp',
				success:function(data){
					So.onebox.weather.configs = {};
					if (data && data.html && $('.js-weather-town', root).val() == code) {
						$('.js-mh-tempcont', root).html(data.html);
						/* 异步后重置变量 */
						if(!/MSIE/.test(navigator.userAgent) && window.addEventListener){
							So.onebox.weather.init();
						}else{
							changeBgImg();
						}
						initHistoryCity();
					}
				}
			});
			/* 更改未来15天预报链接 */
			$('.js-mh-more-weather', root).attr('href','http://www.weather.com.cn/weather/'+code+'.shtml#7d');
		});
	});
})();
</script>

{%/if%}
{%/block%}