package com.marjenmedia.util3d.fp10.alumican.sphere
{
	import com.marjenmedia.util3d.fp10.alumican.ui3d.Object3D;
	import com.marjenmedia.util3d.fp10.alumican.ui3d.Vertex3D;
	
	import flash.display.BitmapData;

	public class Sphere extends Object3D
	{
		//----------------------------------------
		//CLASS CONSTANTS
		
		
		
		
		
		//----------------------------------------
		//VARIABLES
		
		/**
		 * 半径
		 */
		public function get radius():Number { return _radius; }
		public function set radius(value:Number):void { _radius = value;  create(); }
		private var _radius:Number;
		
		/**
		 * 水平方向の分割数
		 */
		public function get segmentW():uint { return _segmentW; }
		public function set segmentW(value:uint):void { _segmentW = value; create(); }
		private var _segmentW:uint;
		
		/**
		 * 垂直方向の分割数
		 */
		public function get segmentH():uint { return _segmentH; }
		public function set segmentH(value:uint):void { _segmentH = value; create(); }
		private var _segmentH:uint;
		
		
		
		
		
		//----------------------------------------
		//METHODS
		
		/**
		 * コンストラクタ
		 */
		public function Sphere(texture:BitmapData = null, radius:Number = 100, segmentW:uint = 8, segmentH:uint = 6):void
		{
			_radius   = radius;
			_segmentW = segmentW;
			_segmentH = segmentH;
		//	super();
			super(texture);
		}
		
		/**
		 * 頂点情報を生成する
		 */
		override protected function _createVetices(vertices3D:Vector.<Number>, indices:Vector.<int>, uvData:Vector.<Number>):void 
		{
			var i:uint,
			j:uint,
			n:uint,
			p:Vertex3D,
			index:uint,
			x:Number,
			y:Number,
			u:Number,
			v:Number,
			angleU:Number,
			angleV:Number,
			points:Vector.<Vertex3D> = new Vector.<Vertex3D>(),
				poly:Vector.<Vertex3D> = new Vector.<Vertex3D>(4),
				poleN:Vertex3D,
				poleS:Vertex3D,
				segW:uint = _segmentW + 1,
				segH:uint = _segmentH + 1;
			
			//頂点の生成
			for (i = 0; i < segH; ++i)
			{
				for (j = 0; j < segW; ++j)
				{
					p = new Vertex3D();
					
					//このあたりの頂点をマージしたい
					//if (i == 0       ) { if (j == 0) poleN = p; else p = poleN; }		// テクスチャ上端に対応する頂点
					//if (i == segH - 1) { if (j == 0) poleS = p; else p = poleS; }		// テクスチャ下端に対応する頂点
					//if (j == segW - 1) { p = _points[_points.length - segW + 1]; }	// テクスチャ右端に対応する頂点
					
					u = j / (segW - 1);
					v = i / (segH - 1);
					
					angleU = u * PI2;
					angleV = v * PI;
					
					y = -_radius * Math.cos(angleV);
					x =  _radius * Math.sin(angleU) * Math.sin(angleV);
					z = -_radius * Math.cos(angleU) * Math.sin(angleV);
					
					p.x = x;
					p.y = y;
					p.z = z;
					p.u = u;
					p.v = v;
					
					points.push(p);
				}
			}
			
			//ポリゴンの生成
			n = points.length;
			index = 0;
			for (i = 0; i < n; ++i)
			{
				if (i + segW + 1 >= n) break;
				if ((i + 1) % segW == 0) continue;
				
				poly[0] = points[i];
				poly[1] = points[i + 1];
				poly[2] = points[i + segW];
				poly[3] = points[i + segW + 1];
				
				for (j = 0; j < 4; ++j)
				{
					//新規頂点を追加
					if ((p = poly[j]).index == -1)
					{
						p.index = index++;
						
						//3D座標
						vertices3D.push(p.x, p.y, p.z);
						
						//UV座標
						uvData.push(p.u, p.v);
					}
				}
				
				//頂点インデックスに追加(時計回り)
				indices.push(
					poly[0].index, poly[1].index, poly[2].index,
					poly[1].index, poly[3].index, poly[2].index
				);
			}
		}
	}
}