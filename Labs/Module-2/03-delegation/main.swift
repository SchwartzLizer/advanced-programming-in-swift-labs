protocol DeliveryDelegate: AnyObject {
    func deliveryDidStart(driver: String)
}

final class DeliveryManager {
    weak var delegate: DeliveryDelegate?

    func startDelivery(driver: String?) {
        guard let driver else {
            print("No driver assigned")
            return
        }

        delegate?.deliveryDidStart(driver: driver)
    }
}

final class Restaurant: DeliveryDelegate {
    func deliveryDidStart(driver: String) {
        print("Delivery started with \(driver)")
    }
}

let manager = DeliveryManager()
let restaurant = Restaurant()
manager.delegate = restaurant
manager.startDelivery(driver: nil)
manager.startDelivery(driver: "Bob")
