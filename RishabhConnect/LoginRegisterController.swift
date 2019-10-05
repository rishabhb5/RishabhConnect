//
//  LoginRegisterController.swift
//  RishabhConnect
//
//  Created by Rishabh Bendiganavale on 6/26/19.
//  Copyright © 2019 Rishabh Bendiganavale. All rights reserved.
//

import UIKit
import Firebase

class LoginRegisterController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //VIEWDIDLOAD
    
    // initializes main view and adds all subviews into here
    override func viewDidLoad() {
        super.viewDidLoad()
    
        checkIfUserIsLoggedIn()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsContainer)
        view.addSubview(segmentedControl)
        view.addSubview(picture)
        view.addSubview(button)
        
        setupinputsContainer()
        setupsegmentedController()
        setupbutton()
        setuppicture()
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid != nil {
            perform(#selector(handleEntry), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleEntry() {
        let m: MainViewController? = MainViewController()
        m!.loginRegisterController = self
        let mNav = UINavigationController(rootViewController: m!)
        
        present(mNav, animated: true, completion: nil)
    }
    
    /*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    // UI ELEMENTS
    
    // all inputs
    let inputsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // segmentedControl
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        
        sc.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
        return sc
    }()
    
    // name
    let nameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // name seperator
    let nameSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // email
    let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // email seperator
    let emailSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // password
    let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // profile pic
    lazy var picture: UIImageView = {
        var pic = UIImageView()
        pic.image = UIImage(named: "Logo")
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFill
        return pic
    }()
    
    // login/register button
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    /*--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    // SETUP FUNCTIONS
    
    var changinginputsContainerHeight: NSLayoutConstraint?
    var changingnameFieldHeight: NSLayoutConstraint?
    var changingemailFieldHeight: NSLayoutConstraint?
    var changingpasswordFieldHeight: NSLayoutConstraint?
    
    func setupinputsContainer() {
        //inputsContainer
        inputsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        changinginputsContainerHeight = inputsContainer.heightAnchor.constraint(equalToConstant: 100)
        changinginputsContainerHeight?.isActive = true
        
        inputsContainer.addSubview(nameField)
        inputsContainer.addSubview(nameSeperator)
        inputsContainer.addSubview(emailField)
        inputsContainer.addSubview(emailSeperator)
        inputsContainer.addSubview(passwordField)
        
        //NAME AND NAME SEPERATOR: need x, y, width, height constraints
        nameField.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        nameField.topAnchor.constraint(equalTo: inputsContainer.topAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //initial
        changingnameFieldHeight = nameField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 0)
        changingnameFieldHeight?.isActive = true
        
        nameSeperator.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor).isActive = true
        nameSeperator.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //EMAIL AND EMAIL SEPERATOR: need x, y, width, height constraints
        emailField.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //initial
        changingemailFieldHeight = emailField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 1/2)
        changingemailFieldHeight?.isActive = true
        
        emailSeperator.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor).isActive = true
        emailSeperator.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        emailSeperator.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        emailSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //PASSWORD: need x, y, width, height constraints
        passwordField.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //tiinitial
        changingpasswordFieldHeight = passwordField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 1/2)
        changingpasswordFieldHeight?.isActive = true
    }
    
    func setuppicture() {
        //need x, y, width, height constraints
        picture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -12).isActive = true
        picture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        picture.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupsegmentedController() {
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: inputsContainer.topAnchor, constant: -12).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupbutton() {
        //need x, y, width, height constraints
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: inputsContainer.bottomAnchor, constant: 12).isActive = true
        button.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    /*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //HANDLERS
    
    @objc func handleSegmentedControlChange() {
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        button.setTitle(title, for: .normal)
        
        // change height of inputsContainer
        changinginputsContainerHeight?.constant = segmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of nameTextField
        changingnameFieldHeight?.isActive = false
        changingnameFieldHeight = nameField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: segmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        changingnameFieldHeight?.isActive = true
        
        // change height of emailTextField
        changingemailFieldHeight?.isActive = false
        changingemailFieldHeight = emailField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: segmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        changingemailFieldHeight?.isActive = true
        
        // change height of passwordTextField
        changingpasswordFieldHeight?.isActive = false
        changingpasswordFieldHeight = passwordField.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: segmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        changingpasswordFieldHeight?.isActive = true
        
        if segmentedControl.selectedSegmentIndex == 0 {
            picture.image = UIImage(named: "Logo")
        } else {
            picture.image = UIImage(named: "Profile")
            
            let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
            mytapGestureRecognizer.numberOfTapsRequired = 1
            picture.addGestureRecognizer(mytapGestureRecognizer)
            picture.isUserInteractionEnabled = true
        }
    }
    
    @objc func handleButton() {
        if segmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error != nil {
                print(error!)
                return
            } else {
                mainScreen(self: self)
            }
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //HANDLING REGISTER
    
    func handleRegister() {
        guard let name = nameField.text, let email = emailField.text, let password = passwordField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let uid = res?.user.uid else {
                return
            }
            
            //successfully authenticated user
            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profileImage = self.picture.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, err) in
                        if let err = err {
                            print(err)
                            return
                        }
                        
                        guard let url = url else { return }
                        let values = ["name": name, "email": email, "profileImageUrl": url.absoluteString]
                        
                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                    })
                    
                })
            }
        }
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            mainScreen(self:self)
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            picture.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
// PUT THIS FUNCTION OUTSIDE OF CLASS

func mainScreen(self: LoginRegisterController) {
    let m: MainViewController? = MainViewController()
    let mNav = UINavigationController(rootViewController: m!)

    self.present(mNav, animated: true, completion: nil)
}

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
//OUTSIDE OF CLASS

// extends UIColor
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
