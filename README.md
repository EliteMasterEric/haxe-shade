# Haxe Shade

A utility library to relocate packages in Haxe projects.

It provides macros which relocate packages and modules to prevent overlap and conflicts in languages that do not support them. For example, Java does not allow two imported JARs to each provide the same classpath.

See here for more information: https://medium.com/@akhaku/java-class-shadowing-and-shading-9439b0eacb13

## Installation

Install via Haxelib:

```
haxelib git haxe-shade https://github.com/EliteMasterEric/haxe-shade
```

## Usage

Use Haxe Shade as a build macro.

For example, you can put this into your `hxml` file:

```
--macro haxe.shade.Shade.apply("my.package", "another.package")
```

In this example, `my.package.Foo` and `my.package.test.Bar` will be moved to `another.package.Foo` and `another.package.test.Bar` in the generated output, respectively.
