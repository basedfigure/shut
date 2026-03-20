unit typmisc;

{$mode ObjFPC}{$H+}
{$DEFINE TWO_CHAR_EMOJI} // fpc -dTWO_CHAR_EMOJI

// Advanced records
// forum.lazarus.freepascal.org/index.php?topic=61682.0

interface

uses
  Classes, SysUtils;

const
  // Colors
  HEX_RGBA_BLACK:   cardinal = $000000;
  HEX_RGBA_WHITE:   cardinal = $FFFFFF;
  HEX_RGBA_GRAY:    cardinal = $999999;
  HEX_RGBA_MORROW:  cardinal = $733F0F;

  // ..ASCII emojis:  en.wikipedia.org/wiki/List_of_emoticons
  {$IFDEF TWO_CHAR_EMOJI}
    SMILE_MOJ = ':)';
    SMILE2_MOJ = ':]';
    FROWN_MOJ = ':(';
  {$ELSE}
    SMILE_MOJ = ':-)';
    SMILE2_MOJ = ':-]';
    FROWN_MOJ = ':-(';
  {$ENDIF}
    HEART_MOJ = '<3';

    // ..chars:  Å Ä Ö
    SWE_UPP_A: array[0..2] of widechar =
      (widechar ($00C5), widechar ($00C4), widechar ($00D6));
    SWE_LOW_A: array[0..2] of widechar =
      (widechar ($00E5), widechar ($00E4), widechar ($00F6));

implementation

end.

