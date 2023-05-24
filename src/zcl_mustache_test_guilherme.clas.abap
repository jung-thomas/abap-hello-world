CLASS zcl_mustache_test_guilherme DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF ty_shop_item,
        name  TYPE string,
        price TYPE string, "p LENGTH 15 DECIMALS 2,
      END OF ty_shop_item,

      ty_shop_item_tt TYPE STANDARD TABLE OF ty_shop_item WITH DEFAULT KEY,

      BEGIN OF ty_shop,
        shop_name TYPE string,
        items     TYPE ty_shop_item_tt,
      END OF ty_shop.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mustache_test_guilherme IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lv_text TYPE string.
    DATA(c_nl) = cl_abap_char_utilities=>newline.
    DATA lt_my_data TYPE STANDARD TABLE OF ty_shop WITH DEFAULT KEY.
    DATA lr_data TYPE REF TO ty_shop.
    DATA lo_mustache TYPE REF TO zcl_mustache.

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = 'LOJA DO GUILHERME'.
    lr_Data->items = VALUE ty_shop_item_tt(
        ( name = 'CAFÉ 500G' price = '12.00' )
        ( name = 'GRANOLA 1KG' price = '25.00' )
        ( name = 'LEIT' price = '9.00' )
     ).

    TRY.
        lo_mustache = zcl_mustache=>create(
          'Welcome to <b>{{shop_name}}</b>!' && c_nl &&
          '<table>' && c_nl &&
          ' {{#items}}' && c_nl &&
          ' <tr><td>{{name}}</td><td>R${{price}}</td>' && c_nl &&
          ' {{/items}}' && c_nl &&
          '</table>'
          ).

        lv_text = lo_mustache->render( lt_my_data ).
        out->write( lv_text ).
      CATCH zcx_mustache_error INTO DATA(error).
        out->write( error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
