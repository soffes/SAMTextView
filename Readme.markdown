# SAMTextView

Add a placeholder to UITextView.

SAMTextView is tested on iOS 7-9 and requires ARC. Released under the [MIT license](LICENSE).

## Usage

#### Objective-C
``` objc
// Initialize a text view
SAMTextView *textView = [[SAMTextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 280.0f)];

// Add a placeholder
textView.placeholder = @"Type something…";
```

#### Swift
``` swift
// Initialize a text view
let textView = SAMTextView(frame:CGRectMake(20.0, 20.0, 280.0, 280.0))

// Add a placeholder
textView.placeholder = "Type something…"
```

For more advanced control of the placeholder, you can set the `attributedPlaceholder` property instead. See the [header](SAMTextView/SAMTextView.swift) for full documentation.

## Installation

Simply add the file `SAMTextView.swift` to your project or add `SAMTextView` to your Podfile if you're using CocoaPods.
