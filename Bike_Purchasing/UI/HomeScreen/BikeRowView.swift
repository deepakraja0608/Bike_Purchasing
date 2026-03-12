import SwiftUI
//struct BikeRowView: View {
//    
//    let bike: Bike
//    @State private var currentIndex: Int = 0
//    
//    var body: some View {
//        
//        VStack {
//            
//            ZStack {
//                
//                // Show current image
//                if bike.image.indices.contains(currentIndex),
//                   let url = URL(string: bike.image[currentIndex]) {
//                    
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(height: 200)
//                    .clipped()
//                    .cornerRadius(12)
//                }
//                
//                // Left & Right Buttons
//                HStack {
//                    
//                    // LEFT BUTTON
//                    Button(action: {
//                        if currentIndex > 0 {
//                            currentIndex -= 1
//                        }
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.6))
//                            .clipShape(Circle())
//                    }
//                    
//                    Spacer()
//                    
//                    // RIGHT BUTTON
//                    Button(action: {
//                        if currentIndex < bike.image.count - 1 {
//                            currentIndex += 1
//                        }
//                    }) {
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.6))
//                            .clipShape(Circle())
//                    }
//                }
//                .padding(.horizontal)
//            }
//            
//            Text(bike.bikeName)
//                .font(.headline)
//        }
//    }
//}
//
//#Preview {
//    BikeRowView()
//}
