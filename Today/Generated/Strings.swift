// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Completed
  internal static let completed = L10n.tr("Localizable", "completed")
  /// %@ at %@
  internal static func dateAtTime(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "dateAtTime", String(describing: p1), String(describing: p2))
  }
  /// Not completed
  internal static let notCompleted = L10n.tr("Localizable", "notCompleted")
  /// Today
  internal static let today = L10n.tr("Localizable", "today")
  /// Today at %@
  internal static func todayAtTime(_ p1: Any) -> String {
    return L10n.tr("Localizable", "todayAtTime", String(describing: p1))
  }
  /// Toggle completion
  internal static let toggleCompletion = L10n.tr("Localizable", "toggleCompletion")

  internal enum Title {
    /// Reminder
    internal static let reminderVC = L10n.tr("Localizable", "title.reminderVC")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
