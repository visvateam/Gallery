import UIKit
import AVFoundation

public struct Config {

  @available(*, deprecated, message: "Use tabsToShow instead.")
  public static var showsVideoTab: Bool {
    // Maintains backwards-compatibility.
    get {
      return tabsToShow.index(of: .videoTab) != nil
    }
    set(newValue) {
      if !newValue {
        tabsToShow = tabsToShow.filter({$0 != .videoTab})
      } else {
        if tabsToShow.index(of: .videoTab) == nil {
          tabsToShow.append(.videoTab)
        }
      }
    }
  }
  public static var tabsToShow: [GalleryTab] = [.imageTab, .cameraTab, .videoTab]
  // Defaults to cameraTab if present, or whatever tab is first if cameraTab isn't present.
  public static var initialTab: GalleryTab?
  
  public enum GalleryTab {
    case imageTab
    case cameraTab
    case videoTab
  }

  public struct PageIndicator {
    public static var backgroundColor: UIColor = UIColor(red: 0, green: 3/255, blue: 10/255, alpha: 1)
    public static var textColor: UIColor = UIColor.white
    public static var indicatorColor: UIColor = UIColor.white
  }

  public struct Camera {

    public static var recordLocation: Bool = false

    public struct ShutterButton {
      public static var numberColor: UIColor = UIColor(red: 54/255, green: 56/255, blue: 62/255, alpha: 1)
    }

    public struct BottomContainer {
      public static var backgroundColor: UIColor = UIColor(red: 23/255, green: 25/255, blue: 28/255, alpha: 0.8)
    }

    public struct StackView {
      public static let imageCount: Int = 4
    }
    
    public static var imageLimit: Int = 0
    public static var StartingSelectedCount: Int = 0
    public static var selectingStackViewOpensGrid: Bool = true
    
  }

  public struct Grid {

    public struct TopView {
        public static var barBackgroundColor: UIColor = UIColor.white
    }
    
    public struct CloseButton {
      public static var tintColor: UIColor = UIColor(red: 109/255, green: 107/255, blue: 132/255, alpha: 1)
    }

    public struct CollectionView {
        public static var backgroundColor: UIColor = UIColor.white
    }
    
    public struct ArrowButton {
      public static var tintColor: UIColor = UIColor(red: 110/255, green: 117/255, blue: 131/255, alpha: 1)
    }
    
    public struct ArrowLabel {
        public static var font: UIFont = UIFont.systemFont(ofSize: 1)
    }

    public struct AlbumTitle {
        public static var font: UIFont = UIFont.systemFont(ofSize: 1)
    }

    public struct FrameView {
      public static var fillColor: UIColor = UIColor(red: 50/255, green: 51/255, blue: 59/255, alpha: 1)
      public static var borderColor: UIColor = UIColor(red: 0, green: 239/255, blue: 155/255, alpha: 1)
    }

    public struct Dimension {
        public static var columnCount: CGFloat = 4
        public static var cellSpacing: CGFloat = 4
        public static var minimumInteritemSpacing: CGFloat = 2
        public static var minimumLineSpacing: CGFloat = 2
    }
    
    public static var hidingBottomBar = false
    
    public struct SelectedImage {
        public static var ImageIcon: UIImage? = nil
        public static var Width: CGFloat = 0
        public static var Height: CGFloat = 0
        public static var CircleFillColor: UIColor = .red
        public static var CircleRadius: CGFloat = 10
        public static var LabelFont: UIFont = UIFont.systemFont(ofSize: 5)
    }
    
    public struct Animation {
        public static var SelectTime: Double = 0.5
        public static var DeselectTime: Double = 0.2
    }
  }

  public struct EmptyView {
    public static var image: UIImage? = GalleryBundle.image("gallery_empty_view_image")
    public static var textColor: UIColor = UIColor(red: 102/255, green: 118/255, blue: 138/255, alpha: 1)
  }

  public struct Permission {
    public static var image: UIImage? = GalleryBundle.image("gallery_permission_view_camera")
    public static var textColor: UIColor = UIColor(red: 102/255, green: 118/255, blue: 138/255, alpha: 1)

    public struct Button {
      public static var textColor: UIColor = UIColor.white
      public static var highlightedTextColor: UIColor = UIColor.lightGray
      public static var backgroundColor = UIColor(red: 40/255, green: 170/255, blue: 236/255, alpha: 1)
    }
  }
    
  public struct SwitchingButtons {
    public static var selectedFont: UIFont = UIFont.systemFont(ofSize: 1)
    public static var unselectedFont: UIFont = UIFont.systemFont(ofSize: 40)
    public static var selectedColor: UIColor = .red
    public static var unselectedColor: UIColor = .blue
    public static var photoTitleText: String = ""
    public static var cameraTitleText: String = ""
  }

  public struct Font {

    public struct Main {
      public static var light: UIFont = UIFont.systemFont(ofSize: 1)
      public static var regular: UIFont = UIFont.systemFont(ofSize: 1)
      public static var bold: UIFont = UIFont.boldSystemFont(ofSize: 1)
      public static var medium: UIFont = UIFont.boldSystemFont(ofSize: 1)
    }

    public struct Text {
      public static var regular: UIFont = UIFont.systemFont(ofSize: 1)
      public static var bold: UIFont = UIFont.boldSystemFont(ofSize: 1)
      public static var semibold: UIFont = UIFont.boldSystemFont(ofSize: 1)
    }
  }

  public struct VideoEditor {

    public static var quality: String = AVAssetExportPresetHighestQuality
    public static var savesEditedVideoToLibrary: Bool = false
    public static var maximumDuration: TimeInterval = 15
    public static var portraitSize: CGSize = CGSize(width: 360, height: 640)
    public static var landscapeSize: CGSize = CGSize(width: 640, height: 360)
  }
    
  public struct DoneButton {
    public static var usingExternalDoneButton = false
  }
  public struct CloseButton {
    public static var usingExternalCloseButton = false
  }
    
}
