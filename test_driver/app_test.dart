// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    //Bottom top bar
    final profileIcon = find.byValueKey('profile');

    //Login screen
    final viewModuleRounded = find.byValueKey("view_module_rounded");
    final loginNavigate = find.byValueKey("login_navigate");
    final loginTextField = find.byValueKey("email_text_field");
    final passwordTextField = find.byValueKey("password_text_field");
    final loginButton = find.byValueKey("login_button");
    final logoutButton = find.byValueKey("logout_button");
    final editProfileButton = find.byValueKey("edit_profile_button");

    // Product form keys
    final postProductTapBarIcon = find.byValueKey("post_tabbar_icon");
    final productIdField = find.byValueKey("product_id");
    final categoryIdField = find.byValueKey("category_id");
    final productNameField = find.byValueKey("product_name");
    final categoryNameField = find.byValueKey("country_name");
    final salePriceField = find.byValueKey("sale_price");
    final fullPriceField = find.byValueKey("full_price");
    final deliveryTimeField = find.byValueKey("delivery_time");
    final productDescriptionField = find.byValueKey("product_description");
    final productImagesField = find.byValueKey("product_image");
    final isSaleSwitch =
        find.byType('Switch'); // Assuming there's only one switch
    final pickImageButton =
        find.text('Pick Image from Gallery'); // Based on button text
    final uploadProductButton =
        find.text('Upload Product'); // Based on button text

    const timeInterval = 1000; // 1s
    const duration = 20; // 10s
    Duration timeout = const Duration(seconds: 60);
    const emailTest = "21522809@gm.uit.edu.vn";
    const passwordTest = "123456789";

    FlutterDriver? driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: duration)}) async {
      try {
        await driver?.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver!.waitUntilFirstFrameRasterized();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    // test('Login', () async {
    //   await driver?.tap(profileIcon);
    //   await Future.delayed(const Duration(microseconds: timeInterval));

    //   if (await isPresent(editProfileButton)) {
    //     await driver?.tap(viewModuleRounded);
    //     await Future.delayed(const Duration(microseconds: timeInterval));
    //     await driver?.tap(logoutButton);
    //   }

    //   await driver?.tap(loginNavigate);
    //   await Future.delayed(const Duration(microseconds: timeInterval));

    //   await driver?.tap(loginTextField);
    //   await driver?.enterText(emailTest);
    //   await Future.delayed(const Duration(microseconds: timeInterval));

    //   await driver?.tap(passwordTextField);
    //   await driver?.enterText(passwordTest);
    //   await Future.delayed(const Duration(microseconds: 10 * timeInterval));

    //   await driver?.tap(loginButton);
    //   await Future.delayed(const Duration(microseconds: 10 * timeInterval));

    //   await driver?.waitFor(editProfileButton, timeout: timeout);
    // });

    test('Upload Product', () async {
      // Assume you navigate to the product form screen after logging in

      // Enter text in each form field
      await driver?.tap(postProductTapBarIcon);

      await driver?.tap(productIdField);
      await driver?.enterText('12345');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(categoryIdField);
      await driver?.enterText('fruit');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(productNameField);
      await driver?.enterText('Dragon fruit');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(categoryNameField);
      await driver?.enterText('fruit');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(salePriceField);
      await driver?.enterText('1.99');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(fullPriceField);
      await driver?.enterText('2.49');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(deliveryTimeField);
      await driver?.enterText('2 days');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.scrollUntilVisible(
        find.byType('ListView'), // Ensure this matches your scrollable widget
        productDescriptionField, // Adjust this to the correct target if needed
        dyScroll: 1000.0, // Positive value to scroll down
      );
      // await driver?.scrollUntilVisible(
      //   find.byType('ListView'), // Replace with your scrollable widget
      //   categoryIdField,
      //   dyScroll: -600.0, // Negative value to scroll up
      // );

      await driver?.tap(productDescriptionField);
      await driver?.enterText('Fresh dragon fruit, great for snacks.');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      await driver?.tap(productImagesField);
      await driver?.enterText(
          'https://media.post.rvohealth.io/wp-content/uploads/sites/2/2021/10/dragon-header.png');
      await Future.delayed(const Duration(milliseconds: timeInterval));

      // // Toggle the switch if needed
      // await driver?.tap(isSaleSwitch);
      // await Future.delayed(const Duration(milliseconds: timeInterval));

      // // Pick Image - Mock action, actual image picking isn't automated
      // await driver?.tap(pickImageButton);
      // await Future.delayed(const Duration(milliseconds: timeInterval));

      // Tap on the 'Upload Product' button
      await driver?.tap(uploadProductButton);
      await Future.delayed(const Duration(milliseconds: 10 * timeInterval));

      // Check if upload was successful - potentially wait for some indication like a SnackBar or navigating to a different screen
      await driver?.waitFor(editProfileButton, timeout: timeout);
    });
  });
}
