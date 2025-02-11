type
  DeepSeekError* = object of CatchableError
    code*: int
  InvalidAPIKeyError* = object of DeepSeekError
  InsufficientQuotaError* = object of DeepSeekError
  RateLimitExceededError* = object of DeepSeekError
  BadRequestError* = object of DeepSeekError
  AuthenticationError* = object of DeepSeekError
  # PermissionDeniedError* = object of DeepSeekError
  # NotFoundError* = object of DeepSeekError
  # ConflictError* = object of DeepSeekError
  UnprocessableEntityError* = object of DeepSeekError
  InternalServerError* = object of DeepSeekError
  ServerOverloadedError* = object of DeepSeekError
