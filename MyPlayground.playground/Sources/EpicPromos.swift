import Foundation

enum EpicPromoType: String, CaseIterable {
    // 🚨Note: We use EpicPromoType rawValues in params of data analytics events, watch out if you are planning to change the rawValue in future.
    case none = "none"
    case oneDollarPromo = "one_dollar"
    case annual6399Promo = "nrmp2022" // nrmp2022 -> national reading month promo 2022
    case bts2022Annual5999Promo = "bts2022"
}

extension EpicPromoType {
    var index: Self.AllCases.Index {
        return type(of: self).allCases.firstIndex(of: self)!
    }

    static func findEpicPromoType(by index: Int) -> EpicPromoType? {
        EpicPromoType.allCases.first(where: { $0.index == index })
    }

    var isValid: Bool {
        switch self {
        case .none: return false
        default: return true
        }
    }

    var subscriptionProductInfo: SubscriptionProductInfo {
        let referenceName: SubscriptionProductInfo.Product
        let producId: SubscriptionProductInfo.Product
        let legalText: String
        let localizedStringsTableName = "Promos"
        let showE2CProduct = ConsumerFlowType.showE2CProduct()

        switch self {
        case .none:
            return showE2CProduct ? SubscriptionProductInfo.defaultE2CProductInfo : SubscriptionProductInfo.defaultD2CProductInfo
        case .oneDollarPromo:
            referenceName = SubscriptionProductInfo.Product(yearly: "epic_1month_for_1_recurring_1y_for_7999_d2c", monthly: "epic_1month_for_1_recurring_999_d2c")
            producId = SubscriptionProductInfo.Product(yearly: "com.getepic.epic_1month_for_1_recurring_1y_for_7999_d2c", monthly: "com.getepic.epic_1month_for_1_recurring_999_d2c")
            legalText = NSLocalizedString("subscription_legal_epic_one_dollar_promo_11_01_2021", tableName: localizedStringsTableName, bundle: Bundle.main, value: "*Compare average monthly cost for Epic to one physical book. Subscription will automatically renew unless you cancel at least 24 hours before the current period ends. You can manage and cancel your subscription on the App Store account settings.  See our Terms of Services and Privacy Policy for more information.", comment: "Subscription page legal text for promo")
        case .annual6399Promo:
            referenceName = SubscriptionProductInfo.Product(yearly: "yearly_sub_intro_6399_recurring_7999", monthly: "monthly_d2c_recurring_999_promo_group")
            producId = SubscriptionProductInfo.Product(yearly: "com.getepic.yearly_sub_intro_6399_recurring_7999", monthly: "com.getepic.monthly_d2c_recurring_999_promo_group")
            legalText = NSLocalizedString("subscription_legal_epic_one_dollar_promo_11_01_2021", tableName: localizedStringsTableName, bundle: Bundle.main, value: "*Compare average monthly cost for Epic to one physical book. Subscription will automatically renew unless you cancel at least 24 hours before the current period ends. You can manage and cancel your subscription on the App Store account settings.  See our Terms of Services and Privacy Policy for more information.", comment: "Subscription page legal text for promo")
        case .bts2022Annual5999Promo:
            if showE2CProduct,
               let e2cSubscriptionProductInfo = e2cSubscriptionProductInfo {
                return e2cSubscriptionProductInfo
            } else {
                referenceName = SubscriptionProductInfo.Product(yearly: "yearly_intro_5999_recurring_7999_d2c", monthly: "monthly_recurring_999_d2c")
                producId = SubscriptionProductInfo.Product(yearly: "com.getepic.yearly_intro_5999_recurring_7999_d2c", monthly: "com.getepic.monthly_recurring_999_d2c")
                legalText = LocalizedString.bts2022Annual5999PromoLegalText
            }
        }

        return SubscriptionProductInfo(referenceName: referenceName, id: producId, legalText: legalText)
    }

    var e2cSubscriptionProductInfo: SubscriptionProductInfo? {
        switch self {
        case .none, .oneDollarPromo, .annual6399Promo:
            return nil
        case .bts2022Annual5999Promo:
            let referenceName = SubscriptionProductInfo.Product(yearly: "yearly_intro_5999_recurring_7999_e2c", monthly: "monthly_recurring_999_e2c")
            let producId = SubscriptionProductInfo.Product(yearly: "com.getepic.yearly_intro_5999_recurring_7999_e2c", monthly: "com.getepic.monthly_recurring_999_e2c")
            let legalText = LocalizedString.bts2022Annual5999PromoLegalText
            return SubscriptionProductInfo(referenceName: referenceName, id: producId, legalText: legalText)
        }
    }

    var subscriptionProduct: SubscriptionProduct? {
        guard let productsDictionary = StoreKitUtil.sharedInstance().productsDictionary as? [String: SKProduct],
              let yearly = productsDictionary[self.subscriptionProductInfo.referenceName.yearly],
              let monthly = productsDictionary[self.subscriptionProductInfo.referenceName.monthly]
        else { return nil }

        return SubscriptionProduct(yearly: yearly, monthly: monthly)
    }
}

extension EpicPromoType {
    static func current() -> EpicPromoType {
        if AppAccount.current == nil || AppAccount.isEpicUnlimited() { return .none }

        #if DEBUG || ADHOC
        // For forcing promo type from Dev Settings
        if let promoTypeRawValue = promoTypeRawValueFromCache(),
           let promoType = EpicPromoType(rawValue: promoTypeRawValue) {
            return promoType
        }
        #endif

        if FeatureFlag.bts2022Annual5999Promo.isActive() { return .bts2022Annual5999Promo }
        else if FeatureFlag.annual6399Promo.isActive() { return .annual6399Promo }
        else if FeatureFlag.oneDollarPromo.isActive() { return .oneDollarPromo }

        return .none
    }

    static func setPromoTypeToCache(promoTypeRawValue: String) {
        guard let currentAccountId = AppAccount.currentAccountId,
              !currentAccountId.isEmpty
        else { return }

        UserDefaults.standard.setValue(promoTypeRawValue, forKey: "\(UserDefaultsConstants.keyDateTriggeredBTS2022Annual5999PromoModalOnExplore)\(currentAccountId)")
    }

    private static func promoTypeRawValueFromCache() -> String? {
        guard let currentAccountId = AppAccount.currentAccountId,
              !currentAccountId.isEmpty,
              let promoTypeRawValue = UserDefaults.standard.value(forKey: "\(UserDefaultsConstants.keyDateTriggeredBTS2022Annual5999PromoModalOnExplore)\(currentAccountId)") as? String,
              !promoTypeRawValue.isEmpty
        else { return nil }

        return promoTypeRawValue
    }
}
