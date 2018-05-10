//
//  Data+MD5.swift
//  RalphRoberts
//
//  Created by John Scott on 09/05/2018.
//  From SO answer https://stackoverflow.com/a/50257157/542244 (with modifications for Swift 4.1 ...)
//

import Foundation
import CommonCrypto

extension Data
{
    func md5() -> Data
    {
        var digest = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        self.withUnsafeBytes { (bytes : UnsafePointer<UInt8>) -> Void in
            digest.withUnsafeMutableBytes { (mutableBytes : UnsafeMutablePointer<UInt8>) -> Void in
                CC_MD5(bytes, CC_LONG(self.count), mutableBytes)
            }
        }
        
        return digest
    }
}
