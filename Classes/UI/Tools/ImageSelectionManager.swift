/*
 The MIT License (MIT)

 Copyright (c) 2019 Ugur Kilic All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

public class ImageSelectionManager: NSObject {

    /// Shared image selection manager
    public static let shared = ImageSelectionManager()

    /// Localization table name if exists
    public var localizationTableName: String?

    private var pickCompletion: ((UIImage?) -> Void)?

    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()

    public func displayImagePicker(completion: @escaping (UIImage?) -> Void) {
        pickCompletion = completion

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(
            UIAlertAction(title: localized(key: "camera"), style: .default, handler: {
                [weak self] (_) in
            self?.present(camera: true)
        }))
        alertController.addAction(
            UIAlertAction(title: localized(key: "gallery"), style: .default, handler:
                { [weak self] (_) in
            self?.present(camera: false)
        }))
        alertController.addAction(
            UIAlertAction(title: localized(key: "cancel"), style: .cancel, handler:
                { [weak self] (_) in
            self?.dismiss()
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    public func dismiss() {
        pickCompletion = nil
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    private func present(camera: Bool) {
        imagePicker.sourceType = camera ? .camera : .photoLibrary
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }

    private func localized(key: String) -> String {
        return NSLocalizedString(key, tableName: localizationTableName, bundle: Bundle.main, value: "", comment: "")
    }
}

extension ImageSelectionManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as? UIImage
        pickCompletion?(image)
        dismiss()
    }
}
