REPORT zfactory_abstract_interface.

INTERFACE leitura_dados.
  METHODS: getData.
ENDINTERFACE.

INTERFACE impressao.
  METHODS: printData.
ENDINTERFACE.

INTERFACE relatorio.
  METHODS: getData, printData.
ENDINTERFACE.

CLASS arquivo_texto DEFINITION.
  PUBLIC SECTION.
    INTERFACES leitura_dados.
ENDCLASS.

CLASS arquivo_texto IMPLEMENTATION.
  METHOD: leitura_dados~getdata.
    WRITE 'coletando dados do arquivo de texto'.
  ENDMETHOD.
ENDCLASS.

CLASS arquivo_pdf DEFINITION.
  PUBLIC SECTION.
    INTERFACES leitura_dados.
ENDCLASS.

CLASS arquivo_pdf IMPLEMENTATION.
  METHOD leitura_dados~getdata.
    WRITE 'coletando dados do arquivo PDF'.
  ENDMETHOD.
ENDCLASS.

CLASS impressao_texto DEFINITION.
  PUBLIC SECTION.
    INTERFACES impressao.
ENDCLASS.

CLASS impressao_texto IMPLEMENTATION.
  METHOD impressao~printdata.
    WRITE 'imprimindo dados do arquivo de texto'.
  ENDMETHOD.
ENDCLASS.

CLASS impressao_pdf DEFINITION.
  PUBLIC SECTION.
    INTERFACES impressao.
ENDCLASS.

CLASS impressao_pdf IMPLEMENTATION.
  METHOD impressao~printdata.
    WRITE 'imprimindo dados do arquivo PDF'.
  ENDMETHOD.
ENDCLASS.

CLASS relatorio_texto DEFINITION.
  PUBLIC SECTION.
    INTERFACES relatorio.
ENDCLASS.

CLASS relatorio_texto IMPLEMENTATION.
  METHOD relatorio~getdata.
    DATA(arquivo) = NEW arquivo_texto( ).
    arquivo->leitura_dados~getdata( ).
  ENDMETHOD.

  METHOD relatorio~printdata.
    DATA(impressao) = NEW impressao_texto( ).
    impressao->impressao~printdata( ).
  ENDMETHOD.
ENDCLASS.

CLASS relatorio_pdf DEFINITION.
  PUBLIC SECTION.
    INTERFACES relatorio.
ENDCLASS.

CLASS relatorio_pdf IMPLEMENTATION.
  METHOD relatorio~getdata.
    DATA(arquivo) = NEW arquivo_pdf( ).
    arquivo->leitura_dados~getdata( ).
  ENDMETHOD.
  METHOD relatorio~printdata.
    DATA(impressao) = NEW impressao_pdf( ).
    impressao->impressao~printdata( ).
  ENDMETHOD.
ENDCLASS.

CLASS run DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
ENDCLASS.

CLASS run IMPLEMENTATION.
  METHOD run.
    DATA relatorio TYPE REF TO relatorio.
    relatorio = NEW relatorio_pdf( ).
    relatorio->getdata( ).
    relatorio->printdata( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  run=>run( ).