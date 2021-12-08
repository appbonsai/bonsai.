//
//  UIImageValueTransformer.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import UIKit
import CoreData

@objc(UIImageValueTransformer)
final class UIImageValueTransformer: ValueTransformer {

    override public class func transformedValueClass() -> AnyClass {
        UIImage.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }

        do {
            return try NSKeyedArchiver.archivedData(
                withRootObject: image,
                requiringSecureCoding: true
            )
        } catch {
            assertionFailure("Failed to transform `UIImage` to `Data`")
            return nil
        }
    }

    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIImage.self,
                from: data as Data
            )
        } catch {
            assertionFailure("Failed to transform `Data` to `UIImage`")
            return nil
        }
    }

    public static func register() {
        ValueTransformer.setValueTransformer(
            UIColorValueTransformer(),
            forName: NSValueTransformerName(
                rawValue: String(
                    describing: UIImageValueTransformer.self
                )
            )
        )
    }
}
