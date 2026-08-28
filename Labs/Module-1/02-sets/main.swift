var reservations: Set<String> = ["Alice", "Bob", "Alice"]

print("Unique reservations: \(reservations.count)")
reservations.insert("Charlie")
reservations.remove("Bob")

for name in reservations.sorted() {
    print(name)
}
