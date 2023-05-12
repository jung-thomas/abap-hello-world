CLASS zcl_hello_dev_challenge_tpj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hello_dev_challenge_tpj IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( |Hello World!| ).
  ENDMETHOD.

ENDCLASS.
