import std/[json, strformat]
import puppy
import ./[types, common]

proc complete*(apiKey: string, model: string, extro: JsonNode, asJson = false): ChatCompletion =
  let msg = newJObject()
  msg.add "model", newJString(model)
  if asJson == true:
    msg.add "response_format", %* { "type": "json_object" }
  for key, val in extro:
    msg.add key, val
  let resp = post("https://api.deepseek.com/v1/chat/completions", headers= @{
      "Content-Type": "application/json",
      "Authorization": "Bearer " & apiKey,
    }, $msg)

  if resp.code != 200:
    raise getException(resp)
  
  resp.body.parseJson.to(ChatCompletion)

when isMainModule:
  import std/[envvars]
  let apiKey = getEnv("DEEPSEEK_API_KEY")
  echo complete(apiKey, "deepseek-chat", %*{ "messages": [{ "role": "user", "content": "How can I get the name of the current day in Node.js" }] })