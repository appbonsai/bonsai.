//
//  SelectBudgetPeriod.swift
//  bonsai
//
//  Created by antuan.khoanh on 13/10/2022.
//

import SwiftUI

struct SelectBudgetPeriodView: View {
   @State private var amount: String
   @State private var title: String
   @Binding var isPresented: Bool
   var completionDateSelected: (Int) -> Void
   private let items: [Period] = [.week, .twoWeek, .threeWeek, .custom]
   @State var selectedRow: Int = 0
   @State var date: Date
   @State var isBudgetCalendarPresented: Bool = false
   @State var isSubscriptionsPresented: Bool = false
   @EnvironmentObject var purchaseService: PurchaseService
   
   private var isPremium: Bool {
//      purchaseService.isSubscriptionActive
       return true
   }
   
   private enum Period: String {
      case week = "Weekly"
      case twoWeek = "2 Week"
      case threeWeek = "3 Week"
      case custom = "Custom"
      
      var value: Int {
         switch self {
         case .week: return 7
         case .twoWeek: return 14
         case .threeWeek: return 21
         case .custom: return 0
         }
      }
   }
   
   init(isPresented: Binding<Bool>, completionDateSelected: @escaping (Int) -> Void) {
      self._amount = .init(initialValue: "")
      self._title = .init(initialValue: "")
      self._date = .init(initialValue: Date())
      self._isPresented = isPresented
      self.completionDateSelected = completionDateSelected
   }
      
   var body: some View {
      NavigationView {
         ZStack {
            BonsaiColor.back
               .ignoresSafeArea()
            VStack {
               ForEach(Array(items.enumerated()), id: \.offset) { index, element  in
                  
                  RoundedRectangle(cornerRadius: 13)
                     .frame(height: 44)
                     .foregroundColor(BonsaiColor.card)
                     .overlay {
                        HStack {
                           Text(element.rawValue).font(.headline)
                              .foregroundColor(.secondary)
                              .padding(.leading, 16)
                           Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                           selectedRow = index
                           
                           /*
                            save in core data
                            */
                           
                           if items[selectedRow] == .custom {
                              if isPremium {
                                 isBudgetCalendarPresented = true
                              } else  {
                                 isSubscriptionsPresented = false
                                  isBudgetCalendarPresented = true

                              }
                           }
                        }
                        .background(BonsaiColor.card)
                        
                        RoundedRectangle(cornerRadius: 13)
                           .stroke(
                              { () -> Color in
                                 if selectedRow == index  {
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
               
               Spacer()
               
               Button {
                  if items[selectedRow] == .custom {
                     if isPremium {
                        let days = date.get(.day)
                        completionDateSelected(days)
                        isPresented = false
                     } else  {
                        isSubscriptionsPresented = true
                     }
                  } else {
                     let days = items[selectedRow].value
                     completionDateSelected(days)
                     isPresented = false
                  }
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
         }.navigationTitle(L.period)
            .popover(isPresented: $isSubscriptionsPresented, content: {
               Subscriptions(isPresented: $isSubscriptionsPresented)
            })
            .popover(isPresented: $isBudgetCalendarPresented) {
               VStack {
                  Spacer()

                  DateSelectorView(
                     date: $date,
                     fullSized: .constant(true),
                     isClosedRange: false
                  )
                  .frame(height: UIScreen.main.bounds.height / 2)
                  
                  Text("\(L.budget_until) \(date.dateString())")
                     .font(.headline)
                     .foregroundColor(.secondary)
                  
                  Spacer()
                  
                  Button {
                     if items[selectedRow] == .custom {
                        let days = date.get(.day)
                        completionDateSelected(days)
                        isPresented = false
                     } else {
                        let days = items[selectedRow].value
                        completionDateSelected(days)
                     }
                    isBudgetCalendarPresented = false
                  } label: {
                     ZStack {
                        RoundedRectangle(cornerRadius: 13)
                           .frame(width: 192, height: 48)
                           .foregroundColor(BonsaiColor.mainPurple)
                        Text(L.Continue_button)
                           .foregroundColor(BonsaiColor.card)
                           .font(.system(size: 17))
                           .bold()
                     }
                  }
               }
            }
      }
   }
}

struct SelectBudgetPeriod_Previews: PreviewProvider {
   static var previews: some View {
      SelectBudgetPeriodView(isPresented: .constant(true), completionDateSelected: { _ in })
   }
}


