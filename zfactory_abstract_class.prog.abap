REPORT zfactory_abstract_class.

CLASS leitura_dados DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: getData ABSTRACT.
ENDCLASS.

CLASS impressao DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: printData ABSTRACT.
ENDCLASS.

CLASS arquivo_texto DEFINITION INHERITING FROM leitura_dados.
  PUBLIC SECTION.
    METHODS getdata REDEFINITION.
ENDCLASS.

CLASS arquivo_texto IMPLEMENTATION.
  METHOD getdata.
    WRITE 'coletando dados do arquivo de texto'.
  ENDMETHOD.
ENDCLASS.

CLASS arquivo_pdf DEFINITION INHERITING FROM leitura_dados.
  PUBLIC SECTION.
    METHODS getData REDEFINITION.
ENDCLASS.

CLASS arquivo_pdf IMPLEMENTATION.
  METHOD getdata.
    WRITE 'coletando dados do arquivo PDF'.
  ENDMETHOD.
ENDCLASS.

CLASS impressao_texto DEFINITION INHERITING FROM impressao.
  PUBLIC SECTION.
    METHODS printdata REDEFINITION.
ENDCLASS.

CLASS impressao_texto IMPLEMENTATION.
  METHOD printdata.
    WRITE 'imprimindo dados do arquivo de texto'.
  ENDMETHOD.
ENDCLASS.

CLASS impressao_pdf DEFINITION INHERITING FROM impressao.
  PUBLIC SECTION.
    METHODS printdata REDEFINITION.
ENDCLASS.

CLASS impressao_pdf IMPLEMENTATION.
  METHOD printdata.
    WRITE 'imprimindo dados do arquivo PDF'.
  ENDMETHOD.
ENDCLASS.

CLASS relatorio DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: getData ABSTRACT,
      printData ABSTRACT.
ENDCLASS.

CLASS relatorio_texto DEFINITION INHERITING FROM relatorio.
  PUBLIC SECTION.
    METHODS: getData REDEFINITION,
      printData REDEFINITION.
ENDCLASS.

CLASS relatorio_texto IMPLEMENTATION.
  METHOD getdata.
    DATA(texto) = NEW arquivo_texto( ).
    texto->getdata( ).
  ENDMETHOD.
  METHOD printdata.
    DATA(impressao) = NEW impressao_texto( ).
    impressao->printdata( ).
  ENDMETHOD.
ENDCLASS.

CLASS relatorio_pdf DEFINITION INHERITING FROM relatorio.
  PUBLIC SECTION.
    METHODS: getdata REDEFINITION,
      printData REDEFINITION.
ENDCLASS.

CLASS relatorio_pdf IMPLEMENTATION.
  METHOD getdata.
    DATA(texto) = NEW arquivo_pdf( ).
    texto->getdata( ).
  ENDMETHOD.
  METHOD printdata.
    DATA(impressao) = NEW impressao_pdf( ).
    impressao->printdata( ).
  ENDMETHOD.
ENDCLASS.

CLASS run DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
ENDCLASS.

CLASS run IMPLEMENTATION.
  METHOD run.
    DATA relatorio TYPE REF TO relatorio.
    relatorio = NEW relatorio_texto( ).
    relatorio->getData( ).
    relatorio->printData( ).
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  run=>run( ).