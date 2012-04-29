package com.marjenmedia.util3d.fp10.alumican.sphere
{
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.RadioButton;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
		public class FP10Sphere extends  Sprite
		{
			//----------------------------------------
			//CLASS CONSTANTS
			
			
			
			
			
			//----------------------------------------
			//VARIABLES
			
			/**
			 * スフィア
			 */
			private var _sphere:Sphere;
			
			/**
			 * 回転速度
			 */
			private var _vx:Number;
			private var _vy:Number;
			
			
			
			
			
			//----------------------------------------
			//STAGE INSTANCES
			
			
			
			
			
			//----------------------------------------
			//METHODS
			
			/**
			 * コンストラクタ
			 */
			public function FP10Sphere():void
			{
				//stage.align     = StageAlign.TOP_LEFT;
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				//stage.frameRate = 60;
				//addChild(new Stats());
				
				_createSphere();
			}
			
			/**
			 * 初期化
			 */
			private function _createSphere():void
			{
				var texture:BitmapData;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
				{
					var texture:BitmapData = Bitmap(loader.contentLoaderInfo.content).bitmapData;
					
					_vx = 0;
					_vy = 0;
					
					//UI色々
					var vertexCountLabel:Label  = new Label(stage, 100, 86, "");
					var surfaceCountLabel:Label = new Label(stage, 180, 86, "");
					function updateCount():void
					{
						vertexCountLabel.text  = "vertex : "  + String(_sphere.vertexCount);
						surfaceCountLabel.text = "surface : " + String(_sphere.surfaceCount);
					}
					
					new Label(stage, 300, 10, "PROJECTOR");
					new RadioButton(stage, 300, 30, "Utils3D.projectVectors"   , true , function(e:Event):void { _sphere.useProjectVectors = true;  } );
					new RadioButton(stage, 300, 50, "Matrix3D.transformVectors", false, function(e:Event):void { _sphere.useProjectVectors = false; } );
					
					new Label(stage, 100, 10, "SHAPE");
					var segWSlider:HUISlider   = new HUISlider(stage, 100, 26, "Segment W", function(e:Event):void { _sphere.segmentW = Math.round(e.target.value); updateCount(); } );
					var segHSlider:HUISlider   = new HUISlider(stage, 100, 46, "Segment H", function(e:Event):void { _sphere.segmentH = Math.round(e.target.value); updateCount(); } );
					var radiusSlider:HUISlider = new HUISlider(stage, 100, 66, "Radius"   , function(e:Event):void { _sphere.radius   = Math.round(e.target.value); } );
					radiusSlider.minimum = 10;
					radiusSlider.maximum = 200;
					radiusSlider.labelPrecision = 0;
					radiusSlider.value = 150;
					segWSlider.minimum = segHSlider.minimum = 2;
					segWSlider.maximum = segHSlider.maximum = 64;
					segWSlider.labelPrecision = segHSlider.labelPrecision = 0;
					segWSlider.value = 16;
					segHSlider.value = 8;
					
					//スフィアを生成する
					_sphere   = addChild(new Sphere(texture, radiusSlider.value, segWSlider.value, segHSlider.value)) as Sphere;
					_sphere.x = stage.stageWidth  * 0.5;
					_sphere.y = stage.stageHeight * 0.5 + 50;
					
					updateCount();
					
					addEventListener(Event.ENTER_FRAME, _update);
				});
			//	loader.load(new URLRequest("http://lab.alumican.net/wonderfl/fp10sphere/texture.png"), new LoaderContext(true));
					loader.load(new URLRequest("assets/earth.png"), new LoaderContext(true));
			}
			
			/**
			 * 毎フレーム実行
			 * @param	e
			 */
			private function _update(e:Event):void 
			{
				//回転
				_sphere.rotateByQuaternion(
					_vx += (-(mouseY / stage.stageHeight - 0.5) * 10 - _vx) * 0.3,
					_vy += ( (mouseX / stage.stageWidth  - 0.5) * 10 - _vy) * 0.3,
					0
				);
				
				//レンダリング
				_sphere.render();
			}
		}
	

}