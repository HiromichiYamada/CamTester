//
//  TRXLog.swift
//  CamTester
//
//  Created by 山田宏道 on 2014/09/29.
//  Copyright (c) 2014年 Torques Inc. All rights reserved.
//

import Foundation

class TRXLog {
	
	let	logFileName : String	= "logs.plist"	// .plist
	
	// シングルトン.
	class var shared: TRXLog {
	struct Instance {
		static let i = TRXLog()
		}
		return Instance.i
	}
	
	// MARK: 初期化.
	init(){
	}
	
	// MARK: -

	// 保存データのアプリバージョン.
	let TRXLogKey_Main : String	= "TRXLogKey_Main"
	var logMain : String? {
		get {
			var defaults : NSUserDefaults	= NSUserDefaults.standardUserDefaults()
			return defaults.stringForKey(TRXLogKey_Main)
		}
		set (newLogMain){
			var defaults : NSUserDefaults	= NSUserDefaults.standardUserDefaults()
			defaults.setObject(newLogMain, forKey:TRXLogKey_Main)
			defaults.synchronize()
		}
	}
	
	// 1行追加（最後に改行コードを自動付与）
	func appendLogLine( str : String)
	{
		var currentLog : String? = self.logMain
		if( currentLog != nil ){
			self.logMain	= currentLog! + str + "\n"
		}
		else{
			self.logMain	= str + "\n"
		}
	}

}