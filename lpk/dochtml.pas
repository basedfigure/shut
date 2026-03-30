unit dochtml;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil, editutil;


const

  HTML_DOC_INIT:  str = (
    '<body>' +
    '<header></header>' +
    '<div class="layout">' +
    '<div class="nav_bar"></div>' +
    '<div class="user_data"></div>' +
    '</div>' +
    '</footer></footer>' +
    '</body>'
  );

  JS_HOT_LOAD:  str = (
    '<script>' +
    '  setTimeout(function(){ location.reload(); }, 1000);' +
    '</script>'
  );

var
  page:  str;


  procedure html_init_new_page (_ed_keep_hot_load:  bool = true);

implementation


procedure html_init_new_page (_ed_keep_hot_load:  bool = true);
begin
  page:=HTML_DOC_INIT;

  if _ed_keep_hot_load then
    page += JS_HOT_LOAD;

  //ed.nth:=Length (page);
end;

end.

