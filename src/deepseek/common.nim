import std/[httpcore,json]
import puppy
import ./[types, exceptions]

proc getException*(resp: Response): ref exceptions.DeepSeekError =
  case resp.code
  of 400:
    result = newException(BadRequestError, $Http400)
  of 0:
    result = newException(InvalidAPIKeyError, "")
  of 401:
    let data = parseJson(resp.body)
    let err = data{"error"}.to(DeepSeekErrorData)
    case err.code
      of "invalid_api_key":
        result = newException(InvalidAPIKeyError, err.message)
      else:
        result = newException(AuthenticationError, $Http401)
  of 402:
    result = newException(InsufficientQuotaError, $Http402)
  # of 403:
  #   result = newException(PermissionDeniedError, $Http403)
  # of 404:
  #   result = newException(NotFoundError, $Http404)
  # of 409:
  #   result = newException(ConflictError, $Http409)
  of 422:
    result = newException(UnprocessableEntityError, $Http422)
  of 429:
    let data = parseJson(resp.body)
    let err = data{"error"}.to(DeepSeekErrorData)
    result = newException(RateLimitExceededError, err.message)
  of 500:
    result = newException(InternalServerError, $Http500)
  of 503:
    result = newException(ServerOverloadedError, $Http503)
  else:
    result = newException(DeepSeekError, "DeepSeek request error, code: " & $resp.code)
  result.code = resp.code
