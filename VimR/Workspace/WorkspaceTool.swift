/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Cocoa

protocol WorkspaceToolDelegate: class {

  func toggle(_ tool: WorkspaceTool)
}

class WorkspaceTool {

  // MARK: - API
  let title: String
  let view: NSView
  let button: WorkspaceToolButton
  var location = WorkspaceBarLocation.left {
    didSet {
      self.button.location = self.location
    }
  }

  var isSelected = false {
    didSet {
      if self.isSelected {
        self.button.highlight()
      } else {
        self.button.dehighlight()
      }
    }
  }

  weak var delegate: WorkspaceToolDelegate?

  let minimumDimension: CGFloat
  var dimension: CGFloat

  init(title: String, view: NSView, minimumDimension: CGFloat = 50) {
    self.title = title
    self.view = view
    self.minimumDimension = minimumDimension
    self.dimension = minimumDimension
    self.button = WorkspaceToolButton(title: title)
    
    self.button.tool = self
  }

  func toggle() {
    self.delegate?.toggle(self)
    self.isSelected = !self.isSelected
  }
}
