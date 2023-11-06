package haxe.shade._internal;

using StringTools;

#if macro
import haxe.macro.Type;
import haxe.macro.Type.BaseType;
import haxe.macro.Type.Ref;
import haxe.macro.Context;

using haxe.macro.TypeTools;

@:allow(haxe.shade.Shade)
class ShadeMacro
{
  public static function shadePackage(from:String, to:String)
  {
    function dotPad(s:String)
      return if (s.endsWith('.')) s else '$s.';

    from = dotPad(from);
    to = dotPad(to);

    Context.onAfterTyping(types -> {
      Context.info('Shading package "$from" -> "$to"', Context.currentPos());

      function applyToType<T:BaseType>(r:Ref<T>)
      {
        switch r.toString()
        {
          case _.startsWith(from) => false: // Context.info('IGNORING "${r.toString()}"', Context.currentPos());
          case match:
            Context.info('Shading module "$match" -> "${to + match.substr(from.length)}"', Context.currentPos());
            Context.info('  Replacing "${r.get().meta.extract(':native').map(function (e) {e.params[0].expr;})}"', Context.currentPos());
            r.get().meta.remove(':native'); // If the class already has @:native, it will be replaced
            r.get().meta.add(':native', [macro $v{to + match.substr(from.length)}], (macro null).pos);
            Context.info('  Done "${r.get().meta.extract(':native').map(function (e) {e.params[0].expr;})}}"', Context.currentPos());
        }
      }
    
      function applyToModuleType(mt:ModuleType)
      {
        var t:Type = mt.fromModuleType();
        switch t
        {
          case TEnum(r, _): applyToType(r);
          case TInst(r, _): applyToType(r);
          case TType(r, _): applyToType(r);
          // ---
          case TAbstract(r, _): // Context.info('IGNORING Abstract ${t.toString()}', Context.currentPos());
          case TAnonymous(r): // Context.info('IGNORING Anonymous ${t.toString()}', Context.currentPos());
          case TDynamic(r): // Context.info('IGNORING Dynamic ${t.toString()}', Context.currentPos());
          case TLazy(r): // Context.info('IGNORING Lazy ${t.toString()}', Context.currentPos());
          case TMono(_): // Context.info('IGNORING Mono ${t.toString()}', Context.currentPos());
          case TFun(_, _): // Context.info('IGNORING Fun ${t.toString()}', Context.currentPos());
        }
      }

      for (t in types)
      {
        // Context.info('Querying module ${t}', Context.currentPos());
        applyToModuleType(t);
      }
    });
  }
}
#end
