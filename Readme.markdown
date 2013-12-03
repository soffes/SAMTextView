# SAMTextView

Add a placeholder to UITextView.

SAMTextView is tested on iOS 6 and requires ARC. Released under the [MIT license](LICENSE).

## Usage

``` objc
// Initialize a text view
SAMTextView *textView = [[SAMTextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 280.0f)];

// Add a placeholder
textView.placeholder = @"Type something…";
```

For more advanced control of the placeholder, you can set the `attributedPlaceholder` property instead. See the [header](SAMTextView/SAMTextView.h) for full documentation.

## Installation

Simply add the files in the `SAMTextView.h` and `SAMTextView.m` to your project or add `SAMTextView` to your Podfile if you're using CocoaPods.
