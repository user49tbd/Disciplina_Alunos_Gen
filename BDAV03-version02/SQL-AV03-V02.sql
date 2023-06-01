USE MASTER
CREATE 
--DROP
DATABASE DBAV03
GO
USE DBAV03
GO
CREATE TABLE ALUNO(
RA		INT	IDENTITY(1,1)		NOT NULL,
NOME	VARCHAR(78)				NOT NULL
PRIMARY KEY (RA)
)
GO
CREATE TABLE DISCIPLINA(
CODIGO		INT			NOT NULL,
NOME		VARCHAR(75)	NOT NULL,
SIGLA		VARCHAR(05)	NULL,
TURNO		VARCHAR(10)	NOT NULL,
NUM_AULAS	INT			NOT NULL
PRIMARY KEY (CODIGO)
)
GO
CREATE TABLE FALTAS(
RA_ALUNO			INT			NOT NULL,
CODIGO_DISCIPLINA	INT			NOT NULL,
DATA				DATE		NOT NULL,
PRESENCA			INT			NOT NULL
PRIMARY KEY (RA_ALUNO,CODIGO_DISCIPLINA,DATA)
FOREIGN KEY (RA_ALUNO) REFERENCES ALUNO(RA),
FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO)
)
GO
CREATE TABLE AVALIACAO(
CODIGO	INT				NOT NULL,
TIPO	VARCHAR(50)		NOT NULL
PRIMARY KEY (CODIGO)
)
GO
CREATE TABLE NOTAS(
RA_ALUNO			INT		NOT NULL,
CODIGO_DISCIPLINA	INT		NOT NULL,
CODIGO_AVALIACAO	INT		NOT NULL,
NOTA				DECIMAL(6,4)		NULL
PRIMARY KEY (RA_ALUNO,CODIGO_DISCIPLINA,CODIGO_AVALIACAO)
FOREIGN KEY (RA_ALUNO) REFERENCES ALUNO(RA),
FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO),
FOREIGN KEY (CODIGO_AVALIACAO) REFERENCES AVALIACAO(CODIGO)
)
GO
CREATE TABLE TBDISCAV(
CODIGO_DISCIPLINA	INT		NOT NULL,
CODIGO_AVALIACAO	INT		NOT NULL
PRIMARY KEY (CODIGO_DISCIPLINA,CODIGO_AVALIACAO)
FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO),
FOREIGN KEY (CODIGO_AVALIACAO) REFERENCES AVALIACAO(CODIGO)
)
GO
INSERT INTO DISCIPLINA 
VALUES
(4203010,'Arquitetura e Organizacao de Computadores ','AOC','T',4),
(4203020,'Arquitetura e Organizacao de Computadores ','AOC','N',4),
(4208010 ,'Laboratorio de Hardware','LABH','T',2),
(4226004 ,'Banco de Dados','BD','T',4),
(4213003 ,'Sistemas Operacionais I','SO1','T',4),
(4213013 ,'Sistemas Operacionais I','SO1','N',4),
(4233005 ,'Laboratorio de Banco de Dados','LABBD','T',4),
(5005220 ,'Metodos Para a Producao do Conhecimento','COMEX','T',4)
GO
INSERT INTO AVALIACAO
VALUES
(1,'A1-0.3*A2-0.5*A3-0.2*'),
(2,'A1-0.35*A2-0.35*A3-0.3*'),
(3,'A1-0.333*A2-0.333*A3-0.333*'),
(4,'A1-0.2*A2-0.8*')
GO
--DELETE FROM TBDISCAV 
--DELETE FROM AVALIACAO
INSERT INTO TBDISCAV 
VALUES
(4203010,1),
(4203020,1),
(4208010,1),
(4226004,1),
(4213003,2),
(4213013,2),
(4233005,3),
(5005220,4)
GO
CREATE TABLE NOMEP(
NOMEP VARCHAR(30)
PRIMARY KEY (NOMEP)
)
GO
INSERT INTO NOMEP
VALUES
('Miguel'),
('Arthur'),
('Gael'),
('Th�o'),
('Heitor'),
('Ravi'),
('Davi'),
('Bernardo'),
('Noah'),
('Gabriel'),
('Helena'),
('Alice'),
('Laura'),
('Maria Alice'),
('Sophia'),
('Manuela'),
('Mait�'),
('Liz'),
('Cec�lia'),
('Isabella')
GO
CREATE TABLE NOMES(
NOME	VARCHAR(20)
PRIMARY KEY (NOME)
)
GO
INSERT INTO NOMES
VALUES
('Silva'),
('Rodrigues'),
('Fernandes'),
('Gon�alves'),
('Santos'),
('Pereira'),
('Costa'),
('Ferreira'),
('Gomes'),
('Martins'),
('Sousa'),
('Dias'),
('Oliveira'),
('Lopes'),
('Freitas'),
('Francisco'),
('Nunes'),
('Ribeiro'),
('Almeida'),
('Mendes') 
GO
CREATE TABLE DIADISCIPLINA(
CODIGO_DISCIPLINA		INT			NOT NULL,
DIA						INT			NOT NULL
PRIMARY KEY (CODIGO_DISCIPLINA,DIA)
FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO)
)
GO
CREATE TABLE MATRICULA(
RA_ALUNO			INT	NOT NULL,
CODIGO_DISCIPLINA	INT	NOT NULL,
ALUNO_STATUS		VARCHAR(01) NOT NULL,
NOTA1	DECIMAL(6,4) NULL,
NOTA2	DECIMAL(6,4) NULL,
NOTA3	DECIMAL(6,4) NULL,
EXAME	DECIMAL(6,4) NULL
PRIMARY KEY (RA_ALUNO,CODIGO_DISCIPLINA)
FOREIGN KEY (RA_ALUNO) REFERENCES ALUNO(RA),
FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO),
)
GO
CREATE 
--DROP
PROCEDURE GETN
AS
BEGIN
	DELETE FROM MATRICULA
	DELETE FROM FALTAS
	DELETE FROM NOTAS
	DELETE FROM ALUNO
	DECLARE @VAL1 INT,
			@NAM VARCHAR(50),
			@I INT,
			@TOT INT,
			@TOTA INT,
			@I2 INT,
			@FN VARCHAR(255)
	SET @I2 = 0
	SET @TOTA = (RAND()*5)+10
	DELETE FROM ALUNO
	----------------------------------------------------------THISLINE
	IF EXISTS (SELECT * FROM sys.identity_columns WHERE OBJECT_NAME(OBJECT_ID) = 'ALUNO' AND last_value IS NOT NULL)
	BEGIN
		DBCC CHECKIDENT ('ALUNO',RESEED,0)
	END
	ELSE
	BEGIN
		DBCC CHECKIDENT ('ALUNO',RESEED,1)
	END
	--SELECT * FROM ALUNO
	WHILE(@I2 < @TOTA)
	BEGIN


	SET @I = 0
	SET @VAL1 = (RAND()*(RAND()*((SELECT COUNT(NP.NOMEP) FROM NOMEP NP)-1))+1)+1
	SET @NAM = (SELECT NM FROM (SELECT ROW_NUMBER() OVER(ORDER BY NP.NOMEP ASC) AS RN, NP.NOMEP AS NM FROM NOMEP NP) AS VL
	WHERE RN = @VAL1)
	SET @FN = @NAM
	SET @TOT = (RAND()*3)+1
	--PRINT @TOT
	WHILE(@I < @TOT)
	BEGIN
		SET @VAL1 = (RAND()*((SELECT COUNT(N.NOME) FROM NOMES N)-1))+1
		SET @NAM = (SELECT NM FROM (SELECT ROW_NUMBER() OVER(ORDER BY N.NOME ASC) AS RN, N.NOME AS NM FROM NOMES N) AS VL
		WHERE RN = @VAL1)
		--PRINT @NAM
		IF(@FN NOT LIKE '%'+@NAM+'%')
		BEGIN
			--PRINT 'INSIDE'
			SET @FN = @FN + ' ' 
			SET @FN = CONCAT(@FN,@NAM)
			SET @I = @I + 1
		END
	END
	INSERT INTO ALUNO (NOME) VALUES
	(@FN)
	SET @FN = ''
	SET @I2 = @I2 + 1
	END
END
GO
CREATE 
--DROP
PROCEDURE GENDISCDIA
AS
BEGIN
	DELETE FROM DIADISCIPLINA
	DECLARE @QTDDISC INT,
			@RNDVAL	INT,
			@RNDDIA INT,
			@DISCOD INT,
			@DISCH  INT,
			@DISCP	VARCHAR(01),
			@INDISC INT,
			@I INT,
			@IDIA INT
	SET @I = 0
	SET @QTDDISC = (SELECT COUNT(D.CODIGO) FROM DISCIPLINA D)-1
	
	WHILE (@I <= @QTDDISC)
	BEGIN
		--PRINT 'RANDING'
		SET @RNDVAL = ROUND((RAND()*@QTDDISC)+1,0)
		--SELECT ROUND((RAND()*7)+1,0)
		PRINT @RNDVAL
		SET @DISCOD = (SELECT COD FROM (SELECT ROW_NUMBER() OVER(ORDER BY DI.CODIGO ASC) AS RN, DI.CODIGO AS COD FROM DISCIPLINA DI) AS VL
		WHERE RN = @RNDVAL)
		IF((SELECT DD.CODIGO_DISCIPLINA FROM DIADISCIPLINA DD WHERE DD.CODIGO_DISCIPLINA = @DISCOD) IS NULL)
		BEGIN
			--PRINT 'FOUND'
			SET @I = @I + 1
			--PRINT @I
			SET @IDIA = 0
			SET @DISCP = (SELECT DIS.TURNO FROM DISCIPLINA DIS WHERE DIS.CODIGO = @DISCOD)
			SET @DISCH = (SELECT DIS.NUM_AULAS FROM DISCIPLINA DIS WHERE DIS.CODIGO = @DISCOD)
			WHILE(@IDIA < 1)
			BEGIN
				--PRINT 'FOUN2'
				--SET @IDIA = @IDIA + 1

				SET @RNDDIA = ROUND((RAND()*4)+2,0)
			
				SET @INDISC = (SELECT DIS.CODIGO FROM DIADISCIPLINA DIA INNER JOIN DISCIPLINA DIS 
				ON DIS.CODIGO = DIA.CODIGO_DISCIPLINA
				WHERE DIA.DIA = @RNDDIA AND DIS.TURNO = @DISCP AND DIS.NUM_AULAS = @DISCH)
				IF(@INDISC IS NULL)
				BEGIN
					SET @IDIA = @IDIA + 1
					INSERT INTO DIADISCIPLINA VALUES (@DISCOD,@RNDDIA)
				END
			END
			--SET @RNDDIA = (RAND()*4)+2 

		END
		
	END
END
GO
CREATE 
--DROP
---------------------------------------------------------------------------------------------------------------------------
PROCEDURE MATRICULAR
AS
BEGIN
	DELETE FROM MATRICULA
	DECLARE @RNDNUMDISC INT,
			@RNDDISC INT ,
			@CODMAT VARCHAR(75),
			@ISRMAT INT,
			@VCODMAT INT,
			@TOTA INT,
			@IA INT,
			@I INT
	SET @IA = 1
	SET @TOTA = (SELECT TOP 1 AL.RA FROM ALUNO AL ORDER BY AL.RA DESC)
	WHILE(@IA <= @TOTA)
	BEGIN
		SET @RNDNUMDISC = (ROUND((RAND()*5)+1,0))
		SET @I = 0
		WHILE(@I <  @RNDNUMDISC)
		BEGIN
			SET @RNDDISC = (ROUND((RAND()*7)+1,0))
			SET @CODMAT = (SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY D.CODIGO ASC) 
			AS RN, D.NOME AS NAM FROM DISCIPLINA D) AS VL
			WHERE RN = @RNDDISC)
			SET @ISRMAT = (SELECT NM FROM (SELECT ROW_NUMBER() OVER(ORDER BY D.CODIGO ASC) 
			AS RN, D.CODIGO AS NM FROM DISCIPLINA D) AS VL
			WHERE RN = @RNDDISC)

			SET @VCODMAT= (SELECT M.CODIGO_DISCIPLINA FROM MATRICULA M 
			INNER JOIN DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA
			WHERE M.RA_ALUNO = @IA AND D.NOME = @CODMAT)
			
			PRINT @IA
			PRINT @CODMAT
			
			IF(@VCODMAT IS NULL)
			BEGIN
				SET @I = @I + 1
				------------------------------------------------------------------------*
				INSERT INTO MATRICULA VALUES (@IA,@ISRMAT,'V',NULL,NULL,NULL,NULL)
			END
		END
		SET @IA = @IA + 1
	END
END
GO
--------------------------------------
CREATE 
--DROP
PROCEDURE ISR_X1
@RA INT,
@DISC INT,
@RVAL VARCHAR(30),
@VAL VARCHAR(30) OUTPUT
AS
BEGIN
	DECLARE @TT TABLE(RES VARCHAR(500))
	DECLARE  @SQL VARCHAR(500)

		SET @SQL = ('SELECT '+@RVAL+' AS PRESENCA
		FROM MATRICULA M INNER JOIN NOTAS N 
		ON N.CODIGO_DISCIPLINA = M.CODIGO_DISCIPLINA AND N.RA_ALUNO = M.RA_ALUNO 
		INNER JOIN FALTAS F ON F.RA_ALUNO = M.RA_ALUNO 
		AND F.CODIGO_DISCIPLINA = M.CODIGO_DISCIPLINA
		INNER JOIN DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA
		WHERE M.RA_ALUNO = '+CAST(@RA AS VARCHAR(10))+' AND D.CODIGO = '+CAST(@DISC AS VARCHAR(20))+'
		GROUP BY M.RA_ALUNO,M.CODIGO_DISCIPLINA,M.ALUNO_STATUS,N.NOTA,D.NUM_AULAS')
	INSERT INTO @TT(RES) EXEC (@SQL)
	SET @VAL = (SELECT RES FROM @TT)
END
--EXEC ISR_X 2,4203010
--SELECT * FROM DISCIPLINA D WHERE D.TURNO = 'T' AND D.NOME LIKE '%gani%'
--
GO
CREATE 
--DROP
PROCEDURE ISR_X
@RA INT,
@DISC INT
AS
BEGIN
	--SELECT * FROM MATRICULA M WHERE M.RA_ALUNO = 2
	--SELECT M.ALUNO_STATUS FROM MATRICULA M WHERE M.RA_ALUNO = 2
	DECLARE @DIAF VARCHAR(01),
			@GETPOR INT,
			@NOTF VARCHAR(01),
			@TVL DECIMAL(6,4),
			@VAL VARCHAR(30),
			@EXM DECIMAL(6,4),
			@NL  INT,
			@NT	INT
	SET @DIAF = 'V'
	SET @NOTF = 'V'
	--@EXM
	SET @NL = (SELECT D.NUM_AULAS FROM DISCIPLINA D WHERE D.CODIGO = @DISC)
	SET @GETPOR = (@NL*10)/2
	
	PRINT(@GETPOR)
	---------------------------------------------
	--PRINT '20 OR 10'
	--PRINT @GETPOR
	EXEC ISR_X1 @RA,@DISC,'SUM(F.PRESENCA)',@VAL OUTPUT
	SET @NT = CAST(@VAL AS INT)
	IF(@NT > @GETPOR
	)
	BEGIN
		--PRINT 'X'
		SET @DIAF = 'X'
	END
	--PRINT @NT
	EXEC ISR_X1 @RA,@DISC,'N.NOTA',@VAL OUTPUT
	SET @TVL = CAST(@VAL AS DECIMAL(6,4))
	PRINT 'VALOR'
	PRINT @TVL
	IF(@TVL < 6)
	BEGIN
		PRINT 'ENTROOOOOO'
		--PRINT 'X'
		SET @NOTF = 'X'
		SET @EXM = (SELECT M.EXAME FROM MATRICULA M WHERE M.RA_ALUNO = @RA AND M.CODIGO_DISCIPLINA = @DISC)
		IF(@EXM IS NULL AND @TVL > 4)
		BEGIN
			SET @NOTF = 'E'
		END
		IF(@EXM IS NULL AND @TVL IS NULL)
		BEGIN
			SET @NOTF = 'C'
		END
	END
	--PRINT @TVL
	IF(@DIAF = 'X' OR @NOTF = 'X')
	BEGIN
		UPDATE MATRICULA 
		SET ALUNO_STATUS = 'X'
		WHERE MATRICULA.CODIGO_DISCIPLINA = @DISC AND MATRICULA.RA_ALUNO = @RA
	END
	IF(@DIAF = 'V' AND @NOTF = 'E')
	BEGIN
		UPDATE MATRICULA 
		SET ALUNO_STATUS = 'E'
		WHERE MATRICULA.CODIGO_DISCIPLINA = @DISC AND MATRICULA.RA_ALUNO = @RA
	END
	IF(@DIAF = 'V' AND @NOTF = 'C')
	BEGIN
		UPDATE MATRICULA 
		SET ALUNO_STATUS = 'C'
		WHERE MATRICULA.CODIGO_DISCIPLINA = @DISC AND MATRICULA.RA_ALUNO = @RA
	END
	IF(@DIAF = 'V' AND @NOTF = 'V')
	BEGIN
		UPDATE MATRICULA 
		SET ALUNO_STATUS = 'V'
		WHERE MATRICULA.CODIGO_DISCIPLINA = @DISC AND MATRICULA.RA_ALUNO = @RA
	END
	PRINT('DIA')
	PRINT(@DIAF)
	PRINT('NOTA')
	PRINT(@NOTF)
END
GO
CREATE 
--DROP
PROCEDURE AUTOINSERF
AS
BEGIN
	DELETE FROM FALTAS
	DECLARE @TOT INT,
			@DISCOD INT,
			@TOTMAT INT,
			--@TOTAULA INT,
			@DIADISC DATE,
			@FREQ	 INT,
			@RA INT,
			@I	 INT,
			@I2	 INT,
			@I3	 INT
	SET @TOT = (SELECT COUNT(D.CODIGO) FROM DISCIPLINA D)
	SET @I = 1
	WHILE (@I <= @TOT )
	BEGIN
		SET @DISCOD = (SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY D.CODIGO ASC) 
		AS RN, D.CODIGO AS NAM FROM DISCIPLINA D) AS VL WHERE RN = @I)
		SET @TOTMAT = (SELECT COUNT(M.RA_ALUNO) FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = @DISCOD)
		SET @I2 = 1
		--SET @TOTAULA = (SELECT D.NUM_AULAS FROM DISCIPLINA D WHERE D.CODIGO = @DISCOD)*20

		SET @DIADISC = GETDATE()
		WHILE (DATEPART(WEEKDAY,@DIADISC) NOT LIKE (SELECT DD.DIA FROM DIADISCIPLINA DD WHERE DD.CODIGO_DISCIPLINA = @DISCOD))
		BEGIN
			SET @DIADISC = DATEADD(DAY,1,@DIADISC)
		END
		WHILE (@I2 <= 20)
		BEGIN
			SET @I3 = 1
			WHILE(@I3 <= @TOTMAT)
			BEGIN
				SET @RA = (SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY M.RA_ALUNO ASC) 
				AS RN, M.RA_ALUNO AS NAM FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = @DISCOD) AS VL 
				WHERE RN = @I3)

				IF((SELECT D.NUM_AULAS FROM DISCIPLINA D WHERE D.CODIGO = @DISCOD) = 4)
				BEGIN
					SET @FREQ = (ROUND((RAND()*2),0))
				END
				ELSE
				BEGIN
					SET @FREQ = (ROUND((RAND()*1),0))
				END

				INSERT INTO FALTAS VALUES (@RA,@DISCOD,@DIADISC,@FREQ)
				EXEC ISR_X @RA,@DISCOD
				SET @I3 = @I3 + 1
			END
			PRINT 'I - '+CAST(@I2 AS VARCHAR(20))
			PRINT 'DIA - '+CAST(@DIADISC AS VARCHAR(20))
			SET @I2 = @I2 + 1
			SET @DIADISC = DATEADD(DAY,7,@DIADISC)
		END

		SET @I = @I + 1
	END
	
END
GO
CREATE
--DROP
FUNCTION CALCNT (@P1 DECIMAL(6,4),@P2 DECIMAL(6,4),@P3 DECIMAL(6,4),@TP INT)
RETURNS DECIMAL(6,4)
AS
BEGIN
	DECLARE @NT DECIMAL(6,4),
			@NT2 DECIMAL(6,4),
			@FSS INT,
			@SST VARCHAR(50),
			@PSST VARCHAR(50),
			@TOTI INT,
			@I	INT
	SET @NT = 0
	SET @I = 0
	SET @PSST = (SELECT AV.TIPO FROM AVALIACAO AV WHERE AV.CODIGO = @TP)
	SET @TOTI = (SELECT LEN(@PSST)-LEN(REPLACE(@PSST,'*','')))
	WHILE(@I < @TOTI)
	BEGIN
		SET @FSS = (SELECT CHARINDEX('*',@PSST))-1
		--PRINT @PSST
		SET @SST = (SELECT SUBSTRING(@PSST,CHARINDEX('A',@PSST),@FSS))
		--PRINT @SST
		SET @SST = (SELECT SUBSTRING(@SST,CHARINDEX('-',@SST)+1,10))
		--PRINT @SST
		SET @PSST =  SUBSTRING(@PSST,(SELECT CHARINDEX('*',@PSST))+1,LEN(@PSST)) 
		SET @NT2 = (
		SELECT 
		CASE
			WHEN @I = 0 THEN (CAST(@SST AS DECIMAL(6,4))*@P1)/10
			WHEN @I = 1 THEN (CAST(@SST AS DECIMAL(6,4))*@P2)/10
			WHEN @I = 2 THEN (CAST(@SST AS DECIMAL(6,4))*@P3)/10
		END )
		SET @NT = @NT + @NT2
		SET @I = @I + 1
		--PRINT @I
		--PRINT @NT2
		--PRINT @NT
	END
	SET @NT = ROUND(@NT*10,1)
	--PRINT @NT
	RETURN @NT
END
GO
CREATE 
--DROP
PROCEDURE NTGEN
AS
BEGIN
	UPDATE MATRICULA
	SET NOTA1 = NULL, NOTA2 = NULL, NOTA3 = NULL, EXAME = NULL
	DELETE FROM NOTAS
	DECLARE @TOT INT,
			@NOTA DECIMAL(6,4),
			@DISCOD INT,
			@TOTALU INT,
			@TPAV INT,
			@RA INT,
			@I INT,
			@I2 INT,
			@P1 DECIMAL(6,4),
			@P2 DECIMAL(6,4),
			@P3 DECIMAL(6,4)
	SET @NOTA = 0
	SET @I = 1
	SET @TOT = (SELECT COUNT(D.CODIGO) FROM DISCIPLINA D)
	WHILE(@I <= @TOT)
	BEGIN
		SET @DISCOD = (SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY D.CODIGO ASC) 
		AS RN, D.CODIGO AS NAM FROM DISCIPLINA D) AS VL WHERE RN = @I)
		SET @TOTALU = (SELECT COUNT(M.RA_ALUNO) FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = @DISCOD)
		SET @I2 = 1
		SET @TPAV = (SELECT TD.CODIGO_AVALIACAO FROM TBDISCAV TD WHERE TD.CODIGO_DISCIPLINA = @DISCOD)
		WHILE(@I2 <= @TOTALU)
		BEGIN
			SET @RA = (SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY M.RA_ALUNO ASC) 
			AS RN, M.RA_ALUNO AS NAM FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = @DISCOD) AS VL 
			WHERE RN = @I2)

			SET @P1 = (RAND()*10)
			SET @P2 = (RAND()*10)
			SET @P3 = (RAND()*10)
			IF(@DISCOD = 5005220)
			BEGIN
				--PRINT 'E UM NOTA TIPO 4'
				--PRINT @TPAV
				SET @P3 = NULL
			END
			SET @NOTA = (SELECT dbo.CALCNT (@P1,@P2,@P3,@TPAV))
			--PRINT 'A QUI A NOTA'
			--PRINT @NOTA
			UPDATE MATRICULA
			SET MATRICULA.NOTA1 = @P1, MATRICULA.NOTA2 = @P2, MATRICULA.NOTA3 = @P3
			WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @DISCOD
			--IF(@DISCOD IN (SELECT DISTINCT D.CODIGO FROM DISCIPLINA D WHERE D.NOME LIKE '%Sistemas Operacionais I%'))
			--BEGIN
				--PRINT 'COMECA A VERIFICAR SE ESTA ENTRE 3 E 6'
				IF(@NOTA BETWEEN 4 AND 5.9999)
				BEGIN
					--PRINT @DISCOD
					--PRINT('THIS ONE')
					--PRINT @NOTA
					SET @P1 = (RAND()*10)
					SET @P1 = (@P1*0.2)/10
					SET @P1 = @P1 * 10
					UPDATE MATRICULA
					SET MATRICULA.EXAME = @P1
					WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @DISCOD
					--PRINT @P1
					SET @NOTA = @NOTA + @P1
					--PRINT @NOTA
				END
			--END
			INSERT INTO NOTAS
			VALUES
			(@RA,@DISCOD,@TPAV,@NOTA)
			EXEC ISR_X @RA,@DISCOD
			SET @I2 = @I2 + 1
		END
		SET @I = @I + 1
	END
END
GO
CREATE 
--DROP
PROCEDURE ISR_NOTA 
@P1 DECIMAL(6,4),
@P2 DECIMAL(6,4),
@P3 DECIMAL(6,4),
@RA INT,
@DISC VARCHAR(75)
AS
BEGIN
	DECLARE @DISCICOD INT,
			@TIPO INT,
			@FNOTA DECIMAL(6,4)
	SET @FNOTA = 0
	SET @DISCICOD = (SELECT D.CODIGO FROM MATRICULA M INNER JOIN DISCIPLINA D 
	ON M.CODIGO_DISCIPLINA = D.CODIGO INNER JOIN ALUNO AL
	ON AL.RA = M.RA_ALUNO WHERE AL.RA = @RA AND D.NOME = @DISC)

	SET @TIPO = (SELECT T.CODIGO_AVALIACAO FROM TBDISCAV T WHERE T.CODIGO_DISCIPLINA = @DISCICOD)

	SET @FNOTA = (SELECT dbo.CALCNT (@P1,@P2,@P3,@TIPO))
	IF(@TIPO = 4)
	BEGIN
		SET @P3 = NULL
	END
	UPDATE MATRICULA
	SET MATRICULA.NOTA1 = @P1, MATRICULA.NOTA2 = @P2, MATRICULA.NOTA3 = @P3
	WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @DISCICOD
	--IF(@FNOTA >=6)
	--BEGIN
	UPDATE MATRICULA
	SET MATRICULA.EXAME = NULL
	WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @DISCICOD
	--END
	UPDATE NOTAS
	SET NOTA = @FNOTA
	WHERE NOTAS.RA_ALUNO = @RA AND NOTAS.CODIGO_DISCIPLINA = @DISCICOD
	EXEC ISR_X @RA,@DISCICOD
END
GO
CREATE 
--DROP
PROCEDURE ISR_EXAME
@RA INT,
@DISC VARCHAR(75),
@NT2 DECIMAL(6,4)
AS
BEGIN
	DECLARE @DISCICOD INT,
			@NT1 DECIMAL(6,4)
	SET @DISCICOD = (SELECT D.CODIGO FROM MATRICULA M INNER JOIN DISCIPLINA D 
	ON M.CODIGO_DISCIPLINA = D.CODIGO INNER JOIN ALUNO AL
	ON AL.RA = M.RA_ALUNO WHERE AL.RA = @RA AND D.NOME = @DISC)
	SET @NT1 = (SELECT N.NOTA FROM NOTAS N WHERE N.CODIGO_DISCIPLINA = @DISCICOD AND N.RA_ALUNO = @RA)
	SET @NT2 = (@NT2*0.2)
	PRINT 'NOTA FIM'
	PRINT @NT1
	PRINT 'EXAME VAL'
	PRINT @NT2
	UPDATE NOTAS
	SET NOTA = @NT1 + @NT2
	WHERE NOTAS.RA_ALUNO = @RA AND NOTAS.CODIGO_DISCIPLINA = @DISCICOD
	--SET @NT2 = @NT2*10
	PRINT 'EXAME VAL STORED'
	PRINT @NT2
	UPDATE MATRICULA
	SET MATRICULA.EXAME = @NT2
	WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @DISCICOD
	EXEC ISR_X @RA,@DISCICOD
END
GO
----------------------------------------------------------------------------------------------------------------------
CREATE 
--DROP
PROCEDURE ISR_FALTAS
@RA INT,
@DISC VARCHAR(75),
@DATA DATE,
@PRESENCA INT
AS
BEGIN
	DECLARE @DISCOD INT
	 
	SET @DISCOD = (SELECT F.CODIGO_DISCIPLINA FROM FALTAS F INNER JOIN DISCIPLINA D 
	ON F.CODIGO_DISCIPLINA = D.CODIGO INNER JOIN ALUNO AL
	ON AL.RA = F.RA_ALUNO WHERE AL.RA = @RA AND D.NOME = @DISC AND F.DATA = @DATA)
	UPDATE FALTAS
	SET PRESENCA = @PRESENCA
	WHERE FALTAS.CODIGO_DISCIPLINA = @DISCOD AND FALTAS.RA_ALUNO = @RA AND FALTAS.DATA = @DATA
	EXEC ISR_X @RA,@DISCOD
END
-----------------------------------------------------------------------------------------------------------------------------
GO
CREATE 
--DROP
FUNCTION EXB_FALT (@DISNOME VARCHAR(75),@TURNO VARCHAR(01),@VC VARCHAR(01))
RETURNS @TAB TABLE(
RA			INT			NOT NULL,
NOME		VARCHAR(78)	NOT NULL,
FALTAS		VARCHAR(501) NOT NULL,
TOTF		INT NOT NULL,
LMTF		INT NOT NULL,
DCOD		INT NOT NULL
)
AS
BEGIN
	DECLARE
			@RA INT,
			@DISCOD INT,
			@NOME	VARCHAR(78),
			@DATA   DATE,
			@PRESENCA INT,
			@FALTAS VARCHAR(101),
			@FDIA VARCHAR(04),
			@LENDIA INT,
			@I INT,
			@LC INT,
			@TOTF		INT,
			@LMTF INT,
			@DISCNF INT,
			@NUMA INT
	SET @LC = 1
	SET @TOTF = 0
	IF(@VC = 'V')
	BEGIN
		DECLARE c CURSOR FOR SELECT RA_ALUNO,AL.NOME,CODIGO_DISCIPLINA,DATA,PRESENCA,D.NUM_AULAS FROM FALTAS F INNER JOIN ALUNO AL ON 
		AL.RA = F.RA_ALUNO INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
		WHERE D.NOME = @DISNOME AND D.TURNO = @TURNO
	END
	ELSE
	BEGIN
		DECLARE c CURSOR FOR SELECT RA_ALUNO,AL.NOME,CODIGO_DISCIPLINA,DATA,PRESENCA,D.NUM_AULAS FROM FALTAS F INNER JOIN ALUNO AL ON 
		AL.RA = F.RA_ALUNO INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
	END
	OPEN c
	FETCH NEXT FROM c INTO @RA, @nome,@DISCOD,@DATA,@PRESENCA,@DISCNF
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(@LC <= 20)
		BEGIN
			SET @NUMA= (SELECT D.NUM_AULAS FROM DISCIPLINA D WHERE D.NOME = @DISNOME AND D.TURNO = @TURNO)
			SET @TOTF = @TOTF + @PRESENCA
			SET @FDIA = 'VVVV'
			--WHILE (@I <= @PRESENCA+1)
			--BEGIN
				SET @FDIA = SUBSTRING(@FDIA,1,4-@PRESENCA)
				--SET @I = @I + 1
			--END
			SET @LENDIA = 4-LEN(@FDIA)
			SET @I = 0
			WHILE (@I < @LENDIA)
			BEGIN
				SET @FDIA = CONCAT('F',@FDIA)
				SET @I = @I + 1
			END
			IF(@NUMA = 2)
			BEGIN
				SET @FDIA = SUBSTRING(@FDIA,1,2)
		    END
			SET @FALTAS = CONCAT(@FALTAS,@FDIA)
			SET @FALTAS = @FALTAS+' '
			SET @LC = @LC + 1
			IF(@LC > 20)
			BEGIN
				SET @FALTAS = SUBSTRING(@FALTAS,1,LEN(@FALTAS))
				SET @LMTF = (@DISCNF*10)/2
				INSERT INTO @TAB VALUES (@RA,@NOME,@FALTAS,@TOTF,@LMTF,@DISCOD)
				SET @TOTF = 0
				SET @FALTAS = ''
				SET @LC = 1
			END
		END
		FETCH NEXT FROM c INTO @RA, @nome,@DISCOD,@DATA,@PRESENCA,@DISCNF
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END
GO
CREATE 
--DROP
FUNCTION EXB_STATUSC(@DISNOME VARCHAR(75),@TURNO VARCHAR(01))
RETURNS @TAB TABLE(
RA			INT			NOT NULL,
NOME		VARCHAR(78)	NOT NULL,
NOTA1		DECIMAL(6,4) NULL,
NOTA2		DECIMAL(6,4) NULL,
NOTA3		DECIMAL(6,4) NULL,
EXAME		DECIMAL(6,4) NULL,
NOTA		DECIMAL(6,4) NULL,
SITUACAO	VARCHAR(23) NOT NULL
)
AS
BEGIN
	DECLARE
			@ALUNORA INT,
			@ALUNONOME	VARCHAR(78),
			@NOTA1 DECIMAL(6,4),
			@NOTA2 DECIMAL(6,4),
			@NOTA3 DECIMAL(6,4),
			@EXAME DECIMAL(6,4),
			@MEDIA DECIMAL(6,4),
			@SITUACAO VARCHAR(20),
			@I INT,
			@LC INT,
			@TOTF INT
	SET @LC = 1
	SET @TOTF = 0
	DECLARE c CURSOR FOR SELECT AL.RA,AL.NOME,M.NOTA1,M.NOTA2,M.NOTA3,M.EXAME,N.NOTA,
	CASE 
	WHEN(M.ALUNO_STATUS = 'X')THEN
	'REPROVADO'
	WHEN(M.ALUNO_STATUS = 'V')THEN
	'APROVADO'
	WHEN(M.ALUNO_STATUS = 'E')THEN
	'EXAME'
	WHEN(M.ALUNO_STATUS = 'C')THEN
	'EM CURSO'
	END AS SITUACAO
	FROM ALUNO AL INNER JOIN MATRICULA M ON AL.RA = M.RA_ALUNO INNER JOIN
	NOTAS N ON N.RA_ALUNO = AL.RA AND N.CODIGO_DISCIPLINA = M.CODIGO_DISCIPLINA INNER JOIN
	DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA
	--WHERE D.NOME = 'Metodos Para a Producao do Conhecimento'
	--SELECT * FROM DISCIPLINA
	WHERE D.NOME = @DISNOME AND D.TURNO = @TURNO
	OPEN c
	FETCH NEXT FROM c INTO @ALUNORA,@ALUNONOME,@NOTA1,@NOTA2,@NOTA3,@EXAME,@MEDIA,@SITUACAO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @TAB VALUES (@ALUNORA,@ALUNONOME,@NOTA1,@NOTA2,@NOTA3,@EXAME,@MEDIA,@SITUACAO)
		FETCH NEXT FROM c INTO @ALUNORA,@ALUNONOME,@NOTA1,@NOTA2,@NOTA3,@EXAME,@MEDIA,@SITUACAO
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END
GO
CREATE 
--DROP
FUNCTION ALUNODT ()
RETURNS @TAB TABLE(
	RA		INT,
	NOME	VARCHAR(78),
	DISC	VARCHAR(300)
)
AS
BEGIN
	DECLARE @RA INT,
			@NOME VARCHAR(78),
			@DISC VARCHAR(300),
			@I INT,
			@I2 INT
	DECLARE c CURSOR FOR SELECT DISTINCT AL.RA,AL.NOME FROM MATRICULA M INNER JOIN DISCIPLINA D
	ON D.CODIGO = M.CODIGO_DISCIPLINA INNER JOIN ALUNO AL
	ON M.RA_ALUNO = AL.RA
	OPEN c
	FETCH NEXT FROM c INTO @RA,@NOME
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @I = (SELECT DISTINCT COUNT(D.NOME) FROM MATRICULA M INNER JOIN DISCIPLINA D
		ON D.CODIGO = M.CODIGO_DISCIPLINA INNER JOIN ALUNO AL
		ON M.RA_ALUNO = AL.RA WHERE AL.RA = @RA )
		SET @I2 = 1
		SET @DISC = ''
		WHILE(@I2 <= @I)
		BEGIN
			SET @DISC = CONCAT(@DISC,(SELECT NAM FROM (SELECT ROW_NUMBER() OVER(ORDER BY M.CODIGO_DISCIPLINA ASC) 
			AS RN, D.NOME AS NAM FROM MATRICULA M INNER JOIN DISCIPLINA D
			ON D.CODIGO = M.CODIGO_DISCIPLINA INNER JOIN ALUNO AL
			ON M.RA_ALUNO = AL.RA WHERE AL.RA = @RA ) AS VL WHERE RN = @I2))
			SET @DISC = @DISC + '@'
			SET @I2 = @I2 + 1
		END
		INSERT INTO @TAB VALUES (@RA,@NOME,SUBSTRING(@DISC,1,LEN(@DISC)-1))
		FETCH NEXT FROM c INTO @RA,@NOME
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END 
GO
CREATE 
--DROP
FUNCTION GETT (@RA INT,@DISC VARCHAR(75))
RETURNS VARCHAR(01)
AS
BEGIN
	DECLARE @TURNO VARCHAR(01)
	SET @TURNO =  (SELECT D.TURNO FROM MATRICULA M INNER JOIN DISCIPLINA D
	ON D.CODIGO = M.CODIGO_DISCIPLINA INNER JOIN ALUNO AL ON M.RA_ALUNO = AL.RA
	WHERE AL.RA = @RA AND D.NOME=@DISC)
	RETURN @TURNO
END 
GO
CREATE 
--DROP
FUNCTION ALUNOTS ()
RETURNS @TAB TABLE(
	RA		INT,
	DISC	VARCHAR(75),
	NT1		DECIMAL(6,4),
	NT2		DECIMAL(6,4),
	NT3		DECIMAL(6,4),
	EXM		DECIMAL(6,4),
	MED		DECIMAL(6,4),
	TOTF	INT,
	SITUACAO VARCHAR(70)
)
AS
BEGIN
	DECLARE @RA		INT,
			@DISC	VARCHAR(75),
			@NT1		DECIMAL(6,4),
			@NT2		DECIMAL(6,4),
			@NT3		DECIMAL(6,4),
			@EXM		DECIMAL(6,4),
			@MED		DECIMAL(6,4),
			@TOTF	INT,
			@LMT    INT,
			@NUMAL INT,
			@SITUACAO VARCHAR(70)
			--@SITUACAON  VARCHAR(20)
	DECLARE c CURSOR FOR SELECT DISTINCT M.RA_ALUNO,D.NOME,D.NUM_AULAS,M.NOTA1,M.NOTA2,M.NOTA3,M.EXAME,N.NOTA,EXB.TOTF,EXB.LMTF
	FROM MATRICULA M INNER JOIN NOTAS N
	ON N.RA_ALUNO = M.RA_ALUNO AND M.CODIGO_DISCIPLINA = N.CODIGO_DISCIPLINA
	INNER JOIN DISCIPLINA D ON M.CODIGO_DISCIPLINA = D.CODIGO INNER JOIN EXB_FALT('','','G') EXB ON
	EXB.RA = N.RA_ALUNO AND EXB.DCOD = N.CODIGO_DISCIPLINA
	OPEN c
	FETCH NEXT FROM c INTO @RA,@DISC,@NUMAL,@NT1,@NT2,@NT3,@EXM,@MED,@TOTF,@LMT 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SITUACAO = 'EM CURSO'
		IF(@MED IS NOT NULL)
		BEGIN
			--SET @SITUACAO = 'APROVADO EM NOTA'
			SET @SITUACAO = 'APROVADO EM NOTA'
			IF(@MED >= 4 AND @MED < 6 AND @EXM IS NULL)
			BEGIN
				SET @SITUACAO = 'EXAME'
			END
		END
		/*
		IF(@TOTF > @LMT )
		BEGIN
			SET @SITUACAO = ''
			IF(@TOTF > 10)
			BEGIN
				SET @SITUACAO = 'REPROVADO POR FALTA '
			END
		END
		*/
		IF((@MED < 4) OR (@MED < 6 AND @EXM IS NOT NULL))
		BEGIN
			SET @SITUACAO = ''
			/*
			IF(@SITUACAO NOT LIKE '%REPROVADO%')
			BEGIN
				SET @SITUACAO = ''
			END
			*/
			--SET @SITUACAO = @SITUACAO + 'REPROVADO POR NOTA'
			SET @SITUACAO = @SITUACAO + 'REPROVADO POR NOTA'
		END
		INSERT INTO @TAB VALUES (@RA,@DISC,@NT1,@NT2,@NT3,@EXM,@MED,@TOTF,@SITUACAO)
		FETCH NEXT FROM c INTO @RA,@DISC,@NUMAL,@NT1,@NT2,@NT3,@EXM,@MED,@TOTF,@LMT 
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END 
GO
CREATE 
--DROP
PROCEDURE CLEARP @RA INT,@DISCN VARCHAR(75)
AS
BEGIN
	DECLARE @CODD INT
	SET @CODD = (SELECT D.CODIGO FROM DISCIPLINA D INNER JOIN MATRICULA M ON 
	D.CODIGO = M.CODIGO_DISCIPLINA WHERE M.RA_ALUNO = @RA AND D.NOME=@DISCN)
	UPDATE MATRICULA
	SET NOTA1 = NULL, NOTA2 = NULL, NOTA3 = NULL, EXAME = NULL, ALUNO_STATUS='C'
	WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @CODD
	UPDATE NOTAS
	SET NOTA = NULL
	WHERE NOTAS.RA_ALUNO = @RA AND NOTAS.CODIGO_DISCIPLINA = @CODD
END
GO
CREATE 
--DROP
PROCEDURE UPDMAT @RA INT,@DISCN VARCHAR(75),@NT1 DECIMAL(6,4),@NT2 DECIMAL(6,4),@NT3 DECIMAL(6,4)
AS
BEGIN
	DECLARE @CODD INT
	SET @CODD = (SELECT D.CODIGO FROM DISCIPLINA D INNER JOIN MATRICULA M ON 
	D.CODIGO = M.CODIGO_DISCIPLINA WHERE M.RA_ALUNO = @RA AND D.NOME=@DISCN)
	UPDATE MATRICULA
	SET NOTA1 = @NT1, NOTA2 = @NT2, NOTA3 = @NT3
	WHERE MATRICULA.RA_ALUNO = @RA AND MATRICULA.CODIGO_DISCIPLINA = @CODD

	EXEC ISR_X @RA,@CODD
END
GO
CREATE FUNCTION F_DATEC (@DISC VARCHAR(MAX),@T VARCHAR(01)) 
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @RES VARCHAR(MAX),
			@D DATE
	DECLARE c CURSOR FOR SELECT DISTINCT F.DATA FROM FALTAS F INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
	WHERE D.NOME = @DISC AND D.TURNO = @T 
	OPEN c
	FETCH NEXT FROM c INTO @D 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @RES = CONCAT(@RES,(CONVERT(VARCHAR(5),@D,103))+' | ')
		FETCH NEXT FROM c INTO @D 
	END
	CLOSE c
	DEALLOCATE c
	SET @RES = SUBSTRING(@RES,1,LEN(@RES)-2)
	RETURN @RES
END
GO
CREATE PROCEDURE INITIAL
AS
BEGIN
	EXEC GETN
	EXEC GENDISCDIA
	EXEC MATRICULAR
	EXEC AUTOINSERF
	EXEC NTGEN
END
GO
EXEC INITIAL


--------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM ALUNO
SELECT * FROM DISCIPLINA
SELECT * FROM FALTAS
SELECT * FROM NOTAS

--1 GERAR ALUNOS
EXEC GETN
SELECT * FROM ALUNO
--1-------------
--2 GERAR DISICPLINA DIAS SEMANA
EXEC GENDISCDIA
SELECT DD.DIA,D.NOME,D.NUM_AULAS,D.TURNO FROM DIADISCIPLINA DD INNER JOIN DISCIPLINA D ON D.CODIGO = DD.CODIGO_DISCIPLINA
--2-------------
--3 GERAR MATRICULAS
EXEC MATRICULAR
SELECT M.RA_ALUNO,D.NOME FROM MATRICULA M INNER JOIN DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA WHERE M.RA_ALUNO = 4
SELECT M.RA_ALUNO,M.CODIGO_DISCIPLINA,M.ALUNO_STATUS FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = 4213003
--3-------------
--4 GERAR PRESENCA
EXEC AUTOINSERF
SELECT F.RA_ALUNO,D.NOME,F.PRESENCA,F.DATA 
FROM FALTAS F INNER JOIN DISCIPLINA D 
ON D.CODIGO = F.CODIGO_DISCIPLINA WHERE D.CODIGO = 4208010 --4203010
--4-------------
--5 GERAR NOTAS
EXEC NTGEN
SELECT N.RA_ALUNO,N.NOTA FROM NOTAS N
SELECT * FROM MATRICULA
--5-------------
--6 INSERIR NOTAS
EXEC ISR_NOTA 7.5,2,0,1,'Arquitetura e Organizacao de Computadores'

EXEC ISR_EXAME 1,'Arquitetura e Organizacao de Computadores',10

SELECT * FROM MATRICULA M WHERE M.RA_ALUNO = 1 AND M.CODIGO_DISCIPLINA = 4203020
-------ALUNOS DE EXAME
SELECT M.RA_ALUNO,M.CODIGO_DISCIPLINA,D.NOME,M.ALUNO_STATUS,M.NOTA1,M.NOTA2,M.NOTA3,M.EXAME,N.NOTA
FROM MATRICULA M INNER JOIN NOTAS N ON N.RA_ALUNO = M.RA_ALUNO AND M.CODIGO_DISCIPLINA = N.CODIGO_DISCIPLINA
INNER JOIN DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA
WHERE M.EXAME IS NULL AND (N.NOTA BETWEEN 4 AND 6)
-------
SELECT M.RA_ALUNO,M.CODIGO_DISCIPLINA,M.ALUNO_STATUS,M.NOTA1,M.NOTA2,M.NOTA3,M.EXAME,N.NOTA
FROM MATRICULA M INNER JOIN NOTAS N ON N.RA_ALUNO = M.RA_ALUNO AND M.CODIGO_DISCIPLINA = N.CODIGO_DISCIPLINA 
--SELECIONAR DADOS MATRICULA
SELECT * FROM MATRICULA
--SELECIONAR ALUNO NOTAS DISCIPLINA
SELECT DISTINCT N.RA_ALUNO,AL.NOME,D.NOME,D.CODIGO,N.NOTA FROM NOTAS N INNER JOIN MATRICULA M
ON M.CODIGO_DISCIPLINA = N.CODIGO_DISCIPLINA INNER JOIN ALUNO AL
ON AL.RA = N.RA_ALUNO INNER JOIN DISCIPLINA D ON D.CODIGO = M.CODIGO_DISCIPLINA
--SELECT * FROM MATRICULA M WHERE M.RA_ALUNO = 1 
--SELECT * FROM NOTAS N WHERE N.RA_ALUNO = 1 
--6-------------
--7 INSERIR FALTAS
EXEC ISR_FALTAS 1,'Sistemas Operacionais I','2023-06-14',0
--ALUNOS COM QTD DE FALTAS EM UM DIA
SELECT * FROM FALTAS
SELECT F.RA_ALUNO,F.DATA,F.CODIGO_DISCIPLINA,D.NOME,F.PRESENCA 
FROM FALTAS F INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
WHERE F.DATA = '2023-05-17' AND D.CODIGO = 4213003
--ALUNOS NA DISCIPLINA
SELECT M.RA_ALUNO FROM MATRICULA M WHERE M.CODIGO_DISCIPLINA = 4213003
--ALUNOS COM QTD TOTAL DE FALTAS
SELECT F.RA_ALUNO,F.CODIGO_DISCIPLINA,D.NOME,SUM(F.PRESENCA) 
FROM FALTAS F INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
GROUP BY F.RA_ALUNO,F.CODIGO_DISCIPLINA,D.NOME
ORDER BY D.NOME
--7-------------
--8 NOTAS TURMA
SELECT * FROM DISCIPLINA
SELECT RA,NOME,NOTA1,NOTA2,NOTA3,EXAME,NOTA,SITUACAO FROM dbo.EXB_STATUSC('Arquitetura e Organizacao de Computadores','N')
----------------
--9 FALTAS TURMA
SELECT RA,NOME,FALTAS,TOTF,LMTF,DCOD  FROM dbo.EXB_FALT ('Laboratorio de Hardware','T','V')
SELECT * FROM FALTAS F INNER JOIN DISCIPLINA D ON D.CODIGO = F.CODIGO_DISCIPLINA
WHERE D.NOME = 'Banco de Dados' AND F.RA_ALUNO = 1
SELECT * FROM DISCIPLINA
--9-------------