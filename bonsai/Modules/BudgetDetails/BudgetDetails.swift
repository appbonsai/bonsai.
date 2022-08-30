//
//  BudgetDetails.swift
//  bonsai
//
//  Created by hoang on 07.12.2021.
//

import SwiftUI
import CoreData

struct BudgetDetails: View {
   @State var startOffsetY: CGFloat = UIScreen.main.bounds.height
   @State var currentOffsetY: CGFloat = 0
   @State var endingOffsetY: CGFloat = 0
   private let thresholdY: CGFloat = (UIScreen.main.bounds.height * 0.8) / 2
   private let viewModel: BudgetViewModelProtocol
   
   init(viewModel: BudgetViewModelProtocol) {
      self.viewModel = viewModel
   }
   
   var body: some View {
      ZStack {
         VStack {
            VStack(alignment: .leading) {
               BudgetNameView(name: viewModel.bugdetName)
                  .frame(height: 33)
                  .padding(.leading, 8)
               
               Text("Handsome, you’re doing well!")
                  .font(BonsaiFont.body_15)
                  .foregroundColor(BonsaiColor.text)
                  .padding(.horizontal)
            }
            
            HStack(alignment: .center, spacing: 16) {
                // TODO: localization
               BudgetMoneyTitleView(title: "Money left", amount: viewModel.totalMoneyLeft)
                  .padding(.leading, 16)
               BudgetMoneyTitleView(title: "Money spent", amount: viewModel.totalMoneySpent)
            }
            .frame(height: 63)
            
            ZStack {
               Image(Asset.tree.name)
                  .resizable()
               
               VStack {
                  HStack(alignment: .center, spacing: 16) {
                      // TODO: localization
                     BudgetMoneyCardView(title: "Total budget", amount: viewModel.totalBudget)
                        .shadow(color: .black, radius: 7, x: 0, y: 4)

                     BudgetMoneyCardView(title: "Daily budget", amount: viewModel.budgetDaily)
                        .shadow(color: .black, radius: 7, x: 0, y: 4)
                  }
                  .frame(height: 116)
                  .padding(.horizontal, 16)
                  .padding(.top, -14)
                  
                  Spacer()
                  
                  BudgetDragUpView()
                     .gesture(
                        DragGesture()
                           .onChanged{ value in
                              withAnimation(.spring()) {
                                 currentOffsetY = value.translation.height - BudgetDragUpView.height
                              }
                           }
                           .onEnded { _ in
                              lockBudgetTransactionsOffset()
                           }
                     )
               }
            }
            .padding(.top, 16)
         }
         .padding(.top, 38)
         .background(BonsaiColor.back)
         .ignoresSafeArea()

         BudgetTransactions(transactions: viewModel.transactions, dragGestureOnChanged: { value in
            withAnimation(.spring()) {
               currentOffsetY = value.location.y
               if currentOffsetY < 0 {
                  currentOffsetY = 0
               }
            }
         }, dragGestureOnEnded: lockBudgetTransactionsOffset)
         .offset(y: startOffsetY)
         .offset(y: currentOffsetY)
         .offset(y: endingOffsetY)
      }
   }
   
   private func lockBudgetTransactionsOffset() {
      withAnimation(.spring()) {
         if currentOffsetY < -thresholdY {
            endingOffsetY = -startOffsetY
         } else if endingOffsetY != 0 && currentOffsetY > thresholdY {
            endingOffsetY = 0
         }
         currentOffsetY = 0
      }
   }
}

struct BudgetDetails_Previews: PreviewProvider {
   static var previews: some View {
      BudgetDetails(
         viewModel: BudgetViewModelAssembler().assembly())
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}



