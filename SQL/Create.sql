USE [master]
GO
/****** Object:  Database [RMI]    Script Date: 04/19/2016 12:42:56 ******/
CREATE DATABASE [RMI] ON  PRIMARY 
( NAME = N'RMI_Data', FILENAME = N'E:\data\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RMI_Data.mdf' , SIZE = 14976KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'RMI_Log', FILENAME = N'E:\data\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RMI_Log.ldf' , SIZE = 23552KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [RMI] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RMI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RMI] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [RMI] SET ANSI_NULLS OFF
GO
ALTER DATABASE [RMI] SET ANSI_PADDING OFF
GO
ALTER DATABASE [RMI] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [RMI] SET ARITHABORT OFF
GO
ALTER DATABASE [RMI] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [RMI] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [RMI] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [RMI] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [RMI] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [RMI] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [RMI] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [RMI] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [RMI] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [RMI] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [RMI] SET  DISABLE_BROKER
GO
ALTER DATABASE [RMI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [RMI] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [RMI] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [RMI] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [RMI] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [RMI] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [RMI] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [RMI] SET  READ_WRITE
GO
ALTER DATABASE [RMI] SET RECOVERY FULL
GO
ALTER DATABASE [RMI] SET  MULTI_USER
GO
ALTER DATABASE [RMI] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [RMI] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'RMI', N'ON'
GO
USE [RMI]
GO
/****** Object:  Table [dbo].[RMI_SUPPLIER]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_SUPPLIER](
	[SupplierCode] [varchar](50) NOT NULL,
	[SupplierName] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[LastModifiedUser] [varchar](50) NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_SUPPLIER] PRIMARY KEY CLUSTERED 
(
	[SupplierCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'SupplierCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'SupplierName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'LastModifiedUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_STEP]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_STEP](
	[StepID] [uniqueidentifier] NOT NULL,
	[StepName] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[UserID] [varchar](50) NULL,
	[note] [varchar](max) NULL,
 CONSTRAINT [PK_RMI_STEP] PRIMARY KEY CLUSTERED 
(
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'StepID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'StepName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'note'
GO
/****** Object:  Table [dbo].[RMI_QUESTION]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_QUESTION](
	[questionName] [varchar](50) NULL,
	[questionID] [uniqueidentifier] NOT NULL,
	[questionClass] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_QUESTION] PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点所属种类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionClass'
GO
/****** Object:  Table [dbo].[RMI_PROCESS_TYPE]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_PROCESS_TYPE](
	[Id] [varchar](50) NOT NULL,
	[Class] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验表格类型ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验材料的类型（主料、辅料等）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验材料名称（表格名称）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相关说明和描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Description'
GO
/****** Object:  Table [dbo].[RMI_PROCESS_STEP]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_PROCESS_STEP](
	[ProcessID] [varchar](50) NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[StepSeq] [int] NOT NULL,
 CONSTRAINT [PK_RMI_PROCESS_SETP] PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC,
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤顺序，该值越大，顺序越前' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'StepSeq'
GO
/****** Object:  Table [dbo].[RMI_MATERIAL_TYPE]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_MATERIAL_TYPE](
	[MaterialTypeID] [uniqueidentifier] NOT NULL,
	[MaterialTypeName] [varchar](max) NULL,
	[LastModifiedUser] [varchar](50) NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_MATERIAL_TYPE] PRIMARY KEY CLUSTERED 
(
	[MaterialTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料种类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_TYPE', @level2type=N'COLUMN',@level2name=N'MaterialTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料种类名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_TYPE', @level2type=N'COLUMN',@level2name=N'MaterialTypeName'
GO
/****** Object:  Table [dbo].[RMI_MATERIAL_NAME]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_MATERIAL_NAME](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[MaterialName] [varchar](max) NULL,
	[LastModifiedUser] [varchar](50) NULL,
	[LastModifiedTime] [datetime] NULL,
	[MaterialTypeID] [uniqueidentifier] NULL,
	[WorkTime] [float] NULL,
 CONSTRAINT [PK_RMI_MATERIAL_NAME] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验工时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'WorkTime'
GO
/****** Object:  Table [dbo].[RMI_JOB]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_JOB](
	[JobID] [varchar](50) NOT NULL,
	[Job] [varchar](50) NOT NULL,
	[Classification] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_JOB] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_FLOW_PROCESS]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_FLOW_PROCESS](
	[FlowID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_RMI_FLOW_PROCESS] PRIMARY KEY CLUSTERED 
(
	[FlowID] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_FLOW_PROCESS', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理表单类型的ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_FLOW_PROCESS', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
/****** Object:  Table [dbo].[RMI_FEEDBACK]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_FEEDBACK](
	[Id] [varchar](50) NULL,
	[Content] [varchar](max) NULL,
	[Subject] [varchar](50) NULL,
	[SubmitTime] [varchar](50) NULL,
	[SubmitUserId] [varchar](50) NULL,
	[SubmitUserName] [varchar](50) NULL,
	[SubmitIP] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F10_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F10_DATA](
	[TiaoJianShenDu] [varchar](50) NULL,
	[PingPai] [varchar](50) NULL,
	[GongYiQueRenRiQi] [varchar](50) NULL,
	[TieHeQiTa] [varchar](50) NULL,
	[WenTiDian] [varchar](50) NULL,
	[CanShuXiaMoWenDu] [varchar](50) NULL,
	[MoYaTiaoJianBeiZhu] [varchar](50) NULL,
	[CanShuShenDu] [varchar](50) NULL,
	[YongTu] [varchar](50) NULL,
	[MoYaCanShuBeiZhu] [varchar](50) NULL,
	[GongYiYuan] [varchar](50) NULL,
	[GongYiQueRen] [varchar](50) NULL,
	[JiShuCanShuXiaMoWenDu] [varchar](50) NULL,
	[ShiYaHouQueRenRiQi] [varchar](50) NULL,
	[JiShuCanShuBeiZhu] [varchar](50) NULL,
	[ShiYaHouQueRen] [varchar](50) NULL,
	[CanShuShiJian] [varchar](50) NULL,
	[ShiYangRenRiQi] [varchar](50) NULL,
	[TiaoJianShangMoWenDu] [varchar](50) NULL,
	[ZhuLiao] [varchar](50) NULL,
	[SongJianRenRiQi] [varchar](50) NULL,
	[ShiYangRen] [varchar](50) NULL,
	[CanShuShangMoWenDu] [varchar](50) NULL,
	[SongJianRen] [varchar](50) NULL,
	[CaiGouBuMenQueRen] [varchar](50) NULL,
	[TiaoJianShiJian] [varchar](50) NULL,
	[TieHeYaLi] [varchar](50) NULL,
	[TiaoJianXiaMoWenDu] [varchar](50) NULL,
	[ShiYongMuJu] [varchar](50) NULL,
	[YongTuBeiZhu] [varchar](50) NULL,
	[TieHeWenDu] [varchar](50) NULL,
	[CaiGouBuMenShenHe] [varchar](50) NULL,
	[CaiLiaoChengFen] [varchar](50) NULL,
	[JiShuCanShuShangMoWenDu] [varchar](50) NULL,
	[JiShuCanShuShiJian] [varchar](50) NULL,
	[GongYiYuanRiQi] [varchar](50) NULL,
	[CaiGouBuMenQueRenRiQi] [varchar](50) NULL,
	[TieHeJiaoShui] [varchar](50) NULL,
	[KuanHao] [varchar](50) NULL,
	[CaiGouBuMenShenHeRiQi] [varchar](50) NULL,
	[JiShuCanShuShenDu] [varchar](50) NULL,
	[GangHao] [varchar](50) NULL,
	[JuanHao] [varchar](50) NULL,
	[TieHeSuDu] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
	[JieLun] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F09_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F09_DATA](
	[BeiZhu] [varchar](max) NULL,
	[HuaXingBiaoZhunPianCha] [varchar](50) NULL,
	[JieLunBeiZhu] [varchar](50) NULL,
	[KaiDuBiaoZhunPianCha] [varchar](50) NULL,
	[AnLunShiYan] [varchar](50) NULL,
	[HouDuBiaoZhunZhi] [varchar](50) NULL,
	[ShaXiang] [varchar](50) NULL,
	[ShouGan] [varchar](50) NULL,
	[KuanDuOrGuiGeBiaoZhunZhi] [varchar](50) NULL,
	[ZhengFanMian] [varchar](50) NULL,
	[BiaoZhunSeKa] [varchar](50) NULL,
	[JieLun] [varchar](50) NULL,
	[hasBiaoZhunSeKa] [bit] NULL,
	[XiangMuFlag] [varchar](max) NULL,
	[CiDian] [varchar](max) NULL,
	[HuaXingShiCe] [varchar](50) NULL,
	[ChanPinZhongLei] [varchar](50) NULL,
	[YanZhenJieGuo] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuBiaoZhunPianCha] [varchar](50) NULL,
	[LeiBie] [varchar](50) NULL,
	[HouDuShiCe] [int] NULL,
	[ShuLiangPiBiao2] [varchar](50) NULL,
	[YinBiaoWeiZhi] [varchar](50) NULL,
	[ShuLiangPiBiao1] [int] NULL,
	[ShuLiang] [varchar](max) NULL,
	[HouDuBiaoZhunPianCha] [varchar](50) NULL,
	[KeZhongBiaoZhunPianCha] [varchar](50) NULL,
	[KuanDuOrGuiGeBiaoZhunPianCha] [varchar](50) NULL,
	[CaiLiaoMingCheng] [varchar](50) NULL,
	[DuiChenXingOrWanQuDu] [varchar](50) NULL,
	[KaiDuBiaoZhunZhi] [varchar](50) NULL,
	[KaiDuShiCe] [varchar](50) NULL,
	[ShouRouHuiSuoLv] [varchar](50) NULL,
	[KuanDuOrGuiGeShiCe1] [varchar](50) NULL,
	[KuanDuOrGuiGeShiCe3] [varchar](50) NULL,
	[KuanDuOrGuiGeShiCe2] [varchar](50) NULL,
	[CaiLiaoCiDianZhuYaoWenTi] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuDanWei] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuShiCe] [int] NULL,
	[ZiRanHuiSuoLv] [varchar](50) NULL,
	[JianYanShu] [int] NULL,
	[ShuLiangShiCe1] [int] NULL,
	[KeZhongBiaoZhunZhi] [varchar](50) NULL,
	[QiWei] [varchar](50) NULL,
	[ShuLiangShiCe2] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuBiaoZhunZhi] [varchar](50) NULL,
	[GuiGeOrKuanDuDanWei] [varchar](50) NULL,
	[GongYingShang] [varchar](50) NULL,
	[GuiGeOrKuanDu] [varchar](50) NULL,
	[DengJiPanDing] [varchar](50) NULL,
	[HuaXingBiaoZhunZhi] [varchar](50) NULL,
	[GangHao] [varchar](50) NULL,
	[ShuiXi] [varchar](50) NULL,
	[CaiLiaoFengYang] [varchar](50) NULL,
	[QiWeiBeiZhu] [varchar](50) NULL,
	[JuanHao] [varchar](50) NULL,
	[KeZhongShiCe] [int] NULL,
	[hasCaiLiaoFengYang] [bit] NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
	[ShiHuaGaoBiaoZhun] [varchar](50) NULL,
	[ShiHuaGaoShiCe] [varchar](50) NULL,
	[ShiHuaKuanBiaoZhun] [varchar](50) NULL,
	[ShiHuaKuanShiCe] [varchar](50) NULL,
	[TiaoShuOrJieTou] [varchar](50) NULL,
 CONSTRAINT [PK__RMI_F09___3214EC0722751F6C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F08_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F08_DATA](
	[BeiZhu] [varchar](50) NULL,
	[BiaoZhi] [varchar](50) NULL,
	[TongHao] [varchar](50) NULL,
	[JieGuo] [varchar](50) NULL,
	[ZaZhi] [varchar](50) NULL,
	[YiWei] [varchar](50) NULL,
	[WaiBaoZhuang] [varchar](50) NULL,
	[YanSe] [varchar](50) NULL,
	[ShiCeShu] [varchar](50) NULL,
	[BiaoZhiShu] [varchar](50) NULL,
	[GongHuoShang] [varchar](50) NULL,
	[PanDing] [varchar](50) NULL,
	[SongHuoDanHao] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F07_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F07_DATA](
	[SaoMiaoJieGuo] [varchar](50) NULL,
	[QiKong] [varchar](50) NULL,
	[GuiGeBiaoZhunZhi] [varchar](50) NULL,
	[QiWei] [varchar](50) NULL,
	[MiDuShiCe] [varchar](50) NULL,
	[ShiMoYa] [varchar](50) NULL,
	[MiDuBiaoZhunPianCha] [varchar](50) NULL,
	[JieGuo] [varchar](50) NULL,
	[SeZe] [varchar](50) NULL,
	[GuiGeBiaoZhunPianCha] [varchar](50) NULL,
	[ShouGan] [varchar](50) NULL,
	[JuanHao] [varchar](50) NULL,
	[XiaCi] [varchar](50) NULL,
	[MiDuBiaoZhunZhi] [varchar](50) NULL,
	[GuiGeShiCe] [varchar](50) NULL,
	[DaoLiaoShu] [varchar](50) NULL,
	[GongHuoShang] [varchar](50) NULL,
	[ChouYanShu] [varchar](50) NULL,
	[PinMingHuoHao] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_F07_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F06_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F06_DATA](
	[RenZaoXianWeiCiShu] [varchar](50) NULL,
	[hasMianMaZhiWu] [bit] NULL,
	[JingXiZhiWuWenDu] [varchar](50) NULL,
	[KuaiSuXiZhuanShu] [varchar](50) NULL,
	[YanSe2] [varchar](50) NULL,
	[hasYangMaoOrShouXi] [bit] NULL,
	[YanSe1] [varchar](50) NULL,
	[RenZaoXianWeiHongGan] [varchar](50) NULL,
	[XiDiYaoQiu] [varchar](50) NULL,
	[MianMaZhiWuHongGan] [varchar](50) NULL,
	[YangMaoOrShouXiZhuanShu] [varchar](50) NULL,
	[hasJingXiZhiWu] [bit] NULL,
	[KuanHao3] [varchar](50) NULL,
	[MianMaZhiWuWenDu] [varchar](50) NULL,
	[MianMaZhiWuZhuanShu] [varchar](50) NULL,
	[RenZaoXianWeiWenDu] [varchar](50) NULL,
	[JingXiZhiWuHongGan] [varchar](50) NULL,
	[YanSe3] [varchar](50) NULL,
	[LaShenMiaoShu] [varchar](50) NULL,
	[KuanHao2] [varchar](50) NULL,
	[LaShenMuDi] [varchar](50) NULL,
	[YangMaoOrShouXiWenDu] [varchar](50) NULL,
	[RenZaoXianWeiZhuanShu] [varchar](50) NULL,
	[hasRenZaoXianWei] [bit] NULL,
	[JieGuo] [varchar](50) NULL,
	[JingXiZhiWuCiShu] [varchar](50) NULL,
	[KuanHao1] [varchar](50) NULL,
	[YangMaoOrShouXiHongGan] [varchar](50) NULL,
	[ShuiXiHouShiYangMiaoShu3] [varchar](50) NULL,
	[ShuiXiHouShiYangMiaoShu2] [varchar](50) NULL,
	[KuaiSuXiHongGan] [varchar](50) NULL,
	[YangMaoOrShouXiCiShu] [varchar](50) NULL,
	[hasKuaiSuXi] [bit] NULL,
	[KuaiSuXiCiShu] [varchar](50) NULL,
	[JingXiZhiWuZhuanShu] [varchar](50) NULL,
	[ShenQingBuMenOrRen] [varchar](50) NULL,
	[ShuLiang2] [varchar](50) NULL,
	[ShuLiang3] [varchar](50) NULL,
	[MianMaZhiWuCiShu] [varchar](50) NULL,
	[ShuLiang1] [varchar](50) NULL,
	[ShuiXiHouShiYangMiaoShu1] [varchar](50) NULL,
	[ShenQingRiQi] [varchar](50) NULL,
	[KuaiSuXiWenDu] [varchar](50) NULL,
	[XiDiJi] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_F06_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F05_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F05_DATA](
	[YanSe] [varchar](50) NULL,
	[BaoKou2] [varchar](50) NULL,
	[BaoKou3] [varchar](50) NULL,
	[BaoKou4] [varchar](50) NULL,
	[MoBeiBeiXing] [varchar](50) NULL,
	[BaoKou1] [varchar](50) NULL,
	[XiDiCiShu] [varchar](50) NULL,
	[ShuLiang] [varchar](50) NULL,
	[hasQiZhouQiMao] [bit] NULL,
	[hasBaoKou] [bit] NULL,
	[QiTaYaoQiu] [varchar](50) NULL,
	[hasTuoJiaoQiPao] [bit] NULL,
	[MoYaTiaoJianShiJian] [varchar](50) NULL,
	[TuoJiaoQiPao4] [varchar](50) NULL,
	[ShenQingBuMen] [varchar](50) NULL,
	[TieHeTiaoJianShiJian] [varchar](50) NULL,
	[TuoJiaoQiPao1] [varchar](50) NULL,
	[TuoJiaoQiPao2] [varchar](50) NULL,
	[TuoJiaoQiPao3] [varchar](50) NULL,
	[TieHeTiaoJianWenDu] [varchar](50) NULL,
	[ShuiWen] [varchar](50) NULL,
	[ShenQingRiQi] [varchar](50) NULL,
	[HongGan] [varchar](50) NULL,
	[XiDiJi] [varchar](50) NULL,
	[MoYaTiaoJianWenDu] [varchar](50) NULL,
	[QiZhouQiMao4] [varchar](50) NULL,
	[QiZhouQiMao1] [varchar](50) NULL,
	[ZhuanSu] [varchar](50) NULL,
	[QiZhouQiMao3] [varchar](50) NULL,
	[QiZhouQiMao2] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[InspectorNo] [varchar](50) NULL,
	[SerialNo] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RMI_F05_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F04_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F04_DATA](
	[ZhuangKuangMiaoShu1] [varchar](50) NULL,
	[ZhuangKuangMiaoShu2] [varchar](50) NULL,
	[ZhuangKuangMiaoShu3] [varchar](50) NULL,
	[CiShu1] [varchar](50) NULL,
	[CiShu2] [varchar](50) NULL,
	[CiShu3] [varchar](50) NULL,
	[YanSe2] [varchar](50) NULL,
	[YanSe3] [varchar](50) NULL,
	[YanSe1] [varchar](50) NULL,
	[JuLi3] [varchar](50) NULL,
	[JuLi2] [varchar](50) NULL,
	[JuLi1] [varchar](50) NULL,
	[KuanHao2] [varchar](50) NULL,
	[KuanHao1] [varchar](50) NULL,
	[KuanHao3] [varchar](50) NULL,
	[LaShenMiaoShu] [varchar](50) NULL,
	[LaShenMuDi] [varchar](50) NULL,
	[JieGuo] [varchar](50) NULL,
	[ShenQingBuMenOrRen] [varchar](50) NULL,
	[ShuLiang2] [varchar](50) NULL,
	[ShuLiang3] [varchar](50) NULL,
	[ShuLiang1] [varchar](50) NULL,
	[ShenQingRiQi] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_F04_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F03_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F03_DATA](
	[SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun1] [varchar](50) NULL,
	[SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun2] [varchar](50) NULL,
	[SiLieQiangDuSiLieQiangDuBiaoZhun1] [varchar](50) NULL,
	[LaiYangQingKuang] [varchar](50) NULL,
	[hasFenHuangBian] [bit] NULL,
	[CaoZuoGongYi] [varchar](50) NULL,
	[BoLiQiangLi1JieGuo] [varchar](50) NULL,
	[LaShenQiangDuZuiDaLiZhi] [varchar](50) NULL,
	[NaiHanZiSeLaoDuBianSe] [varchar](50) NULL,
	[XiHouNiuDuBiaoZhun2] [varchar](50) NULL,
	[XiHouNiuDuBiaoZhun1] [varchar](50) NULL,
	[NaiZaoXiSeLaoDuZhanSe] [varchar](50) NULL,
	[hasBoLiQiangLi] [bit] NULL,
	[TanXingShenChangLv] [varchar](50) NULL,
	[JianCeXingZhi] [varchar](50) NULL,
	[JiaQuan] [varchar](50) NULL,
	[KangHuangBianBiaoZhun1] [varchar](50) NULL,
	[KangHuangBianBiaoZhun2] [varchar](50) NULL,
	[TanXingShenChangLvWeiXiangBiaoZhun1] [varchar](50) NULL,
	[YuYangJiLu] [varchar](50) NULL,
	[YaXianYingDuBiaoZhun1] [varchar](50) NULL,
	[YaXianYingDuBiaoZhun2] [varchar](50) NULL,
	[NaiReSeLaoDu] [varchar](50) NULL,
	[SiLieQiangDuSiLieQiangDuBiaoZhun2] [varchar](50) NULL,
	[TanXingShenChangLvWeiXiang] [varchar](50) NULL,
	[ShenQingBuMen] [varchar](50) NULL,
	[hasDuanLieShenChangLv] [bit] NULL,
	[TanXingShenChangLvWeiXiangBiaoZhun2] [varchar](50) NULL,
	[NaiReSeLaoDuBiaoZhun1] [varchar](50) NULL,
	[SiPoQiangLiJingXiangBiaoZhun1] [varchar](50) NULL,
	[SiPoQiangLiJingXiangBiaoZhun2] [varchar](50) NULL,
	[NaiReSeLaoDuBiaoZhun2] [varchar](50) NULL,
	[hasDingPoQiangLi] [bit] NULL,
	[WaiJianGongYingShang2] [varchar](50) NULL,
	[SiPoQiangLiWeiXiangBiaoZhun1] [varchar](50) NULL,
	[BuHeGeChuLi] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuBianSeBiaoZhun1] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuBianSeBiaoZhun2] [varchar](50) NULL,
	[HuiTanLvBiaoZhun2] [varchar](50) NULL,
	[HuiTanLvBiaoZhun1] [varchar](50) NULL,
	[NaiHanZiSeLaoDuZhanSe] [varchar](50) NULL,
	[CanKaoBiaoZhun] [varchar](50) NULL,
	[SiLieQiangDuSiLieQiangDu] [varchar](50) NULL,
	[WaiJianGongYingShang1] [varchar](50) NULL,
	[PingDing] [varchar](50) NULL,
	[hasPH] [bit] NULL,
	[YangPinMingChen] [varchar](50) NULL,
	[LaShenQiangDuLaShenQiangDuBiaoZhun2] [varchar](50) NULL,
	[LaShenQiangDuLaShenQiangDuBiaoZhun1] [varchar](50) NULL,
	[HuiTanGaoDuJieGuo] [varchar](50) NULL,
	[HuiTanLvJieGuo] [varchar](50) NULL,
	[PH] [varchar](50) NULL,
	[GanMo] [varchar](50) NULL,
	[NaiZaoXiBianSeBiaoZhun2] [varchar](50) NULL,
	[DingPoQiangLiJieGuo] [varchar](50) NULL,
	[WaiJianPiCiGangHao1] [varchar](50) NULL,
	[ShiMoBiaoZhun1] [varchar](50) NULL,
	[ShiMoBiaoZhun2] [varchar](50) NULL,
	[WaiJianPiCiGangHao2] [varchar](50) NULL,
	[hasSiLieQiangDu] [bit] NULL,
	[SongJianRen] [varchar](50) NULL,
	[PHBiaoZhun2] [varchar](50) NULL,
	[PHBiaoZhun1] [varchar](50) NULL,
	[NaiHanZiSeLaoDuBianSeBiaoZhun1] [varchar](50) NULL,
	[BoLiQiangLi2JieGuo] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuBianSe] [varchar](50) NULL,
	[ZhengChangOrJiaJi] [varchar](50) NULL,
	[DuanLieQiangLiJianCeJieGuo] [varchar](50) NULL,
	[KangHuangBianJieGuo] [varchar](50) NULL,
	[TanXingShenChangLvJingXiangBiaoZhun1] [varchar](50) NULL,
	[SiPoQiangLiJingXiangJieGuo] [varchar](50) NULL,
	[TanXingShenChangLvJingXiangBiaoZhun2] [varchar](50) NULL,
	[XiDiSuoShuiLvJingXiangBiaoZhun2] [varchar](50) NULL,
	[XiDiSuoShuiLvJingXiangBiaoZhun1] [varchar](50) NULL,
	[hasYaXianYingDu] [bit] NULL,
	[hasMiDu] [bit] NULL,
	[WaiJianCaiLiaoMingChen2] [varchar](50) NULL,
	[SiLieQiangDuZuiDaSiLieLiZhi] [varchar](50) NULL,
	[NaiHanZiSeLaoDuBianSeBiaoZhun2] [varchar](50) NULL,
	[hasDuanLieQiangLi] [bit] NULL,
	[NaiZaoXiBianSe] [varchar](50) NULL,
	[NaiHanZiSeLaoDuZhanSeBiaoZhun2] [varchar](50) NULL,
	[YaXianYingDuJianCeJieGuo] [varchar](50) NULL,
	[NaiHanZiSeLaoDuZhanSeBiaoZhun1] [varchar](50) NULL,
	[DuanLieBiaoJuBiaoZhun1] [varchar](50) NULL,
	[DuanLieBiaoJuBiaoZhun2] [varchar](50) NULL,
	[LaShenQiangDuZuiDaLiZhiBiaoZhun1] [varchar](50) NULL,
	[SiPoQiangLiWeiXiangBiaoZhun2] [varchar](50) NULL,
	[LaShenQiangDuZuiDaLiZhiBiaoZhun2] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuZhanSe] [varchar](50) NULL,
	[BoLiQiangLi2BiaoZhun1] [varchar](50) NULL,
	[BoLiQiangLi2BiaoZhun2] [varchar](50) NULL,
	[HuiTanGaoDuBiaoZhun1] [varchar](50) NULL,
	[FenHuangBian] [varchar](50) NULL,
	[hasXiDiSuoShuiLv] [bit] NULL,
	[HuiTanGaoDuBiaoZhun2] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuZhanSeBiaoZhun2] [varchar](50) NULL,
	[hasNaiZaoXiSeLaoDu] [bit] NULL,
	[ShiMo] [varchar](50) NULL,
	[FenHuangBianBiaoZhun1] [varchar](50) NULL,
	[hasNaiShuiXiSeLaoDu] [bit] NULL,
	[LaShenQiangDuLaShenQiangDu] [varchar](50) NULL,
	[FenHuangBianBiaoZhun2] [varchar](50) NULL,
	[DuanLieBiaoJuJieGuo] [varchar](50) NULL,
	[TanXingShenChangLvJingXiang] [varchar](50) NULL,
	[GanMoBiaoZhun1] [varchar](50) NULL,
	[GanMoBiaoZhun2] [varchar](50) NULL,
	[WeiWaiXiangMu] [varchar](50) NULL,
	[NaiShuiXiSeLaoDuZhanSeBiaoZhun1] [varchar](50) NULL,
	[MiDuBiaoZhun1] [varchar](50) NULL,
	[MiDuBiaoZhun2] [varchar](50) NULL,
	[hasJiaQuan] [bit] NULL,
	[hasTanXingShenChangLv] [bit] NULL,
	[DuanLieShenChangLvJieGuo] [varchar](50) NULL,
	[DuanLieShenChangLvBiaoZhun2] [varchar](50) NULL,
	[DuanLieShenChangLvBiaoZhun1] [varchar](50) NULL,
	[hasNaiMoCaSeLaoDu] [bit] NULL,
	[CaiLiaoXingZhi] [varchar](50) NULL,
	[hasSiPoQiangLi] [bit] NULL,
	[WaiJianCaiLiaoMingChen1] [varchar](50) NULL,
	[DuanLieQiangLiBiaoZhun1] [varchar](50) NULL,
	[hasHuiTanXing] [bit] NULL,
	[SiPoQiangLiWeiXiangJieGuo] [varchar](50) NULL,
	[XiDiSuoShuiLvWeiXiangBiaoZhun1] [varchar](50) NULL,
	[XiDiSuoShuiLvWeiXiangBiaoZhun2] [varchar](50) NULL,
	[hasLaShenQiangDu] [bit] NULL,
	[XiDiSuoShuiLvJingXiang] [varchar](50) NULL,
	[DingPoQiangLiBiaoZhun1] [varchar](50) NULL,
	[DingPoQiangLiBiaoZhun2] [varchar](50) NULL,
	[NaiZaoXiBianSeBiaoZhun1] [varchar](50) NULL,
	[DuanLieQiangLiBiaoZhun2] [varchar](50) NULL,
	[MiDuJieGuo] [varchar](50) NULL,
	[WaiJianHuoHao2] [varchar](50) NULL,
	[hasKangHuangBian] [bit] NULL,
	[PiCiAndGangHao] [varchar](50) NULL,
	[hasXiHouNiuDu] [bit] NULL,
	[hasNaiReSeLaoDu] [bit] NULL,
	[JiaQuanBiaoZhun1] [varchar](50) NULL,
	[JiaQuanBiaoZhun2] [varchar](50) NULL,
	[NaiZaoXiSeLaoDuZhanSeBiaoZhun2] [varchar](50) NULL,
	[NaiZaoXiSeLaoDuZhanSeBiaoZhun1] [varchar](50) NULL,
	[XiDiSuoShuiLvWeiXiang] [varchar](50) NULL,
	[BoLiQiangLi1BiaoZhun1] [varchar](50) NULL,
	[BoLiQiangLi1BiaoZhun2] [varchar](50) NULL,
	[WaiJianSeHao2] [varchar](50) NULL,
	[QiTaYaoQiu] [varchar](50) NULL,
	[WaiJianHuoHao1] [varchar](50) NULL,
	[WaiJianSeHao1] [varchar](50) NULL,
	[hasNaiHanZiSeLaoDu] [bit] NULL,
	[XiHouNiuDu] [varchar](50) NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[InspectorNo] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_F03_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'酚黄变' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F03_DATA', @level2type=N'COLUMN',@level2name=N'FenHuangBian'
GO
/****** Object:  Table [dbo].[RMI_F02_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F02_DATA](
	[SerialNo] [uniqueidentifier] NULL,
	[JuanHao] [varchar](50) NULL,
	[GangHao] [varchar](50) NULL,
	[JianYanShu] [float] NULL,
	[CaiLiaoMingCheng] [varchar](50) NULL,
	[ShuLiang] [varchar](max) NULL,
	[ShuLiangPiBiao1] [float] NULL,
	[ShuLiangShiCe1] [float] NULL,
	[ShuLiangPiBiao2] [float] NULL,
	[ShuLiangShiCe2] [float] NULL,
	[GuiGeOrKuanDu] [varchar](50) NULL,
	[KuanDuOrGuiGeBiaoZhunZhi] [varchar](50) NULL,
	[KuanDuOrGuiGeBiaoZhunPianCha] [varchar](50) NULL,
	[KuanDuOrGuiGeShiCe1] [float] NULL,
	[KuanDuOrGuiGeShiCe2] [float] NULL,
	[KuanDuOrGuiGeShiCe3] [float] NULL,
	[CiDianJiDian] [int] NULL,
	[CiDianJiFen] [float] NULL,
	[DuiChenXingOrWanQuDu] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuBiaoZhunZhi] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuBiaoZhunPianCha] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuShiCe] [float] NULL,
	[KeZhongBiaoZhunZhi] [varchar](50) NULL,
	[KeZhongBiaoZhunPianCha] [varchar](50) NULL,
	[KeZhongShiCe] [float] NULL,
	[KaiDuBiaoZhunZhi] [varchar](50) NULL,
	[KaiDuBiaoZhunPianCha] [varchar](50) NULL,
	[KaiDuShiCe] [float] NULL,
	[HouDuBiaoZhunZhi] [varchar](50) NULL,
	[HouDuBiaoZhunPianCha] [varchar](50) NULL,
	[HouDuShiCe] [float] NULL,
	[HuaXingBiaoZhunZhi] [varchar](50) NULL,
	[HuaXingBiaoZhunPianCha] [varchar](50) NULL,
	[HuaXingShiCe] [float] NULL,
	[DengJiPanDing] [varchar](10) NULL,
	[BeiZhu] [varchar](max) NULL,
	[InspectorNo] [varchar](50) NULL,
	[GongYingShang] [varchar](50) NULL,
	[GuiGeOrKuanDuDanWei] [varchar](50) NULL,
	[DuiChenXingOrWanQuDuDanWei] [varchar](50) NULL,
	[LeiBie] [varchar](50) NULL,
	[ShouRouHuiSuoLv] [varchar](50) NULL,
	[ZiRanHuiSuoLv] [varchar](50) NULL,
	[CaiLiaoCiDianZhuYaoWenTi] [varchar](max) NULL,
	[QiWei] [varchar](50) NULL,
	[QiWeiBeiZhu] [varchar](50) NULL,
	[AnLunShiYan] [varchar](50) NULL,
	[YanZhenJieGuo] [varchar](max) NULL,
	[hasBiaoZhunSeKa] [bit] NULL,
	[BiaoZhunSeKa] [varchar](max) NULL,
	[hasCaiLiaoFengYang] [bit] NULL,
	[CaiLiaoFengYang] [varchar](max) NULL,
	[JieLun] [varchar](50) NULL,
	[JieLunBeiZhu] [varchar](max) NULL,
	[YinBiaoWeiZhi] [varchar](50) NULL,
	[ShaXiang] [varchar](50) NULL,
	[ShouGan] [varchar](max) NULL,
	[ZhengFanMian] [varchar](50) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[XiangMuFlag] [varchar](max) NULL,
	[ChanPinZhongLei] [varchar](50) NULL,
	[GangTuoBeiZhu] [varchar](max) NULL,
 CONSTRAINT [PK_RMI_F02_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'SerialNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卷号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'JuanHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缸号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'GangHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'CaiLiaoMingCheng'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量皮标1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShuLiangPiBiao1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量实测1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShuLiangShiCe1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量皮标2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShuLiangPiBiao2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量实测2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShuLiangShiCe2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'选择了规格或者宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'GuiGeOrKuanDu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度或者规格标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KuanDuOrGuiGeBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度或者规格偏差值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KuanDuOrGuiGeBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度或者规格实测值1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KuanDuOrGuiGeShiCe1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度或者规格实测值2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KuanDuOrGuiGeShiCe2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽度或者规格实测值3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KuanDuOrGuiGeShiCe3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点记点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'CiDianJiDian'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点记分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'CiDianJiFen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对称性或者弯曲度选择' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'DuiChenXingOrWanQuDu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对称性或者弯曲度标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'DuiChenXingOrWanQuDuBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对称性或者弯曲度偏差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'DuiChenXingOrWanQuDuBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对称性或者弯曲度实测值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'DuiChenXingOrWanQuDuShiCe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'克重标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KeZhongBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'克重标准偏差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KeZhongBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'克重实测值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KeZhongShiCe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开度标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KaiDuBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开度标准偏差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KaiDuBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开度实测值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'KaiDuShiCe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'厚度标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HouDuBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'厚度标准偏差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HouDuBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'厚度实测值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HouDuShiCe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'花型标准值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HuaXingBiaoZhunZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'花型标准值偏差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HuaXingBiaoZhunPianCha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'花型实测' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'HuaXingShiCe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'BeiZhu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入人工号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'InspectorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'GongYingShang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格或者宽度的单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'GuiGeOrKuanDuDanWei'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对称性或者弯曲度单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'DuiChenXingOrWanQuDuDanWei'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料疵点主要问题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'CaiLiaoCiDianZhuYaoWenTi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'气味：正常或不正常' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'QiWei'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'气味备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'QiWeiBeiZhu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'氨纶试验结果：合格或不合格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'AnLunShiYan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验针结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'YanZhenJieGuo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否勾选标准色卡比对' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'hasBiaoZhunSeKa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标准色卡级数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'BiaoZhunSeKa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否勾选材料封样比对' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'hasCaiLiaoFengYang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料封样比对级数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'CaiLiaoFengYang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验结论：不做判定或者合格或者不合格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'JieLun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结论备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'JieLunBeiZhu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'印标位置：正确或不正确' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'YinBiaoWeiZhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'纱向：正确或不正确' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShaXiang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手感' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ShouGan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行主键标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'项目标记（用于表格缩短）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'XiangMuFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品种类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F02_DATA', @level2type=N'COLUMN',@level2name=N'ChanPinZhongLei'
GO
/****** Object:  Table [dbo].[RMI_F01_DATA]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F01_DATA](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[GuiGe] [varchar](50) NULL,
	[BiaoZhiShu] [int] NULL,
	[ShiCeShu] [int] NULL,
	[HeGeShu] [int] NULL,
	[WaiGuan] [bit] NULL,
	[JianYanHao] [varchar](50) NULL,
	[TouChanShu] [int] NULL,
	[DingDanShu] [int] NULL,
	[QiTa] [varchar](max) NULL,
	[ID] [uniqueidentifier] NOT NULL,
	[InspectorNo] [varchar](50) NULL,
	[isZhuDiaoPai] [bit] NULL,
	[JianYanShu] [float] NULL,
	[SaoMiaoJieGuo] [varchar](50) NULL,
	[DingDanHao] [varchar](50) NULL,
	[ShengChanRiQi] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_F01_DATA_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'GuiGe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标识数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'BiaoZhiShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实测数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ShiCeShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合格数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'HeGeShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外观' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'WaiGuan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'JianYanHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'投产数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'TouChanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'DingDanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'其他' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'QiTa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'填写该数据的检验员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'InspectorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是主吊牌的标记，1为主吊牌，0不是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'isZhuDiaoPai'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'JianYanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扫描结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'SaoMiaoJieGuo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'DingDanHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ShengChanRiQi'
GO
/****** Object:  Table [dbo].[RMI_DEPARTMENT]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_DEPARTMENT](
	[DepartmentID] [varchar](50) NOT NULL,
	[Department] [varchar](50) NOT NULL,
	[Classification] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_DEPARTMENT] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'Classification'
GO
/****** Object:  Table [dbo].[RMI_ACCOUNT_USER]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_ACCOUNT_USER](
	[ID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[DepartmentID] [varchar](50) NOT NULL,
	[JobID] [varchar](50) NOT NULL,
	[Permission] [varchar](max) NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_ACCOUNT_USER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限JSON' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Permission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修订时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_WORK_FLOW]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_WORK_FLOW](
	[FlowID] [uniqueidentifier] NOT NULL,
	[FlowName] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_WORKFLOW] PRIMARY KEY CLUSTERED 
(
	[FlowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'FlowName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_UNIT]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_UNIT](
	[UnitID] [uniqueidentifier] NOT NULL,
	[UnitName] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_UNIT] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'UnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'UnitName'
GO
/****** Object:  Table [dbo].[RMI_TASK_PROCESS_STEP]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK_PROCESS_STEP](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[Finished] [tinyint] NULL,
	[FinishTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[note] [varchar](max) NULL,
 CONSTRAINT [PK_RMI_TASK_PROCESS_STEP] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC,
	[ProcessID] ASC,
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'SerialNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单步骤ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'StepID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单步骤完成状态，0未完成，1已完成,2表示正在编辑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'Finished'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'FinishTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'note'
GO
/****** Object:  Table [dbo].[auth_user_user_permissions]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_user_permissions](
	[id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_groups]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_groups](
	[id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user](
	[id] [int] NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[first_name] [nvarchar](30) NOT NULL,
	[last_name] [nvarchar](30) NOT NULL,
	[email] [nvarchar](75) NOT NULL,
	[password] [nvarchar](128) NOT NULL,
	[is_staff] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_superuser] [bit] NOT NULL,
	[last_login] [datetime] NOT NULL,
	[date_joined] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_permission]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_permission](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[content_type_id] [int] NOT NULL,
	[codename] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group_permissions]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group_permissions](
	[id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group](
	[id] [int] NOT NULL,
	[name] [nvarchar](80) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_site]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_site](
	[id] [int] NOT NULL,
	[domain] [nvarchar](100) NOT NULL,
	[name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_session]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_session](
	[session_key] [nvarchar](40) NOT NULL,
	[session_data] [nvarchar](max) NOT NULL,
	[expire_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_content_type]    Script Date: 04/19/2016 12:42:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_content_type](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[app_label] [nvarchar](100) NOT NULL,
	[model] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sys_Page_v2]    Script Date: 04/19/2016 12:42:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sys_Page_v2]
@PCount int output,    --总页数输出
@RCount int output,    --总记录数输出
@sys_Table nvarchar(100),    --查询表名
@sys_Key varchar(50),        --主键
@sys_Fields nvarchar(500),    --查询字段
@sys_Where nvarchar(3000),    --查询条件
@sys_Order nvarchar(100),    --排序字段
@sys_Begin int,        --开始位置
@sys_PageIndex int,        --当前页数
@sys_PageSize int        --页大小
AS

SET NOCOUNT ON
SET ANSI_WARNINGS ON

IF @sys_PageSize < 0 OR @sys_PageIndex < 0
BEGIN        
RETURN
END

DECLARE @new_where1 NVARCHAR(3000)
DECLARE @new_order1 NVARCHAR(100)
DECLARE @new_order2 NVARCHAR(100)
DECLARE @Sql NVARCHAR(4000)
DECLARE @SqlCount NVARCHAR(4000)

DECLARE @Top int

if(@sys_Begin <=0)
    set @sys_Begin=0
else
    set @sys_Begin=@sys_Begin-1

IF ISNULL(@sys_Where,'') = ''
    SET @new_where1 = ' '
ELSE
    SET @new_where1 = ' WHERE ' + @sys_Where 

IF ISNULL(@sys_Order,'') <> '' 
BEGIN
    SET @new_order1 = ' ORDER BY ' + Replace(@sys_Order,'desc','')
    SET @new_order1 = Replace(@new_order1,'asc','desc')

    SET @new_order2 = ' ORDER BY ' + @sys_Order
END
ELSE
BEGIN
    SET @new_order1 = ' ORDER BY ID DESC'
    SET @new_order2 = ' ORDER BY ID ASC'
END

SET @SqlCount = 'SELECT @RCount=COUNT(1),@PCount=CEILING((COUNT(1)+0.0)/'
            + CAST(@sys_PageSize AS NVARCHAR)+') FROM ' + @sys_Table + @new_where1

EXEC SP_EXECUTESQL @SqlCount,N'@RCount INT OUTPUT,@PCount INT OUTPUT',
               @RCount OUTPUT,@PCount OUTPUT

IF @sys_PageIndex > CEILING((@RCount+0.0)/@sys_PageSize)    --如果输入的当前页数大于实际总页数,则把实际总页数赋值给当前页数
BEGIN
    SET @sys_PageIndex =  CEILING((@RCount+0.0)/@sys_PageSize)
END

set @sql = 'select '+ @sys_fields +' from ' + @sys_Table + ' w1 '
    + ' where '+ @sys_Key +' in ('
        +'select top '+ ltrim(str(@sys_PageSize)) +' ' + @sys_Key + ' from '
        +'('
            +'select top ' + ltrim(STR(@sys_PageSize * @sys_PageIndex + @sys_Begin)) + ' ' + @sys_Key + ' FROM ' 
        + @sys_Table + @new_where1 + @new_order2 
        +') w ' + @new_order1
    +') ' + @new_order2

print(@sql)

Exec(@sql)
GO
/****** Object:  UserDefinedFunction [dbo].[getCurrentFinishedStep]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getCurrentFinishedStep](@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @step uniqueidentifier,@finish int, @stepName varchar(50);
SELECT TOP 1 @step = a.StepID, @finish = Finished FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
ON a.StepID = b.StepID AND a.ProcessID = b.ProcessID WHERE SerialNo = @serialno AND a.ProcessID = @process
ORDER BY a.Finished DESC , b.StepSeq;
IF @finish != 1
	SELECT TOP 1 @stepName = StepName FROM RMI_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
	 ON a.StepID = b.StepID
	 WHERE ProcessID = @process
	 ORDER BY StepSeq DESC;
ELSE
	SELECT @stepName = StepName FROM RMI_STEP WITH(NOLOCK) WHERE StepID = @step;
RETURN @stepName;
END
GO
/****** Object:  UserDefinedFunction [dbo].[taskJudgement]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[taskJudgement](@serialNo uniqueidentifier)
-------0：不合格 1：合格 2：不做判定
RETURNS INT
AS
BEGIN
DECLARE @judgeResult INT, @F09Res varchar(50), @F10Res varchar(50), @F03Res varchar(50);
SELECT @F09Res = JieLun FROM RMI_F09_DATA WHERE SerialNo = @serialNo;
SELECT @F10Res = JieLun FROM RMI_F10_DATA WHERE SerialNo = @serialNo;
SELECT @F03Res = PingDing FROM RMI_F03_DATA WHERE SerialNo = @serialNo;
IF ( @F09Res = 'BuHeGe' ) OR ( @F10Res = 'BuHeGe' ) OR ( @F03Res = 'BuHeGe' )
BEGIN
	SET @judgeResult = 0;
END
ELSE
BEGIN
	IF ( @F09Res = 'HeGe' ) OR ( @F10Res = 'HeGe' ) OR ( @F03Res = 'HeGe' )
	BEGIN
		SET @judgeResult = 1;
	END
	ELSE
	BEGIN
		SET @judgeResult = 2;
	END
END
RETURN @judgeResult;
END
GO
/****** Object:  StoredProcedure [dbo].[createNewProcess]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[createNewProcess]
@processID varchar(50),
 @processName varchar(50), 
 @processClass varchar(50),
  @processDescription varchar(50)
AS
BEGIN
DECLARE @flowID uniqueidentifier;
INSERT INTO RMI_PROCESS_TYPE(ID, NAME, CLASS, DESCRIPTION) VALUES( @processID, @processName, @processClass, @processDescription );
SELECT @flowID = flowID FROM RMI_WORK_FLOW WHERE FlowName = '所有表单';
INSERT INTO RMI_FLOW_PROCESS(FLOWID, PROCESSID) VALUES(@flowID, @processID);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'4b652f7e-846e-419c-818e-544e1d00e6a5', 1);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'36929b8a-8c15-4068-8c0a-6da2060aa172', 0);
END
GO
/****** Object:  Table [dbo].[RMI_TASK_PROCESS]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK_PROCESS](
	[Serialno] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[LastModifiedTime] [datetime] NULL,
	[LastModifiedUser] [varchar](50) NULL,
	[AssessTime] [datetime] NULL,
	[Assessor] [varchar](50) NULL,
 CONSTRAINT [PK_RMI_TASK_PROCESS] PRIMARY KEY CLUSTERED 
(
	[Serialno] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS', @level2type=N'COLUMN',@level2name=N'Serialno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单类型ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
/****** Object:  UserDefinedFunction [dbo].[getUserNameByUserID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getUserNameByUserID](@UserID varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE ID = @UserID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getUnitNameByID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getUnitNameByID](@UnitID uniqueidentifier)
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(MAX);
IF @UnitID IS NOT NULL
	SELECT TOP 1 @name = UnitName FROM RMI_UNIT WHERE UnitID = @UnitID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getSupplierNameByID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getSupplierNameByID](@SupplierCode varchar(50))
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = SupplierName FROM RMI_SUPPLIER WHERE SupplierCode = @SupplierCode;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialTypeNameByID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialTypeNameByID](@materialTypeID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialTypeName FROM RMI_MATERIAL_TYPE WHERE MaterialTypeID = @materialTypeID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialTypeIDByMaterialID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialTypeIDByMaterialID](@materialID uniqueidentifier)
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @ID uniqueidentifier;
SELECT TOP 1 @ID = MaterialTypeID FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @ID;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialNameByID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialNameByID](@materialID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialName FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getLastModifiedUserNameByProcessID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLastModifiedUserNameByProcessID](@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_TASK_PROCESS a WITH(NOLOCK)JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)
ON a.LastModifiedUser = b.ID WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getLastModifiedTimeByProcessID]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLastModifiedTimeByProcessID](@serialno uniqueidentifier, @process varchar(50))
RETURNS datetime
AS
BEGIN
DECLARE @lastModifiedTime datetime;
SELECT TOP 1 @lastModifiedTime = lastModifiedTime FROM RMI_TASK_PROCESS WITH(NOLOCK)WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @lastModifiedTime;
END
GO
/****** Object:  Table [dbo].[RMI_TASK]    Script Date: 04/19/2016 12:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[ProductNo] [varchar](50) NULL,
	[ColorNo] [varchar](50) NULL,
	[ArriveTime] [datetime] NULL,
	[UserID] [varchar](50) NULL,
	[FlowID] [uniqueidentifier] NOT NULL,
	[State] [int] NOT NULL,
	[SupplierCode] [varchar](50) NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[DaoLiaoZongShu] [float] NULL,
	[UnitID] [uniqueidentifier] NULL,
	[DaoLiaoZongShu2] [float] NULL,
	[UnitID2] [uniqueidentifier] NULL,
	[InspectTotalNumber] [float] NULL,
 CONSTRAINT [PK_RMI_TASK] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'SerialNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ProductNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'色号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ColorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ArriveTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务状态：2：填写中， 1：审批通过，0：提交完成 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'SupplierCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'DaoLiaoZongShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数单位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数多余项填写（如卷）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'DaoLiaoZongShu2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数多余项的单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UnitID2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'InspectTotalNumber'
GO
/****** Object:  View [dbo].[SupplierInfoAnalysis]    Script Date: 04/19/2016 12:43:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SupplierInfoAnalysis] /*创建视图*/
  AS
    SELECT GongYingShangBianMa=SupplierCode,
		   GongYingShangMingCheng=dbo.getSupplierNameByID(SupplierCode),
		   GongHuoShuLiang = SUM(DaoLiaoZongShu),  TongJiQiNeiDaoHuoPiCi=COUNT(*),
           BuHeGePiCi=(SELECT COUNT(*) FROM RMI_TASK A
						WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						AND dbo.taskJudgement(SerialNo) = 0 AND A.SupplierCode = B.SupplierCode AND A.UnitID = B.UnitID),
		   BuHeGeShuLiang=(SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
						   WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						   AND dbo.taskJudgement(SerialNo) = 0
						   AND C.SupplierCode = B.SupplierCode AND C.UnitID = B.UnitID),
			RiQi=CONVERT(varchar(10), Createtime , 21),
			DaoHuoShuLiangDanWei=(SELECT dbo.getUnitNameByID(B.UnitID))
			FROM RMI_TASK B 
            GROUP BY SupplierCode, UnitID, CONVERT(varchar(10), Createtime , 21)
GO
/****** Object:  UserDefinedFunction [dbo].[getDaoLiaoZongShuAndUnit]    Script Date: 04/19/2016 12:43:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getDaoLiaoZongShuAndUnit](@SerialNo uniqueidentifier)
RETURNS varchar(100)
AS
BEGIN
DECLARE @DaoLiaoZongShuAndUnit VARCHAR(100),@DaoLiaoZongShu varchar(100), @DaoLiaoZongShu2 varchar(100);
SELECT @DaoLiaoZongShu = CONVERT(VARCHAR(20),DaoLiaoZongShu)+dbo.getUnitNameByID(UnitID),
	   @DaoLiaoZongShu2 = CONVERT(VARCHAR(20),ISNULL(DaoLiaoZongShu2, ''))+ISNULL(dbo.getUnitNameByID(UnitID2),'')
	   FROM RMI_TASK WHERE SerialNo = @SerialNo;
IF @DaoLiaoZongShu2 <> '0'
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu + '/' + @DaoLiaoZongShu2;
ELSE
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu;
RETURN @DaoLiaoZongShuAndUnit;
END
GO
/****** Object:  Default [DF_RMI_STEP_StepID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_STEP] ADD  CONSTRAINT [DF_RMI_STEP_StepID]  DEFAULT (newid()) FOR [StepID]
GO
/****** Object:  Default [DF_RMI_QUESTION_questionID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_QUESTION] ADD  CONSTRAINT [DF_RMI_QUESTION_questionID]  DEFAULT (newid()) FOR [questionID]
GO
/****** Object:  Default [DF_RMI_MATERIAL_TYPE_MaterialTypeID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_MATERIAL_TYPE] ADD  CONSTRAINT [DF_RMI_MATERIAL_TYPE_MaterialTypeID]  DEFAULT (newid()) FOR [MaterialTypeID]
GO
/****** Object:  Default [DF_RMI_MATERIAL_NAME_MaterialID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_MATERIAL_NAME] ADD  CONSTRAINT [DF_RMI_MATERIAL_NAME_MaterialID]  DEFAULT (newid()) FOR [MaterialID]
GO
/****** Object:  Default [DF__RMI_F10_DATA__Id__5BAD9CC8]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F10_DATA] ADD  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F09_DATA__Id__245D67DE]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F09_DATA] ADD  CONSTRAINT [DF__RMI_F09_DATA__Id__245D67DE]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F08_DATA__id__1EA48E88]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F08_DATA] ADD  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F07_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F07_DATA] ADD  CONSTRAINT [DF_RMI_F07_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F06_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F06_DATA] ADD  CONSTRAINT [DF_RMI_F06_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F05_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F05_DATA] ADD  CONSTRAINT [DF_RMI_F05_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F04_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F04_DATA] ADD  CONSTRAINT [DF_RMI_F04_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F03_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F03_DATA] ADD  CONSTRAINT [DF_RMI_F03_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F02_DATA_Id]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F02_DATA] ADD  CONSTRAINT [DF_RMI_F02_DATA_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F01_DATA_ID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F01_DATA] ADD  CONSTRAINT [DF_RMI_F01_DATA_ID]  DEFAULT (newid()) FOR [ID]
GO
/****** Object:  Default [DF_RMI_F01_DATA_ZhuDiaoPai]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_F01_DATA] ADD  CONSTRAINT [DF_RMI_F01_DATA_ZhuDiaoPai]  DEFAULT ((0)) FOR [isZhuDiaoPai]
GO
/****** Object:  Default [DF_RMI_WORKFLOW_FlowID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_WORK_FLOW] ADD  CONSTRAINT [DF_RMI_WORKFLOW_FlowID]  DEFAULT (newid()) FOR [FlowID]
GO
/****** Object:  Default [DF_RMI_WORK_FLOW_LastModifiedTime]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_WORK_FLOW] ADD  CONSTRAINT [DF_RMI_WORK_FLOW_LastModifiedTime]  DEFAULT (getdate()) FOR [LastModifiedTime]
GO
/****** Object:  Default [DF_RMI_UNIT_UnitID]    Script Date: 04/19/2016 12:42:58 ******/
ALTER TABLE [dbo].[RMI_UNIT] ADD  CONSTRAINT [DF_RMI_UNIT_UnitID]  DEFAULT (newid()) FOR [UnitID]
GO
/****** Object:  Default [DF_RMI_TASK_SerialNo]    Script Date: 04/19/2016 12:43:00 ******/
ALTER TABLE [dbo].[RMI_TASK] ADD  CONSTRAINT [DF_RMI_TASK_SerialNo]  DEFAULT (newid()) FOR [SerialNo]
GO
/****** Object:  Default [DF_RMI_TASK_State]    Script Date: 04/19/2016 12:43:00 ******/
ALTER TABLE [dbo].[RMI_TASK] ADD  CONSTRAINT [DF_RMI_TASK_State]  DEFAULT ((2)) FOR [State]
GO
