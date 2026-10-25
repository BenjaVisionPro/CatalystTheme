# Catalyst Theme

Catalyst Theme gives developers building GT/Bloc tools a shared appearance layer:
light and dark themes, reusable palettes, and styling for the controls that
make up an inspector or application workspace. Use it to give your own Catalyst
tools a consistent look while keeping appearance choices separate from domain
objects.

## Features

- Shared palette and appearance state, with change announcements.
- Light and dark detail themes.
- GT styling for menus, palettes, selections, sliders, switches, tabs, tags,
  typography, group cards, and diagrams.
- Theme choice and toggle controls for application tools.
- Appearance examples alongside the packages.

This is a GT/Pharo UI component. It does not provide themes for Unreal, SwiftUI,
or browser applications.

## Installation

Install Catalyst through [BVC](https://github.com/BenjaVisionPro/bvc#install).
With BVC installed, create and launch a local development project:

```sh
bvc init MyCatalystProject
cd MyCatalystProject
bvc run
```

BVC builds and launches the GT/Pharo DevKit without starting a GemStone deployment.
Your project's BVC configuration selects the components and startup packages.
Package-loading details below describe development inside that environment.

## Package loading

`BaselineOfCatalystTheme` defines the Core, GT, Light, and Dark packages.
It resolves Foundation from BVC's `PROJECTS_ROOT` checkout layout, so use the
BVC-built environment rather than treating a Metacello load as standalone setup.

For package development, the baseline entry point is:

```smalltalk
Metacello new
    repository: 'github://BenjaVisionPro/CatalystTheme:main/src';
    baseline: 'CatalystTheme';
    load.
```

Validate appearance in the GT/Bloc version and application controls you use.

## License

This repository is licensed under the [Catalyst Developer License](LICENSE).

Each developer using Catalyst for development needs an active
BenjaVision-Catalyst subscription: **$5 per month, billed annually at $60 per
developer**, including access to the BenjaVision-Catalyst repository. New products,
updates, bug fixes, and recompilation require active developer subscriptions.
Automated build machines do not need separate subscriptions.

Products lawfully built during active subscriptions may continue to be used,
hosted, sold, and distributed indefinitely without runtime royalties. Customers
and operators do not need subscriptions solely to use or distribute those builds.
Commercial and proprietary products are permitted; this license does not require
you to publish your own source code.

Existing license grants and separately licensed third-party material remain
unaffected. See [LICENSE](LICENSE) for the complete terms.
