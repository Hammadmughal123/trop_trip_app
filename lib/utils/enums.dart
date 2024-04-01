// enums.dart

// Authentication result status
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  userNotFound,
  userDisabled,
  tooManyRequests,
  undefined,
}

// Travel booking status
enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

// User roles
enum UserRole {
  traveler,
  guide,
  admin,
}

// Add more enums as needed
