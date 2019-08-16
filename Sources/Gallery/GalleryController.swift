import UIKit
import AVFoundation

public protocol GalleryControllerDelegate: class {

  func galleryController(_ controller: GalleryController, didSelectImages images: [Image])
  func galleryController(_ controller: GalleryController, didSelectVideo video: Video)
  func galleryController(_ controller: GalleryController, requestLightbox images: [Image])
  func galleryControllerDidCancel(_ controller: GalleryController)
  func galleryControllerUpdateNumImagesSelected(_ controller: GalleryController, countImages count: Int)
  func galleryControllerTriedToSelectMoreThanMaxImges(_ controller: GalleryController)
  func galleryControllerUserPanned(_ controller: GalleryController)
}

public class GalleryController: UIViewController, PermissionControllerDelegate {

  public weak var delegate: GalleryControllerDelegate?
  private weak var pagesController: PagesController?

  public let cart = Cart()

  public func externalDoneButtonTapped() {
    if Config.DoneButton.usingExternalDoneButton {
        EventHub.shared.doneWithImages?()
    }
  }
    
  // MARK: - Init

  public required init() {
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life cycle

  public override func viewDidLoad() {
    super.viewDidLoad()

    setup()

    if let pagesController = makePagesController() {
      g_addChildController(pagesController)
    } else {
      let permissionController = makePermissionController()
      g_addChildController(permissionController)
    }
  }

  public override var prefersStatusBarHidden : Bool {
    return true
  }

  // MARK: - Child view controller

  func makeImagesController() -> ImagesController {
    let controller = ImagesController(cart: cart)
    controller.title = Config.SwitchingButtons.photoTitleText

    return controller
  }

  func makeCameraController() -> CameraController {
    let controller = CameraController(cart: cart)
    controller.title = Config.SwitchingButtons.cameraTitleText

    return controller
  }

  func makeVideosController() -> VideosController {
    let controller = VideosController(cart: cart)
    controller.title = "Gallery.Videos.Title".g_localize(fallback: "VIDEOS")

    return controller
  }

  func makePagesController() -> PagesController? {
    guard Permission.Photos.status == .authorized else {
      return nil
    }

    let useCamera = Permission.Camera.needsPermission && Permission.Camera.status == .authorized

    let tabsToShow = Config.tabsToShow.compactMap { $0 != .cameraTab ? $0 : (useCamera ? $0 : nil) }

    let controllers: [UIViewController] = tabsToShow.compactMap { tab in
      if tab == .imageTab {
        return makeImagesController()
      } else if tab == .cameraTab {
        return makeCameraController()
      } else if tab == .videoTab {
        return makeVideosController()
      } else {
        return nil
      }
    }

    guard !controllers.isEmpty else {
      return nil
    }

    let controller = PagesController(controllers: controllers)
    controller.selectedIndex = tabsToShow.firstIndex(of: Config.initialTab ?? .cameraTab) ?? 0
    pagesController = controller
    return controller
  }

  func makePermissionController() -> PermissionController {
    let controller = PermissionController()
    controller.delegate = self

    return controller
  }

  // MARK: - Setup

  func setup() {
    EventHub.shared.close = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryControllerDidCancel(strongSelf)
      }
    }

    EventHub.shared.doneWithImages = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryController(strongSelf, didSelectImages: strongSelf.cart.images)
      }
    }

    EventHub.shared.doneWithVideos = { [weak self] in
      if let strongSelf = self, let video = strongSelf.cart.video {
        strongSelf.delegate?.galleryController(strongSelf, didSelectVideo: video)
      }
    }

    EventHub.shared.stackViewTouched = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryController(strongSelf, requestLightbox: strongSelf.cart.images)
        if Config.Camera.selectingStackViewOpensGrid {
            guard let indicator = strongSelf.pagesController?.pageIndicator else {
                return
            }
            strongSelf.pagesController?.pageIndicator(indicator, didSelect: 0)
        }
      }
    }
    EventHub.shared.updateNumImagesSelected = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryControllerUpdateNumImagesSelected(strongSelf, countImages: strongSelf.cart.images.count)
      }
    }
    EventHub.shared.triedToSelectMoreImagesThanMaxAllowed = { [weak self] in
        if let strongSelf = self {
            strongSelf.delegate?.galleryControllerTriedToSelectMoreThanMaxImges(strongSelf)
        }
    }
    EventHub.shared.userPanned = { [weak self] in
        if let strongSelf = self {
            strongSelf.delegate?.galleryControllerUserPanned(strongSelf)
        }
    }
  }

  // MARK: - PermissionControllerDelegate

  func permissionControllerDidFinish(_ controller: PermissionController) {
    if let pagesController = makePagesController() {
      g_addChildController(pagesController)
      controller.g_removeFromParentController()
    }
  }
}
