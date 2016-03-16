//
//  KMPreferencesController.swift
//  Komikan
//
//  Created by Seth on 2016-01-11.
//  Copyright © 2016 DrabWeb. All rights reserved.
//

import Cocoa

class KMPreferencesController: NSViewController {

    // The main window for this view controller
    var preferencesWindow : NSWindow = NSWindow();
    
    // The tab view for going through preference categories
    @IBOutlet weak var tabView: NSTabView!
    
    // The visual effect view for the background of the window
    @IBOutlet weak var backgroundVisualEffectView: NSVisualEffectView!
    
    // The visual effect view for the titlebar of the window
    @IBOutlet weak var titlebarVisualEffectView: NSVisualEffectView!
    
    // The checkbox to say if we want to havel-lewd... mode enabled
    @IBOutlet weak var llewdModeEnabledCheckbox: NSButton!
    
    // The checkbox to say if we should delete a manga that is added from EH when we remove it from the grid
    @IBOutlet weak var llewdModeDeleteWhenRemovingCheckbox: NSButton!
    
    // When we interact llewdModeEnabledCheckbox...
    @IBAction func llewdModeEnabledCheckboxInteracted(sender: AnyObject) {
        // Disable / enable all the checkboxes under it
        enableOrDisableLLewdModeCheckboxes();
    }
    
    // The checkbox to say if we want to mark a manga as read when we complete it in the reader
    @IBOutlet weak var markAsReadWhenCompletedInReaderCheckbox: NSButton!
    
    // The checkbox to say if we want to hide the cursor in distraction free mode
    @IBOutlet weak var hideCursorInDistractionFreeModeCheckbox: NSButton!
    
    /// The slider to say how much distraction free mode should dim the background
    @IBOutlet weak var distractionFreeModeDimAmountSlider: NSSlider!
    
    /// The checkbox to say if we want to be able to drag the reader window by the background without holding alt
    @IBOutlet weak var dragReaderWindowByBackgroundWithoutHoldingAltCheckbox: NSButton!
    
    /// The text field for saying if the filename of a page in a manga matches the regex given, then ignore it
    @IBOutlet var ignorePagesMatchingRegexTextField: KMAlwaysActiveTextField!
    
    /// The color well for letting the user set the background color of the reader window
    @IBOutlet var readerWindowBackgroundColorColorWell: NSColorWell!
    
    /// The popup button to select what the default screen to show at launch is
    @IBOutlet var defaultScreenPopupButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        // Style the window
        styleWindow();
        
        // Load the preferences
        loadPreferences();
        
        // Enable or disable the l-lewd... checkboxes
        enableOrDisableLLewdModeCheckboxes();
    }
    
    override func viewWillDisappear() {
        // Set the global preferences keepers value to the preference value
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.llewdModeEnabled = Bool(llewdModeEnabledCheckbox.state);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.deleteLLewdMangaWhenRemovingFromTheGrid = Bool(llewdModeDeleteWhenRemovingCheckbox.state);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.markAsReadWhenCompletedInReader = Bool(markAsReadWhenCompletedInReaderCheckbox.state);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.hideCursorInDistractionFreeMode = Bool(hideCursorInDistractionFreeModeCheckbox.state);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.distractionFreeModeDimAmount = CGFloat(distractionFreeModeDimAmountSlider.floatValue);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.dragReaderWindowByBackgroundWithoutHoldingAlt = Bool(dragReaderWindowByBackgroundWithoutHoldingAltCheckbox.state);
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.pageIgnoreRegex = ignorePagesMatchingRegexTextField.stringValue;
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.readerWindowBackgroundColor = readerWindowBackgroundColorColorWell.color;
        (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.defaultScreen = defaultScreenPopupButton.indexOfSelectedItem;
        
        // Tell AppDelegate to act upon the preferences
        (NSApplication.sharedApplication().delegate as! AppDelegate).actOnPreferences();
    }
    
    // Lods the preferences from the global preferences keeper object
    func loadPreferences() {
        // Load the checkbox values
        llewdModeEnabledCheckbox.state = Int((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.llewdModeEnabled);
        llewdModeDeleteWhenRemovingCheckbox.state = Int((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.deleteLLewdMangaWhenRemovingFromTheGrid);
        markAsReadWhenCompletedInReaderCheckbox.state = Int((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.markAsReadWhenCompletedInReader);
        hideCursorInDistractionFreeModeCheckbox.state = Int((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.hideCursorInDistractionFreeMode);
        distractionFreeModeDimAmountSlider.floatValue = Float((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.distractionFreeModeDimAmount);
        dragReaderWindowByBackgroundWithoutHoldingAltCheckbox.state = Int((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.dragReaderWindowByBackgroundWithoutHoldingAlt);
        ignorePagesMatchingRegexTextField.stringValue = (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.pageIgnoreRegex;
        readerWindowBackgroundColorColorWell.color = (NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.readerWindowBackgroundColor;
        defaultScreenPopupButton.selectItemAtIndex((NSApplication.sharedApplication().delegate as! AppDelegate).preferencesKepper.defaultScreen);
    }
    
    // Enables / disables all the checkboxes under the l-lewd... mode enabled checkbox
    func enableOrDisableLLewdModeCheckboxes() {
        // Do the delete when removing checkbox
        llewdModeDeleteWhenRemovingCheckbox.enabled = Bool(llewdModeEnabledCheckbox.state);
    }
    
    func styleWindow() {
        // Get a reference to the main window
        preferencesWindow = NSApplication.sharedApplication().windows.last!;
        
        // Set the main window to have a full size content view
        preferencesWindow.styleMask |= NSFullSizeContentViewWindowMask;
        
        // Hide the titlebar background
        preferencesWindow.titlebarAppearsTransparent = true;
        
        // Hide the titlebar title
        preferencesWindow.titleVisibility = NSWindowTitleVisibility.Hidden;
        
        // Set the backgrouynd effect view to be dark
        backgroundVisualEffectView.material = NSVisualEffectMaterial.Dark;
        
        // Set the titlebar effect to be ultra dark
        if #available(OSX 10.11, *) {
            titlebarVisualEffectView.material = NSVisualEffectMaterial.UltraDark
        } else {
            titlebarVisualEffectView.material = NSVisualEffectMaterial.Titlebar
        };
        
        // Get the windows center position on the X
        let windowX = ((NSScreen.mainScreen()?.frame.width)! / 2) - (480 / 2);
        
        // Get the windows center position on the Y
        let windowY = ((NSScreen.mainScreen()?.frame.height)! / 2) - (270 / 2);
        
        // Center the window
        preferencesWindow.setFrame(NSRect(x: windowX, y: windowY, width: 480, height: 270), display: false);
    }
}
