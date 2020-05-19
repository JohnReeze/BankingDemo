// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L10n {

  public enum Actions {
    /// Оплатить
    public static let pay = L10n.tr("Localizable", "Actions.pay")
    /// Оплатить с этой карты
    public static let payByCard = L10n.tr("Localizable", "Actions.payByCard")
    /// Пополнить
    public static let replanish = L10n.tr("Localizable", "Actions.replanish")
    /// Пополнить с этой карты
    public static let replenishFromCard = L10n.tr("Localizable", "Actions.replenishFromCard")
    /// Реквизиты
    public static let requisites = L10n.tr("Localizable", "Actions.requisites")
  }

  public enum Date {
    /// Сегодня
    public static let today = L10n.tr("Localizable", "Date.today")
    /// Вчера
    public static let yestarday = L10n.tr("Localizable", "Date.yestarday")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
