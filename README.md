# Server Driven UI


It's a combination 
- Dynamic route with go_router
- Lego: Server driven UI with firestore UI config


## Dynamic Route

Check the flow of request [Swimlane diagram](https://swimlanes.io/#bZHNasMwEITveoq9FQzJAxhaKGkoCaWEJCXHIuRxLKKs3F05IX36Kj92WuhFh9WMZj5t8imgpA2Ci3tQiqRHvw+WoWMfjTHPbUujJ1pBDpCSXqdrCvYUu2QMx4TSCL46aBo3sBVE6ZE+FPKgNN+s83s7MNEgSmLdDnIX3QazyphrxJ8wMMQmXMS0auF87d2QfzfkkiXNNTItoW1kxVD8crWwoni72Xxd0qwm7ZyDqiH6rVyCMwUtMklkG/w3qlseGQTNXzXNJ/3vekFtu5D6goMGIlHWV9KSJrZNneA6VZOtxlwA+9dm3HappHd78NszfV5KdWK7z+jqBOC/cI3lKqCX+8j9ZkY0aeB2dMgcVW8d9XrJFT1v6ehTQ0WxjZ/nCaQozA8=)

If you like to have some explanation please check this [medium blog](https://snehmehta.medium.com/dynamic-bottom-navigation-with-go-router-flutter-power-series-part-1-2437e2d72546).

![Dynamic route](https://user-images.githubusercontent.com/36638657/196851928-772a13e8-6f60-4853-a234-0a4573c06410.png)

---
## Lego

- A `LegoView` is composed of `List<LegoRow>`
- A `LegoView` is composed of `List<BaseCardData>` 
  - `BaseCard` is an abstract class.
  - `Card` is composed of `filters`, `actions` which are used for building UI.

This repo contains `cards`:-
- audio
- image
- text
- spacer
- carousel

A `LegoView` is subscribe to firestore doc, it re-render the UI anytime the document gets updated

This cards are extracted from my previous startup product, I would write few generalized cards in upcoming days.

---

## Licence starware 
### Please give a star, if you found it useful.
