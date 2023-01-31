//
//  RNMask.swift
//  InputMask
//
//  Created by Ivan Zotov on 8/4/17.
//  Copyright © 2017 Ivan Zotov. All rights reserved.
//
import Foundation
import InputMask

@objcMembers
open class RNMask : NSObject {
    private(set) var mask: Mask? = nil

    public func setMask(format: String, customNotations: [Notation]) {
        self.mask = try! Mask.getOrCreate(withFormat: format, customNotations: customNotations)
    }

    public func maskValue(text: String, format: String, autcomplete: Bool) -> String {
        guard let mask = self.mask else { return text }
        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex,
                caretGravity: CaretString.CaretGravity.forward(autocomplete: autcomplete)
            )
        )

        return result.formattedText.string
    }

    public func unmaskValue(text: String, format: String, autocomplete: Bool) -> String {
        guard let mask = self.mask else { return text }

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex,
                caretGravity: CaretString.CaretGravity.forward(autocomplete: autocomplete)
            )
        )

        return result.extractedValue
    }
}
