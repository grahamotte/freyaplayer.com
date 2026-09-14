# SKIP - Playback intros cannot be skipped

## user value

As a viewer, I want to skip known intro segments during playback, so that I can reach episode content quickly.

## Problem description

Freya Player does not offer a way to skip an episode intro even when the connected media server has timing metadata for that intro. Viewers must seek manually, and the app gives no indication of whether the server has supplied a usable intro interval.

Plex and Jellyfin expose this information differently and do not guarantee that it exists. Plex can return `Marker` elements, including `intro` start and end offsets, with regular metadata responses when markers are requested. Jellyfin 10.10 and later exposes typed intervals through `GET /MediaSegments/{itemID}`, but the server must have a media-segment provider configured and its media-segment scan completed.

This distinction affects both feature availability and refresh cost. Plex markers can travel with the existing paginated library, child, item, and playback metadata requests. Jellyfin's endpoint is item-specific, so eagerly warming intro data during a recursive TV-library refresh adds approximately one request per episode. Freya's request scheduler currently limits total concurrent HTTP work to four requests.

The feature must behave clearly when intro data is absent, unsupported, stale, or temporarily unavailable. Existing cached library data must remain readable without a migration, and a transient metadata failure must not erase previously known timing.

## Status, notes, context, etc

- AVKit supports contextual playback actions on tvOS. These actions are visible with the native transport controls rather than as a permanently visible overlay.
- On iOS, iPadOS, and Mac Catalyst, AVPlayerViewController's `contentOverlayView` can host player-specific UI.
- Intro timing needs to use content-relative time correctly when playback starts from a resume offset or a server-generated stream begins on a shifted local timeline.
- A prototype was implemented and compiled for tvOS, iOS, and Mac Catalyst, then removed when the work was deferred.
- The prototype passed the full repository test suite, including tests for segment boundaries, Jellyfin tick conversion, cached timing preservation, and decoding cache entries that predated the field.
- During simulator validation against Jellyfin 10.11.11, Freya issued 1,164 `MediaSegments` requests. Every response was successful but returned an empty `Items` array. Playback metadata reported `HasSegments: false`, so there was no interval in which a Skip Intro action could appear.
- Jellyfin requires a media-segment provider, such as a provider that derives segments from named chapters or an external intro database, followed by the server's Media Segment Scan task. Merely running Jellyfin 10.10 or later does not produce intro timings.
- Future work should establish the intended Jellyfin loading policy, acceptable refresh overhead, minimum supported provider behavior, and how users understand that skipping depends on server-supplied metadata.

## Prompts

> this app really needs a 'skip intro' button - before we build that, couple questions:
>
>
>
> - is there a native way of displaying it in player?
> - do/can we get intros times from both jellyfin and plex?

Investigated native AVKit presentation and the intro metadata available from Plex and Jellyfin.

> great lets add this - id assume that the skip position gets pulled along with all the other data on a refresh and we shouldn't need to do any real data migration since the user can just wait for the next refresh. lets make sure to use the native method for tvos and go ahead and add the `contentOverlayView` for other platforms

Implemented a prototype covering provider metadata, caching, playback seeking, native tvOS actions, and overlay controls on the other Apple platforms. Verified tests and platform builds.

> can you describe the structure of a refresh for both plex and jellyfin, like what requests we are making for each

Traced the complete refresh request graph. Identified that Plex can return intro markers inline, while Jellyfin needs an additional item-specific request for every episode whose segments are warmed.

> i tried running the tv simulator and doing a refresh, but im not seeing any UI for skipping the intro

Inspected the booted simulator, its HTTP cache, and its media cache. Confirmed the new requests ran but Jellyfin returned no intro segments.

> ok so its just because jellyfin doesnt have it?

Confirmed that the tested Jellyfin library had no generated media-segment data and described the server-side provider and scan prerequisite.

> i decided not to make this change, but lets record our learnings in a kanban card so we will maybe do in the future

Removed the prototype implementation and recorded the problem, evidence, compatibility findings, request-cost implications, and open product questions for possible future work.
