//
//  IPPlistHandler.swift
//  call
//
//  Created by Zsolt Balint on 11/26/16.
//  Copyright © 2016 InPos Soft. All rights reserved.
//

import UIKit

public class IPPlistHandler: NSObject {

	// MARK: -
	// MARK: Properties

	private var plistDictionary: [String: AnyObject]!

	// MARK: -
	// MARK: Initialization

	public init?(withName name: String) {
		super.init()

		guard let URL = Bundle.main.url(forResource: name, withExtension: "plist") else {
			print("[InPos][Error]: Project settings plist doesn't exist")
			return nil
		}

		guard let dictionary = NSDictionary(contentsOf: URL) as? [String: AnyObject] else {
			print("[InPos][Error]: Project settings file is not a plist")
			return nil
		}

		plistDictionary = dictionary
	}

	// MARK: -
	// MARK: Public methods

	public func object<RetType>(forKey key: String) -> RetType? {
		return plistDictionary[key] as? RetType
	}

	public func object<RetType>(forKeys keys: [String]) -> RetType? {
		if keys.count == 0 {
			return nil
		}

		var index = 0
		let count = keys.count
		var key: String = keys[index]
		var element: NSObject? = plistDictionary as NSObject
		repeat {
			key = keys[index]
			element = (element as? [String: AnyObject])?[key] as? NSObject ?? element
			index += 1
		} while index < count && element != nil

		return element as? RetType
	}

}
