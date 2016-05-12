

CREATE TABLE CATEGORIAS
  (
    ID_CAT INTEGER NOT NULL CONSTRAINT CAT_ID_PK  PRIMARY KEY , 
    TITULO VARCHAR2 (50) NOT NULL
  ) ;



CREATE TABLE PREGUNTAS
  (
    ID_PREG          INTEGER NOT NULL CONSTRAINT PREG_ID_PK PRIMARY KEY ,
    ENUNCIADO        VARCHAR2 (100) NOT NULL ,
    CATEGORIA_ID_CAT INTEGER NOT NULL,
    CONSTRAINT PREGUNTAS_CATEGORIA_FK FOREIGN KEY ( CATEGORIA_ID_CAT )REFERENCES CATEGORIA ( ID_CAT ) ON
    DELETE CASCADE 
  ) ;



CREATE TABLE RESPUESTAS
  (
    ID_RESP          INTEGER NOT NULL CONSTRAINT RESP_ID_PK PRIMARY KEY ,
    RESPUESTA        VARCHAR2 (250) NOT NULL ,
    ACERTADA         CHAR (1) NOT NULL ,
    PREGUNTA_ID_PREG INTEGER NOT NULL, 
    CONSTRAINT RESPUESTAS_PREGUNTA_FK FOREIGN KEY ( PREGUNTA_ID_PREG ) REFERENCES PREGUNTA ( ID_PREG ) ON
    DELETE CASCADE
  ) ;



CREATE OR REPLACE PROCEDURE INSERT_CATEGORIA (
   V_TITULO CATEGORIAS.TITULO%TYPE)
 AS
    V_ULTIMA_CAT CATEGORIAS.ID_CAT%TYPE;
    v__dep depart.DNOMBRE%TYPE;
    E_TITULO_REPETIDO EXCEPTION;
      
    BEGIN
      SELECT dnombre INTO v_nom_dep FROM depart
        WHERE upper(dnombre) = UPPER(p_nom_dep);
     if v_nom_dep is not null then
      RAISE e_nombre_repetido; 
    end if;
      
    EXCEPTION
    when no_data_found then
        SELECT MAX(DEPT_NO) INTO v_ultimo_dep FROM DEPART;
       -- Calcular el número de departamento e insertar 
             
        IF v_ultimo_dep IS NULL THEN
            --Si la tabla departamento esta vacia, es decir, no hay ningun departamento
            INSERT INTO DEPART VALUES (10,upper(p_nom_dep),upper(p_loc));
        ELSE
            INSERT INTO DEPART VALUES (v_ultimo_dep +10, p_nom_dep,p_loc);
        END IF;
     
     WHEN e_nombre_repetido THEN
       DBMS_OUTPUT.PUT_LINE('ya existe un departamento con ese nombre');
       
      WHEN others THEN
       DBMS_OUTPUT.PUT_LINE('operacion incorrecta'); 
    
    END insert_depart;      
  
  




