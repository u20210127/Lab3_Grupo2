CREATE DATABASE AnimesAPI

USE AnimesAPI

--TABLAS

CREATE TABLE Autores
(
	Id_Autor INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	Nombre_Autor NVARCHAR(50)NOT NULL,
	Fecha_Nacimiento DATE NOT NULL,
	Nacionalidad NVARCHAR(50)NOT NULL,
	Genero_Literario NVARCHAR(50)NOT NULL
);


CREATE TABLE Animes   
(
	Id_Anime INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	Nombre_Anime NVARCHAR(50)NOT NULL,
	Precio DECIMAL(5, 2)NOT NULL,
	Id_Autor INT NOT NULL
	FOREIGN KEY  (Id_Autor) REFERENCES Autores(Id_Autor)
);



CREATE TABLE Categorias
(
	Id_Categoria INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
	Nombre_Categoria NVARCHAR(50)NOT NULL,
	Descripcion_Categoria NVARCHAR(50)NOT NULL,
	Id_Anime INT NOT NULL
	FOREIGN KEY  (Id_Anime) REFERENCES Animes(Id_Anime)
);



--PROCEDIMIENTOS ALMACENADOS

--PARA LA TABLA AUTORES
CREATE OR ALTER PROCEDURE dbo.spAutor_GetAll
AS
BEGIN
	SELECT Id_Autor, Nombre_Autor, Fecha_Nacimiento,Nacionalidad,Genero_Literario 
	FROM Autores;
END


CREATE OR ALTER PROCEDURE dbo.spAutor_GetById
@Id Int
AS
BEGIN
	SELECT Id_Autor, Nombre_Autor, Fecha_Nacimiento,Nacionalidad,Genero_Literario 
	 FROM Autores
	WHERE Id_Autor = @Id;
END


CREATE OR ALTER PROCEDURE dbo.spAutor_Insert
(
	@Nombre_Autor VARCHAR(50),
	@Fecha_Nacimiento DATE,
	@Nacionalidad VARCHAR(50),
	@Genero_Literario VARCHAR(50)
)
AS
BEGIN
	INSERT INTO Autores 
	VALUES(@Nombre_Autor, @Fecha_Nacimiento, @Nacionalidad, @Genero_Literario) 
END


CREATE OR ALTER PROCEDURE dbo.spAutor_Update
	@Nombre_Autor NVARCHAR(50),
	@Fecha_Nacimiento DATE,
	@Nacionalidad NVARCHAR(50),
	@Genero_Literario NVARCHAR(50),
	@Id_Autor INT
AS
BEGIN
	UPDATE Autores
	SET Nombre_Autor = @Nombre_Autor,
		Fecha_Nacimiento = @Fecha_Nacimiento,
		Nacionalidad = @Nacionalidad,
		Genero_Literario = @Genero_Literario
	WHERE Id_Autor = @Id_Autor 
END 


CREATE OR ALTER PROCEDURE dbo.spAutor_Delete
@Id_Autor INT
AS
BEGIN
	DELETE FROM Autores 
	WHERE Id_Autor = @Id_Autor
END




--PARA LA TABLA ANIMES
CREATE OR ALTER PROCEDURE dbo.spAnime_GetAll
AS
BEGIN
	SELECT Id_Anime, Nombre_Anime, Precio, Animes.Id_Autor 
	FROM Animes
	INNER JOIN Autores
	ON Animes.Id_Autor = Autores.Id_Autor;
END

CREATE OR ALTER PROCEDURE dbo.spAnime_GetById
@Id_Anime INT
AS
BEGIN
	SELECT Id_Anime, Nombre_Anime, Precio, Id_Autor 
	FROM Animes
	WHERE Id_Anime = @Id_Anime;
END


CREATE OR ALTER PROCEDURE dbo.spAnime_Insert
(
	@Nombre_Anime NVARCHAR(50),
	@Precio DECIMAL(5, 2),
	@Id_Autor INT
)
AS
BEGIN
	INSERT INTO Animes (Nombre_Anime, Precio, Id_Autor)
	VALUES (@Nombre_Anime, @Precio, @Id_Autor);
END


CREATE OR ALTER PROCEDURE dbo.spAnime_Update
	@Nombre_Anime NVARCHAR(50),
	@Precio DECIMAL(5, 2),
	@Id_Autor INT,
	@Id_Anime INT
AS
BEGIN
	UPDATE Animes
	SET Nombre_Anime = @Nombre_Anime,
		Precio = @Precio,
		Id_Autor = @Id_Autor
	WHERE Id_Anime = @Id_Anime;
END


CREATE OR ALTER PROCEDURE dbo.spAnime_Delete
@Id_Anime INT
AS
BEGIN
	DELETE FROM Animes
	WHERE Id_Anime = @Id_Anime;
END




--PARA LA TABLA CATEGORIAS
CREATE OR ALTER PROCEDURE dbo.spCategoria_GetAll
AS
BEGIN
	SELECT Id_Categoria, Nombre_Categoria, Descripcion_Categoria, Animes.Id_Anime 
	FROM Categorias
	INNER JOIN Animes
	ON Categorias.Id_Anime = Animes.Id_Anime;
END

CREATE OR ALTER PROCEDURE dbo.spCategoria_GetById
@Id INT
AS
BEGIN
	SELECT Id_Categoria, Nombre_Categoria, Descripcion_Categoria, Id_Anime 
	FROM Categorias
	WHERE Id_Categoria = @Id;
END


CREATE OR ALTER PROCEDURE dbo.spCategoria_Insert
(
	@Nombre_Categoria NVARCHAR(50),
	@Descripcion_Categoria NVARCHAR(50),
	@Id_Anime INT
)
AS
BEGIN
	INSERT INTO Categorias (Nombre_Categoria, Descripcion_Categoria, Id_Anime)
	VALUES (@Nombre_Categoria, @Descripcion_Categoria, @Id_Anime);
END

CREATE OR ALTER PROCEDURE dbo.spCategoria_Update
	@Nombre_Categoria NVARCHAR(50),
	@Descripcion_Categoria NVARCHAR(50),
	@Id_Anime INT,
	@Id_Categoria INT
AS
BEGIN
	UPDATE Categorias
	SET Nombre_Categoria = @Nombre_Categoria,
		Descripcion_Categoria = @Descripcion_Categoria,
		Id_Anime = @Id_Anime
	WHERE Id_Categoria = @Id_Categoria;
END


CREATE OR ALTER PROCEDURE dbo.spCategoria_Delete
@Id_Categoria INT
AS
BEGIN
	DELETE FROM Categorias
	WHERE Id_Categoria = @Id_Categoria;
END