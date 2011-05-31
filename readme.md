DCFineTuneSlider
============

Twitter: [@patr](http://twitter.com/patr)

Our commercial apps: [domesticcat.com.au](http://domesticcat.com.au/apps)

DCFineTuneSlider is designed to be a drop in replacement for UISlider that adds a few extra features.

![DCFineTuneSlider Demo Image](http://domesticcat.com.au/projects/dcfinetuneslider/finetunesliderdemo.png)

* A button either side of the slider that increments it by a preset fine tune amount
* Drag outwards on the track of the slider to fine tune
* Double tap on the track of the slider to jump to a value
* Adds a block handler to the valueDidChange event

Usage is almost identical to a normal UISlider, with just a few extra properties to setup;

    @property CGFloat fineTuneAmount;
    @property (nonatomic, retain) UIButton *increaseButton;
    @property (nonatomic, retain) UIButton *decreaseButton;

The `fineTuneAmount` is the amount that will be added or subtracted when the user taps on the increase/decrease buttons.  The two buttons are setup as `UIButtonTypeCustom`, and are directly accessible.  Recommended use is to assign images using `setImage:forControlState:`.

And the optional block to handle value changes:

    @property (nonatomic, copy) void (^valueChangedHandler)(id sender);

A demo project is included to see it in action.

License
-----------

Made available under the MIT License.