//
//  Category+Icon.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI

extension Category {

   enum Emoji {
      static func fromStorage(text: String) -> String? {
         if text.starts(with: "e_") {
            var copy = text
            copy.removeFirst()
            copy.removeFirst()
            return copy
         }
         return nil
      }
      static func toStorage(emoji: String) -> String? {
         guard let emoji = emoji.first, emoji.isEmoji else {
            return nil
         }
         return "e_\(emoji)"
      }
   }

   enum Icon: String, CaseIterable, Identifiable {
      case airplane = "airplane.departure"
      case car = "car.fill"
      case bus = "bus.fill"
      case tram = "tram.fill"
      case ferry = "ferry.fill"
      case bicycle = "bicycle"
      case fuel = "fuelpump.fill"
      case person = "person.fill"
      case persons = "person.2.fill"
      case tShirt = "tshirt.fill"
      case drop = "drop.fill"
      case pawPrint = "pawprint.fill"
      case leaf = "leaf.fill"
      case bag = "bag.fill"
      case cart = "cart.fill"
      case creditCard = "creditcard.fill"
      case heart = "heart.fill"
      case crossCase = "cross.case.fill"
      case pills = "pills.fill"
      case phone = "phone.fill"
      case books = "books.vertical.fill"
      case graduationCap = "graduationcap.fill"
      case ticket = "ticket.fill"
      case hammer = "hammer.fill"
      case briefCase = "briefcase.fill"
      case theaterMasks = "theatermasks.fill"
      case key = "key.fill"
      case gameController = "gamecontroller.fill"
      case paintPalette = "paintpalette.fill"
      case gift = "gift.fill"
      case display = "display"
      case play = "play.fill"
      case banknote = "banknote.fill"
      case mic = "mic.fill"
      case docText = "doc.text.fill"
      case star = "star.fill"
      case scissors = "scissors"
      case wandAndStars = "wand.and.stars"
      case bandage = "bandage.fill"
      case facemask = "facemask.fill"
      case camera = "camera.macro"

      var img: SwiftUI.Image { .init(systemName: rawValue) }

      // MARK: - Identifiable

      var id: Icon { self }
   }
}
