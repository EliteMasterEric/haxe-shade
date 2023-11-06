package haxe.shade;

import haxe.shade._internal.ShadeMacro;

class Shade {
    /**
     * Shade a package, renaming it to another package at compile time.
     * 
     * @param from The package to apply shading to.
     * @param to The package to relocate shaded packages to.
     */
    public static function apply(from:String, to:String):Void {
        ShadeMacro.shadePackage(from, to);
    }
}