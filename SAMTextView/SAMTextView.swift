//
//  SAMTextView.swift
//  SAMTextView
//
//  Created by Sam Soffes on 8/18/10.
//  Copyright 2010-2014 Sam Soffes. All rights reserved.
//

import UIKit

/**
 UITextView subclass that adds placeholder support like UITextField has.
 */
public class SAMTextView : UITextView {
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    /**
     The string that is displayed when there is no other text in the text view. This property reads and writes the
     attributed variant.
     
     The default value is `nil`.
     */
    public var placeholder: String? {
        get {
            return attributedPlaceholder?.string
        }
        set(newPlaceholder) {
            guard let newPlaceholder = newPlaceholder else { return }
            guard newPlaceholder != attributedPlaceholder?.string else { return }
        
            var attributes = [String : AnyObject]()
            if isFirstResponder() {
                attributes = typingAttributes
            } else {
                attributes[NSFontAttributeName] = font
                attributes[NSForegroundColorAttributeName] = UIColor(white: 0.702, alpha: 1)
            
                if textAlignment != NSTextAlignment.Left {
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.alignment = textAlignment
                    attributes[NSParagraphStyleAttributeName] = paragraph
                }
            }
            attributedPlaceholder = NSAttributedString(string: newPlaceholder, attributes: attributes)
        }
    }
    
    /**
     The attributed string that is displayed when there is no other text in the text view.
     
     The default value is `nil`.
     */
    var attributedPlaceholder: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func insertText(text: String) {
        super.insertText(text)
        setNeedsDisplay()
    }
    
    // MARK: - Deinit
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: self)
    }
    
    // MARK: - UIView
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // Draw placeholder if necessary
        if text.characters.count == 0 && attributedPlaceholder != nil {
            let placeholderRect = placeholderRectForBounds(bounds)
            attributedPlaceholder?.drawInRect(placeholderRect)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Redraw placeholder text when the layout changes if necessary
        if attributedPlaceholder != nil && text.characters.count == 0 {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private
    
    private func textChanged() {
        setNeedsDisplay()
    }
    
    private func initialize() {
        NSNotificationCenter.defaultCenter().addObserverForName(UITextViewTextDidChangeNotification, object: self, queue: nil) { [unowned self] notification in
            self.textChanged()
        }
    }
    
    /**
     Returns the drawing rectangle for the text views’s placeholder text.
     
     - parameter bounds: The bounding rectangle of the receiver.
     
     - returns: The computed drawing rectangle for the placeholder text.
     */
    private func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, contentInset)
        
        if respondsToSelector("textContainer") {
            rect = UIEdgeInsetsInsetRect(rect, textContainerInset)
            let padding = textContainer.lineFragmentPadding
            rect.origin.x += padding
            rect.size.width -= padding * 2.0
        } else {
            if contentInset.left == 0.0 {
                rect.origin.x += 8.0
            }
            rect.origin.y += 8.0
        }
        
        return rect
    }
}
