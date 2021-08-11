//
//  SettingsViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import AttributedStringBuilder

class SettingsViewController: BaseBottomPopupViewController {
    
    @IBOutlet weak var settingsTitleLabel: UILabel!
    @IBOutlet weak var increaseFontSizeView: UIView!
    @IBOutlet weak var decreaseFontSizeView: UIView!
    @IBOutlet weak var currentFontSizeLabel: UILabel!
    @IBOutlet weak var smallLineSpacingView: UIView!
    @IBOutlet weak var normalLineSpacingView: UIView!
    @IBOutlet weak var largeLineSpacingView: UIView!
    @IBOutlet weak var fontStyleCollectionView: UICollectionView!
    @IBOutlet weak var systemThemeView: UIView!
    @IBOutlet weak var darkThemeView: UIView!
    @IBOutlet weak var lightThemeView: UIView!
    @IBOutlet weak var themesStackView: UIStackView!
    @IBOutlet weak var stayAwakeSwitch: UISwitch!
    
    var moreViewModel: IMoreViewModel!
    override func getViewModel() -> BaseViewModel { moreViewModel as! BaseViewModel }

    override func configureViews() {
        super.configureViews()
        
        setupFontStylesCollectionView()
        
        moreViewModel.do {
            $0.getFontStyles()
            $0.getUserSettings()
        }
        
        settingsTitleLabel.attributedText = AttributedStringBuilder()
            .text("Settings", attributes: [.font(.comfortaaBold(size: 18)), .underline(true), .textColor(.aLabel), .alignment(.center)])
            .attributedString
        
        runAfter(0.2) { [weak self] in
            guard let self = self else { return }
            self.updateThemeViews(theme: self.moreViewModel.currentTheme)
        }
        
        stayAwakeSwitch.isOn = moreViewModel.stayAwake
    }
    
    override func setupTapGestures() {
        
        systemThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .system)
        }
        
        darkThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .dark)
        }
        
        lightThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .light)
        }
        
        increaseFontSizeView.animateViewOnTapGesture { [weak self] in
            self?.moreViewModel.increaseFontSize()
        }
        
        decreaseFontSizeView.animateViewOnTapGesture { [weak self] in
            self?.moreViewModel.decreaseFontSize()
        }
        
        smallLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.moreViewModel.updateLineSpacing(type: .small)
        }
        
        normalLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.moreViewModel.updateLineSpacing(type: .normal)
        }
        
        largeLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.moreViewModel.updateLineSpacing(type: .large)
        }
    }
    
    @IBAction func stayAwakeSwitchValueChanged(_ sender: UISwitch) {
        moreViewModel.stayAwake = sender.isOn
    }
    
    fileprivate func switchAppTheme(type theme: Theme) {
        if #available(iOS 13.0, *) {
            view.window?.do {
                switch theme {
                case .system:
                    $0.overrideUserInterfaceStyle = .unspecified
                case .dark:
                    $0.overrideUserInterfaceStyle = .dark
                case .light:
                    $0.overrideUserInterfaceStyle = .light
                }
            }
            moreViewModel.currentTheme = theme
            updateThemeViews(theme: theme)
        } else {
            themesStackView.hideView()
        }
    }
    
    fileprivate func updateThemeViews(theme: Theme) {
        updateThemeView(systemThemeView, isActive: theme == .system)
        updateThemeView(darkThemeView, isActive: theme == .dark)
        updateThemeView(lightThemeView, isActive: theme == .light)
    }
    
    fileprivate func updateThemeView(_ themeView: UIView, isActive: Bool) {
        ((themeView.subviews.first as? UIStackView)?.subviews.filter { $0 is UIImageView }.first as? UIImageView)?.showView(isActive)
    }
    
    override var popupHeight: CGFloat { 480 }
    
    fileprivate func setupFontStylesCollectionView() {
        fontStyleCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        moreViewModel.fontStyles.bind(to: fontStyleCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.settingsFontStyleCollectionViewCell.identifier, cellType: FontStyleCollectionViewCell.self)) { [weak self] row, font, cell in
            guard let self = self else { return }
            
            cell.configureView(font: font, settings: self.moreViewModel.currentSettings!)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.moreViewModel.updateSelectedFontStyle(font)
            }
            
        }.disposed(by: disposeBag)
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeUserSettingsChanges()
    }
    
    fileprivate func observeUserSettingsChanges() {
        moreViewModel.updateUIWithCurrentSettings.bind { [weak self] update in
            if update {
                self?.updateUIWithCurrentSettings()
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func updateUIWithCurrentSettings() {
        updateThemeViews(theme: moreViewModel.currentTheme)
        moreViewModel.currentSettings!.do {
            currentFontSizeLabel.text = "\($0.fontSize)px"
            updateLineSpacingViews(type: $0.lineSpacingType)
        }
        fontStyleCollectionView.reloadData()
    }
    
    fileprivate func updateLineSpacingViews(type: LineSpacingType) {
        switch type {
        case .small:
            updateLineSpacingView(smallLineSpacingView)
            updateLineSpacingView(normalLineSpacingView, isActive: false)
            updateLineSpacingView(largeLineSpacingView, isActive: false)
        case .normal:
            updateLineSpacingView(smallLineSpacingView, isActive: false)
            updateLineSpacingView(normalLineSpacingView)
            updateLineSpacingView(largeLineSpacingView, isActive: false)
        case .large:
            updateLineSpacingView(smallLineSpacingView, isActive: false)
            updateLineSpacingView(normalLineSpacingView, isActive: false)
            updateLineSpacingView(largeLineSpacingView)
        }
    }
    
    fileprivate func updateLineSpacingView(_ view: UIView, isActive: Bool = true) {
        view.backgroundColor = isActive ? .accentColor : .aSecondarySystemBackground
        (view.subviews.first as? UIImageView)?.tintColor = isActive ? .white : .aSecondaryLabel
    }

}


//MARK: - UICollectionViewDelegateFlowLayout
extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: collectionView.height)
    }
    
}
