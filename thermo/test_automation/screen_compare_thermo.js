test.log("Starting Test for " + test.platformName());
test.sleep(1000);
test.verifyImage("image_compare_" + test.platformName() + "_thermo", "data/" + test.platformName() + "-thermo.png")
test.getScreen(test.platformName() + "_main_screen");

if (test.platformName() == "stm32f469i-discovery"
    || test.platformName() == "stm32f769i-discovery") {
     // Click on "Schedule"
    test.performTouchGesture( [ {x:427, y:418, ts:0} , {x:427, y:418, ts:100 }]);
    test.sleep(1000);

     // Click on "Places"
    test.performTouchGesture( [ {x:169, y:435, ts:0} , {x:169, y:435, ts:100 }]);
    test.sleep(1000);

     // Click on "Living Room"
    test.performTouchGesture( [ {x:204, y:239, ts:0} , {x:204, y:239, ts:100 }]);
    test.sleep(1000);
} else {
     // Click on "Schedule"
    test.performTouchGesture( [ {x:230, y:240, ts:0} , {x:230, y:240, ts:100 }]);
    test.sleep(1000);

     // Click on "Places"
    test.performTouchGesture( [ {x:30, y:240, ts:0} , {x:30, y:240, ts:100 }]);
    test.sleep(1000);

     // Click on "Living Room"
    test.performTouchGesture( [ {x:240, y:130, ts:0} , {x:240, y:130, ts:100 }]);
    test.sleep(1000);
}

test.succeed();
