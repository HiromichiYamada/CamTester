//
//  MenuViewController.swift
//  CamTester
//
//  Created by 山田宏道 on 2014/09/29.
//  Copyright (c) 2014年 Torques Inc. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
	
	var currentPreset : String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		// ログ表示ボタン.
		let buttonShowLog : UIBarButtonItem	= UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Bookmarks, target: self, action: "showLogPressed")
		self.navigationItem.rightBarButtonItem	= buttonShowLog
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func buttonPressed(sender: AnyObject) {
		let button : UIButton	= sender as UIButton
//		println( button.titleLabel!.text )
		//		Photo
		//		High
		//		Medium
		//		Low
		//		352x288
		//		640x480
		//		1280x720
		//		1920x1080
		//		iFrame960x540
		//		iFrame1280x720
		//
		
		self.currentPreset	= "AVCaptureSessionPreset"+button.titleLabel!.text!
		
		self.performSegueWithIdentifier("segueOpenCamera", sender: nil)
	}
	
	func showLogPressed()
	{
		self.performSegueWithIdentifier("segueOpenLog", sender: nil)
	}
	

	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		
		if( segue.identifier == "segueOpenCamera" ){
			var cameraVC	= segue.destinationViewController as CameraViewController
			cameraVC.sessionPreset	= self.currentPreset
		}
	}

}
