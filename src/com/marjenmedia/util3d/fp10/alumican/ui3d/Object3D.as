package com.marjenmedia.util3d.fp10.alumican.ui3d
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.geom.Matrix3D;
	import flash.geom.Utils3D;
	import flash.display.TriangleCulling;

	/*****************************************//**
	* 3Dオブジェクトの基底クラス
	* 
	* @author alumican.net
	*/
	public class Object3D extends Sprite
	{
		//----------------------------------------
		//CLASS CONSTANTS
		
		static public const PI:Number        = Math.PI;
		static public const PI2:Number       = PI * 2;
		static public const TO_RADIAN:Number = PI  / 180;
		static public const TO_DEGREE:Number = 180 / PI;
		
		
		
		
		
		//----------------------------------------
		//VARIABLES
		
		/**
		 * レンダリング先
		 */
		public var _viewport:Sprite;
		
		/**
		 * テクスチャ画像
		 */
		public var _texture:BitmapData;
		
		/**
		 * 3D変形マトリックス
		 */
		private var _transform3D:Matrix3D;
		
		/**
		 * 3D頂点情報
		 */
		private var _vertices3D:Vector.<Number>;
		private var _indices:Vector.<int>;
		private var _uvData:Vector.<Number>;
		
		/**
		 * 頂点/サーフィス数
		 */
		public function get vertexCount():uint { return _vertices3D.length / 3; }
		public function get surfaceCount():uint { return _indices.length / 3; }
		
		/**
		 * プロジェクト後の座標
		 */
		private var _transformedVertices3D:Vector.<Number>;
		private var _transformedVertices2D:Vector.<Number>;
		
		/**
		 * projectVectors用
		 */
		private var _uvtData:Vector.<Number>;
		
		/**
		 * クォータニオン
		 */
		private var _qx:Number;
		private var _qy:Number;
		private var _qz:Number;
		private var _qw:Number;
		
		/**
		 * レンダリング方法の指定
		 * true  : projectVectors
		 * false : transformVectors
		 */
		public var useProjectVectors:Boolean;
		
		
		
		
		
		//----------------------------------------
		//STAGE INSTANCES
		
		
		
		
		
		//----------------------------------------
		//METHODS
		
		/**
		 * コンストラクタ
		 */
		public function Object3D(texture:BitmapData = null):void 
		{
			_viewport = addChild( new Sprite() ) as Sprite;
			
			_texture = texture;
			
			useProjectVectors = true;
			
			_transform3D = new Matrix3D();
			_transform3D.identity();
			
			_qx = _qy = _qz = 0;
			_qw = 1;
			
			create();
		}
		
		/**
		 * オブジェクトを生成する
		 */
		public function create():void
		{
			_vertices3D = new Vector.<Number>();
			_indices    = new Vector.<int>();
			_uvData     = new Vector.<Number>();
			
			_createVetices(_vertices3D, _indices, _uvData);
			
			_transformedVertices2D = new Vector.<Number>(_uvData.length, true);
			_transformedVertices3D = new Vector.<Number>(_vertices3D.length, true);
			
			_uvtData = new Vector.<Number>(_vertices3D.length, true);
			var n:uint = _uvData.length;
			var i:uint = 0;
			var j:uint = 0;
			while (i < n)
			{
				_uvtData[j++] = _uvData[i++];
				_uvtData[j++] = _uvData[i++];
				_uvtData[j++] = null;
			}
		}
		
		/**
		 * 3D頂点座標、頂点インデックス、UVデータを生成する（オーバーライド用）
		 * @param	vertices3D
		 * @param	indices
		 * @param	uvData
		 */
		protected function _createVetices(vertices3D:Vector.<Number>, indices:Vector.<int>, uvData:Vector.<Number>):void
		{
		}
		
		/**
		 * オブジェクトをレンダリングする
		 */
		public function render():void
		{
			if (!_texture) return;
			
			if (useProjectVectors)
			{
				//projectVectorsを使う
				Utils3D.projectVectors(_transform3D, _vertices3D, _transformedVertices2D, _uvtData);
			}
			else
			{
				//transformVectorsを使う
				_transform3D.transformVectors(_vertices3D, _transformedVertices3D);
				
				var n:uint = _uvData.length,
					j:uint = 0;
				for (var i:uint = 0; i < n; i += 2)
				{
					_transformedVertices2D[i    ] = _transformedVertices3D[j    ];
					_transformedVertices2D[i + 1] = _transformedVertices3D[j + 1];
					j += 3;
				}
			}
			
			var g:Graphics = _viewport.graphics;
			g.clear();
			g.beginBitmapFill(_texture, null, false, false);
			g.drawTriangles(_transformedVertices2D, _indices, _uvData, TriangleCulling.NEGATIVE);
		}
		
		/**
		 * クォータニオンを用いた回転を付与する
		 * @param	rotateX
		 * @param	rotateY
		 * @param	rotateZ
		 * @param	useDegree
		 */
		public function rotateByQuaternion(rotateX:Number, rotateY:Number, rotateZ:Number, useDegree:Boolean = true):void
		{
			if (useDegree)
			{
				rotateX *= TO_RADIAN;
				rotateY *= TO_RADIAN;
				rotateZ *= TO_RADIAN;
			}
			
			//----------------------------------------
			//回転クォータニオンの生成
			var fSinPitch:Number       = Math.sin(rotateY * 0.5),
				fCosPitch:Number       = Math.cos(rotateY * 0.5),
				fSinYaw:Number         = Math.sin(rotateZ * 0.5),
				fCosYaw:Number         = Math.cos(rotateZ * 0.5),
				fSinRoll:Number        = Math.sin(rotateX * 0.5),
				fCosRoll:Number        = Math.cos(rotateX * 0.5),
				fCosPitchCosYaw:Number = fCosPitch * fCosYaw,
				fSinPitchSinYaw:Number = fSinPitch * fSinYaw,
				
				rx:Number = fSinRoll * fCosPitchCosYaw     - fCosRoll * fSinPitchSinYaw,
				ry:Number = fCosRoll * fSinPitch * fCosYaw + fSinRoll * fCosPitch * fSinYaw,
				rz:Number = fCosRoll * fCosPitch * fSinYaw - fSinRoll * fSinPitch * fCosYaw,
				rw:Number = fCosRoll * fCosPitchCosYaw     + fSinRoll * fSinPitchSinYaw,
				
				//----------------------------------------
				//元のクォータニオンに回転を合成
				qx:Number = _qw * rx + _qx * rw + _qy * rz - _qz * ry,
				qy:Number = _qw * ry - _qx * rz + _qy * rw + _qz * rx,
				qz:Number = _qw * rz + _qx * ry - _qy * rx + _qz * rw,
				qw:Number = _qw * rw - _qx * rx - _qy * ry - _qz * rz,
				
				//----------------------------------------
				//正規化
				norm:Number = Math.sqrt(qx * qx + qy * qy + qz * qz + qw * qw),
				inv:Number,
				
				//----------------------------------------
				//行列へ変換
				xx:Number,
				xy:Number,
				xz:Number,
				xw:Number,
				
				yy:Number,
				yz:Number,
				yw:Number,
				
				zz:Number,
				zw:Number,
				
				m:Vector.<Number> = _transform3D.rawData;
			
			//----------------------------------------
			//正規化
			
			if(((norm < 0) ? -norm : norm) < 0.000001)
			{
				qx = qy = qz = 0.0;
				qw = 1.0;
			}
			else
			{
				inv = 1 / norm;
				qx *= inv;
				qy *= inv;
				qz *= inv;
				qw *= inv;
			}
			
			//----------------------------------------
			//行列へ変換
			xx = qx * qx;
			xy = qx * qy;
			xz = qx * qz;
			xw = qx * qw;
			
			yy = qy * qy;
			yz = qy * qz;
			yw = qy * qw;
			
			zz = qz * qz;
			zw = qz * qw;
			
			m[0]  = 1 - 2 * (yy + zz);
			m[1]  =     2 * (xy - zw);
			m[2]  =     2 * (xz + yw);
			
			m[4]  =     2 * (xy + zw);
			m[5]  = 1 - 2 * (xx + zz);
			m[6]  =     2 * (yz - xw);
			
			m[8]  =     2 * (xz - yw);
			m[9]  =     2 * (yz + xw);
			m[10] = 1 - 2 * (xx + yy);
			
			_transform3D.rawData = m;
			
			//----------------------------------------
			//クォータニオンの保存
			_qx = qx;
			_qy = qy;
			_qz = qz;
			_qw = qw;
		}
	}
	
	/*****************************************//**
	* スフィア
	* 
	*/
	
}