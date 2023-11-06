package haxe.shade;

import haxe.shade._internal.ShadeMacro;

using StringTools;

class Shade {
    static final WILDCARD:String = "*";

    /**
     * Shade a package, relocating it to another package at compile time.
     * 
     * @param from The package to apply shading to.
     * @param to The package to relocate shaded packages to.
     */
    public static function applyPackage(from:String, to:String):Void {
        from = cleanPackage(from);
        to = cleanPackage(to);

        ShadeMacro.shadePackage(from, to);
    }

    static function cleanPackage(input:String):String {
        var parts:Array<String> = input.split('.');
        // Remove empty parts.
        parts = parts.filter(function (s) return s != '');
        // Remove wildcard from the end.
        while (parts[parts.length - 1] == WILDCARD) {
            parts.pop();
        }
        return parts.join('.') + '.'; // Enforce trailing dot.
    }

    /**
     * Shade a module, relocating it to another package at compile time.
     * 
     * @param from The package to apply shading to.
     * @param to The package to relocate shaded packages to.
     */
    public static function applyModule(from:String, to:String):Void {
        from = cleanModule(from);
        to = cleanModule(to);

        ShadeMacro.shadeModule(from, to);
    }

    static function cleanModule(input:String):String {
        var parts:Array<String> = input.split('.');
        // Remove empty parts.
        parts = parts.filter(function (s) return s != '');
        // Remove wildcard from the end.
        while (parts[parts.length - 1] == WILDCARD) {
            parts.pop();
        }
        return parts.join('.'); // No trailing dot.
    }

    /**
     * Shade all the standard classes, relocating them to another package at compile time.
     * @param to The package to relocate shaded packages to.
     */
    public static function applyCore(to:String):Void {
        // Full packages.
        Shade.applyPackage('haxe', '$to.haxe');
        Shade.applyPackage('jvm', '$to.jvm');
        // Only one class in `java` should be shaded.
        Shade.applyModule('java.Init', '$to.java.Init');
        // Apply to the root package.
        // TODO: Causes a compiler failure!
        // Shade.applyModule('Array', '$to.haxe.Array');
        // Shade.applyModule('Iterable', '$to.haxe.Iterable');
        // Shade.applyModule('Iterator', '$to.haxe.Iterator');
    }
}