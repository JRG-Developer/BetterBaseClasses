## BetterBaseClasses

`BetterBaseClasses` are abstract, base classes meant to be subclassed.

Most view controllers will only have *ONE* nib or storyboard scene associated with them.  `BetterBaseClasses` lets you specify the `identifier`, `bundle`, and `storyboardName`  as part of the class- where it makes more sense for it to be in most cases.

This also makes creating and consuming a CocoaPod *much* easier.
 
In example, instead of having to call `initWithNibName: bundle:`, which requires that the consuming app have knowledge of the nib name and the bundle, you can simply call the class method `instanceFromNib`.

`BetterBaseClasses` also provides convenience methods for working with views, too.

### Installation with CocoaPods

The easiest way to add `BetterBaseClasses` to your project is using <a href="http://cocoapods.org/">CocoaPods</a>. 

Simply add the following line to your Podfile:

    pod 'BetterBaseClasses', '~> 1.0'

Then run `pod install` as you normally would.

### Manual Installation

Follow these steps for manual installation:

1) Clone this repo locally onto your computer, or press `Download ZIP` to download the latest master commit.

2) Drag the `BetterBaseClasses` folder into your project.

3) Delete the `BetterBaseClasses.h` file (it's a public header for when this included as a library/CocoaPod).

### How to Use

1) Instead of subclassing `UIViewController` or `UITableViewController`, you should subclass `BaseViewController` or `BaseTableViewController`, respectively.

2) (Optional) override `commonInit`, which is called by *all* designated initializers, to run common setup code.

3) (Optional) override the class methods `bundle`, `identifier`, or `storyboardName`. This allows you to specify the nib name or storyboard identifier *right in the view controller*.

In most cases, however, you won't need to override these as reasonable default values are already provided (e.g. nib name is expected to match the view controller's name, etc).

4) Call the class method `instanceFromNib` to instantiate a view controller from its nib or `instanceFromStoryboard` to instantiate a view controller from its storyboard scene.

For example,

------ **TestViewController.h** ------
	
    #import "BaseViewController.h"

    @interface TestViewController : BaseViewController
    @property (assign, nonatomic) NSUInteger exampleValue;
    @end

------ **TestViewController.m** ------

    #import "TestViewController.h"

    @implementation TestViewController
    
    - (void)commonInit {

      [super commonInit];
      _exampleValue = 42;
    }
    
    @end

You could then instantiate a new `TestViewController` from a nib named `TestViewController.xib` like this:

    TestViewController *viewController = [TestViewController instanceFromNib];

Win. :]

There are also convenience methods for working with views, too. See `BaseView` and `BaseTableView` for in-line documentation for more details.

### License

`BetterBaseClasses` is available under the MIT license (see the LICENSE file for more details).
