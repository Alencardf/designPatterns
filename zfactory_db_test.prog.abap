*&---------------------------------------------------------------------*
*& Report ZFACTORY_TESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfactory_teste.

INTERFACE banco_dados.
  METHODS: read, updata, delete.
ENDINTERFACE.

CLASS xpto DEFINITION.
  PUBLIC SECTION.
    INTERFACES: banco_dados.
ENDCLASS.

CLASS xpto IMPLEMENTATION.
  METHOD banco_dados~updata.
  ENDMETHOD.

  METHOD banco_dados~read.
    write 'lendo xpto' .
  ENDMETHOD.

  METHOD banco_dados~delete.
  ENDMETHOD.
ENDCLASS.

CLASS lpto DEFINITION.
  PUBLIC SECTION.
    INTERFACES: banco_dados.
ENDCLASS.

CLASS lpto IMPLEMENTATION.
  METHOD banco_dados~updata.
  ENDMETHOD.

  METHOD banco_dados~read.
    write 'lendo lpto'.
  ENDMETHOD.

  METHOD banco_dados~delete.
  ENDMETHOD.
ENDCLASS.

CLASS db_factory DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS get_db
      IMPORTING im_db         TYPE char4
      RETURNING VALUE(result) TYPE REF TO banco_dados.
ENDCLASS.

CLASS db_factory IMPLEMENTATION.

  METHOD get_db.

    CASE im_db.
      WHEN 'xpto'.
        result = NEW xpto( ).
      WHEN 'lpto'.
        result = NEW lpto( ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.


  DATA(xpto) = db_factory=>get_db('xpto').

  data(lpto) = db_factory=>get_db('lpto').

  xpto->read( ).
  lpto->read( ).