uiview-loading
==============

Category to show a loading indicator inside any kind of UIView.

Demo
====

The demo/ folder contains a demo project showing UIView+Loading in use. Open and run it.

Usage
=====

Import "UIView+Loading". Then, on your UIView that will be loading asynchronous data, instead of loading it directly, load it inside a block:

    [_container loadDataFromLoader:^() {
    	// kick off async load here
    }];

The block will be run immediately, and the view will display a loading indicator and a translucent white mask will be applied.

When the data load attempt is done, you call a different method depending on whether the load succeeded or failed:

- If it succeeded, call `[_container hideLoadingPrompt]`. This will hide the loading indicator and mask.
- If it failed, call `[_container displayReloadPrompt]`. This will allow the user to tap to reattempt the data load. (This is why you passed the loader a block containing the loading code.)

Compatibility
=============

This class has been tested back to iOS 6.0.

Implementation
==============

This class is implemented by storing the block of loading code to execute, so it can be rerun upon reload without manual UI work on your part.

License
=======

This code is released under the MIT License. See the LICENSE file for details.
