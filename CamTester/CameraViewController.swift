import UIKit
import AVFoundation

// based on 
// https://sites.google.com/a/gclue.jp/swift-docs/ni-yinki100-ios/3-avfoundation/002-kamerano-qi-dongto-hua-xiangno-bao-cun


// apple's document
// https://developer.apple.com/library/IOs/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/04_MediaCapture.html

class CameraViewController: UIViewController {
	
	var sessionPreset : String!
	var	devicePosition : AVCaptureDevicePosition	= AVCaptureDevicePosition.Back
	
	// セッション
	var mySession : AVCaptureSession!
	
	// デバイス
	var myDevice : AVCaptureDevice!
	
	// 画像のアウトプット
	var myImageOutput : AVCaptureStillImageOutput!
	var videoInput : AVCaptureDeviceInput!
	var myVideoLayer : AVCaptureVideoPreviewLayer!
	
	var myButton: UIButton!
	var myLabel: UILabel!

	override func viewDidLoad() {
		println( "viewDidLoad" )
		
		super.viewDidLoad()
		
		self.setupAVSession()
		self.setupUI()
	}
	
	func resetAVSession(){
		mySession.stopRunning()
		mySession.removeInput(videoInput)
		
		// Viewから削除
		myVideoLayer.removeFromSuperlayer()
		
		myButton.removeFromSuperview()
		myLabel.removeFromSuperview()
	}
	
	func setupAVSession(){
		// セッションの作成.
		mySession = AVCaptureSession()
		
		// デバイス一覧の取得
		let devices = AVCaptureDevice.devices()
		
		// バックカメラをmyDeviceに格納
		for device in devices{
			if(device.position == devicePosition){
				myDevice = device as AVCaptureDevice
			}
		}
		
		// バックカメラからVideoInputを取得.
		videoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput
		
		// セッションに追加
		mySession.addInput(videoInput)
		
		if( mySession.canSetSessionPreset(self.sessionPreset) ){
			mySession.sessionPreset	= self.sessionPreset	//AVCaptureSessionPresetPhoto	//AVCaptureSessionPresetMedium
			
			
			// 出力先を生成.
			myImageOutput = AVCaptureStillImageOutput()
			
			// セッションに追加.
			mySession.addOutput(myImageOutput)
			
			// 画像を表示するレイヤーを生成.
			myVideoLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as AVCaptureVideoPreviewLayer
			myVideoLayer.frame = self.view.bounds
			myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
			
			// Viewに追加
			self.view.layer.addSublayer(myVideoLayer)
			
			// セッション開始
			mySession.startRunning()
			
			// UIボタンを作成
			myButton = UIButton(frame: CGRectMake(0,0,120,50))
			myButton.backgroundColor = UIColor.redColor();
			myButton.layer.masksToBounds = true
			myButton.setTitle("撮影", forState: .Normal)
			myButton.layer.cornerRadius = 20.0
			myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
			myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
			
			// UIボタンをViewに追加
			self.view.addSubview(myButton);
			
			// ラベルを作成
			myLabel = UILabel()
			myLabel.backgroundColor	= UIColor(white: 1.0, alpha: 0.3)
			myLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
			myLabel.text = self.sessionPreset
			myLabel.frame = CGRect(x: 10, y: 200, width: self.view.bounds.width-20, height: 50)
			self.view.addSubview(myLabel)
			
			println(self.sessionPreset)
//			TRXLog.shared.appendLogLine(self.sessionPreset)
		}
		else{
			// ラベルを作成
			myLabel = UILabel()
			myLabel.backgroundColor	= UIColor(white: 1.0, alpha: 0.3)
			myLabel.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
			myLabel.text = self.sessionPreset + " is NOT SUPPORTED"
			myLabel.frame = CGRect(x: 10, y: 200, width: self.view.bounds.width-20, height: 50)
			self.view.addSubview(myLabel)
			
			var strDevicePosition : String = ((self.devicePosition == .Back) ? "Back" : "Front")
			println(self.sessionPreset + " is NOT SUPPORTED for " + strDevicePosition)
			TRXLog.shared.appendLogLine(self.sessionPreset + " is NOT SUPPORTED for " + strDevicePosition)
		}
	}
	
	func setupUI(){
		
		// カメラ変更ボタン.
		let buttonFlipCamera : UIBarButtonItem	= UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Refresh, target: self, action: "flipCameraPressed")

		self.navigationItem.rightBarButtonItem	= buttonFlipCamera
	}
	
	func flipCameraPressed(){
		println(__FUNCTION__)
		
		self.resetAVSession()
		
		// flip camera.
		if( self.devicePosition	== .Back ){
			self.devicePosition	= .Front
		}
		else{
			self.devicePosition	= .Back
		}

		
		self.setupAVSession()
	}
	
	//
	// ボタンイベント
	//
	func onClickMyButton(sender: UIButton){
		
		TRXLog.shared.appendLogLine(self.sessionPreset)
		
		// ビデオ出力に接続.
		let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
		
		// 接続から画像を取得.
		self.myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
			
			// 取得したImageのDataBufferをJpegに変換.
			let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
			
			// JpegからUIIMageを作成.
			let myImage : UIImage = UIImage(data: myImageData)
			
			// 撮影画像のサイズを取得.
			var strInfo : String	= (self.devicePosition == .Back) ? "Back" : "Front"
			strInfo += NSStringFromCGSize(myImage.size)
			self.updateInfoLabel(strInfo)
			TRXLog.shared.appendLogLine(strInfo)
			
			// アルバムに追加.
//			UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
		})
		
	}
	
	func updateInfoLabel( str : String )
	{
		self.myLabel.text	= str
		println(str)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
