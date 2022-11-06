//
//  SelectBudgetPeriod.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct SelectBudgetPeriodView: View {

   @EnvironmentObject var purchaseService: PurchaseService

   @Binding var isPresented: Bool

   @Binding var periodDays: Int
   @State var period: Period
   @State private var date: Date

   @State var isSubscriptionsPresented: Bool = false
   
   private var isPremium: Bool {
      purchaseService.isSubscriptionActive
   }

   enum Period: Equatable, Identifiable {
      case week, twoWeeks, threeWeeks, month, custom

      var id: Period { self }

      init(days: Int) {
         switch days {
         case 7:
            self = .week
         case 14:
            self = .twoWeeks
         case 21:
            self = .threeWeeks
         case 30:
            self = .month
         default:
            self = .custom
         }
      }

      fileprivate var description: String {
         switch self {
         case .week:
            return "Weekly"
         case .twoWeeks:
            return "2 Weeks"
         case .threeWeeks:
            return "3 Weeks"
         case .month:
            return "Month"
         case .custom:
            return "Custom"
         }
      }
   }
   private let items: [Period] = [.week, .twoWeeks, .threeWeeks, .month, .custom]

   init(isPresented: Binding<Bool>, period: Binding<Int>) {
      self._date = .init(initialValue: Date())
      self._isPresented = isPresented
      self._periodDays = period
      self._period = .init(initialValue: .init(days: period.wrappedValue))
      self._date = .init(initialValue: SelectBudgetPeriodView.dateFromPeriod(period.wrappedValue))
   }

   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack(spacing: 12) {
               ForEach(items) { item in
                  if item == .custom {
                     VStack {
                        Text(L.choose_budget_period_or)
                        if isPremium {
                           DatePicker(
                              selection: $date,
                              in: Date().addingTimeInterval(24 * 60 * 60)...,
                              displayedComponents: [.date],
                              label: {
                                 Text(L.choose_budget_period_custom)
                                    .font(BonsaiFont.body_15)
                                    .foregroundColor(.white)
                              }
                           )
                           .padding(16)
                           .datePickerStyle(.compact)
                           .accentColor(BonsaiColor.purple3)
                           .background(BonsaiColor.card)
                           .cornerRadius(13)
                           .foregroundColor(.secondary)
                           .frame(height: 60)
                           .overlay {
                              RoundedRectangle(cornerRadius: 13)
                                 .stroke(
                                    { () -> Color in
                                       if period == .custom {
                                          return BonsaiColor.mainPurple
                                       } else {
                                          return .clear
                                       }
                                    }(),
                                    lineWidth: 2
                                 )
                           }
                           .padding([.leading, .trailing], 16)
                           .onChange(of: date, perform: { newValue in
                              period = .custom
                           })
                        } else {
                           RoundedRectangle(cornerRadius: 13)
                              .frame(height: 60)
                              .foregroundColor(BonsaiColor.card)
                              .overlay {
                                 HStack {
                                    Text(L.choose_budget_period_custom_premium)
                                       .font(BonsaiFont.body_15)
                                       .padding(.leading, 16)
                                    Spacer()
                                    Text(L.choose_budget_period_premium)
                                       .font(BonsaiFont.subtitle_15)
                                       .foregroundColor(BonsaiColor.mainPurple)
                                       .padding(.trailing, 16)
                                 }
                                 .contentShape(Rectangle())
                                 .background(BonsaiColor.card)
                              }
                              .padding([.leading, .trailing], 16)
                              .onTapGesture {
                                 if isPremium == false {
                                    isSubscriptionsPresented = true
                                 }
                              }
                        }
                     }
                  } else {
                     RoundedRectangle(cornerRadius: 13)
                        .frame(height: 44)
                        .foregroundColor(BonsaiColor.card)
                        .overlay {
                           HStack {
                              Text(item.description)
                                 .font(BonsaiFont.body_15)
                                 .padding(.leading, 16)
                              Spacer()
                           }
                           .contentShape(Rectangle())
                           .onTapGesture { period = item }
                           .background(BonsaiColor.card)

                           RoundedRectangle(cornerRadius: 13)
                              .stroke(
                                 { () -> Color in
                                    if period == item {
                                       return BonsaiColor.mainPurple
                                    } else {
                                       return .clear
                                    }
                                 }(),
                                 lineWidth: 2
                              )
                        }
                        .padding([.leading, .trailing], 16)
                  }
               } // ForEach

               Spacer()

               Button {
                  if isPremium == false && period == .custom {
                     isSubscriptionsPresented = true
                     return
                  }
                  periodDays = {
                     switch period {
                     case .week:
                        return 7
                     case .twoWeeks:
                        return 14
                     case .threeWeeks:
                        return 21
                     case .month:
                        return 30
                     case .custom:
                        return dateToPeriod(date)
                     }
                  }()
                  isPresented = false
               } label: {
                  ZStack {
                     RoundedRectangle(cornerRadius: 13)
                        .frame(width: 192, height: 48)
                        .foregroundColor(BonsaiColor.mainPurple)
                     Text(L.choose)
                        .foregroundColor(BonsaiColor.card)
                        .font(.system(size: 17))
                        .bold()
                  }
               }
               .padding(.bottom, 16)
            } //VStack
            .padding(.top, 20)
         }
         .navigationTitle(L.period)
         .popover(isPresented: $isSubscriptionsPresented, content: {
            Subscriptions(isPresented: $isSubscriptionsPresented)
         })
      }
   }

   private func dateToPeriod(_ date: Date) -> Int {
      guard let days = Calendar.current.dateComponents([.day], from: Date.now.startOfDay, to: date.startOfDay).day,
            days >= 0
      else { return 0 }
      return days
   }

   static private func dateFromPeriod(_ period: Int) -> Date {
      Date.now.startOfDay.addingTimeInterval(Double(period) * 24 * 60 * 60)
   }
}

struct SelectBudgetPeriod_Previews: PreviewProvider {
   static var previews: some View {
      SelectBudgetPeriodView(isPresented: .constant(true), period: .constant(0))
   }
}
