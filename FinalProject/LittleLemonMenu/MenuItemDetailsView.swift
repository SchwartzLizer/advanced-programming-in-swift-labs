import SwiftUI

struct MenuItemDetailsView: View {
    let item: MenuItem

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image("LittleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .accessibilityLabel("Little Lemon logo")

                VStack(spacing: 8) {
                    Text(item.title)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    Text(item.menuCategory.rawValue)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(item.price, format: .currency(code: "USD"))
                        .font(.title2.bold())
                        .foregroundStyle(Color(red: 0.19, green: 0.36, blue: 0.32))
                }

                Label("Ordered \(item.ordersCount) times", systemImage: "flame.fill")
                    .font(.subheadline)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title3.bold())

                    ForEach(item.ingredients) { ingredient in
                        Label(ingredient.rawValue, systemImage: "leaf.fill")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
