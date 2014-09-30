//
//  LogViewController.swift
//  CamTester
//
//  Created by 山田宏道 on 2014/09/29.
//  Copyright (c) 2014年 Torques Inc. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
	
	@IBOutlet weak var textView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		// ログ削除ボタン.
		let buttonDeleteLog : UIBarButtonItem	= UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Trash, target: self, action: "deleteLogPressed")
		self.navigationItem.rightBarButtonItem	= buttonDeleteLog
		
		// log.
		self.updateLog()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func updateLog() {
		textView.text	= TRXLog.shared.logMain
	}
	
	func deleteLogPressed() {
		
		// delete.
		TRXLog.shared.logMain	= ""
		
		self.updateLog()
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
