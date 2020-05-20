//
//  HistoryEntity.swift
//  BankingDemo
//

import Foundation

struct HistoryEntity: Decodable {
    let resultCode: String
    let payload: HistoryPayload
    let trackingID: String?
}

struct HistoryPayload: Decodable {
    let operations: Operations
    let payments: Payments
}

struct Operations: Decodable {
    let payload: [OperationsPayload]
    let details: Details
    let resultCode: String
}

struct Details: Decodable {
    let hasNext: Bool
}

struct OperationsPayload: Decodable {
    let isDispute, hasStatement, isSuspicious: Bool
    let authorizationID: String?
    let id: String
    let status: String
    let idSourceType: String
    let type: String
    let trancheCreationAllowed: Bool
    let locations: [Location]
    let loyaltyBonus: [LoyaltyBonus]
    let cashbackAmount: AccountAmountClass
    let authMessage: String?
    let payloadDescription: String?
    let cashback: Int
    let brand: Brand?
    let amount: AccountAmountClass
    let operationTime: DebitingTime
    let spendingCategory: SpendingCategory
    let isHce: Bool
    let mcc: Int
    let category: Category
    let additionalInfo: [AdditionalInfo]
    let virtualPaymentType: Int
    let account: String
    let ucid: String?
    let merchant: Merchant?
    let card: String?
    let group: Group
    let mccString: String
    let cardPresent, isExternalCard: Bool
    let cardNumber: String?
    let accountAmount: AccountAmountClass
    let subgroup: Category?
    let debitingTime: DebitingTime?
    let compensation: String?
    let senderFullName: SenderFullName?
    let senderDetails, subcategory, senderAgreement: String?
    let payment: Payment?
    let operationPaymentType, partnerType, message: String?
}

struct AccountAmountClass: Decodable {
    let currency: Currency
    let value: Double
}

struct Currency: Decodable {
    let code: Int
    let name: String
    let strCode: String
}

struct AdditionalInfo: Decodable {
    let fieldName, fieldValue: String
}

struct Brand: Decodable {
    let name: String
    let baseTextColor: String?
    let logo: String?
    let id: String
    let roundedLogo: Bool
    let link: String?
    let baseColor, logoFile: String?
}

struct Category: Decodable {
    let id, name: String
}

struct DebitingTime: Decodable {
    let milliseconds: Int
}

enum Group: String, Decodable {
    case cash = "CASH"
    case income = "INCOME"
    case pay = "PAY"
    case transfer = "TRANSFER"
    case correction = "CORRECTION"
}

struct Location: Decodable {
    let latitude, longitude: Double
}

struct LoyaltyBonus: Decodable {
    let loyaltyType: String
    let status: String
}

struct Merchant: Decodable {
    let name: String
    let region: Region?
}

struct Region: Decodable {
    let country: String
    let city: String
    let address, zip: String?
    let addressRus: String?
}

struct Payment: Decodable {
    let sourceIsQr: Bool
    let bankAccountID, paymentID, paymentType: String?
    let feeAmount: AccountAmountClass
    let providerID: String?
    let hasPaymentOrder: Bool
    let comment: String?
    let fieldsValues: PaymentFieldsValues
    let cardNumber: String?
    let templateID: String?
}

struct PaymentFieldsValues: Decodable {
    let agreement, bankContract, pointerType, maskedFIO: String?
    let pointer, workflowType, pointerLinkID: String?
}

struct SenderFullName: Decodable {
    let patronymic, lastName, firstName: String
}

struct SpendingCategory: Decodable {
    let id, name, icon: String
    let parentID: String?
}

struct Payments: Decodable {
    let payload: [PaymentsPayload]
    let details: Details
    let resultCode: String
}

struct PaymentsPayload: Decodable {
    let sourceIsQr: Bool
    let bankAccountID, paymentID, payloadDescription, paymentType: String?
    let cardID: String?
    let feeAmount: AccountAmountClass
    let brand: Brand
    let groupPayment: GroupPayment
    let amount: AccountAmountClass
    let providerID, detailedStatus: String?
    let hasPaymentOrder: Bool
    let date: DebitingTime
    let status: String
    let comment: String
    let fieldsValues: PayloadFieldsValues
    let cardNumber, paymentOperationType: String?
    let templateID: String?
}

struct PayloadFieldsValues: Decodable {
    let agreement, bankContract, pointerType, maskedFIO: String?
    let pointer: String?
}

struct GroupPayment: Decodable {
    let id: String
}

extension Currency {

    var sign: String {
        return "₽"
    }

}
