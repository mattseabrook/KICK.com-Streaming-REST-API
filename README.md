Cross-platform utility for KICK

**Table-of-Contents**

- [Usage](#usage)
  - [TTS (Text-to-Speech)](#tts-text-to-speech)
- [Developer Notes](#developer-notes)
  - [Chat](#chat)
- [API](#api)
  - [User](#user)
  - [Channels](#channels)
    - [Followed](#followed)
  - [Current Viewers](#current-viewers)
  - [Categories](#categories)
    - [Top](#top)
    - [stream/livestreams/en](#streamlivestreamsen)
  - [Chat Messages](#chat-messages)
    - [Send](#send)

# Usage

## TTS (Text-to-Speech)

Open the Windows Command Prompt and supply the username and browser to use: `KICKstand.cmd <username> <browser>`

```cmd
KICKstand.cmd mattseabrook brave
```

# Developer Notes

Working theory for the prototype is to run a browser in headless mode in the background:

```cmd
@echo off
setlocal
set TITLE=myapp
start /B "chrome" /D "C:\Program Files (x86)\Google\Chrome\Application" chrome.exe --headless --disable-gpu --remote-debugging-port=9222 --user-data-dir=C:\temp --title=%TITLE%
tasklist /fi "WindowTitle eq %TITLE%*" | findstr chrome.exe > temp.txt
for /f "tokens=2" %%a in (temp.txt) do set pid=%%a
del temp.txt
echo Process ID is %pid%
```

## Chat

Using the Pusher js library.

Sample WebSocket message:

```json
{
  "event": "App\\Events\\ChatMessageSentEvent",
  "data": {
    "message": {
      "id": "48b77917-9cc6-4fd3-9a9c-e62dd89a95e2",
      "message": "I SAW THAT :) :) :)\u00a0",
      "type": "",
      "replied_to": null,
      "is_info": null,
      "link_preview": null,
      "chatroom_id": "259821",
      "role": null,
      "created_at": 1677379978,
      "action": null,
      "optional_message": null,
      "months_subscribed": 0,
      "subscriptions_count": null,
      "giftedUsers": null
    },
    "user": {
      "id": 242977,
      "username": "Luwu",
      "role": null,
      "isSuperAdmin": false,
      "verified": false,
      "follower_badges": [
        "OG",
        "VIP"
      ],
      "is_subscribed": false,
      "months_subscribed": 0,
      "quantity_gifted": 0
    }
  },
  "channel": "chatrooms.259821"
}
```

# API

## User

**URL**: `/api/v1/user`

**Method**: `GET`

| Property                              | Type           | Description                                                                                                    |
| ------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------- |
| id                                    | number         | The unique identifier of the user.                                                                             |
| username                              | string         | The username of the user.                                                                                      |
| risk_level_id                         | null or number | The risk level of the user. If the value is null, it means that the user does not have a specified risk level. |
| bio                                   | string         | The user's bio, which can contain information about their interests, activities, or other relevant details.    |
| year_started_trading                  | null or number | The year the user started trading. If the value is null, it means that the user has not specified a year.      |
| country                               | string         | The country where the user is located.                                                                         |
| state                                 | string         | The state where the user is located.                                                                           |
| city                                  | string         | The city where the user is located.                                                                            |
| enable_live_notifications             | boolean        | Indicates whether the user has enabled live notifications for their channel.                                   |
| instagram                             | string         | The user's Instagram username.                                                                                 |
| twitter                               | string         | The user's Twitter username.                                                                                   |
| youtube                               | string         | The user's YouTube username.                                                                                   |
| discord                               | string         | The user's Discord username.                                                                                   |
| tiktok                                | string         | The user's TikTok username.                                                                                    |
| facebook                              | string         | The user's Facebook username.                                                                                  |
| enable_onscreen_live_notifications    | boolean        | Indicates whether the user has enabled on-screen live notifications for their channel.                         |
| profilepic                            | string         | The URL of the user's profile picture.                                                                         |
| is_2fa_setup                          | boolean        | Indicates whether the user has set up two-factor authentication.                                               |
| redirect                              | null           | Not used.                                                                                                      |
| channel_can_be_updated                | boolean        | Indicates whether the user's channel can be updated.                                                           |
| is_live                               | boolean        | Indicates whether the user is currently live streaming.                                                        |
| roles                                 | array          | An array of the user's roles.                                                                                  |
| streamer_channel.id                   | number         | The unique identifier of the user's streamer channel.                                                          |
| streamer_channel.user_id              | number         | The unique identifier of the user associated with the streamer channel.                                        |
| streamer_channel.slug                 | string         | The URL slug for the user's streamer channel.                                                                  |
| streamer_channel.playback_url         | string         | The playback URL for the user's streamer channel.                                                              |
| streamer_channel.name_updated_at      | null           | Not used.                                                                                                      |
| streamer_channel.vod_enabled          | boolean        | Indicates whether video on demand is enabled for the user's streamer channel.                                  |
| streamer_channel.subscription_enabled | boolean        | Indicates whether subscriptions are enabled for the user's streamer channel.                                   |

**Sample Response:**

```json
{
    "id": 262331,
    "username": "mattseabrook",
    "risk_level_id": null,
    "bio": "Matt & Megan Seabrook's Variety Stream - Retro Video Games, Art, and Software Development",
    "year_started_trading": null,
    "country": "",
    "state": "",
    "city": "",
    "enable_live_notifications": true,
    "instagram": "matthewseabrook",
    "twitter": "",
    "youtube": "",
    "discord": "",
    "tiktok": "mattseabrook",
    "facebook": "",
    "enable_onscreen_live_notifications": true,
    "profilepic": "https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/user\/262331\/profile_image\/conversion\/be1cdc95-f519-4a84-869c-08aaa6250501-medium.webp",
    "is_2fa_setup": false,
    "redirect": null,
    "channel_can_be_updated": true,
    "is_live": true,
    "roles": [],
    "streamer_channel": {
        "id": 259825,
        "user_id": 262331,
        "slug": "mattseabrook",
        "playback_url": "https:\/\/fa723fc1b171.us-west-2.playback.live-video.net\/api\/video\/v1\/us-west-2.196233775518.channel.ijAXYlFNAvzV.m3u8",
        "name_updated_at": null,
        "vod_enabled": true,
        "subscription_enabled": false
    }
}
```

## Channels 

### Followed

Returns an array of channel data, each with the following properties:

**URL**: `/api/v1/channels/followed`

**Method**: `GET`

| Property                                 | Type           | Description                                                                                                                                                                       |
| ---------------------------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id                                       | number         | The unique identifier of the channel.                                                                                                                                             |
| user_id                                  | number         | The unique identifier of the user associated with the channel.                                                                                                                    |
| slug                                     | string         | The URL slug for the channel.                                                                                                                                                     |
| playback_url                             | string         | The playback URL for the channel.                                                                                                                                                 |
| name_updated_at                          | null           | Not used.                                                                                                                                                                         |
| vod_enabled                              | boolean        | Indicates whether video on demand is enabled for the channel.                                                                                                                     |
| subscription_enabled                     | boolean        | Indicates whether subscriptions are enabled for the channel.                                                                                                                      |
| user.id                                  | number         | The unique identifier of the user associated with the channel.                                                                                                                    |
| user.username                            | string         | The username of the user associated with the channel.                                                                                                                             |
| user.risk_level_id                       | null or number | The risk level of the user associated with the channel. If the value is null, it means that the user does not have a specified risk level.                                        |
| user.bio                                 | null or string | The user's bio, which can contain information about their interests, activities, or other relevant details. If the value is null, it means that the user has not specified a bio. |
| user.year_started_trading                | null or number | The year the user started trading. If the value is null, it means that the user has not specified a year.                                                                         |
| user.country                             | null or string | The country where the user is located. If the value is null, it means that the user has not specified a country.                                                                  |
| user.state                               | null or string | The state where the user is located. If the value is null, it means that the user has not specified a state.                                                                      |
| user.city                                | null or string | The city where the user is located. If the value is null, it means that the user has not specified a city.                                                                        |
| user.instagram                           | null or string | The user's Instagram username. If the value is null, it means that the user has not specified an Instagram username.                                                              |
| user.twitter                             | null or string | The user's Twitter username. If the value is null, it means that the user has not specified a Twitter username.                                                                   |
| user.youtube                             | null or string | The user's YouTube username. If the value is null, it means that the user has not specified a YouTube username.                                                                   |
| user.discord                             | null or string | The user's Discord username. If the value is null, it means that the user has not specified a Discord username.                                                                   |
| user.tiktok                              | null or string | The user's TikTok username. If the value is null, it means that the user has not specified a TikTok username.                                                                     |
| user.facebook                            | null or string | The user's Facebook username. If the value is null, it means that the user has not specified a Facebook username.                                                                 |
| user.profilepic                          | string         | The URL of the user's profile picture.                                                                                                                                            |
| recent_livestream.id                     | number         | The unique identifier of the most recent livestream for the channel.                                                                                                              |
| recent_livestream.slug                   | string         | The title of the most recent livestream.                                                                                                                                          |
| recent_livestream.channel_id             | number         | The unique identifier of the channel associated with the most recent livestream.                                                                                                  |
| recent_livestream.channel_id             | number         | The unique identifier of the channel associated with the most recent livestream.                                                                                                  |
| recent_livestream.created_at             | string         | The date and time that the most recent livestream was created, in YYYY-MM-DD HH:MM:SS format.                                                                                     |
| recent_livestream.session_title          | string         | The title of the most recent livestream.                                                                                                                                          |
| recent_livestream.is_live                | boolean        | Indicates whether the most recent livestream is currently live.                                                                                                                   |
| recent_livestream.risk_level_id          | null or number | The risk level of the most recent livestream. If the value is null, it means that the livestream does not have a specified risk level.                                            |
| recent_livestream.source                 | string         | The source of the most recent livestream.                                                                                                                                         |
| recent_livestream.twitch_channel         | null           | Not used.                                                                                                                                                                         |
| recent_livestream.duration               | number         | The duration of the most recent livestream, in milliseconds.                                                                                                                      |
| recent_livestream.language               | string         | The language of the most recent livestream.                                                                                                                                       |
| recent_livestream.is_mature              | boolean        | Indicates whether the most recent livestream is marked as mature.                                                                                                                 |
| recent_livestream.viewer_count           | null           | Not used.                                                                                                                                                                         |
| recent_livestream.categories.id          | number         | The unique identifier of the category associated with the most recent livestream.                                                                                                 |
| recent_livestream.categories.category_id | number         | The unique identifier of the parent category associated with the category of the most recent livestream.                                                                          |
| recent_livestream.categories.name        | string         | The name of the category associated with the most recent livestream.                                                                                                              |
| recent_livestream.categories.slug        | string         | The URL slug for the category associated with the most recent livestream.                                                                                                         |
| recent_livestream.categories.tags        | array          | An array of tags associated with the category of the most recent livestream.                                                                                                      |
| recent_livestream.categories.description | null           | Not used.                                                                                                                                                                         |
| recent_livestream.categories.deleted_at  | null           | Not used.                                                                                                                                                                         |
| current_livestream                       | null           | Not used.                                                                                                                                                                         |
**Sample Response:**

```json
{
    "id": 999,
    "user_id": 888,
    "slug": "trainwreckstv",
    "playback_url": "https:\/\/fa723fc1b171.us-west-2.playback.live-video.net\/api\/video\/v1\/us-west-2.196233775518.channel.p0mBRipm9p81.m3u8",
    "name_updated_at": null,
    "vod_enabled": true,
    "subscription_enabled": true,
    "user": {
        "id": 888,
        "username": "Trainwreckstv",
        "risk_level_id": null,
        "bio": null,
        "year_started_trading": null,
        "country": null,
        "state": null,
        "city": null,
        "instagram": "madeupdata",
        "twitter": "madeupdata",
        "youtube": "madeupdata",
        "discord": null,
        "tiktok": null,
        "facebook": null,
        "profilepic": "https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/user\/888\/profile_image\/conversion\/madeupdata-thumb.webp"
    },
    "recent_livestream": {
        "id": 777,
        "slug": "madeupdata",
        "channel_id": 999,
        "created_at": "2023-02-09 00:42:21",
        "session_title": "madeupdata",
        "is_live": false,
        "risk_level_id": null,
        "source": "madeupdata",
        "twitch_channel": null,
        "duration": 28600000,
        "language": "madeupdata",
        "is_mature": true,
        "viewer_count": null,
        "categories": [
            {
                "id": 28,
                "category_id": 4,
                "name": "madeupdata",
                "slug": "madeupdata",
                "tags": [
                    "madeupdata"
                ],
                "description": null,
                "deleted_at": null
            }
        ]
    },
    "current_livestream": null
}
```

## Current Viewers

**URL**: `/api/v1/current-viewers?ids[]=151368`

**Method**: `GET`

- Where does this ID come from?

## Categories

### Top

Fetches platform data for the top categories.

**URL**: `/api/v1/categories-top`

**Method**: `GET`

| Property      | Type             | Description                                                                   |
| ------------- | ---------------- | ----------------------------------------------------------------------------- |
| id            | integer          | The unique identifier of the subcategory                                      |
| category_id   | integer          | The identifier of the parent category                                         |
| name          | string           | The name of the subcategory                                                   |
| slug          | string           | The URL-friendly version of the subcategory name                              |
| tags          | array of strings | The tags associated with the subcategory                                      |
| description   | string, null     | The description of the subcategory, or null if none exists                    |
| deleted_at    | datetime, null   | The time that the subcategory was deleted, or null if it has not been deleted |
| banner.src    | string           | The URL of the subcategory banner image                                       |
| banner.srcset | string           | The URL and size of the subcategory banner image in various resolutions       |
| viewers       | integer          | The current number of viewers in the subcategory                              |
| category.id   | integer          | The unique identifier of the parent category                                  |
| category.name | string           | The name of the parent category                                               |
| category.slug | string           | The URL-friendly version of the parent category name                          |
| category.icon | string           | The emoji icon associated with the parent category                            |


**Sample Response:**

```json
{
    "id": 15,
    "category_id": 2,
    "name": "Just Chatting",
    "slug": "just-chatting",
    "tags": [
        "IRL"
    ],
    "description": null,
    "deleted_at": null,
    "banner": {
        "src": "https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/conversion\/just-chatting-banner.webp",
        "srcset": "https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_600_800.webp 600w, https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_501_668.webp 501w, https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_420_560.webp 420w, https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_351_468.webp 351w, https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_294_392.webp 294w, https:\/\/d2egosedh0nm8l.cloudfront.net\/images\/subcategories\/15\/banner\/responsives\/just-chatting___banner_245_327.webp 245w, data:image\/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KPHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHg9IjAiCiB5PSIwIiB2aWV3Qm94PSIwIDAgNjAwIDgwMCI+Cgk8aW1hZ2Ugd2lkdGg9IjYwMCIgaGVpZ2h0PSI4MDAiIHhsaW5rOmhyZWY9ImRhdGE6aW1hZ2UvanBlZztiYXNlNjQsLzlqLzRBQVFTa1pKUmdBQkFRRUFZQUJnQUFELy9nQTdRMUpGUVZSUFVqb2daMlF0YW5CbFp5QjJNUzR3SUNoMWMybHVaeUJKU2tjZ1NsQkZSeUIyT0RBcExDQnhkV0ZzYVhSNUlEMGdPVEFLLzlzQVF3QURBZ0lEQWdJREF3TURCQU1EQkFVSUJRVUVCQVVLQndjR0NBd0tEQXdMQ2dzTERRNFNFQTBPRVE0TEN4QVdFQkVURkJVVkZRd1BGeGdXRkJnU0ZCVVUvOXNBUXdFREJBUUZCQVVKQlFVSkZBMExEUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVS84QUFFUWdBS3dBZ0F3RWlBQUlSQVFNUkFmL0VBQjhBQUFFRkFRRUJBUUVCQUFBQUFBQUFBQUFCQWdNRUJRWUhDQWtLQy8vRUFMVVFBQUlCQXdNQ0JBTUZCUVFFQUFBQmZRRUNBd0FFRVFVU0lURkJCaE5SWVFjaWNSUXlnWkdoQ0NOQ3NjRVZVdEh3SkROaWNvSUpDaFlYR0JrYUpTWW5LQ2txTkRVMk56ZzVPa05FUlVaSFNFbEtVMVJWVmxkWVdWcGpaR1ZtWjJocGFuTjBkWFozZUhsNmc0U0Zob2VJaVlxU2s1U1ZscGVZbVpxaW82U2xwcWVvcWFxeXM3UzF0cmU0dWJyQ3c4VEZ4c2ZJeWNyUzA5VFYxdGZZMmRyaDR1UGs1ZWJuNk9ucThmTHo5UFgyOS9qNSt2L0VBQjhCQUFNQkFRRUJBUUVCQVFFQUFBQUFBQUFCQWdNRUJRWUhDQWtLQy8vRUFMVVJBQUlCQWdRRUF3UUhCUVFFQUFFQ2R3QUJBZ01SQkFVaE1RWVNRVkVIWVhFVElqS0JDQlJDa2FHeHdRa2pNMUx3RldKeTBRb1dKRFRoSmZFWEdCa2FKaWNvS1NvMU5qYzRPVHBEUkVWR1IwaEpTbE5VVlZaWFdGbGFZMlJsWm1kb2FXcHpkSFYyZDNoNWVvS0RoSVdHaDRpSmlwS1RsSldXbDVpWm1xS2pwS1dtcDZpcHFyS3p0TFcydDdpNXVzTER4TVhHeDhqSnl0TFQxTlhXMTlqWjJ1TGo1T1htNStqcDZ2THo5UFgyOS9qNSt2L2FBQXdEQVFBQ0VRTVJBRDhBdGZGNUJlK0g1WEErWWpBelh6dDRLMVVlRTlmQ05JTXl0eml2WHZpdjQ0VVFQYllBQkZmTGsycHpmOEpRc3U3S2J2V29yMGVTWHMwenJ3cjVGek05ditKUGpTQld0NExkdDhrcEJPSzlzK0ZiTkpvMXJLM0IyQ3ZqeTl2QnFIaUczd3hjTGl2cUg0U2E1TWx0RkE0ekdCeFhCR2kzTGtXNTIxcCswWE1qNW0rT0d0NmkrdG1PTjJSUFd2TS9EczgwdXNLa3JsOG12Y3ZqWDRaa3ZQM3NLWlk4Y0NzLzRXL3M4YXpxc2NlcHRBeFRPUnhYMG1JamFiUEppbTJZZW1hZXVtNm1KcHhrTjByNkQrSGVveHBCR0VPQ2VsWUd1ZkJQVlhsalpvZGtjZkpKRlNXVHA0Y3VVaXo5d1lPSzh5aFNrNjNOMFBUbEtLcDJQWXo0RzhPNnhBalhjb0RkY0d2UU5FdWRHOE1hR3R0YU1oQ2pnWXJ5TGV3WWNtcjBic1JqY2NWOVBMRFJscTJRc09ybnFTNnBwbmlDRm9yaGxqRERHUlhIYTE4TGZEelJTVEpLR2NuUEpyQVdWMGI1V0kraHFacm1Wb2VaR1A0MUVjS283TXQwVmZSbi85az0iPgoJPC9pbWFnZT4KPC9zdmc+ 32w"
    },
    "viewers": 13447,
    "category": {
        "id": 2,
        "name": "IRL",
        "slug": "irl",
        "icon": "\ud83c\udf99\ufe0f"
    }
}
```

### stream/livestreams/en

Obtain the current top streams in a particular category

**URL**: https://kick.com/stream/livestreams/en

**Method**: GET

| Parameter | Type   | Description                                                                                                       |
| --------- | ------ | ----------------------------------------------------------------------------------------------------------------- |
| category  | string | Optional. Filters the results by category. Possible values are: "games", "irl", "music" , "gambling" , "creative" |
| sort      | string | Optional. Sorts the results by the specified field. Known possible values are: "featured".                        |

## Chat Messages

### Send

JSON POST request

**URL**: `/api/v1/chat-messages`

**Method**: `POST`

| Property    | Type    | Description                                                |
| ----------- | ------- | ---------------------------------------------------------- |
| chatroom_id | integer | The ID of the chatroom associated with the message         |
| type        | string  | The type of the message, if available                      |
| message     | string  | The text of the message                                    |
| created_at  | integer | The Unix timestamp when the message was created            |
| id          | string  | The unique identifier of the message                       |
| reactions   | array   | An array of reactions (emotes) associated with the message |
| emotes      | array   | An array of emotes associated with the message             |

```json
{
    "chatroom_id": 259821,
    "user": {
        "id": 262331,
        "username": "mattseabrook",
        "risk_level_id": null,
        "bio": "Matt & Megan Seabrook's Variety Stream - Retro Video Games, Art, and Software Development",
        "year_started_trading": null,
        "country": "",
        "state": "",
        "city": "",
        "enable_live_notifications": true,
        "instagram": "matthewseabrook",
        "twitter": "",
        "youtube": "",
        "discord": "",
        "tiktok": "mattseabrook",
        "facebook": "",
        "enable_onscreen_live_notifications": true,
        "profilepic": "https://d2egosedh0nm8l.cloudfront.net/images/user/262331/profile_image/conversion/be1cdc95-f519-4a84-869c-08aaa6250501-medium.webp",
        "is_2fa_setup": false,
        "redirect": null,
        "channel_can_be_updated": true,
        "is_live": false,
        "roles": [],
        "streamer_channel": {
            "id": 259825,
            "user_id": 262331,
            "slug": "mattseabrook",
            "playback_url": "https://fa723fc1b171.us-west-2.playback.live-video.net/api/video/v1/us-west-2.196233775518.channel.ijAXYlFNAvzV.m3u8",
            "name_updated_at": null,
            "vod_enabled": true,
            "subscription_enabled": false
        },
        "role": "Channel Host",
        "verified": null,
        "profile_thumb": "https://d2egosedh0nm8l.cloudfront.net/images/user/262331/profile_image/conversion/be1cdc95-f519-4a84-869c-08aaa6250501-medium.webp",
        "isSuperAdmin": false,
        "is_subscribed": null,
        "follower_badges": [],
        "months_subscribed": 0
    },
    "type": null,
    "message": "Test",
    "created_at": 1676794478,
    "id": "temp_1676794478542",
    "reactions": [],
    "emotes": []
}
```