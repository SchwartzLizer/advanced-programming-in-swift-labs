import SwiftUI

struct MenuItemsView: View {
    @StateObject private var viewModel = MenuViewModel()
    @State private var isShowingOptions = false

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    header

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredAndSortedItems) { item in
                            NavigationLink {
                                MenuItemDetailsView(item: item)
                            } label: {
                                menuCard(for: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingOptions = true
                    } label: {
                        Label("Menu options", systemImage: "line.3.horizontal.decrease.circle")
                    }
                    .accessibilityIdentifier("menu-options-button")
                }
            }
            .sheet(isPresented: $isShowingOptions) {
                MenuItemsOptionView(viewModel: viewModel)
            }
        }
        .tint(.littleLemonGreen)
    }

    private var header: some View {
        HStack(spacing: 16) {
            Image("LittleLemonLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .accessibilityLabel("Little Lemon logo")

            VStack(alignment: .leading, spacing: 4) {
                Text("Little Lemon")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.littleLemonGreen)
                Text("Fresh Mediterranean flavors")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 20))
    }

    private func menuCard(for item: MenuItem) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image("LittleLemonLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 86)
                .padding(.vertical, 8)

            Text(item.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)

            Text(item.menuCategory.rawValue)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.littleLemonGreen)

            HStack {
                Text(item.price, format: .currency(code: "USD"))
                    .font(.subheadline.bold())
                Spacer()
                Label("\(item.ordersCount)", systemImage: "flame.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 220, alignment: .topLeading)
        .background(.background, in: RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
        .accessibilityElement(children: .combine)
    }
}

private extension Color {
    static let littleLemonGreen = Color(red: 0.19, green: 0.36, blue: 0.32)
}
