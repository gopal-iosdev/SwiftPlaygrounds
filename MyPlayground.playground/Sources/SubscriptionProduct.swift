import Foundation

struct SubscriptionProductInfo {
    struct Product {
        var yearly: String
        var monthly: String
    }

    let referenceName: Product
    let id: Product
    let legalText: String
}

struct SubscriptionProduct {
    var yearly: SKProduct
    var monthly: SKProduct
}

extension SubscriptionProduct {
    static var defaultD2CProduct: SubscriptionProduct? {
        let defaultD2CProductInfo = SubscriptionProductInfo.defaultD2CProductInfo
        guard let productsDictionary = StoreKitUtil.sharedInstance().productsDictionary as? [String: SKProduct],
              let yearly = productsDictionary[defaultD2CProductInfo.referenceName.yearly],
              let monthly = productsDictionary[defaultD2CProductInfo.referenceName.monthly]
        else { return nil }

        return SubscriptionProduct(yearly: yearly, monthly: monthly)
    }

    static var defaultE2CProduct: SubscriptionProduct? {
        let defaultE2CProductInfo = SubscriptionProductInfo.defaultD2CProductInfo
        guard let productsDictionary = StoreKitUtil.sharedInstance().productsDictionary as? [String: SKProduct],
              let yearly = productsDictionary[defaultE2CProductInfo.referenceName.yearly],
              let monthly = productsDictionary[defaultE2CProductInfo.referenceName.monthly]
        else { return nil }

        return SubscriptionProduct(yearly: yearly, monthly: monthly)
    }

    static var defaultProduct: SubscriptionProduct? {
        return ConsumerFlowType.showE2CProduct() ? defaultE2CProduct : defaultD2CProduct
    }
}

extension SubscriptionProductInfo {
    static let defaultD2CProductInfo: SubscriptionProductInfo = {
        let referenceName = SubscriptionProductInfo.Product(yearly: "yearlySubD2C7999", monthly: "monthlySubD2C999")
        let producId = SubscriptionProductInfo.Product(yearly: "com.getepic.yearly_d2c_recurring_7999", monthly: "com.getepic.monthly_d2c_recurring_999")
        let legalText = NSLocalizedString("subscription_legal_epic_free_upgrade_lawyer_with_book_price_5_11_2021", tableName: "Subscription", bundle: Bundle.main, value: "*Compare average monthly cost for Epic to one physical book. Payment will be charged to iTunes account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user’s account settings after purchase. Any unused portion of a free trial period, if offered, will be fortified when the user purchases a subscription to that publication where applicable.", comment: "")
        return SubscriptionProductInfo(referenceName: referenceName, id: producId, legalText: legalText)
    }()

    static let defaultE2CProductInfo: SubscriptionProductInfo = {
        let referenceName = SubscriptionProductInfo.Product(yearly: "yearly_e2c_recurring_7999", monthly: "monthly_e2c_recurring_999")
        let producId = SubscriptionProductInfo.Product(yearly: "com.getepic.yearly_e2c_recurring_7999", monthly: "com.getepic.monthly_e2c_recurring_999")
        let legalText = NSLocalizedString("subscription_legal_epic_free_upgrade_lawyer_with_book_price_5_11_2021", tableName: "Subscription", bundle: Bundle.main, value: "*Compare average monthly cost for Epic to one physical book. Payment will be charged to iTunes account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user’s account settings after purchase. Any unused portion of a free trial period, if offered, will be fortified when the user purchases a subscription to that publication where applicable.", comment: "")
        return SubscriptionProductInfo(referenceName: referenceName, id: producId, legalText: legalText)
    }()
}
