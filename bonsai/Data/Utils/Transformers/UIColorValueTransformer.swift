//
//  UIColorValueTransformer.swift
//  bonsai
//
//  Created by Vladimir Korolev on 06.12.2021.
//

import UIKit
import CoreData

@objc(UIColorValueTransformer)
final class UIColorValueTransformer: ValueTransformer {

    override public class func transformedValueClass() -> AnyClass {
        UIColor.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }

        do {
            return try NSKeyedArchiver.archivedData(
                withRootObject: color,
                requiringSecureCoding: true
            )
        } catch {
            assertionFailure("Failed to transform `UIColor` to `Data`")
            return nil
        }
    }

    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: data as Data
            )
        } catch {
            assertionFailure("Failed to transform `Data` to `UIColor`")
            return nil
        }
    }

    public static func register() {
        ValueTransformer.setValueTransformer(
            UIColorValueTransformer(),
            forName: NSValueTransformerName(
                rawValue: String(
                    describing: UIColorValueTransformer.self
                )
            )
        )
    }
}
