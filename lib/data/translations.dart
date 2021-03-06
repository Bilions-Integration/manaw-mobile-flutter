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
          'createNew': 'Create New',
          'product': 'Product',
          'category': 'Category',
          'coupon': 'Coupon',
          //POS
          'all': 'All',
          'variations': 'Variations',
          'addToCart': 'Add To Cart',
          //Dashboard
          'overview': 'Overview',
          'summary': 'Summary',
          'topProducts': 'Top Products',
          'topCustomers': 'Top Customers',
          'grossProfit': 'Gross Profit',
          'saleOverview': 'Sale Overview',
          'totalSale': 'Total Sale',
          'capital': 'Capital',
          'assets': 'Assets',
          'totalLiability': 'Total Liability',
          'taxes': 'Taxes',
          'saleTax': 'Sale Tax',
          'purchaseTax': 'Purchase Tax',
          'whtTax': 'Withholding Tax',
          'noProductSoldYet': 'No product sold yet',
          'noCustomerYet': 'No customer yet',
          //Category
          'addCategoryImg': 'Add Category Image',
          'categoryName': 'Category Name',
          'categoryNamePlaceholder': 'Enter category name',
          'successUpdate': 'Successfully updated',
          'successDelete': 'Successfully deleted',
          //Store
          'storeName': 'Store Name',
          'currency': 'Currency',
          'taxId': 'Tax ID',
          'defaultTax': 'Default Tax (%)',
          'defaultWht': 'Default WHT (%)',
          'purchaseInvoicePrefix': 'Purchase Invoice Prefix',
          'saleInvoicePrefix': 'Sale Invoice Prefix',
          'address': 'Address',
          'delete': 'Delete',
          'confirmDelete': 'Are you sure, you want to delete?',
          'yes': 'Yes',
          //account
          'account': 'Account',
          'emptyAccount': 'No accounts yet',
          'createAccount': 'Create account',
          'editAccount': 'Edit account',
          'ownerName': 'Owner Name',
          'accNumber': 'Account Number',
          'bankName': 'Bank Name',
          'initialBalance': 'Initial Balance',
          //Coupons
          'createCoupon': 'Create Coupon',
          'editCoupon': 'Edit Coupon',
          'successCreate': 'Successfully Created',
          'couponName': 'Coupon Name',
          'couponCodePlaceholder': 'eg. NEWYEAR50OFF',
          'couponCode': 'Coupon Code',
          'percentage': 'Percentage',
          'usableTimePlaceholder': 'Usable Times',
          'usableTime': '( leave empty for unlimited )',
          'save': 'Save',
          'specificCustomers': 'Specific Customers',
          'customerEmail': 'Customer Email',
          'addAnotherCustomer': 'Add Another Customer',
          'leaveBlankForAll': '(Leave blank if it can be used by everyone)',
          'fixed': 'Fixed',
          //Report
          'createdAt': 'Created at',
          'invoice': 'Invoice',
          'invoiceNumber': 'Invoice Number',
          'invoiceDate': 'Invoice Date',
          'totalPrice': 'Total Price',
          'quantity': 'Quantity',
          'unitPrice': 'Unit Price',
          //Invoice
          'emptyInvoice': 'Empty Invoice',
          'createInvoice': 'Create Invoice',
          'customerSupplier': 'Customer/Supplier',
          'downloadReceipt': 'Download Receipt',
          'saleInvoice': 'Sale Invoice',
          'purchaseInvoice': 'Purchase Invoice',
          'shippingAddress': 'Shipping Address',
          'customerNote': 'Customer Note',
          //cart
          'cartItems': 'Cart Items',
          'clearAll': 'Clear All',
          'total': 'Total',
          'tax': 'Tax',
          'taxPercent': 'Tax (@percent %)',
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
          'productVariation': 'Choose Variation',
          'confirmCheckout': 'Are you sure to continue checkout?',
          'customer': 'Customer',
          'cartNote': 'Note for cart',
          'noteToCart': 'Write some note to cart',
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
          'saleInvoices': 'Sale Invoices',
          'purchaseInvoices': 'Purchase Invoices',
          'inventoryReports': 'Inventory Reports',
          'myStore': 'My Store',
          'coupons': 'Coupons',
          'accounts': 'Accounts',
          'referral': 'Referral',
          'referralCode': 'Referral Code',
          'referralCodePlaceholder': 'Referral Code (Optional)',

          // - //Products
          'manageProducts': 'Manage Products',
          'productName': 'Product Name',
          'stock': 'Stock',
          'sell': 'Sell',
          'addStock': 'Add Stock',
          'areYouSure': 'Are you sure?',
          'deleteProductConfirm': "Are you sure to delete this product?",
          'deleteProduct': 'Delete Product',
          'createProduct': 'Create Product',
          'editProduct': 'Update Product',
          'addProductImage': 'Add Product Image',
          'allowNegativeStock': 'Allow Negative Stock',
          'productNamePlaceholder': 'Enter product name',
          'salePrice': 'Sale Price',
          'purchasePrice': 'Purchase Price',
          'barcode': 'Barcode',
          'productUnit': 'Product unit',
          'addVariation': 'Add new variation',
          'active': 'Active',
          'inactive': 'Inactive',
          'addVarImage': 'Add variant image',
          'isActive': 'Active?',
          'create': 'Create',
          'varPlaceholder': 'Red color',
          'editVariation': 'Edit Variation',
          'createVariation': 'Create Variation',
          'clone': 'Clone',

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
          'themeColor': 'Pick Theme Color',
          'pickColor': 'Pick Color',
          'emptyPrinter': 'There\'re no printer connected',
          'printerSetConfirm':
              'Are you sure you want to set @printer as default printer?',
          'printerSetSuccess': 'Successfully set to @printer',
          'appDescription':
              'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
          //Name
          'changeName': 'Change Name',
          'enterFullName': 'Enter Full Name',
          //Email
          'next': 'Next',
          'changeEmail': 'Change Email',
          'requestOtp': 'Request OTP',
          'enterEmailAddress': 'Enter email address',
          'sendCodeToMail': "We will send a code to the email you entered.",
          'sendCodeToPhone':
              "We will send a code (via SMS text message to your phone number.",
          'sentOTPLabel':
              'You will get a 6 digit verification code we\'ve sent to @target',
          //Phone
          'phone': 'Phone',
          'verifyOTP': 'Verify OTP',
          'enterOTP': 'Enter the OTP code',
          'invalidOTP': 'Invalid OTP',
          'notReceivedOTP': 'Didn’t received code?',
          'sendAgain': 'Send Again',
          'verify': 'Verify',
          'failedSendOTP': 'Failed to send OTP',
          //Password
          'newPassword': 'New Password',
          'confirmPassword': 'Confirm Password',
          'changePassword': 'Change Password',
          'successPassword': 'Successfully updated password',
          'failPassword': 'Failed to update password. Please try again',

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
          'or': 'OR',
          'agreePolicy':
              'By signing in, you agree to our Terms of Service and Privacy Policy.',
          'continue': 'Continue',
          'loginSuccess': 'Login Success',
          'loginLabel': 'Enter your email to login',
          'doLogin': 'LOGIN',
          'notAMember': 'Not a member yet? Register here',
          'alreadyMember': 'Already member? Login here',
          'forgetPassword': 'Forget password?',
          'fullName': 'Full name',
          'companyName': 'Store / Company Name',
          'error': 'Error',
          'emailRegistered': 'Email already registered!',
          'somethingWrong': 'Something went wrong. Please try again.',
          'invalidCreds': 'Invalid email or password!',

          'addPhoto': 'Add Photo',
          'submit': 'Submit',
          'success': 'Success',
          'version': 'Version @code',
          'failed': 'Failed',

          //pricing plan
          'planHeadline': 'Best plans for your business',
          'planDesc':
              'Upgrade your account and get full access for your business',
          'monthly': 'Monthly',
          'yearly': 'Yearly',
          'upgradeNow': 'Upgrade Now',
          'planDetails': 'Plan Details',
          'popular': 'Popular',
          'saveFor2months': 'Save for 2 months',
          'chooseMethod': 'Choose Payment Method',
          'paymentMethods': 'Payment Methods',
          'paymentError': 'Something went wrong!',
          'paymentSuccessDesc':
              'Your payment was successful! You can now continue using MaNaw Store.',
          'paymentFailDesc':
              'We aren’t able to process your payment. Please try again.',
          'copied': 'Copied',
          'invoiceNumberCopied': 'Invoice number copied',
          'done': 'Done',
          'tryAgain': 'Try Again',
          'goBack': 'Go Back',
          'expiredIn': 'Expired in @date',
          'recharge': 'Recharge',
          'deleteAccount': 'Delete Account',
          'waringDeleteAccount':
              "Enter 'Yes' To delete your account. This action will delete your account completely from our system. You will not be able to recover your account again.",
          'enterYesToDelete': "Please enter 'Yes' to delete your account!"
        },
        'my_MM': {
          //Navigation
          'profile': 'ပရိုဖိုင်',
          'pos': 'အရောင်း',
          'dashboard': 'စာရင်းဇယား',
          'manage': 'စီမံ',
          'createNew': 'အသစ်ဖန်တီးမည်',
          'product': 'ကုန်ပစ္စည်း',
          'category': 'အမျိုးအစား',
          'coupon': 'ကူပွန်',
          //POS
          'all': 'အားလုံး',
          'variations': 'ပုံစံကွဲများ',
          'addToCart': 'ဈေးခြင်းထဲထည့်မည်',
          //Dashboard
          'overview': 'ခြုံငုံပြဇယား',
          'summary': 'အနှစ်ချုပ်',
          'topProducts': 'ထိပ်တန်းပစ္စည်းများ',
          'topCustomers': 'ထိပ်တန်းဖောက်သည်များ',
          'grossProfit': 'စုစုပေါင်းအမြတ်ငွေ',
          'saleOverview': 'အရောင်းငွေခြုံငုံခြင်း',
          'totalSale': 'စုစုပေါင်းရောင်းရငွေ',
          'capital': 'အရင်းအနှီး',
          'assets': 'ပိုင်ဆိုင်မှု',
          'totalLiability': 'အကြွေး စုစုပေါင်း',
          'taxes': 'အခွန်များ',
          'saleTax': 'အရောင်းခွန်',
          'purchaseTax': 'အဝယ်ခွန်',
          'whtTax': 'နုတ်ခွန် (%)',
          'noProductSoldYet': 'ပစ္စည်းတစ်ခုမှမရောင်းရသေးပါ',
          'noCustomerYet': 'ဖောက်သည်မရှိသေးပါ',
          //Category
          'addCategoryImg': 'အမျိုးအစားပုံထည့်ပါ',
          'categoryName': 'ပစ္စည်းအမျိုးအစားအမည်',
          'categoryNamePlaceholder': 'ဥပမာ - အထည်/ဖုန်း',
          'successUpdate': 'အောင်မြင်စွာပြောင်းပြီးပါပြီ',
          'successDelete': 'အောင်မြင်စွာဖျက်ပြီးပါပြီ',
          //Store
          'storeName': 'ဆိုင်အမည်',
          'currency': 'ငွေကြေးယူနစ်',
          'taxId': 'အခွန်နံပါတ်',
          'defaultTax': 'ပုံမှန်အခွန် (%)',
          'defaultWht': 'ပုံမှန် နှုတ်ခွန် (%)',
          'purchaseInvoicePrefix': 'အဝယ်ပြေစာရှေ့စာလုံး',
          'saleInvoicePrefix': 'အရောင်းပြေစာရှေ့စာလုံး',
          'address': 'လိပ်စာ',
          'delete': 'ဖျက်မည်',
          'confirmDelete': 'ဖျက်ဖို့သေချာပါသလား',
          'yes': 'ဟုတ်ပါသည်',
          //account
          'account': 'အကောင့်',
          'emptyAccount': 'အကောင့်မရှိသေးပါ',
          'createAccount': 'အကောင့်ဖန်တီးပါ',
          'editAccount': 'အကောင့်ပြင်ပါ',
          'ownerName': 'ပိုင်ရှင်အမည်',
          'accNumber': 'အကောင့်နံပါတ်',
          'bankName': 'ဘဏ်အမည်',
          'initialBalance': 'မူလရှိငွေ',
          //Coupons
          'emptyCoupons': 'ကူပွန်မရှိသေးပါ',
          'createCoupon': 'ကူပွန်ဖန်တီးပါ',
          'editCoupon': 'ကူပွန်ပြင်ပါ',
          'successCreate': 'အောင်မြင်စွာဖန်တီးပြီးပြီ',
          'couponName': 'ကူပွန်အမည်',
          'couponCodePlaceholder': 'ဥပမာ- NEWYEAR50OFF',
          'couponCode': 'ကူပွန်ကုဒ်',
          'percentage': 'ရာခိုင်နှုန်း',
          'usableTimePlaceholder': 'အကျုံးဝင်သောအကြိမ်',
          'usableTime': '(အမြဲတမ်းအသုံးပြုနိုင်စေလိုလျှင် အလွတ်ထားပါ)',
          'save': 'သိမ်းပါ',
          'specificCustomers': 'အသုံးပြုနိုင်သောဝယ်ယူသူများ',
          'customerEmail': 'ဝယ်သူ အီးမေးလ်',
          'addAnotherCustomer': 'နောက်ထပ်ဝယ်သူတစ်ယောက်ထည့်ပါ',
          'leaveBlankForAll': '(လူတိုင်းအသုံးပြုနိုင်ပါက ဖြည့်ရန်မလိုပါ)',
          'fixed': 'ပုံသေ',
          //Report
          'createdAt': 'ပြုလုပ်ခဲ့သောအချိန်',
          'invoice': 'ပြေစာ',
          'invoiceNumber': 'ပြေစာနံပါတ်',
          'invoiceDate': 'ပြေစာရက်စွဲ',
          'totalPrice': 'ကျသင့်ငွေစုစုပေါင်း',
          'quantity': 'ပမာဏ',
          'unitPrice': 'ဈေးနှုန်း',
          //Invoice
          'emptyInvoice': 'ပြေစာမရှိသေးပါ',
          'createInvoice': 'ပြေစာဖန်တီးပါ',
          'customerSupplier': 'ဝယ်သူ/ရောင်းသူ',
          'downloadReceipt': 'ဘောက်ချာသိမ်းပါ',
          'saleInvoice': 'အရောင်းပြေစာ',
          'purchaseInvoice': 'အဝယ်ပြေစာ',
          'shippingAddress': 'ပို့ဆောင်ရန်လိပ်စာ',
          'customerNote': 'ဝယ်သူမှတ်စု',
          //cart
          'cartItems': 'ဈေးခြင်းရှိပစ္စည်းများ',
          'clearAll': 'အားလုံးရှင်းပါ',
          'total': 'စုစုပေါင်း',
          'tax': 'အခွန်',
          'taxPercent': 'အခွန် (@percent %)',
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
          'productVariation': 'ပစ္စည်းပုံစံကွဲရွေးပါ',
          'confirmCheckout': 'ဝယ်မှာသေချာပါသလား',
          'customer': 'ဝယ်သူ',
          'cartNote': 'ဈေခြင်းမှတ်စု',
          'noteToCart': 'မှတ်စုတစ်ခုခုရေးပါ',
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
          'saleInvoices': 'အရောင်းပြေစာများ',
          'purchaseInvoices': 'အဝယ်ပြေစာများ',
          'inventoryReports': 'ပစ္စည်းမှတ်တမ်း',
          'myStore': 'ကျွန်ုပ်၏ဆိုင်',
          'coupons': 'ကူပွန်များ',
          'accounts': 'အကောင့်များ',
          'removeAll': 'အားလုံးကိုဖျက်မည်',
          'remove': 'ဖျက်မည်',
          'referral': 'ရည်ညွှန်းပေးထားသည်များ',
          'referralCode': 'ရည်ညွှန်းကုဒ်',
          'referralCodePlaceholder': 'ရည်ညွှန်းကုဒ် (အလွတ်ထား၍ရသည်)',

          // - //Products
          'manageProducts': 'ပစ္စည်းများစီမံ',
          'productName': 'ပစ္စည်းအမည်',
          'stock': 'လက်ကျန်',
          'sell': 'ရောင်းမည်',
          'addStock': 'ပစ္စည်းထပ်ထည့်ရန်',
          'areYouSure': 'သေချာပါသလား',
          'deleteProductConfirm': "ဤပစ္စည်းကိုဖျက်ပစ်ဖို့သေချာပါသလား",
          'deleteProduct': 'ပစ္စည်းကိုဖျက်မည်',
          'createProduct': 'ပစ္စည်းအသစ်',
          'editProduct': 'ပစ္စည်းကိုပြင်မည်',
          'addProductImage': 'ကုန်ပစ္စည်းပုံများ',
          'allowNegativeStock': 'လက်ကျန်အနှုတ်လက်ခံပါ',
          'productNamePlaceholder': 'ကုန်ပစ္စည်းအမည်ထည့်ပါ',
          'salePrice': 'ရောင်းဈေး',
          'purchasePrice': 'ဝယ်ဈေး',
          'barcode': 'Barcode',
          'productUnit': 'ပစ္စည်းမျိုးကွဲများ',
          'addVariation': 'ပစ္စည်းပုံစံကွဲထည့်ပါ',
          'active': 'ဖွင့်ထားသည်,',
          'inactive': 'ပိတ်ထားသည်',
          'addVarImage': 'ပုံစံကွဲ၏ ဓာတ်ပုံထည့်ပါ',
          'isActive': 'ဖွင့်ထားမည်',
          'create': 'ဖန်တီးမည်',
          'varPlaceholder': 'အနီရောင်',
          'editVariation': 'ပုံစံကွဲကိုပြင်ပါ',
          'createVariation': 'ပုံစံကွဲဖန်တီးပါ',
          'clone': 'ပုံစံတူ ပွားမည်',

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
          'themeColor': 'အရောင်ရွေးပါ',
          'pickColor': 'ရွေးမည်',
          'emptyPrinter': 'ချိတ်ဆက်ထားသော Printer များမရှိသေးပါ',
          'printerSetConfirm':
              '@printer ကို ပုံမှန်သုံး printer အဖြစ်အသုံးပြုချင်ပါသလား',
          'printerSetSuccess': '@printer ကို ပုံမှန်သုံးအဖြစ်ထားရှိပြီးပြီ',
          'appDescription':
              'တွက်ချက်ခြင်း၊ ဘောက်ချာထုတ်ခြင်း၊ ပစ္စည်းစီမံခြင်း တို့ကို တစ်နေရာထဲတွင် အချိန်ကုန်၊ ငွေကုန်သက်သာစွာ အသုံးပြုနိုင်သော ဆော့ဝဲလ်',

          //Name
          'changeName': 'အမည်ပြောင်းမည်',
          'enterFullName': 'အမည်အပြည့်စုံထည့်ပါ',
          //Email
          'changeEmail': 'အီးမေးလ်ပြောင်းပါ',
          'requestOtp': 'တစ်ခါသုံးကုဒ်ရယူမည်',
          'next': 'နောက်တဆင့်',
          'enterEmailAddress': 'အီးမေးလ်လိပ်စာထည့်ပါ',
          'sendCodeToMail': "ရိုက်ထည့်လိုက်သောအီးမေးလ်ကို ကုဒ်ပို့ပါမည်",
          'enterPhone': 'ဖုန်းနံပါတ်ထည့်ပါ',
          'sendCodeToPhone': "ဖုန်းနံပါတ်ဆီသို့ SMS မှတဆင့် Code ပို့ပါမည်",
          'sentOTPLabel':
              'နံပါတ် ၆ လုံးပါသည့် အတည်ပြုကုဒ်ကို @target သို့ပို့ပြီးပါပြီ',
          //Password
          'newPassword': 'စကားဝှက်အသစ်',
          'confirmPassword': 'စကားဝှက်အသစ်ကိုပြန်ထည့်ပါ',
          'changePassword': 'စကားဝှက်ပြောင်းမည်',
          'successPassword': 'စကားဝှက်ပြောင်းခြင်းအောင်မြင်သည်',
          'failPassword':
              'စကားဝှက်ပြောင်းခြင်းမအောင်မြင်ပါ၊ ထပ်ကြိုးစားကြည့်ပါ',

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
          'or': 'သို့မဟုတ်',
          'agreePolicy':
              'Login ဝင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ဝန်ဆောင်မှုစည်းကမ်းချက်များ နှင့် ကိုယ်ရေးအချက်အလက်ဝါဒကိုသဘောတူသည်ဟုယူဆပါသည်',
          'continue': 'ဆက်သွားပါ',
          'loginSuccess': 'Login ဝင်ရောက်ခြင်းအောင်မြင်သည်',

          'loginLabel': 'Login ဝင်ရန် အီးမေးလ် နှင့် စကားဝှက်ကိုအသုံးပြုပါ',
          'doLogin': 'LOGIN ဝင်မည်',
          'notAMember': 'အသုံးပြုသူအသစ်ဆိုလျှင် မှတ်ပုံအရင်တင်ပါ',
          'alreadyMember': 'အသုံးပြုနေသူဆိုလျှင် Login ဝင်ပါ',
          'forgetPassword': 'စကားဝှက်မေ့သွားပြီလား?',
          'fullName': 'အမည်အပြည့်စုံ',
          'companyName': 'ဆိုင်/ကုမ္ပဏီ အမည်',
          'error': 'မအောင်မြင်ပါ',
          'emailRegistered': 'အီးမေးလ် သည်မှတ်ပုံတင်ထားပြီးသားဖြစ်နေသည်',
          'somethingWrong': 'တစ်ခုခုအဆင်မပြေဖြစ်သွားသည်။ ပြန်ကြိုးစားကြည့်ပါ',
          'invalidCreds': 'အီးမေးလ်းသို့မဟုတ် စကားဝှက်မှားနေသည်',

          'addPhoto': 'ပုံထည့်ပါ',
          'submit': 'တင်မည်',
          'success': 'အောင်မြင်သည်',
          'version': 'ဗားရှင်း - @code',
          'failed': 'မအောင်မြင်ပါ',

          //pricing plan
          'planHeadline': 'သင့်လုပ်ငန်းအတွက် အကောင်းဆုံးအစီစဉ်များ',
          'planDesc':
              'အသင့်လုပ်ငန်းအတွက်အပြည့်အဝအသုံးပြုနိုင်ရန် အဆင့်မြှင့်တင်ပါ',
          'monthly': 'လစဉ်',
          'yearly': 'နှစ်စဉ်',
          'upgradeNow': 'အဆင့်မြှင့်မည်',
          'planDetails': 'အစီအစဉ်အကြောင်း',
          'popular': 'လူကြိုက်များသော',
          'saveFor2months': '၂ လစာချွေတာနိုင်သည်',
          'chooseMethod': 'ငွေပေးချေနည်းလမ်းရွေးပါ',
          'paymentMethods': 'ငွေပေးချေနည်းလမ်းများ',
          'paymentError': ' တစ်စုံတစ်ခုများနေသည်',
          'paymentSuccessDesc':
              'ငွေပေးချေခြင်းအောင်မြင်ပါသည်။ ဆက်လက်အသုံးပြုနိုင်ပါပြီ',
          'paymentFailDesc': 'ငွေပေးချေခြင်းမအောင်မြင်ပါ။ ပြန်ကြိုးစားကြည့်ပါ။',
          'copied': 'ကူးပြီးပြီ',
          'invoiceNumberCopied': 'ပြေစာနံပါတ်ကို ကူးယူပြီးပြီ',
          'done': 'အဆင်ပြေပါသည်',
          'tryAgain': 'ပြန်ကြိုးစားမည်',
          'goBack': 'နောက်သို့ပြန်သွားမည်',
          'expiredIn': '@date တွင်သက်တမ်းကုန်မည်',
          'recharge': 'သက်တမ်းတိုးမည်',
          'deleteAccount': 'အကောင့်ဖျက်မည်။',
          'enterYesToDelete': "သင့်အကောင့်ကိုဖျက်ရန် 'Yes' ဟုရိုက်ထည့်ပါ",
          'waringDeleteAccount':
              "သင့်အကောင့်ကိုဖျက်ရန် 'Yes' ဟုရိုက်ထည့်ပါ။ ဤလုပ်ဆောင်ချက်သည် ကျွန်ုပ်တို့၏စနစ်မှ သင့်အကောင့်ကို လုံးလုံးလျားလျား ဖျက်လိုက်ပါမည်။ သင့်အကောင့်ကို နောက်တစ်ကြိမ် ပြန်လည်ရယူနိုင်တော့မည်မဟုတ်ပါ။",
        }
      };
}
