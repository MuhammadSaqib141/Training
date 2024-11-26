
locals {
  flatteded_subscriptions = flatten([
    for topickey, topicvalue in var.servicebus_topics : [
      for sub in topicvalue.subcriptions : {
        topic_key   = topickey
        subscription = sub
      }
    ]
  ])

  subscriptions_map = {
    for value in local.flatteded_subscriptions :
    "${value.topic_key}-${value.subscription.name}" => {
      topic_key   = value.topic_key
      subscription = value.subscription
    }
  }
}


output "flatteded_subscriptions" {
    value = local.flatteded_subscriptions
}


output "subscriptions_map" {
    value = local.subscriptions_map
}