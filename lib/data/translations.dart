import 'package:get/get.dart';

class AppLocales extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Navigation
          'pos': 'POS',
          'dashboard': 'Dashboard',
          'manage': 'Manage',
          'profile': 'Profile',
          //POS
          'all': 'All',
          'variations': 'Variations',
          'addToCart': 'Add To Cart',
          //cart
          'cartItems': 'Cart Items',
          'clearAll': 'Clear All',
          'total': 'Total',
          'tax': 'Tax (@percent %)',
          'taxIncluded': 'Tax Included',
          'taxExclusive': 'Tax Exclusive',
          'goToCheckout': 'Go to Checkout',
          'clearAllTitle': 'Clear All Cart Items',
          'clearAllMessage': 'Are you sure you want to remove all?',
          'cancel': 'Cancel',
          'clearCart': 'Clear Cart',
          'emptyCart': 'You have no order yet.',
          'outOfStock': 'Out of Stock',
          'outOfOpts': '@product have only @count @unit',
          'removeProduct': 'Are you sure to remove @product',
          'productVariation': 'Choose Variation (@currency @price)',
          'confirmCheckout': 'Are you sure to continue checkout?',
          'customer': 'Customer',
          //Print
          'continuePrint': 'Continue to print receipt?',
          'saveReceipt': 'Save receipt to gallery',
          'printReceipt': 'Print Receipt',
          'print': 'Print',

          //-checkout
          'new': 'New',
          'title': 'Title',
          'checkout': 'Checkout',
          'change': 'Change',
          'subTotal': 'Sub Total',
          'discount': 'Discount',
          'discountAmount': 'Discount Amount',
          'confirm': 'Confirm',
          'info': 'Info',
          'selectCategory': 'Select Category',

          'addPromoCode': 'Add Promo Code',
          'confirmPayment': 'Confirm Payment',
          'payment': 'Payment',
          'otherPaymentMethods': 'Other Payment Methods',
          'paymentSuccess': 'Payment Success',
          'paymentFail': 'Payment Fail',
          'backToHome': 'Back to Home',
          'doNotLeavePage': 'Do not leave the page',
          'update': 'Update',

          //Manage
          'removeAll': 'Remove All',
          'remove': 'Remove',
          'products': 'Products',
          'categories': 'Categories',
          'saleInvoice': 'Sale Invoice',
          'purchaseInvoice': 'Purchase Invoice',
          'inventoryReports': 'Inventory Reports',
          'myStore': 'My Store',
          'coupons': 'Coupons',
          'accounts': 'Accounts',

          //Profile
          'email': 'Email',
          'name': 'Name',
          'password': 'Password',
          'preference': 'Preference',
          'appearance': 'Appearance',
          'printerSetting': 'Printer Setting',
          'others': 'Others',
          'reportProblem': 'Report Problem',
          'aboutUs': 'About us',

          'emailAddress': 'Email Address',
          'phoneNumber': 'Phone Number',
          'language': 'Language',
          'help': 'Help',
          'login': 'Login',
          'register': 'Register',
          'logout': 'Logout',
          'logoutConfirm': 'Are you sure to logout?',
          'edit': 'Edit',
          'camera': 'Camera',
          'gallery': 'Gallery',
          'successUpload': 'Successfully Uploaded',
          'successUploadDesc': 'Your profile image is successfully uploaded',
          'failUpload': 'Failed uploading',
          'failUploadDesc':
              'Cannot upload your profile picture. Please try again',

          //Email
          'next': 'Next',
          'enterEmailAddress': 'Enter email address',
          'sendCodeToMail': "We will send a code to the email you entered.",
          'enterPhone': 'Enter Phone Number',
          'sendCodeToPhone':
              "We will send a code (via SMS text message to your phone number.",
          'sentOTPLabel':
              'You will get a 6 digit verification code we\'ve sent to @target',
          'manageEmail': 'Manage Email Address',
          'addEmail': 'Add your email address',
          //Phone
          'phone': 'Phone',
          'managePhone': 'Manage Phone Number',
          'addPhone': 'Add your phone number',
          'verifyOTP': 'Verify OTP',
          'enterOTP': 'Enter the OTP code',
          'changeTarget': 'Change @target',
          'invalidOTP': 'Invalid OTP',
          'notReceivedOTP': 'Didn’t received code?',
          'sendAgain': 'Send Again',
          'verify': 'Verify',
          'failedSendOTP': 'Failed to send OTP',

          //Coupons
          'emptyCoupons': "You don't have any voucher yet.",
          //Notification
          'notifications': 'Notifications',
          //Help
          'helpLabel':
              "Please write down your problems and we will reply to you as soon as possible.",
          'helpPlaceholder': 'Write here',
          'addScreenshot': 'Add Screenshot',
          'send': 'Send',
          'successTitle': "Sent Successfully!",
          'successDesc': 'We will reply you as soon as we can.',
          'failTitle': "Sent failed!",
          'failDesc': 'An error occurred during sending. Please try again.',
          //Shop
          'noProductFound': 'No products found',
          'searchDifferentStore': 'Search Different Store',

          //Search
          'searchProducts': 'Search Products',
          'searchHistories': 'Search Histories',
          'clear': 'Clear',
          'noRecentSearch': 'No Recent Searches',
          'shops': 'Shops',
          'suggestedKeywords': 'Suggested Keywords',

          //Auth
          'everythingIsHere': 'Everything you need is here!',
          'manawZay': 'MaNaw Zay',
          'or': 'OR',
          'agreePolicy':
              'By signing in, you agree to our Terms of Service and Privacy Policy.',
          'continue': 'Continue',
          'loginSuccess': 'Login Success',

          //Review
          'loadMore': 'Load More',
          'aCustomer': 'A Customer',
          'rateProductQuality': 'Rate the Product Quality',
          'writeYourReview': 'Write your review',
          'reviewPlaceholder':
              "Would you like to write anything about this product?",
          'addPhoto': 'Add Photo',
          'submit': 'Submit',
          'success': 'Success',
          'reviewSuccess': 'Successfully posted a review',
          'version': 'Version @code',
          'failed': 'Failed',
          'reviewFailed': 'Failed to submit review, please try again',
          //Change name
          'changeName': 'Change Name',
          'newName': 'New Name',
          'namePlaceholder': 'John Doe',
          'nameChangeSuccess': 'Successfully Changed',
          'nameChangeSuccessMsg': 'Your name is successfully changed',
          'nameChangeFail': 'Failed',
          'nameChangeFailMsg': 'Some errors occurred, please try again',
        },
        'my_MM': {
          //Navigation
          'profile': 'ပရိုဖိုင်',
          'pos': 'အရောင်း',
          'dashboard': 'စာရင်းဇယား',
          'manage': 'စီမံ',
          //POS
          'all': 'အားလုံး',
          'variations': 'ပုံစံကွဲများ',
          'addToCart': 'ဈေးခြင်းထဲထည့်မည်',
          //cart
          'cartItems': 'ဈေးခြင်းရှိပစ္စည်းများ',
          'clearAll': 'အားလုံးရှင်းပါ',
          'total': 'စုစုပေါင်း',
          'tax': 'အခွန် (@percent %)',
          'taxIncluded': 'အခွန်ပါဝင်ပြီး',
          'taxExclusive': 'အခွန်မပါဝင်သေး',
          'goToCheckout': 'ဝယ်ယူမည်',
          'clearAllTitle': 'ဈေးခြင်းရှိပစ္စည်းများကိုရှင်းမည်',
          'clearAllMessage': 'ပစ္စည်းများအားလုံးကိုရှင်းလင်းမှာသေချာပါသလား',
          'cancel': 'မလုပ်တော့ပါ',
          'clearCart': 'ရှင်းမည်',
          'emptyCart': 'ချင်းထဲတွင်မှာထားသောပစ္စည်းမရှိသေးပါ',
          'startOrder': 'ပစ္စည်းမှာမည်',
          'outOfStock': 'ပစ္စည်းကုန်နေသည်',
          'outOfOpts': '@product တွင် @unit ယူနစ် @count ခုသာကျန်တော့သည်',
          'removeProduct': '@product ကိုဖျက်ဖို့သေချာပါသလား',
          'productVariation': 'ပစ္စည်းပုံစံကွဲရွေးပါ (@currency @price)',
          'confirmCheckout': 'ဝယ်မှာသေချာပါသလား',
          'customer': 'ဝယ်သူ',
          //Print
          'continuePrint': 'ဖြတ်ပိုင်းထုတ်မလား',
          'saveReceipt': 'ဖြတ်ပိုင်းသိမ်းမည်',
          'printReceipt': 'ဖြတ်ပိုင်းထုတ်မည်',
          'print': 'ထုတ်မည်',

          //-checkout
          'new': 'အသစ်',
          'title': 'ခေါင်းစဉ်',
          'checkout': 'ဝယ်ယူမည်',
          'change': 'ပြောင်းပါ',
          'subTotal': 'ကျသင့်ငွေပေါင်း',
          'discount': 'လျှော့ဈေး',
          'discountAmount': 'လျှော့ဈေးပမာဏ',
          'confirm': 'သေချာသည်',
          'info': 'အချက်အလက်',
          'selectCategory': 'အမျိုးအစားရွေးပါ',

          'addPromoCode': 'ဈေးလျှော့ကုဒ်ထည့်ပါ',
          'confirmPayment': 'ငွေပေးချေမှုအတည်ပြုပါ',
          'payment': 'ငွေပေးချေမှု',
          'otherPaymentMethods': 'အခြားပေးချေမှုနည်းလမ်းများ',
          'placeOrderAgree':
              'မှာယူခြင်းဖြင့် ကျွန်ုပ်တို့၏ ဝန်ဆောင်မှုစည်းကမ်းချက်များ နှင့် ကိုယ်ရေးအချက်အလက်ဝါဒကိုသဘောတူသည်ဟုယူဆပါသည်',
          'placeOrder': 'မှာယူမည်',
          'paymentSuccess': 'ပေးချေမှုအောင်မြင်သည်',
          'paymentFail': 'ပေးချေမှုမအောင်မြင်ပါ',
          'backToHome': 'ပင်မစာမျက်နှာသို့',
          'doNotLeavePage': 'ဤစာမျက်နှာမှမထွက်ပါနှင့်',
          'update': 'ပြင်မည်',

          //Manage
          'products': 'ကုန်ပစ္စည်းများ',
          'categories': 'ပစ္စည်းအမျိူးအစားများ',
          'saleInvoice': 'အရောင်းပြေစာ',
          'purchaseInvoice': 'အဝယ်ပြေစာ',
          'inventoryReports': 'ပစ္စည်းမှတ်တမ်း',
          'myStore': 'ကျွန်ုပ်၏ဆိုင်',
          'coupons': 'ကူပွန်များ',
          'accounts': 'အကောင့်များ',
          'removeAll': 'အားလုံးကိုဖျက်မည်',
          'remove': 'ဖျက်မည်',

          //Profile
          'email': 'အီးမေးလ်',
          'name': 'အမည်',
          'password': 'စကားဝှက်',
          'preference': 'အပြင်အဆင်',
          'appearance': 'အသွင်ပြင်',
          'printerSetting': 'Printer အပြင်ဆင်',
          'others': 'အခြား',
          'reportProblem': 'အမှားတင်ပြရန်',
          'aboutUs': 'ကျွန်ုပ်တို့အကြောင်း',

          'emailAddress': 'အီးမေးလ်လိပ်စာ',
          'phoneNumber': 'ဖုန်းနံပါတ်',
          'language': 'ဘာသာစကား',
          'help': 'အကူအညီ',
          'logout': 'အကောင့်ထွက်မည်',
          'login': 'Login ဝင်မည်',
          'register': 'မှတ်ပုံတင်မည်',
          'edit': 'ပြင်မည်',
          'camera': 'ကင်မရာ',
          'gallery': 'ဖုန်းထဲရှိပုံများ',
          'choosePicture': 'ပုံရွေးပါ',
          'successUpload': 'ပုံတင်ပြီးပါပြီ',
          'successUploadDesc': 'သင့်ပုံကိုအောင်မြင်စွာတင်ပြီးပါပြီ',
          'failUpload': 'ပုံတင်၍မရပါ',
          'failUploadDesc':
              'သင့်ပုံကိုတင်ရာတွင်အခက်ခဲရှိနေပါသည်။ ထပ်တင်ကြည့်ပါ။',

          //Email
          'next': 'နောက်တဆင့်',
          'enterEmailAddress': 'အီးမေးလ်လိပ်စာထည့်ပါ',
          'sendCodeToMail': "ရိုက်ထည့်လိုက်သောအီးမေးလ်ကို ကုဒ်ပို့ပါမည်",
          'enterPhone': 'ဖုန်းနံပါတ်ထည့်ပါ',
          'sendCodeToPhone': "ဖုန်းနံပါတ်ဆီသို့ SMS မှတဆင့် Code ပို့ပါမည်",
          'sentOTPLabel':
              'နံပါတ် ၆ လုံးပါသည့် အတည်ပြုကုဒ်ကို @target သို့ပို့ပြီးပါပြီ',
          'manageEmail': 'အီးမေးလ်လိပ်စာ စီမံခြင်း',
          'addEmail': 'အီးမေးလ်ထည့်ပါ',
          //Phone
          'phone': 'ဖုန်း',
          'managePhone': 'ဖုန်းနံပါတ်စီမံခြင်း',
          'addPhone': 'သင့်ဖုန်းနံပါတ်ထည့်ပါ',
          'verifyOTP': 'ကုဒ်ဖြင့်အတည်ပြုပါ',
          'enterOTP': 'အတည်ပြုကုဒ်ထည့်ပါ',
          'changeTarget': '@target ပြောင်းပါ',
          'invalidOTP': 'အတည်ပြုကုဒ်မှားနေသည်',
          'notReceivedOTP': 'ကုဒ်မရသေးဘူးလား',
          'sendAgain': 'ထပ်မံပေးပို့ပါ',
          'verify': 'အတည်ပြုပါ',
          'failedSendOTP': 'ကုဒ်ပေးပို့ခြင်းမအောင်မြင်ပါ',

          //Coupons
          'emptyCoupons': "ကူပွန်များမရှိသေးပါ",
          //Notification
          'notifications': 'အသိပေးချက်များ',
          //Help
          'helpLabel':
              "အသုံးပြုစဉ်ကြုံတွေ့ရသော အခက်အခဲများကိုရေးပေးပါ။ အမြန်ဆုံးဖြေကြားပေးသွားပါမည်။",
          'helpPlaceholder': 'ဤနေရာတွင်ရေးပါ',
          'addScreenshot': 'Screenshot ထည့်ပါ',
          'send': 'ပို့ပါ',
          'successTitle': "ပေးပို့ခြင်းအောင်မြင်သည်",
          'successDesc': 'အမြန်ဆုံးပြန်လည်ဖြေကြားပေးသွားပါမည်',
          'failTitle': "ပေးပို့ခြင်းမအောင်မြင်ပါ",
          'failDesc': 'နောက်ထပ်ပြန်ပေးပို့ပေးပါ',
          //Shop
          'noProductFound': 'ပစ္စည်းမတွေ့ပါ',
          'searchDifferentStore': 'အခြားဆိုင်မှာရှာပါ',

          //Search
          'searchProducts': 'ကုန်ပစ္စည်းများကိုရှာပါ',
          'searchHistories': 'ရှာထားသောမှတ်တမ်းများ',
          'clear': 'ရှင်းပါ',
          'noRecentSearch': 'မကြာသေးခင်ကရှာထားသောမှတ်တမ်းမရှိပါ',
          'shops': 'ဆိုင်များ',
          'suggestedKeywords': 'အကြံပြုထားသော စကားလုံးများ',

          //Auth
          'everythingIsHere': 'လိုအပ်နေတာအားလုံးဒီမှာရနိုင်ပါတယ်',
          'manawZay': 'မနောဈေး',
          'or': 'သို့မဟုတ်',
          'agreePolicy':
              'Login ဝင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ဝန်ဆောင်မှုစည်းကမ်းချက်များ နှင့် ကိုယ်ရေးအချက်အလက်ဝါဒကိုသဘောတူသည်ဟုယူဆပါသည်',
          'continue': 'ဆက်သွားပါ',
          'loginSuccess': 'Login ဝင်ရောက်ခြင်းအောင်မြင်သည်',
          //Review
          'loadMore': 'နောက်ထပ်',
          'aCustomer': 'ဝယ်သူတစ်ယောက်',
          'rateProductQuality': 'ကုန်ပစ္စည်းအရည်အသွေးကိုသတ်မှတ်ပါ',
          'writeYourReview': 'သုံးသပ်ချက်ရေးပါ',
          'reviewPlaceholder':
              "ဤပစ္စည်းနဲ့ပက်သတ်ပြီးရေးလိုသည်များကိုဤနေရာတွင်ရေးပါ",
          'addPhoto': 'ပုံထည့်ပါ',
          'submit': 'တင်မည်',
          'success': 'အောင်မြင်သည်',
          'reviewSuccess': 'သုံးသပ်ချက်တစ်ခုအောင်မြင်စွာတင်ပြီးပြီ',
          'version': 'ဗားရှင်း - @code',
          'failed': 'မအောင်မြင်ပါ',
          'reviewFailed': 'သုံးသပ်ချက်တင်ခြင်း မအောင်မြင်ပါ။ ထပ်တင်ကြည့်ပါ',

          //Change Name
          'changeName': 'အမည်ပြောင်းမည်',
          'newName': 'အမည်အသစ်',
          'namePlaceholder': 'John Doe',
          'nameChangeSuccess': 'အောင်မြင်ပါသည်',
          'nameChangeSuccessMsg': 'အမည်ပြောင်းခြင်းအောင်မြင်ပါသည်',
          'nameChangeFail': 'မအောင်မြင်ပါ',
          'nameChangeFailMsg': 'နောက်တစ်ကြိမ်ပြန်ကြိုးစားကြည့်ပါ။',
        }
      };
}
