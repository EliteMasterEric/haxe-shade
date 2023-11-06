package haxe.shade._internal;

#if macro
import haxe.macro.Expr;

class MacroUtil
{
  public static function exprToStr(input:ExprDef):String
  {
    switch (input)
    {
      case EConst(c):
        switch (c)
        {
          case CString(s): return s; // Return the inner string value.
          default: // Fallthrough.
        }
      default: // Fallthrough.
    }

    // Fallthrough, just attempt to stringify the expression.
    return '${input}';
  }
}
#end
