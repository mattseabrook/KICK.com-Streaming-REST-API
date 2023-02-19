# KICKstand

Cross-platform utility for KICK

**Table-of-Contents**

- [KICKstand](#kickstand)
- [Developer Notes](#developer-notes)
  - [API](#api)
    - [User](#user)

# Developer Notes

## API

### User

URL: `/api/v1/user`

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