// enums acting like state

// page tab enum
enum TabEnum { home, savings, credit, vas, account }

enum ObscureTextEnum { confirmPassword, password }

enum ActivityEnum { all, savings, credit, vas, account }

enum RtsStatus { ongoing, pending, completed }

enum TargetStatus { ongoing, completed, paused }

//vas tab enums
enum AirtimeTopUpEnum {
  onetime,
  auto,
}

enum DataTopUpEnum {
  onetime,
  auto,
}

enum ElectricityTopUpEnum {
  onetime,
  auto,
}

enum CableTopUpEnum {
  onetime,
  auto,
}

enum TargetUserType { owner, partner, sponsor }

// title subtitle enum
enum BothPosition { left, right, center }

// image type
enum ImageTypeEnum { png, svg }

//card type
enum CardTypeEnum {
  masterCard,
  visa,
  verve,
  americanExpress,
  discover,
  others,
  invalid
}

// rtsMenuoptions enum
enum RtsMenuOptionEnum {
  contributionHistory,
  requestSwap,
  disallowPayment,
  rtsExit
}

// targetMenuoptions enum
enum TargetSavingsMenuOptionEnum {
  editPlan,
  transactionHistory,
  pauseSavings,
  resumeSavings,
  terminateSavings,
  leavePlan
}

//notification type
enum NotificationType {
  newMember,
  swapRequest,
  disallowPayment,
  planParameter,
}

//credit eligibility enum
enum CreditEligibleEnum {
  isEligible,
  isNotEligible,
  lowCreditScore,
  lowAccount,
}

// transaction status

enum TransactionStatusEnum { complete, failed, mixed }

// customer care bottom sheet
enum CustomerCareBottomSheetEnum { natureOfIssue, channels }

//account enums
enum NotificationSettingsEnum { email, push, rts }
