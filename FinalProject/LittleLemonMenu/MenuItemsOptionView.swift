import SwiftUI

struct MenuItemsOptionView: View {
    @ObservedObject var viewModel: MenuViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Categories") {
                    ForEach(MenuCategory.allCases) { category in
                        Toggle(
                            category.rawValue,
                            isOn: binding(for: category)
                        )
                    }
                }

                Section("Sort by") {
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        ForEach(MenuSortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
            }
            .navigationTitle("Menu Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func binding(for category: MenuCategory) -> Binding<Bool> {
        Binding(
            get: {
                viewModel.selectedCategories.contains(category)
            },
            set: { isSelected in
                if isSelected {
                    viewModel.selectedCategories.insert(category)
                } else {
                    viewModel.selectedCategories.remove(category)
                }
            }
        )
    }
}
