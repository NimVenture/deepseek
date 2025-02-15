
import std/[options]

type DeepSeekErrorData* = object
  message*: string
  `type`: string
  code*: string
  # param: Option[]

type Message* = object
  role*:string
  content*: string

type Choice* = object
  index*: int
  message*: Message
  logprobs*: Option[int]
  finish_reason*: string

type Usage* = object
  prompt_tokens*: int
  completion_tokens*: int
  total_tokens*: int

type ChatCompletion* = object
  id*: string
  `object`*: string
  created*: int
  model*: string
  # system_fingerprint*: string
  choices*: seq[Choice]
  usage*: Usage
