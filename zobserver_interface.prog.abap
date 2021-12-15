REPORT zobserver_interface.

CLASS calculadora DEFINITION.
  PUBLIC SECTION.
    METHODS: efetua_calculos,
      registra_valor IMPORTING valor TYPE i.
    EVENTS: calculado EXPORTING VALUE(valor) TYPE i.
  PRIVATE SECTION.
    DATA valor TYPE i.
ENDCLASS.

CLASS calculadora IMPLEMENTATION.
  METHOD efetua_calculos.
    RAISE EVENT calculado EXPORTING valor = me->valor.
  ENDMETHOD.
  METHOD registra_valor.
    me->valor = valor.
  ENDMETHOD.
ENDCLASS.

INTERFACE observer.
  METHODS: on_calculado FOR EVENT calculado OF calculadora IMPORTING valor.
ENDINTERFACE.

CLASS soma_complexa DEFINITION.
  PUBLIC SECTION.
    INTERFACES: observer.
ENDCLASS.

CLASS soma_complexa IMPLEMENTATION.
  METHOD observer~on_calculado.
    WRITE: / |Valor { valor } somado complexamente com 1: { valor + 1 }|.
  ENDMETHOD.
ENDCLASS.

CLASS multiplicacao_complexa DEFINITION.
  PUBLIC SECTION.
    INTERFACES: observer.
ENDCLASS.

CLASS multiplicacao_complexa IMPLEMENTATION.
  METHOD observer~on_calculado.
    WRITE: / |Valor { valor } multiplicado complexamente por 2: { valor * 2 }|.
  ENDMETHOD.
ENDCLASS.


CLASS programa_cliente DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS run.
ENDCLASS.

CLASS programa_cliente IMPLEMENTATION.
  METHOD run.
    DATA(calculadora) = NEW calculadora( ).
    DATA(soma_complexa) = NEW soma_complexa( ).
    DATA(multiplicacao_complexa) = NEW multiplicacao_complexa( ).

    SET HANDLER soma_complexa->observer~on_calculado FOR calculadora.
    SET HANDLER multiplicacao_complexa->observer~on_calculado FOR calculadora.

    calculadora->registra_valor( 16 ).
    calculadora->efetua_calculos( ).

    calculadora->registra_valor( 20 ).
    calculadora->efetua_calculos( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

programa_cliente=>run( ).