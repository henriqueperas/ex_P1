CREATE DATABASE ex_campeonato_futebol
GO
USE ex_campeonato_futebol

CREATE TABLE times(
codigoTime		INT	NOT NULL,
nomeTime		VARCHAR(30)	NOT NULL,
cidade			VARCHAR(30)	NOT NULL,
estadio			VARCHAR(30)	NOT NULL,
juntosNão		BIT	NOT NULL,
PRIMARY KEY(codigoTime)
)
GO
CREATE TABLE grupos(
codigoGrupo INT NOT NULL,
codigoTimeG INT	NOT NULL,
grupo	CHAR(1)	NOT NULL	CHECK(grupo = 'A' OR grupo = 'B' OR grupo = 'C' OR grupo = 'D')
PRIMARY KEY(codigoGrupo)
FOREIGN KEY(codigoTimeG) REFERENCES times(codigoTime)
)
GO
CREATE TABLE jogos(
codigoJogo		INT	NOT NULL,
codigoTime1	INT	NOT NULL,
codigoTime2	INT	NOT NULL,
golsTime1	INT	NULL,
golsTime2	INT	NULL,
data_jogo	DATE NULL,
PRIMARY KEY(codigoJogo),
FOREIGN KEY(codigoTime1) REFERENCES times(codigoTime),
FOREIGN KEY(codigoTime2) REFERENCES times(codigoTime)
)
GO
INSERT INTO times VALUES
(1,'Botafogo-SP','Ribeirão Preto','Santa Cruz', 0),
(2,'Corinthians','São Paulo','Neo Quimica Arena', 1),
(3,'Ferroviária','Araraquara','Fonte Luminosa', 0),
(4,'Guarani','Campinas','Brinco de ouro', 0),
(5,'Inter de Limeira','Limeira','Limeirão', 0),
(6,'Ituano','Itu','Novelli Júnior', 0),
(7,'Mirassol','Mirassol','José Maria de Campos Maia', 0),
(8,'Novorizontino','Novo Horizonte','Jorge Ismael de Biasi', 0),
(9,'Palmeiras','São Paulo','Allianz Parque', 1),
(10,'Ponte Preta','Capinas','Moisés Lucarelli', 0),
(11,'Red Bull Bragantino','Bragança Paulista','Nabi Abi Chedid', 0),
(12,'Santo André','Santo André','Bruno José Daniel', 0),
(13,'Santos','Santos','Vila Belmiro', 1),
(14,'São Bento','Sorocaba','Walter Ribeiro', 0),
(15,'São Caetano','São Caetano do sul','Anacietto Campanella', 0),
(16,'São Paulo','São Paulo','Morumbi', 1)

--DIVIDE OS TIMES EM 4 GRUPOS
CREATE PROCEDURE sp_separa_grupos(@saida VARCHAR(50) OUTPUT)
	AS
		DECLARE @interLoop INT, @interJunto INT, @juntosNão INT, @escolha INT, @grupos CHAR(1), @interGrupo CHAR(4), @interG INT, @interG2 INT, @valido INT

		SET @interLoop = 1
		SET @interJunto = 1
		SET @interGrupo = 'ABCD'
		SET @interG = 1
		
		--coloca primeiro queles que não podem ficar juntos nos grupos
		WHILE (@interLoop <= 16)
		BEGIN
			--confere se ele pode ou não ser o unico do grupo
			SELECT @juntosNão = juntosNão FROM times WHERE @interLoop = codigoTime
			SET @grupos = SUBSTRING(@interGrupo,@interG,1)
			IF(@juntosNão = 1)
			BEGIN
				INSERT INTO grupos VALUES (@interJunto, @interLoop, @grupos)
				SET @interG = @interG + 1
				SET @interJunto = @interJunto + 4
			END
			SET @interLoop = @interLoop + 1
		END
		
		SET @interLoop = 1
		SET @interG = 1
		SET @interG2 = 1
		
		--coloca o restante, verificando queles que já estão, sem repetir
		WHILE (@interLoop <= 16)
		BEGIN
			IF(@interLoop = 1 OR @interLoop = 5 OR @interLoop = 9 OR @interLoop = 13)
			BEGIN
				SET @interLoop = @interLoop + 1
			END
			ELSE
			BEGIN
				SET @grupos = SUBSTRING(@interGrupo,@interG,1)
				SET @escolha = CAST(FLOOR(RAND()*(16)+1) AS INT)
				--confere se já existe um repetido
				SELECT @valido = 1 FROM grupos WHERE @escolha = codigoTimeG
				IF(@valido = 0)
				BEGIN
					INSERT INTO grupos VALUES (@interLoop, @escolha, @grupos)
					SET @interG2 = @interG2 + 1
					SET @interLoop = @interLoop + 1
				END
			END
			SET @valido = 0
			IF(@interG2 = 4)
			BEGIN
				SET @interG = @interG + 1
				SET @interG2 = 1
			END
		END
		SET @saida = 'times separados com sucesso'

DECLARE @out VARCHAR(40)
DELETE FROM grupos
EXEC sp_separa_grupos @out OUTPUT
PRINT @out

SELECT * FROM grupos
SELECT * FROM grupos ORDER BY codigoTimeG

--SEPARA O DIA QUE IRA ACONTECER AS PARTIDAS
CREATE PROCEDURE sp_separa_datas (@saida VARCHAR(40) OUTPUT)
AS
		--SEPARA OS DIAS DOS JOGOS
		DECLARE @dia DATE,@dia2 DATE, @interLoop4 INT, @interLoop5 INT, @interLoopR INT, @interLoopR2 INT, @interdia INT, @interdia2 INT, @interSeparaDia INT

		--dia que começa, domingo 23/01

		SET @dia = '2022-01-23'
		SET @dia2 = '2022-01-26' 
		SET @interLoop4 = 1
		SET @interLoopR = 1
		SET @interLoopR2 = 4
		SET @interdia = 0
		SET @interdia2 = 0

		--vai ser complicado explicar como eu fiz isso
		--no loop 1 ao 8 e 13 ao 16 é dado uma data, com 13 jogos de diferença na lista do 1 ao 8 e 9 jogos de diferença na lista do 13 ao 16
		--no resto fiz um esquema para não repetir as datas, basicamente isso
		WHILE(@interLoop4 <= 24)
		BEGIN
			IF(@interLoop4 <= 12)
			BEGIN
				--define quantos jogos vão ser pulados na lista 
				SET @interSeparaDia = 13
				--apartie de qual vai começar 
				SET @interLoop5 = @interLoop4
			END
			ELSE IF(@interLoop4 > 12 AND @interLoop4 <= 20)
			BEGIN
				SET @interSeparaDia = 9
				SET @interLoop5 = @interLoop4 + 36
			END
			ELSE IF(@interLoop4 > 20 AND @interLoop4 <= 24)
			BEGIN
				SET @interSeparaDia = 5
				SET @interLoop5 = @interLoop4 + 60
			END
			--se for impar é domingo e par quarta
			IF(@interLoop4 % 2 = 1)
			BEGIN
				WHILE(@interLoopR <= 4)
				BEGIN
					UPDATE jogos SET data_jogo = DATEADD(DAY, 7 * @interdia, @dia) WHERE @interLoop5 = codigoJogo
					IF(@interLoopR = @interLoopR2)
					BEGIN
						SET @interLoop5 = @interLoop5 + 1
					END
					ELSE
					BEGIN
						SET @interLoop5 = @interLoop5 + @interSeparaDia
					END
					SET @interLoopR = @interLoopR + 1
				END
				SET @interdia = @interdia + 1
			END
			ELSE
			BEGIN	
				WHILE(@interLoopR <= 4)
				BEGIN
					UPDATE jogos SET data_jogo = DATEADD(DAY, 7 * @interdia2, @dia2) WHERE @interLoop5 = codigoJogo
					IF(@interLoopR = @interLoopR2)
					BEGIN
						SET @interLoop5 = @interLoop5 + 1
					END
					ELSE
					BEGIN
						SET @interLoop5 = @interLoop5 + @interSeparaDia
					END
					SET @interLoopR = @interLoopR + 1
				END
				SET @interdia2 = @interdia2 + 1
			END
			-- o esquema que ue falei
			-- nem sei explicar direito como isso funciona
			-- mas ele basicamente a partir de um tanto de vezes ao inves de pular como estava pulando antes
			-- apenas passa para o proximo, isso evitar ter dois jogos na mesma data, porem esse esquema não é nada flexivel
			IF(@interLoop4 > 8 AND @interLoop4 <= 12)
			BEGIN
				SET @interLoopR2 = @interLoopR2 - 1
			END
			ELSE IF(@interLoop4 > 16)
			BEGIN
				SET @interLoopR2 = @interLoopR2 - 1
			END
			-- a partir desse ele recomeça
			IF(@interLoop4 = 13 OR @interLoop4 = 20)
			BEGIN
				SET @interLoopR2 = 4
			END
			SET @interLoopR = 1
			SET @interLoop4 = @interLoop4 + 1
		END

--CRIA PARTIDA PARA TODOS OS TIMES EM SEUS GRUPOS
CREATE PROCEDURE sp_cria_partidas (@saida VARCHAR(40) OUTPUT)
	AS
		DECLARE @interLoop1 INT,@interLoop2 INT,@interLoop3 INT, @interTime1 INT, @interTime2 INT, @interSeparaG INT, @interSeparaG2 INT, @interVerificaG CHAR(1)

		SET @interLoop1 = 1
		SET @interLoop2 = 1
		SET @interTime2 = 1

		--SEPARA QUEM VAI JOGAR COM QUEM
		WHILE (@interLoop2 <= 12)
		BEGIN
			SELECT @interTime1 = codigoTimeG, @interVerificaG = grupo FROM grupos WHERE @interLoop2 = codigoGrupo
			IF(@interVerificaG = 'A')
			BEGIN
				SET @interSeparaG = 12
				SET @interLoop3 = 5
			END
			ELSE IF(@interVerificaG = 'B')
			BEGIN
				SET @interSeparaG = 8
				SET @interLoop3 = 9
			END
			ELSE IF(@interVerificaG = 'C' OR @interVerificaG = 'D')
			BEGIN
				SET @interSeparaG = 4
				SET @interLoop3 = 13
			END
			WHILE (@interTime2 <= @interSeparaG)
			BEGIN
				SELECT @interSeparaG2 = codigoTimeG FROM grupos WHERE @interLoop3 = codigoGrupo
				INSERT INTO jogos VALUES (@interLoop1, @interTime1, @interSeparaG2, CAST(FLOOR(RAND()*(5)) AS INT), CAST(FLOOR(RAND()*(5)) AS INT), NULL)
				SET @interTime2 = @interTime2 + 1
				SET @interLoop1 = @interLoop1 + 1
				SET @interLoop3 = @interLoop3 + 1
			END
			SET @interTime2 = 1
			SET @interLoop2 = @interLoop2 + 1
		END
		EXEC sp_separa_datas @saida

DECLARE @out VARCHAR(40)
DELETE FROM jogos
EXEC sp_cria_partidas @out OUTPUT
PRINT @out

DELETE jogos

SELECT * FROM jogos ORDER BY data_jogo


