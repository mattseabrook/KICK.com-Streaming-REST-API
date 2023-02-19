# KICKstand

Cross-platform utility for KICK

**Table-of-Contents**

- [KICKstand](#kickstand)
- [Developer Notes](#developer-notes)
  - [API](#api)
    - [User](#user)
    - [Channels Followed](#channels-followed)
    - [Current Viewers](#current-viewers)

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

### Channels Followed

Returns an array of channel data, each with the following properties:

**URL**: `/api/v1/channels/followed`

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

### Current Viewers

**URL**: `/api/v1/current-viewers?ids[]=151368`