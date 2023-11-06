# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2023-11-06

Initial version.

### Added
- Added initial functionality.
    - `haxe.shade.Shade.applyPackage(from, to)` to shade one entire package (and all its subpackages) to another.
    - `haxe.shade.Shade.applyPackage(from, to)` to shade one module to a new name and/or package.
    - `haxe.shade.Shade.applyCore(to)` to shade all core Haxe modules (such as `haxe.root`) to a new root package.
- Added two test projects.
    - The `basic-example` test project is a basic example of shading a package.
    - The `haxe` test project is an example of shading the core Haxe package.
