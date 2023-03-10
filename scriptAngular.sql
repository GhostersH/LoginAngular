USE [master]
GO
/****** Object:  Database [databaseAngular]    Script Date: 13/1/2023 21:08:29 ******/
CREATE DATABASE [databaseAngular]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'databaseAngular_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\databaseAngular.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'databaseAngular_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\databaseAngular.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [databaseAngular] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [databaseAngular].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [databaseAngular] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [databaseAngular] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [databaseAngular] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [databaseAngular] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [databaseAngular] SET ARITHABORT OFF 
GO
ALTER DATABASE [databaseAngular] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [databaseAngular] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [databaseAngular] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [databaseAngular] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [databaseAngular] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [databaseAngular] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [databaseAngular] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [databaseAngular] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [databaseAngular] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [databaseAngular] SET  ENABLE_BROKER 
GO
ALTER DATABASE [databaseAngular] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [databaseAngular] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [databaseAngular] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [databaseAngular] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [databaseAngular] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [databaseAngular] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [databaseAngular] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [databaseAngular] SET RECOVERY FULL 
GO
ALTER DATABASE [databaseAngular] SET  MULTI_USER 
GO
ALTER DATABASE [databaseAngular] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [databaseAngular] SET DB_CHAINING OFF 
GO
ALTER DATABASE [databaseAngular] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [databaseAngular] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [databaseAngular] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [databaseAngular] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'databaseAngular', N'ON'
GO
ALTER DATABASE [databaseAngular] SET QUERY_STORE = OFF
GO
USE [databaseAngular]
GO
/****** Object:  Table [dbo].[Nota]    Script Date: 13/1/2023 21:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nota](
	[NotaId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ubicacion] [nvarchar](50) NULL,
	[fecha] [date] NULL,
	[nota] [nvarchar](250) NULL,
 CONSTRAINT [pk_NotaID] PRIMARY KEY CLUSTERED 
(
	[NotaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13/1/2023 21:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Mail] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Token] [nvarchar](500) NULL,
 CONSTRAINT [pk_UserID] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Nota] ON 

INSERT [dbo].[Nota] ([NotaId], [UserId], [ubicacion], [fecha], [nota]) VALUES (1, 1, N'laboratorio1', CAST(N'2022-12-16' AS Date), N'puertas abiertas')
INSERT [dbo].[Nota] ([NotaId], [UserId], [ubicacion], [fecha], [nota]) VALUES (2, 1, N'Laboratorio 15', CAST(N'2022-12-16' AS Date), N'Pertas cerradas')
INSERT [dbo].[Nota] ([NotaId], [UserId], [ubicacion], [fecha], [nota]) VALUES (3, 1, N'', CAST(N'2022-11-05' AS Date), N'')
INSERT [dbo].[Nota] ([NotaId], [UserId], [ubicacion], [fecha], [nota]) VALUES (4, 1, N'', CAST(N'2022-11-05' AS Date), N'')
SET IDENTITY_INSERT [dbo].[Nota] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Nombre], [Mail], [Password], [Token]) VALUES (1, N'Alberto', N'alberto@udla.edu.ec', N'albertito1087', N'dabe1bef-03c6-4762-ba0a-104ec0018694')
INSERT [dbo].[Users] ([UserId], [Nombre], [Mail], [Password], [Token]) VALUES (2, N'Manuel', N'manuel@udla.edu.ec', N'manu2200', N'41241241235')
INSERT [dbo].[Users] ([UserId], [Nombre], [Mail], [Password], [Token]) VALUES (3, N'Emilio', N'emilio@udla.edu.ec', N'emilio123', N'c912731c-041e-4f46-8f8c-f3787494c4be')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Nota]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Nota] CHECK CONSTRAINT [fk_UserId]
GO
USE [master]
GO
ALTER DATABASE [databaseAngular] SET  READ_WRITE 
GO
