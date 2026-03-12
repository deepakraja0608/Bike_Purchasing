struct CartView: View {
    @EnvironmentObject var viewModel: TabbarViewModel
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack {
            ScrollView {
                orderDetails()
                ForEach(viewModel.cartData, id: \.id) { item in
                    contentView(model: item)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder private func contentView(model: LocalStorage) -> some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                imageView(model: model)
                itemsDetailsView(model: model)
                
                Spacer()
                updateItemsView(model: model)
            }
        }
        .padding([.vertical], 10)
        .background(Color.white
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.5), radius: 2)
        )
        .padding([.vertical, .horizontal], 10)
    }
    
    @ViewBuilder private func itemsDetailsView(model: LocalStorage) -> some View {
        VStack(alignment: .leading) {
            Text(model.name ?? "")
                .font(.fontSFProText(ofSize: 14, weight: .semibold))
            HStack {
                Text("Price: ")
                    .font(.fontSFProText(ofSize: 18, weight: .bold))
                + Text("\(viewModel.formatDecimalValue(model.price))")
                    .font(.fontSFProText(ofSize: 14, weight: .semibold))
            }
            .padding(.top, 10)
        }
        .padding(.top, 10)
        .padding(.leading, 10)
    }
    
    @ViewBuilder private func updateItemsView(model: LocalStorage)  -> some View {
        VStack(alignment: .trailing) {
            buttonActionView(name: "bin.xmark", fGColor: .red) {
                viewModel.deleteData(context: viewContext, item: model)
            }
            .padding(.trailing, -10)
            Spacer()
            HStack {
                buttonActionView(name: "minus", fGColor: .black) {
                    let price = model.price / model.quantity
                    let item = ProductModel.Item(id: Int(model.id ?? ""), icon: model.icon ?? "", name: model.name, price: price)
                    if model.quantity > 1 {
                        viewModel.addCart(context: viewContext, item: item, price: -price, quantity: -1.0)
                    }
                }
                
                Text("\(viewModel.formatDecimalValue(model.quantity))")
                    .frame(width: 40, height: 30)
                    .background(Color.white
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 1)
                    )
                
                buttonActionView(name: "plus.app", fGColor: .black) {
                    let price = model.price / model.quantity
                    let item = ProductModel.Item(id: Int(model.id ?? ""), icon: model.icon ?? "", name: model.name, price: price)
                    viewModel.addCart(context: viewContext, item: item, price: price, quantity: 1.0)
                }
            }
        }
        .padding(.trailing, 30)
    }
    
    @ViewBuilder private func buttonActionView(name: String, fGColor: Color, onTaped: @escaping (() -> Void)) -> some View {
        Button {
            onTaped()
        } label: {
            Image(systemName: name)
                .foregroundColor(fGColor)
        }
    }
    

    
    
    @ViewBuilder private func imageView(model: LocalStorage) -> some View {
        ZStack {
            AsyncImage(url: URL(string: model.icon ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                  //  .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(10)
        }
        .frame(width: 120, height: 120)
        .background(
            Color.white
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.5), radius: 5))
        .padding(.leading)
    }
    
    
    @ViewBuilder private func orderDetails() -> some View {
        let totalPrice = viewModel.cartData.map({$0.price}).reduce(0, +)
        VStack {
            Text("Order Details: ")
            Text("Total Price: \(viewModel.formatDecimalValue(totalPrice))")
        }
    }
}