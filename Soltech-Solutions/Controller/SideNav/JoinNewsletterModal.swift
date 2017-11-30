//
//  JoinNewsletterModal.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/9/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class JoinNewsletterModal: UIViewController {
	private lazy var formView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.clipsToBounds = true
		view.layer.cornerRadius = 5
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOffset = CGSize(width: 0, height: 2)
		view.layer.shadowOpacity = 0.3
		return view
	}()

	private let label: UILabel = {
		let label = UILabel()
		label.text = "Join our Newsletter"
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textAlignment = .center
		return label
	}()

	private let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "logo")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private let nameText: RoundedTextfield = {
		let textfield = RoundedTextfield(cornerRadius: 5)
		textfield.placeholder = "Enter full name"
		textfield.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
		textfield.layer.cornerRadius = 5
		textfield.autocapitalizationType = .words
		textfield.autocorrectionType = .no
		return textfield
	}()

	private let emailText: RoundedTextfield = {
		let textfield = RoundedTextfield(cornerRadius: 5)
		textfield.placeholder = "Enter email"
		textfield.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
		textfield.layer.cornerRadius = 5
		textfield.keyboardType = .emailAddress
		textfield.autocorrectionType = .no
		textfield.autocapitalizationType = .none
		return textfield
	}()

	private lazy var submitBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("Submit", for: .normal)
		btn.backgroundColor = COLOR_GREEN
		btn.setTitleColor(.white, for: .normal)
		btn.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		return btn
	}()

	private lazy var closeBtn: UIButton = {
		let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 24, height: 24))
		btn.setImage(UIImage(named: "closeBtn_24")?.withRenderingMode(.alwaysTemplate), for: .normal)
		btn.tintColor = .red
		btn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
		btn.layer.opacity = 0
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		let stackView = UIStackView(arrangedSubviews: [label, nameText, emailText])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 10

		formView.addSubview(logoImageView)
		formView.addSubview(stackView)
		formView.addSubview(submitBtn)
		formView.addSubview(closeBtn)

		constrain(nameText, emailText, label) { (name, email, label) in
			name.height == 40
			email.height == 40
			label.height == 40
		}

		constrain(logoImageView, stackView, submitBtn) { (img, stack, btn) in
			img.top == img.superview!.top
			img.centerX == img.superview!.centerX
			img.width == img.superview!.width * 0.5
			img.height == 80

			stack.top == img.bottom
			stack.right == img.superview!.right - 20
			stack.left == img.superview!.left + 20

			btn.bottom == btn.superview!.bottom
			btn.right == btn.superview!.right
			btn.left == btn.superview!.left
			btn.height == 50

			stack.bottom == btn.top - 15
		}

		view.addSubview(formView)

		formView.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: 285)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		animateFormView(isShowing: true)
	}

	@objc private func submitBtnPressed() {
		animateFormView(isShowing: false)
	}

	@objc private func closeBtnPressed() {
		animateFormView(isShowing: false)
	}

	private func animateFormView(isShowing: Bool) {
		if isShowing {
			UIView.animate(withDuration: 0.25, animations: {
				self.formView.frame.origin.y = (self.view.frame.height / 2) - (self.formView.frame.height / 2)
				self.view.layoutIfNeeded()
				self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
				self.closeBtn.layer.opacity = 1
			})
		} else {
			UIView.animate(withDuration: 0.25, animations: {
				self.formView.frame.origin.y = self.view.frame.height
				self.view.layoutIfNeeded()
				self.view.backgroundColor = .clear
				self.closeBtn.layer.opacity = 0
			}, completion: { (completed) in
				self.dismiss(animated: true, completion: nil)
			})
		}
	}
}


















