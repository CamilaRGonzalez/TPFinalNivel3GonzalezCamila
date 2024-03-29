USE [CATALOGO_WEB_DB]
GO
/****** Object:  Table [dbo].[ARTICULOS]    Script Date: 5/3/2023 02:05:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICULOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](150) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[ImagenUrl] [varchar](1000) NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_ARTICULOS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIAS]    Script Date: 5/3/2023 02:05:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CATEGORIAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAVORITOS]    Script Date: 5/3/2023 02:05:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAVORITOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdArticulo] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MARCAS]    Script Date: 5/3/2023 02:05:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MARCAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 5/3/2023 02:05:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[pass] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[urlImagenPerfil] [varchar](500) NULL,
	[admin] [bit] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ARTICULOS] ON 

INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (1, N'S01', N'Galaxy S10', N'Una canoa cara', 1, 1, N'https://images.samsung.com/is/image/samsung/assets/ar/p6_gro2/p6_initial_mktpd/smartphones/galaxy-s10/specs/galaxy-s10-plus_specs_design_colors_prism_black.jpg?$163_346_PNG$', 69.9990)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (2, N'M03', N'Moto G Play 7ma Gen', N'Ya siete de estos?', 5, 1, N'https://www.motorola.cl/arquivos/moto-g7-play-img-product.png?v=636862863804700000', 30499.9900)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (4, N'S56', N'Bravia 55', N'Alta tele', 3, 2, N'https://intercompras.com/product_thumb_keepratio_2.php?img=images/product/SONY_KDL-55W950A.jpg&w=650&h=450', 49500.0000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (5, N'A23', N'Apple TV', N'lindo loro', 2, 3, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/rfb-apple-tv-4k?wid=1144&hei=1144&fmt=jpeg&qlt=80&.v=1513897159574', 7850.0000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (8, N'F45', N'Auriculares Samsung airpods', N'Auriculares Samsung inalámbricos', 1, 4, N'https://m.media-amazon.com/images/I/41iwUjbN0CL._AC_SY1000_.jpg', 9789.0000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (9, N'T05', N'TV LED Sony W65OD', N'TV LED Sony 50''''', 3, 2, N'https://www.sony.com.ar/image/7330e6d37c178d8930475bcc68628ca3?fmt=pjpeg&wid=330&bgcolor=FFFFFF&bgc=FFFFFF', 300500.5000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (10, N'B56', N'Huawei nova 9', N'Huawei nova 9 pantalla 5''''', 4, 1, N'https://ar.celulares.com/fotos/huawei-nova-9-93639-g-alt.jpg', 125600.0000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (15, N'V91', N'Microsoft Xbox Series X ', N'Microsoft Xbox Series X 1TB Standard color negro 16 GB RAM', 5, 3, N'https://http2.mlstatic.com/D_NQ_NP_2X_963862-MLA45041918050_032021-F.webp', 349998.0000)
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (26, N'V45', N'Ventilador de pared y de piso Liliana ', N'Ventilador de pared y de piso Liliana VTF16P negro con 5 palas, 16" ', 6, 9, N'https://http2.mlstatic.com/D_NQ_NP_2X_646426-MLA44210229351_112020-F.webp', 9449.0000)
SET IDENTITY_INSERT [dbo].[ARTICULOS] OFF
GO
SET IDENTITY_INSERT [dbo].[CATEGORIAS] ON 

INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (1, N'Celulares')
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (2, N'Televisores')
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (3, N'Media')
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (4, N'Audio')
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (9, N'Hogar')
SET IDENTITY_INSERT [dbo].[CATEGORIAS] OFF
GO
SET IDENTITY_INSERT [dbo].[FAVORITOS] ON 

INSERT [dbo].[FAVORITOS] ([Id], [IdUser], [IdArticulo]) VALUES (25, 2, 4)
INSERT [dbo].[FAVORITOS] ([Id], [IdUser], [IdArticulo]) VALUES (26, 2, 10)
INSERT [dbo].[FAVORITOS] ([Id], [IdUser], [IdArticulo]) VALUES (27, 2, 5)
INSERT [dbo].[FAVORITOS] ([Id], [IdUser], [IdArticulo]) VALUES (24, 5, 5)
SET IDENTITY_INSERT [dbo].[FAVORITOS] OFF
GO
SET IDENTITY_INSERT [dbo].[MARCAS] ON 

INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (1, N'Samsung')
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (2, N'Apple')
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (3, N'Sony')
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (4, N'Huawei')
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (5, N'Motorola')
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (6, N'Liliana')
SET IDENTITY_INSERT [dbo].[MARCAS] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (1, N'admin@admin.com', N'admin', NULL, NULL, NULL, 1)
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (2, N'user@user.com', N'user', N'user', N'user', N'Perfil-2.jpg', 0)
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (3, N'cami@hotmail.com', N'cami123', NULL, NULL, NULL, 0)
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (4, N'barilli@telefe.com', N'barilli123', NULL, NULL, NULL, 0)
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (5, N'lalolanda@hotmail.com', N'lalolanda123', NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [admin]
GO
