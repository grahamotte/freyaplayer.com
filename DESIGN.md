---
name: Freya Player
description: A native Apple client for personal Plex and Jellyfin servers that looks like Apple built it.
colors:
  night-top: "#14171F"
  night-bottom: "#0A0D12"
  text-primary: "#FFFFFF"
  text-secondary: "rgba(255, 255, 255, 0.72)"
  text-inverse: "#000000"
  surface-subtle: "rgba(255, 255, 255, 0.05)"
  surface: "rgba(255, 255, 255, 0.08)"
  surface-border: "rgba(255, 255, 255, 0.12)"
  surface-emphasized: "rgba(255, 255, 255, 0.16)"
  glass-fill: "rgba(255, 255, 255, 0.12)"
  glass-stroke: "rgba(255, 255, 255, 0.28)"
  seen-yellow: "#FFD60A"
  warning-orange: "#FF9F0A"
  positive-green: "#30D158"
  destructive-red: "#FF453A"
typography:
  page-title:
    fontFamily: "SF Pro Display, -apple-system, system-ui, sans-serif"
    fontSize: "38px"
    fontWeight: 700
    lineHeight: 1.15
  item-title:
    fontFamily: "SF Pro Display, -apple-system, system-ui, sans-serif"
    fontSize: "28px"
    fontWeight: 700
    lineHeight: 1.15
  headline:
    fontFamily: "SF Pro Display, -apple-system, system-ui, sans-serif"
    fontSize: "22px"
    fontWeight: 600
    lineHeight: 1.27
  control:
    fontFamily: "SF Pro Text, -apple-system, system-ui, sans-serif"
    fontSize: "17px"
    fontWeight: 600
    lineHeight: 1.29
  body:
    fontFamily: "SF Pro Text, -apple-system, system-ui, sans-serif"
    fontSize: "17px"
    fontWeight: 400
    lineHeight: 1.29
  label:
    fontFamily: "SF Pro Text, -apple-system, system-ui, sans-serif"
    fontSize: "13px"
    fontWeight: 400
    lineHeight: 1.38
rounded:
  inline: "16px"
  artwork: "18px"
  card: "20px"
  large: "28px"
  panel: "34px"
  control: "36px"
spacing:
  xx-small: "4px"
  x-small: "8px"
  small: "12px"
  medium: "16px"
  large: "24px"
  x-large: "32px"
  xx-large: "48px"
components:
  button-glass:
    backgroundColor: "{colors.glass-fill}"
    textColor: "{colors.text-primary}"
    typography: "{typography.control}"
    rounded: "{rounded.control}"
    padding: "16px 28px"
  button-glass-focused:
    backgroundColor: "{colors.text-primary}"
    textColor: "{colors.text-inverse}"
    typography: "{typography.control}"
    rounded: "{rounded.control}"
    padding: "16px 28px"
  button-glass-compact:
    backgroundColor: "{colors.glass-fill}"
    textColor: "{colors.text-primary}"
    typography: "{typography.control}"
    rounded: "{rounded.control}"
    padding: "16px 24px"
  button-glass-destructive:
    backgroundColor: "rgba(255, 69, 58, 0.18)"
    textColor: "{colors.text-primary}"
    typography: "{typography.control}"
    rounded: "{rounded.control}"
    padding: "16px 28px"
  field:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.inline}"
    padding: "12px"
  tile-artwork:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.artwork}"
  panel:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.panel}"
    padding: "18px"
  surface-card:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text-primary}"
    rounded: "{rounded.card}"
  surface-card-focused:
    backgroundColor: "{colors.surface-emphasized}"
    textColor: "{colors.text-primary}"
    rounded: "{rounded.card}"
---

# Design System: Freya Player

## Overview

**Creative North Star: "The Stock Apple Client"**

Freya Player should look like an app Apple shipped for watching your own server. Every visual decision starts from the stock platform: SF system type, SF Symbols, standard focus and hover behavior, AVKit playback, and native search. The app adds only what a media client needs: a dark room, the library's artwork, and a single yellow signal for watch state.

The mood is refined and restrained. The app is dark only (`preferredColorScheme(.dark)`), and the global accent color is white, so stock controls never show system blue. Chrome is faint white glass over a deep blue-black gradient, so posters and backdrops carry the color. Behind the Home, Search, and item pages, a slowly drifting blurred mesh gradient adds atmosphere; on item pages its colors are sampled from the item's artwork. Density follows each platform: tvOS uses large gutters and 10-foot type; iPhone tightens spacing without changing the system.

Every value in this file has one home in code. `AppTheme` (`apps/apple/App/Components/AppTheme.swift`) owns colors, radii, spacing, and interaction constants. `PlatformMetadata` owns per-platform page metrics and type sizes. SwiftUI and UIKit draw from the same tokens. A literal color, radius, or opacity in a view is a bug unless it is part of a one-off gradient composition such as a vignette.

**Key Characteristics:**
- Dark only, with white-alpha glass surfaces and a white accent color.
- Artwork and the ambient mesh supply the color; the UI supplies structure.
- One accent with one job: Seen Yellow marks progress and watched state.
- Six continuous-corner radii, chosen by role.
- Two focus behaviors: controls invert to white; content cards brighten and, on tvOS, lift.

## Colors

A near-black canvas with white at graded opacities, plus system colors that each carry a single meaning.

### Primary
- **Seen Yellow** (`seen-yellow`, `AppTheme.seen`, systemYellow): used only for watch state. It fills the progress pie on tile artwork, the checkmark circle for watched items, and the tint of the watch-status button. That tint blends from white toward yellow as progress rises.

### Neutral
- **Night Top / Night Bottom** (`night-top` → `night-bottom`): the vertical gradient behind every page, and the base under the ambient mesh.
- **Primary Text** (`text-primary`): titles, labels, and icons, and the fill of focused controls.
- **Secondary Text** (`text-secondary`, white at 72%): subtitles, metadata, prompts, and placeholder icons.
- **Inverse Text** (`text-inverse`): content on a focused (white) control.
- **Surface steps** (`surface-subtle` 5%, `surface` 8%, `surface-emphasized` 16%): resting fills for tiles, panels, fields, and cards, and the focused fill for content cards.
- **Surface Border** (`surface-border`, 12%): the 1px hairline on panels and fields.
- **Glass Fill / Glass Stroke** (`glass-fill` 12%, `glass-stroke` 28%): the resting glass button.
- **Scrims** (`AppTheme.scrim` 40%, `AppTheme.modalScrim` 50%): darkening layers under details views and the iPhone playback dialog.

### Status
- **Warning Orange** (`warning-orange`, `AppTheme.warning`): server conversion in playback details, conditional capabilities, and playback errors.
- **Positive Green** (`positive-green`, `AppTheme.positive`): supported capabilities.
- **Destructive Red** (`destructive-red`, `AppTheme.destructive`): the tint of the destructive glass button.

### Named Rules
**The One Signal Rule.** Yellow means "you've watched some or all of this." Never use it for selection, focus, links, or decoration.

**The Artwork Owns Color Rule.** Chrome stays achromatic. Color in the UI comes from artwork, the artwork-sampled mesh, or a status color with a specific meaning.

## Typography

**Display Font:** SF Pro (system)
**Body Font:** SF Pro (system)
**Label/Mono Font:** SF Mono via `.monospaced()`, only for technical values such as stream details and link codes

**Character:** Only the system typeface. Weight does the work of hierarchy. Two display sizes are fixed per platform so titles read the same on every page; everything else uses Dynamic Type text styles.

### Hierarchy
- **Page Title** (bold, `PlatformMetadata.pageTitleFont`: 38pt iPhone, 52pt iPad and Mac, 64pt tvOS): the server name on Home and the library name on Library pages.
- **Item Title** (bold, `PlatformMetadata.itemTitleFont`: 28pt iPhone, 38pt iPad and Mac, 58pt tvOS): media item titles and the full details view.
- **Headline** (semibold `title2`; `title3` on tvOS; `PlatformMetadata.sectionTitleFont` / `uiSectionTitleFont`): section titles, shelf headers, panel titles, dialog titles, and the provider buttons. There is one headline style; do not mix `headline`, `title3`, bold, and semibold for the same role.
- **Tile Title** (`headline`; semibold `callout` on tvOS; `PlatformMetadata.tileTitleFont` / `uiTileTitleFont`): tile titles, the Open Library label, and the focused-item title on tvOS.
- **Control** (semibold `body`, `PlatformMetadata.controlFont` / `uiControlFont`): every glass button label and icon, in SwiftUI and UIKit.
- **Body** (regular, `body` / `callout`): synopses, descriptions, and settings rows. Row titles inside a panel use `body` at medium weight, and a panel's primary value (the server name) uses `headline`.
- **Label** (regular, `footnote`; `caption` on tvOS; `PlatformMetadata.labelFont` / `uiLabelFont`): tile subtitles, metadata, field labels, captions, and playback plan lines on tvOS, in Secondary Text. Add `.weight(.semibold)` for a label that names a value.

### Named Rules
**The System Type Rule.** No custom fonts and no `.system(size:)` in views. Fixed sizes exist only for page and item titles, which live in `PlatformMetadata`, and for the checkmark glyph inside the fixed-size Progress Indicator. Large display values such as the Plex link code use `largeTitle`.

## Layout

The Home Page is a vertical stack of horizontally scrolling library shelves with management buttons at the bottom. Library pages use a grid of tiles. Item pages put artwork and actions over the artwork-tinted ambient background.

Page metrics come from `PlatformMetadata`:
- **Page gutter** (`pageGutter`): 16pt iPhone, 32pt iPad and Mac, 48pt tvOS. Every page uses it, including tvOS UIKit pages, search, and library grids. The bottom and trailing padding match the leading gutter.
- **Section spacing** (`pageSectionSpacing`): 24pt iPhone, 32pt iPad and Mac, 48pt tvOS. It also separates rows in library grids and sections on the full details view.
- **Shelf spacing** (`shelfSpacing`): 12pt iPhone, 16pt elsewhere, between a shelf title and its row.
- **Tile spacing** (`tileSpacing`): 12pt iPhone, 16pt iPad and Mac, 48pt tvOS, between tiles in shelves and between columns in library grids, in SwiftUI and UIKit.
- **Tile text** (`tileTitleSpacing`, `tileSubtitleSpacing`): 8pt (24pt on tvOS, to clear the focus lift) from artwork to title, and 4pt from title to subtitle.
- **Control spacing** (`controlSpacing`): 12pt, 24pt on tvOS, between glass buttons in a row.
- **Panel padding** (`panelPadding`): 16pt iPhone, 24pt elsewhere, inside every panel.
- **Spacing scale** (`AppTheme.Spacing`): 4, 8, 12, 16, 24, 32, 48 for everything else. Use 4–8 inside a group (a label and its value), 12–16 between siblings, and 24–32 between groups. Every spacing, padding, and inset in a view comes from this scale or a metric above; there are no off-scale values such as 10, 18, 20, or 44.

Scrolling rows keep a trailing gutter equal to the leading one. Text in a borderless focusable block (the item title and synopsis) aligns with the column edge; its focus highlight hangs 16pt outside the text instead of indenting it. Elements with a visible resting fill (glass buttons, metadata tiles, rows) align by their box edge. The item page keeps its own `MediaViewMetrics` because its artwork-and-details split is a distinct composition; on iPhone its side margin is still the page gutter, so titles line up with the Library Page.

## Elevation & Depth

Depth is tonal: surface layers at 5%, 8%, and 16% white sit over the gradient and the blurred mesh. Two shadows exist, both `AppTheme.artworkShadow`: one under hero artwork on item pages and one under the iPhone playback dialog. On tvOS, poster focus uses the system parallax (`adjustsImageWhenAncestorFocused`), and content cards scale by `AppTheme.focusedCardScale`.

### Shadow Vocabulary
- **Artwork lift** (`shadow(color: AppTheme.artworkShadow, radius: 28, y: 12–18)`): hero artwork and the iPhone playback dialog only.

### Named Rules
**The Flat Glass Rule.** Controls, cards, and panels never cast shadows. Show elevation with a surface step, and show focus with inversion or the card lift.

## Shapes

All rounding uses `.continuous` style. `AppTheme.Radius` has six roles:
- **Inline** (16pt): fields, detail rows, the description block, and search artwork.
- **Artwork** (18pt; 24pt tvOS): tile artwork and Open Library cards, in SwiftUI and UIKit.
- **Card** (20pt): search results, metadata tiles, episode rows, and the playback plan block.
- **Large** (28pt): hero artwork, gallery items, settings rows, and the iPhone playback dialog.
- **Panel** (34pt): settings and setup panels.
- **Control** (36pt): every glass button, which makes it a pill.

The progress indicator is a 24pt circle inset `AppTheme.Spacing.small` from the artwork corner: a pie while in progress, and a filled circle with a checkmark once watched.

## Components

### Buttons
`MediaGlassButtonStyle` is the one button style for actions. It takes a size and a role instead of raw padding or colors.
- **Sizes:** `regular` (16 × 28pt padding), `compact` (16 × 24pt; 16 × 16pt on iPhone), `square` (14pt, for icon rows), and `bare` (for labels that set their own frame).
- **Roles:** `standard` (glass fill and stroke), `tinted(Color)` (`AppTheme.tintedFillOpacity` 18% fill, `tintedStrokeOpacity` 40% stroke of the tint), and `destructive` (tinted with Destructive Red).
- **Focused:** solid white fill with black content and no stroke.
- **Pressed / Disabled:** `AppTheme.pressedScale` (0.98) and `AppTheme.disabledOpacity` (0.45).
- **UIKit:** tvOS UIKit buttons call `AppTheme.applyGlassBackground` and `AppTheme.uiGlassForeground` for the same states, and take their padding from `AppTheme.uiGlassContentInsets`, which reads the `regular` size.
- **Menus:** every menu that looks like a glass button sets `.menuStyle(.button)`, so tvOS draws only the glass pill and no system platter. Menu rows in dialogs span the full width, with the label leading and an up-down chevron trailing.

### Cards / Containers
- **Surface cards:** `MediaSurfaceButtonStyle` and the `focusSurface` modifier give every focusable content card the same behavior. It rests on a surface fill, brightens to Surface Emphasized on focus, scales by 1.02 on tvOS, and animates with `AppTheme.focusAnimation`. Search results, season and episode rows, metadata tiles, the synopsis, detail rows, and gallery items all use it.
- **Tile artwork:** Artwork radius, a Surface fill behind the image, and an SF Symbol placeholder while loading. The Progress Indicator sits in the bottom-right corner.
- **Panel:** Surface fill with a 1px Surface Border, Panel radius, and `panelPadding`, titled with Headline. Content inside a panel never gets its own box; rows inside a panel are separated by spacing alone.
- **Playback plan block:** Surface fill, Card radius, and a two-column grid so each stream's label and plan align.
- **Dialogs:** sheets use the system presentation background, so there is one surface. Only the iPhone playback dialog, a full-screen cover, draws its own Night Top background.

### Inputs / Fields
`glassField(isFocused:)` styles every custom text field: Surface fill, Inline radius, and a 1px Surface Border that becomes a 2pt `AppTheme.focusStroke` (white at 80%) on focus. Setup fields pad 12pt; the search field pads 16pt because it is the page's primary control. The search field and the Jellyfin setup fields share it. On tvOS, setup uses the system text field and native search.

### Signature Component: Ambient Mesh Background
A 4×4 `MeshGradient` whose points drift slowly with sine waves. It is blurred 120–132pt and set to 66–74% opacity over Night Top/Bottom, with a light black vignette on top. On Home and Search it uses a random harmonious palette with a gentle hue rotation. On item pages it samples the artwork and holds its hue still. When Reduce Motion is on, the mesh holds still.

## Do's and Don'ts

### Do:
- **Do** use stock SwiftUI and UIKit controls, SF Symbols, and system text styles before building anything custom.
- **Do** style every action with `MediaGlassButtonStyle(size:role:)`, and every focusable content card with `focusSurface` or `MediaSurfaceButtonStyle`.
- **Do** take colors, radii, spacing, and interaction constants from `AppTheme`, and page metrics and title sizes from `PlatformMetadata`.
- **Do** keep chrome achromatic and let artwork and the ambient mesh carry the color.
- **Do** match bottom and trailing gutters to the leading gutter on every platform.
- **Do** preserve normal tvOS focus movement and the system parallax on artwork.

### Don't:
- **Don't** use Seen Yellow for anything except watch progress and watched state.
- **Don't** write literal colors, corner radii, or opacities in views. Add or reuse a token.
- **Don't** add a light theme, a light-mode island, custom fonts, or brand colors in the chrome.
- **Don't** nest a box inside a box, or draw a custom background inside a system sheet.
- **Don't** put shadows on controls, cards, or panels. Shadow is reserved for hero artwork and the iPhone playback dialog.
- **Don't** replace AVKit's player chrome or the native tvOS search UI with custom versions.
- **Don't** burn in or restyle subtitles.
