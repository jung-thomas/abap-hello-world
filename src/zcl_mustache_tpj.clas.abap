class ZCL_MUSTACHE_TPJ definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
    types: begin of challengeWeek,
            weekNumber type i,
            description type string,
           end of challengeWeek.
    types challengeWeeks type standard table of challengeWeek with default key.

    types: begin of challenge,
            month type string,
            description type string,
            weeks type challengeWeeks,
           end of challenge.
ENDCLASS.



CLASS ZCL_MUSTACHE_TPJ IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
    response->set_content_type( `text/html` ).
    data devChallenges type STANDARD TABLE OF challenge with DEFAULT KEY.

    append initial line to devChallenges REFERENCE INTO data(challenge).
    challenge->month = 'April'.
    challenge->description = 'You Think You Know SAP Build? Take Our Challenge'.
    challenge->weeks = value challengeWeeks(
        ( weeknumber = 1 description = 'SAP Build Apps: Formulas')
        ( weeknumber = 2 description = 'SAP Build Apps: UI Design')
        ( weeknumber = 3 description = 'SAP Build Process Automation: Automation Bots')
        ( weeknumber = 4 description = 'SAP Build Apps: OData')
        ( weeknumber = 5 description = 'SAP Build Process Automation: Business Process')
    ).

    append initial line to devChallenges REFERENCE INTO challenge.
    challenge->month = 'May'.
    challenge->description = 'SAP Developer Code Challenge – Open Source ABAP!'.
    challenge->weeks = value challengeWeeks(
        ( weeknumber = 1 description = 'ABAPGit')
        ( weeknumber = 2 description = 'ABAP2UI5')
        ( weeknumber = 3 description = 'ABAP Mustache')
    ).

    try.
    data(mustache) = zcl_mustache=>create(
        '{{month}}: {{ description }}' &&
        '<table>{{#weeks}}' &&
        '  <tr><td>{{weeknumber}}</td><td>{{description}}</td>' &&
        '{{/weeks}}</table></br>'
    ).

    data(output) = |The SAP Developer Challenges</br></br>| && mustache->render( devChallenges ).
    response->set_text( output ).
    catch zcx_mustache_error into data(error).
        response->set_status( 500 ).
        response->set_text( error->get_text(  ) ).
    endtry.
  endmethod.
ENDCLASS.
