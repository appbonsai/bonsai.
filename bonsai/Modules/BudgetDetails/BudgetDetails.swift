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
   private let thresholdY: CGFloat = (UIScreen.main.bounds.height * 0.2) / 2
   private let viewModel: BudgetViewModelProtocol
    @State var isPresented: Bool = false

   init(viewModel: BudgetViewModelProtocol) {
      self.viewModel = viewModel
   }
    
    private func budgetMoneyTitleView() -> some View {
        HStack(alignment: .center, spacing: 16) {
            // TODO: localization
            BudgetMoneyTitleView(title: L.Money_left, amount: viewModel.totalMoneyLeft)
              .padding(.leading, 16)
            BudgetMoneyTitleView(title: L.Money_spent, amount: viewModel.totalMoneySpent)
        }
        .frame(height: 63)
    }
    
    private func budgetMoneyCardView() -> some View {
        HStack(alignment: .center, spacing: 16) {
            // TODO: localization
            BudgetMoneyCardView(title: L.Total_budget, amount: viewModel.totalBudget)
              .shadow(color: .black, radius: 7, x: 0, y: 4)

           BudgetMoneyCardView(title: L.Daily_budget, amount: viewModel.budgetDaily)
              .shadow(color: .black, radius: 7, x: 0, y: 4)
        }
        .frame(height: 116)
        .padding(.horizontal, 16)
        .padding(.top, -14)
    }
       

    private func tapViewTransactions() -> some View {
        BudgetTapView()
            .onTapGesture {
                isPresented = true
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation(.spring()) {
                            currentOffsetY = value.translation.height - BudgetTapView.height
                        }
                    }
                    .onEnded { _ in
                        lockBudgetTransactionsOffset()
                    }
            )
    }
    
   var body: some View {
      ZStack {
         VStack {
            VStack(alignment: .leading) {
               BudgetNameView(name: viewModel.bugdetName)
                  .padding([.top, .leading], 8)
            }
             budgetMoneyTitleView()
            
            ZStack {
               Image(Asset.tree.name)
                  .resizable()
               
               VStack {
                budgetMoneyCardView()
                  
                  Spacer()
                  
                   tapViewTransactions()
               }
            }
            .padding(.top, 16)
         }
         .popover(isPresented: $isPresented, content: {
             BudgetTransactions(transactions: viewModel.transactions, isPresented: $isPresented)
         })
         .background(BonsaiColor.back)
         .ignoresSafeArea()

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



