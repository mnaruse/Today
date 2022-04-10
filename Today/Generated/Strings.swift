// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// %@ at %@
  internal static func dateAtTime(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "dateAtTime", String(describing: p1), String(describing: p2))
  }
  /// Today
  internal static let today = L10n.tr("Localizable", "today")
  /// Today at %@
  internal static func todayAtTime(_ p1: Any) -> String {
    return L10n.tr("Localizable", "todayAtTime", String(describing: p1))
  }

  internal enum Accessibility {
    /// Add reminder
    internal static let addReminder = L10n.tr("Localizable", "accessibility.addReminder")
    /// Completed
    internal static let completed = L10n.tr("Localizable", "accessibility.completed")
    /// Not completed
    internal static let notCompleted = L10n.tr("Localizable", "accessibility.notCompleted")
    /// %d percent
    internal static func percent(_ p1: Int) -> String {
      return L10n.tr("Localizable", "accessibility.percent", p1)
    }
    /// Progress
    internal static let progress = L10n.tr("Localizable", "accessibility.progress")
    /// Toggle completion
    internal static let toggleCompletion = L10n.tr("Localizable", "accessibility.toggleCompletion")
  }

  internal enum Action {
    /// Delete
    internal static let delete = L10n.tr("Localizable", "action.delete")
  }

  internal enum Error {
    /// Failed to read reminders.
    internal static let readReminders = L10n.tr("Localizable", "error.readReminders")
  }

  internal enum Reminder {
    internal enum Section {
      /// Date
      internal static let date = L10n.tr("Localizable", "reminder.section.date")
      /// Notes
      internal static let notes = L10n.tr("Localizable", "reminder.section.notes")
      /// Title
      internal static let title = L10n.tr("Localizable", "reminder.section.title")
    }
  }

  internal enum Segment {
    /// All
    internal static let all = L10n.tr("Localizable", "segment.all")
    /// Future
    internal static let future = L10n.tr("Localizable", "segment.future")
    /// Today
    internal static let today = L10n.tr("Localizable", "segment.today")
  }

  internal enum Title {
    /// Add Reminder
    internal static let addReminder = L10n.tr("Localizable", "title.addReminder")
    /// Reminder
    internal static let viewAndEditReminder = L10n.tr("Localizable", "title.viewAndEditReminder")
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
