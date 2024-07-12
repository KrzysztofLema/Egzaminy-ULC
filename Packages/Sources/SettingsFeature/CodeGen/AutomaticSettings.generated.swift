// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import SwiftUI
import AutomaticSettings
import Inject
// swiftlint:disable all

import SharedModels



extension BetaSettingsView {

// MARK: - Views

struct AnimationsView<HeaderView: View, FooterView: View>: View, AutomaticSettingsViewDSL {
  typealias ViewModel = AutomaticSettingsViewModel<BetaSettings, BetaSettingsExternalData>

  @ObserveInjection var iO

  @ObservedObject
  var viewModel: ViewModel

  var headerView: HeaderView
  var footerView: FooterView

  init(viewModel: ViewModel, headerView: HeaderView, footerView: FooterView) {
    self.viewModel = viewModel
    self.headerView = headerView
    self.footerView = footerView
  }

  init(viewModel: ViewModel) where HeaderView == EmptyView, FooterView == EmptyView {
    self.viewModel = viewModel
    self.headerView = EmptyView()
    self.footerView = EmptyView()
  }

  init(viewModel: ViewModel, headerView: HeaderView) where FooterView == EmptyView {
    self.viewModel = viewModel
    self.headerView = headerView
    self.footerView = EmptyView()
  }

  init(viewModel: ViewModel, footerView: FooterView) where HeaderView == EmptyView {
    self.viewModel = viewModel
    self.headerView = EmptyView()
    self.footerView = footerView
  }

  var body: some View {
    Group {
      headerView
      settings()
      footerView
    }
    .enableInjection()
  }


  /// `Group` containing all Animations views
  func settings() -> some View {
    Section {
       Group { 
        setting(
          "postOpeningSpeed", 
          keyPath: \.animations.postOpeningSpeed, 
          requiresRestart: false,
          sideEffect: nil, 
          uniqueIdentifier: "\\.animations.postOpeningSpeed"
        ) 
        setting(
          "postOpeningCurve", 
          keyPath: \.animations.postOpeningCurve, 
          requiresRestart: false,
          sideEffect: nil, 
          uniqueIdentifier: "\\.animations.postOpeningCurve"
        ) 
       } 
    }
  }

}


// MARK: -

/// All generated section links:
    // Group { 
      // animationsLink()
    // } 

// MARK: - Top Level Link wrappers


  func animationsLink<HeaderView: View, FooterView: View>(
    label: String = "Animations", 
    @ViewBuilder headerView: @escaping () -> HeaderView,
    @ViewBuilder footerView: @escaping () -> FooterView
  ) -> some View {
    NavigationLink(
      label.automaticSettingsTitleCase, 
      destination: 
        Form {
          AnimationsView(viewModel: viewModel, headerView: InjectionWrapper { headerView() }, footerView: InjectionWrapper { footerView() })
        }
        //.navigationBarTitle("Animations".automaticSettingsTitleCase)
      )
  }

  func animationsLink<HeaderView: View>(
    label: String = "Animations", 
    @ViewBuilder headerView: @escaping () -> HeaderView
  ) -> some View {
    NavigationLink(
      label.automaticSettingsTitleCase, 
      destination: 
        Form {
          AnimationsView(viewModel: viewModel, headerView: InjectionWrapper { headerView() })
        }
        //.navigationBarTitle("Animations".automaticSettingsTitleCase)
      )
  }

  func animationsLink<FooterView: View>(
    label: String = "Animations", 
    @ViewBuilder footerView: @escaping () -> FooterView
  ) -> some View {
    NavigationLink(
      label.automaticSettingsTitleCase, 
      destination: 
        Form {
          AnimationsView(viewModel: viewModel, footerView: footerView())
        }
        //.navigationBarTitle("Animations".automaticSettingsTitleCase)
      )
  }
  func animationsLink(
    label: String = "Animations"
  ) -> some View {
    NavigationLink(
      label.automaticSettingsTitleCase,
      destination:
        Form {
          AnimationsView(viewModel: self.viewModel)
        }
        //.navigationBarTitle("Animations".automaticSettingsTitleCase)
      )
  }
}

/// Creates a view that supports injecting dynamic header / footer
struct InjectionWrapper<Content: View>: View {
    @ObserveInjection var iO
    var content: () -> Content
    var body: some View {
        content()
            .enableInjection()
    }
}

// swiftlint:enable all
