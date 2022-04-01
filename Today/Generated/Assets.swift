// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let todayDetailCellTint = ColorAsset(name: "TodayDetailCellTint")
  internal static let todayGradientAllBegin = ColorAsset(name: "TodayGradientAllBegin")
  internal static let todayGradientAllEnd = ColorAsset(name: "TodayGradientAllEnd")
  internal static let todayGradientFutureBegin = ColorAsset(name: "TodayGradientFutureBegin")
  internal static let todayGradientFutureEnd = ColorAsset(name: "TodayGradientFutureEnd")
  internal static let todayGradientTodayBegin = ColorAsset(name: "TodayGradientTodayBegin")
  internal static let todayGradientTodayEnd = ColorAsset(name: "TodayGradientTodayEnd")
  internal static let todayListCellBackground = ColorAsset(name: "TodayListCellBackground")
  internal static let todayListCellDoneButtonTint = ColorAsset(name: "TodayListCellDoneButtonTint")
  internal static let todayNavigationBackground = ColorAsset(name: "TodayNavigationBackground")
  internal static let todayPrimaryTint = ColorAsset(name: "TodayPrimaryTint")
  internal static let todayProgressLowerBackground = ColorAsset(name: "TodayProgressLowerBackground")
  internal static let todayProgressUpperBackground = ColorAsset(name: "TodayProgressUpperBackground")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
