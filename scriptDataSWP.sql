USE [master]
GO
/****** Object:  Database [SWP391]    Script Date: 7/8/2024 11:23:43 AM ******/
CREATE DATABASE [SWP391]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP391', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP391.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP391_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP391_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SWP391] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP391].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP391] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP391] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP391] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP391] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP391] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP391] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP391] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP391] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP391] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP391] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP391] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP391] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP391] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP391] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP391] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP391] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP391] SET  MULTI_USER 
GO
ALTER DATABASE [SWP391] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP391] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP391] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP391] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP391] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP391] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP391', N'ON'
GO
ALTER DATABASE [SWP391] SET QUERY_STORE = ON
GO
ALTER DATABASE [SWP391] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SWP391]
GO
/****** Object:  Table [dbo].[categoriesinfo]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoriesinfo](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[commenter_id] [int] NOT NULL,
	[is_violation] [bit] NOT NULL,
	[rating_value] [int] NULL,
	[receiver_id] [int] NULL,
	[created_at] [datetimeoffset](6) NOT NULL,
	[comment_content] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[commentviolation]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[commentviolation](
	[comment_id] [int] NOT NULL,
	[comment_violation_id] [int] IDENTITY(1,1) NOT NULL,
	[violation_level] [int] NOT NULL,
	[word_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_violation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day_request]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day_request](
	[request_id] [int] NOT NULL,
	[day_request] [datetime2](6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[media_profile]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[media_profile](
	[profile_id] [int] NULL,
	[create_at] [datetimeoffset](6) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[url] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notification]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notification](
	[user_id] [int] NOT NULL,
	[create_at] [datetimeoffset](6) NULL,
	[notification_id] [bigint] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](100) NULL,
	[reference_id] [varchar](255) NULL,
	[type] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile](
	[money] [float] NULL,
	[rating] [float] NULL,
	[user_id] [int] NOT NULL,
	[birthday] [datetime2](6) NULL,
	[priceapost] [bigint] NOT NULL,
	[priceato_hireaday] [bigint] NOT NULL,
	[priceavideo] [bigint] NOT NULL,
	[representative_price] [bigint] NOT NULL,
	[location] [nvarchar](155) NULL,
	[full_name] [nvarchar](max) NULL,
	[avatar_url] [varchar](500) NULL,
	[bio] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_categories]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_categories](
	[category_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[comment_id] [int] NOT NULL,
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[report_user] [int] NULL,
	[reported_user] [int] NULL,
	[create_date] [datetime2](6) NULL,
	[description] [varchar](50) NOT NULL,
	[reason] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_categories]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_categories](
	[category_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_representatives]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_representatives](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[months] [int] NOT NULL,
	[request_id] [int] NULL,
	[end_date] [datetime2](6) NULL,
	[start_date] [datetime2](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_wait_list]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_wait_list](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [int] NOT NULL,
	[responder_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[requests]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[requests](
	[is_public] [bit] NULL,
	[payment] [float] NULL,
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[request_status] [smallint] NULL,
	[requester_confirm] [bit] NULL,
	[requester_id] [int] NULL,
	[responder_id] [int] NULL,
	[responer_confirm] [bit] NULL,
	[request_date] [datetime2](6) NULL,
	[request_date_end] [datetime2](6) NULL,
	[request_location] [nvarchar](155) NULL,
	[request_description] [nvarchar](max) NULL,
	[request_type] [varchar](255) NULL,
	[result_link] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedule](
	[request_id] [int] NULL,
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[request_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_conversation]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_conversation](
	[created_at] [datetimeoffset](6) NULL,
	[updated_at] [datetimeoffset](6) NULL,
	[id] [varchar](255) NOT NULL,
	[last_message] [varchar](255) NULL,
	[type] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_message]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_message](
	[is_read] [bit] NOT NULL,
	[recipient_id] [int] NOT NULL,
	[sender_id] [int] NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[timestamp] [datetimeoffset](6) NOT NULL,
	[content] [ntext] NOT NULL,
	[conversation_id] [varchar](255) NOT NULL,
	[type] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_verifycode]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_verifycode](
	[number_of_attempts] [int] NULL,
	[userid] [int] NULL,
	[expiry_date_time] [datetime2](6) NULL,
	[code] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[id] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactionhistory]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactionhistory](
	[receiver_id] [int] NULL,
	[request_id] [int] NULL,
	[sender_id] [int] NULL,
	[trans_id] [int] IDENTITY(1,1) NOT NULL,
	[trans_payment] [float] NOT NULL,
	[trans_status] [bit] NULL,
	[trans_time] [datetime2](6) NULL,
	[transaction_id] [varchar](255) NULL,
	[type] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[trans_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_conversation]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_conversation](
	[user_id] [int] NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[conversation_id] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[account_balance] [float] NULL,
	[is_locked] [bit] NULL,
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[gender] [varchar](6) NULL,
	[create_at] [datetime2](6) NULL,
	[what_role] [varchar](20) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](100) NULL,
	[password_hash] [varchar](255) NOT NULL,
	[reset_password_token] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[violationwords]    Script Date: 7/8/2024 11:23:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[violationwords](
	[violation_level] [int] NOT NULL,
	[word_id] [int] IDENTITY(1,1) NOT NULL,
	[word] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[word_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categoriesinfo] ON 

INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (1, N'Fashion', N'Category related to fashion influencers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (2, N'Technology', N'Category for tech reviewers and experts')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (3, N'Fitness', N'Category for fitness trainers and health experts')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (4, N'Travel', N'Category for travel bloggers and adventurers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (5, N'Food', N'Category for food critics and chefs')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (6, N'Beauty', N'Category for beauty and skincare experts')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (7, N'Lifestyle', N'Category for lifestyle coaches and personal development')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (8, N'Gaming', N'Category for gaming streamers and reviewers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (9, N'Education', N'Category for educational content creators')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (10, N'Entertainment', N'Category for entertainers, comedians, and performers')
SET IDENTITY_INSERT [dbo].[categoriesinfo] OFF
GO
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([comment_id], [commenter_id], [is_violation], [rating_value], [receiver_id], [created_at], [comment_content]) VALUES (1, 1, 0, 5, 2, CAST(N'2024-07-08T10:30:27.8339870+07:00' AS DateTimeOffset), N'-10 điểm về sự nhiệt tình ')
SET IDENTITY_INSERT [dbo].[comment] OFF
GO
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-20T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-21T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-22T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-23T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-24T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-25T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-26T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (0, 1, 1, NULL, 0, 0, 0, 0, N'', N'Đại Nhân', N'', N'')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 5, 2, CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), 100000, 200000, 150000, 120000, N'Kon Tum', N'user1', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 3, CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), 100000, 200000, 150000, 120000, N'Gia Lai', N'user2', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 4, CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), 100000, 200000, 150000, 120000, N'Kiên Giang', N'user3', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 5, CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Duong', N'user4', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 6, CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Ninh', N'user5', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 7, CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), 100000, 200000, 150000, 120000, N'Hoà Bình', N'user6', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 8, CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'user7', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 9, CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'user8', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 10, CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'user9', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 11, CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Liêu', N'user10', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 12, CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), 100000, 200000, 150000, 120000, N'Ð?ng Tháp', N'user11', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 13, CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Phòng', N'user12', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 14, CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), 100000, 200000, 150000, 120000, N'Bình Duong', N'user13', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 15, CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'user14', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 16, CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), 100000, 200000, 150000, 120000, N'Hung Yên', N'user15', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 17, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'user16', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 18, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'H? Chí Minh', N'user17', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 19, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'B?n Tre', N'user18', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 20, CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), 100000, 200000, 150000, 120000, N'Nam Ð?nh', N'user19', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 21, CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), 100000, 200000, 150000, 120000, N'Hoà Bình', N'user20', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 22, CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), 100000, 200000, 150000, 120000, N'An Giang', N'user21', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 23, CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c K?n', N'user22', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 24, CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Tinh', N'user23', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 25, CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c K?n', N'user24', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 26, CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Giang', N'user25', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 27, CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'user26', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 28, CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Nam', N'user27', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 29, CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), 100000, 200000, 150000, 120000, N'Cao B?ng', N'user28', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 30, CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), 100000, 200000, 150000, 120000, N'Ð?ng Nai', N'user29', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 31, CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Ninh', N'user30', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 32, CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Duong', N'user31', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 33, CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Giang', N'user32', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 34, CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), 100000, 200000, 150000, 120000, N'Nam Ð?nh', N'user33', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 35, CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Giang', N'user34', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 36, CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), 100000, 200000, 150000, 120000, N'H?u Giang', N'user35', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 37, CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), 100000, 200000, 150000, 120000, N'Hung Yên', N'user36', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 38, CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), 100000, 200000, 150000, 120000, N'Ð?k L?k', N'user37', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 39, CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), 100000, 200000, 150000, 120000, N'Khánh Hòa', N'user38', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 40, CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'user39', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 41, CAST(N'2024-07-08T01:05:36.9026590' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Tinh', N'user40', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', NULL)
GO
SET IDENTITY_INSERT [dbo].[request_representatives] ON 

INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (1, 3, 2, CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-09T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (2, 3, 5, CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-09T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (3, 3, 7, CAST(N'2024-11-01T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-01T17:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[request_representatives] OFF
GO
SET IDENTITY_INSERT [dbo].[requests] ON 

INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 2200000, 1, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), NULL, N'Đà Nẵng', N'- Làm PG quán nhậu trong mấy ngày trên', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 120000, 2, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), N'An Giang', N'- Làm đại sứ thương hiệu cho mĩ phẫm blabla', N'REPRESENTATIVE', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 800000, 3, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), NULL, N'An Giang', N'-123123123', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 800000, 4, 0, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2), N'An Giang', N'sadasdasd', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 120000, 5, 0, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), N'An Giang', N'sdfsdf', N'REPRESENTATIVE', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (1, 11, 6, 0, 0, 1, NULL, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2), N'An Giang', N'asdfaf', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (1, 11, 7, 0, 0, 1, NULL, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-11-01T17:00:00.0000000' AS DateTime2), N'An Giang', N'sdfsdf', N'REPRESENTATIVE', NULL)
SET IDENTITY_INSERT [dbo].[requests] OFF
GO
SET IDENTITY_INSERT [dbo].[transactionhistory] ON 

INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (1, NULL, NULL, 1, 10000000, 1, CAST(N'2024-07-08T02:16:40.0000000' AS DateTime2), N'14498672', N'PAY_IN')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (2, 1, 1, 2, 2200000, 1, CAST(N'2024-07-08T02:42:16.2680000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (2, 2, 1, 3, 120000, 1, CAST(N'2024-07-08T03:41:27.8720000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (2, 3, 1, 6, 800000, 1, CAST(N'2024-07-08T02:57:26.0430000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (2, 4, 1, 7, 800000, 0, CAST(N'2024-07-08T03:24:07.4610000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (2, 5, 1, 8, 120000, 0, CAST(N'2024-07-08T03:24:25.9120000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (NULL, 6, 1, 9, 11, 0, CAST(N'2024-07-08T04:00:14.1800000' AS DateTime2), NULL, N'PAY_FOR')
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type]) VALUES (NULL, 7, 1, 10, 11, 0, CAST(N'2024-07-08T04:00:39.4910000' AS DateTime2), NULL, N'PAY_FOR')
SET IDENTITY_INSERT [dbo].[transactionhistory] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1559978, 0, 1, N'OTHER', CAST(N'2024-07-07T18:01:27.9050000' AS DateTime2), N'USER', N'user', NULL, N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (7521000, 0, 2, N'FEMALE', CAST(N'2024-07-08T01:05:36.8817140' AS DateTime2), N'KOL', N'user1', N'user1@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 3, N'MALE', CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), N'KOL', N'user2', N'user2@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 4, N'FEMALE', CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), N'KOL', N'user3', N'user3@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 5, N'MALE', CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), N'KOL', N'user4', N'user4@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 6, N'FEMALE', CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), N'KOL', N'user5', N'user5@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 7, N'MALE', CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), N'KOL', N'user6', N'user6@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 8, N'FEMALE', CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), N'KOL', N'user7', N'user7@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 9, N'MALE', CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), N'KOL', N'user8', N'user8@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 10, N'FEMALE', CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), N'KOL', N'user9', N'user9@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 11, N'MALE', CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), N'KOL', N'user10', N'user10@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 12, N'FEMALE', CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), N'KOL', N'user11', N'user11@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 13, N'MALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user12', N'user12@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 14, N'FEMALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user13', N'user13@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 15, N'MALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user14', N'user14@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 16, N'FEMALE', CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), N'KOL', N'user15', N'user15@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 17, N'MALE', CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), N'KOL', N'user16', N'user16@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 18, N'FEMALE', CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), N'KOL', N'user17', N'user17@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 19, N'MALE', CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), N'KOL', N'user18', N'user18@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 20, N'FEMALE', CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), N'KOL', N'user19', N'user19@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 21, N'MALE', CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), N'KOL', N'user20', N'user20@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 22, N'FEMALE', CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), N'KOL', N'user21', N'user21@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 23, N'MALE', CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), N'KOL', N'user22', N'user22@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 24, N'FEMALE', CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), N'KOL', N'user23', N'user23@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 25, N'MALE', CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), N'KOL', N'user24', N'user24@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 26, N'FEMALE', CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), N'KOL', N'user25', N'user25@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 27, N'MALE', CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), N'KOL', N'user26', N'user26@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 28, N'FEMALE', CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), N'KOL', N'user27', N'user27@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 29, N'MALE', CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), N'KOL', N'user28', N'user28@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 30, N'FEMALE', CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), N'KOL', N'user29', N'user29@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 31, N'MALE', CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), N'KOL', N'user30', N'user30@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 32, N'FEMALE', CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), N'KOL', N'user31', N'user31@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 33, N'MALE', CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), N'KOL', N'user32', N'user32@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 34, N'FEMALE', CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), N'KOL', N'user33', N'user33@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 35, N'MALE', CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), N'KOL', N'user34', N'user34@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 36, N'FEMALE', CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), N'KOL', N'user35', N'user35@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 37, N'MALE', CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), N'KOL', N'user36', N'user36@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 38, N'FEMALE', CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), N'KOL', N'user37', N'user37@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 39, N'MALE', CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), N'KOL', N'user38', N'user38@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 40, N'FEMALE', CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), N'KOL', N'user39', N'user39@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 41, N'MALE', CAST(N'2024-07-08T01:05:36.9026590' AS DateTime2), N'KOL', N'user40', N'user40@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
/****** Object:  Index [UK_pmrngec2vywy21t6i3y64i0pv]    Script Date: 7/8/2024 11:23:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_pmrngec2vywy21t6i3y64i0pv] ON [dbo].[request_representatives]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ftaruaeajpk9sdcbipf9y57em]    Script Date: 7/8/2024 11:23:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_ftaruaeajpk9sdcbipf9y57em] ON [dbo].[transactionhistory]
(
	[transaction_id] ASC
)
WHERE ([transaction_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_qwdhbpj6th5m3kmaldn6mcnor]    Script Date: 7/8/2024 11:23:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_qwdhbpj6th5m3kmaldn6mcnor] ON [dbo].[transactionhistory]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_r43af9ap4edm43mmtq01oddj6]    Script Date: 7/8/2024 11:23:43 AM ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UK_r43af9ap4edm43mmtq01oddj6] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_6dotkott2kjsp8vw4d0m25fb7]    Script Date: 7/8/2024 11:23:43 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_6dotkott2kjsp8vw4d0m25fb7] ON [dbo].[users]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKawn9hd2qnh51bbt1ss1fonejl] FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKawn9hd2qnh51bbt1ss1fonejl]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKgaxm9ywyh7xh7qvsjfjwe9s5f] FOREIGN KEY([commenter_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKgaxm9ywyh7xh7qvsjfjwe9s5f]
GO
ALTER TABLE [dbo].[commentviolation]  WITH CHECK ADD  CONSTRAINT [FK1512dftkac1r5b6i4o1yl82gl] FOREIGN KEY([comment_id])
REFERENCES [dbo].[comment] ([comment_id])
GO
ALTER TABLE [dbo].[commentviolation] CHECK CONSTRAINT [FK1512dftkac1r5b6i4o1yl82gl]
GO
ALTER TABLE [dbo].[commentviolation]  WITH CHECK ADD  CONSTRAINT [FKm26fqehse4g7rel1vdro1nxfv] FOREIGN KEY([word_id])
REFERENCES [dbo].[violationwords] ([word_id])
GO
ALTER TABLE [dbo].[commentviolation] CHECK CONSTRAINT [FKm26fqehse4g7rel1vdro1nxfv]
GO
ALTER TABLE [dbo].[day_request]  WITH CHECK ADD  CONSTRAINT [FKnjlvfr93jqftab5rrdv3ktu9u] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[day_request] CHECK CONSTRAINT [FKnjlvfr93jqftab5rrdv3ktu9u]
GO
ALTER TABLE [dbo].[media_profile]  WITH CHECK ADD  CONSTRAINT [FK3xru5lnhu6gdtn5u9xfi02o5s] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([user_id])
GO
ALTER TABLE [dbo].[media_profile] CHECK CONSTRAINT [FK3xru5lnhu6gdtn5u9xfi02o5s]
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD  CONSTRAINT [FKnk4ftb5am9ubmkv1661h15ds9] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[notification] CHECK CONSTRAINT [FKnk4ftb5am9ubmkv1661h15ds9]
GO
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FKs14jvsf9tqrcnly0afsv0ngwv] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FKs14jvsf9tqrcnly0afsv0ngwv]
GO
ALTER TABLE [dbo].[profile_categories]  WITH CHECK ADD  CONSTRAINT [FKfaeiqns6dbmacis0ly2s5o6ia] FOREIGN KEY([user_id])
REFERENCES [dbo].[profile] ([user_id])
GO
ALTER TABLE [dbo].[profile_categories] CHECK CONSTRAINT [FKfaeiqns6dbmacis0ly2s5o6ia]
GO
ALTER TABLE [dbo].[profile_categories]  WITH CHECK ADD  CONSTRAINT [FKi15awrec4bbbjej2fbaan3o1h] FOREIGN KEY([category_id])
REFERENCES [dbo].[categoriesinfo] ([category_id])
GO
ALTER TABLE [dbo].[profile_categories] CHECK CONSTRAINT [FKi15awrec4bbbjej2fbaan3o1h]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK1dw2gwqqspkllnye2ylaiabqx] FOREIGN KEY([comment_id])
REFERENCES [dbo].[comment] ([comment_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK1dw2gwqqspkllnye2ylaiabqx]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK88cok9gyod0nrsbwg18mi66v6] FOREIGN KEY([report_user])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK88cok9gyod0nrsbwg18mi66v6]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FKhxlcmvsqq4b3jawr0mtplwads] FOREIGN KEY([reported_user])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FKhxlcmvsqq4b3jawr0mtplwads]
GO
ALTER TABLE [dbo].[request_categories]  WITH CHECK ADD  CONSTRAINT [FK5cxp1dglvxvjc9o5ppafb4wn7] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_categories] CHECK CONSTRAINT [FK5cxp1dglvxvjc9o5ppafb4wn7]
GO
ALTER TABLE [dbo].[request_categories]  WITH CHECK ADD  CONSTRAINT [FKl1thwnslpbm7q5wvxkh41rdb] FOREIGN KEY([category_id])
REFERENCES [dbo].[categoriesinfo] ([category_id])
GO
ALTER TABLE [dbo].[request_categories] CHECK CONSTRAINT [FKl1thwnslpbm7q5wvxkh41rdb]
GO
ALTER TABLE [dbo].[request_representatives]  WITH CHECK ADD  CONSTRAINT [FKmvgcq5h6429ow0tuwrdkf8djs] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_representatives] CHECK CONSTRAINT [FKmvgcq5h6429ow0tuwrdkf8djs]
GO
ALTER TABLE [dbo].[request_wait_list]  WITH CHECK ADD  CONSTRAINT [FKixedg52nfrc6dyhtvgik1ii9] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_wait_list] CHECK CONSTRAINT [FKixedg52nfrc6dyhtvgik1ii9]
GO
ALTER TABLE [dbo].[request_wait_list]  WITH CHECK ADD  CONSTRAINT [FKt7jq5crr6hhm57jt56a0yd482] FOREIGN KEY([responder_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[request_wait_list] CHECK CONSTRAINT [FKt7jq5crr6hhm57jt56a0yd482]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FK61tiajfpj7rnd6vfffouni3ia] FOREIGN KEY([responder_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FK61tiajfpj7rnd6vfffouni3ia]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FKeoax2t4j9i61p9lmon3009tr4] FOREIGN KEY([requester_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FKeoax2t4j9i61p9lmon3009tr4]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FKdn5svbxyacce1gpfiawk7iqtc] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FKdn5svbxyacce1gpfiawk7iqtc]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FKph5lnau95vs8pq7o11kutc9p9] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FKph5lnau95vs8pq7o11kutc9p9]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKel1jtd3x1iohuxaqfi5x1do4e] FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKel1jtd3x1iohuxaqfi5x1do4e]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKmc1gpglhvtqepa1nwgdggkbew] FOREIGN KEY([conversation_id])
REFERENCES [dbo].[tb_conversation] ([id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKmc1gpglhvtqepa1nwgdggkbew]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKr6x5njynwtyqw7p2slacvr6af] FOREIGN KEY([recipient_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKr6x5njynwtyqw7p2slacvr6af]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FK3k6vj5im7dye9gjxwaais1av4] FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FK3k6vj5im7dye9gjxwaais1av4]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FK45q09bwlpjs04ay8bm0i1sqq3] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FK45q09bwlpjs04ay8bm0i1sqq3]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FKikp5febooy027fkrg8fttk3w4] FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FKikp5febooy027fkrg8fttk3w4]
GO
ALTER TABLE [dbo].[user_conversation]  WITH CHECK ADD  CONSTRAINT [FK1ku1u4d2bmps059vypee7c702] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_conversation] CHECK CONSTRAINT [FK1ku1u4d2bmps059vypee7c702]
GO
ALTER TABLE [dbo].[user_conversation]  WITH CHECK ADD  CONSTRAINT [FKlmaq6skixvxsqglg8b2osni5x] FOREIGN KEY([conversation_id])
REFERENCES [dbo].[tb_conversation] ([id])
GO
ALTER TABLE [dbo].[user_conversation] CHECK CONSTRAINT [FKlmaq6skixvxsqglg8b2osni5x]
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD CHECK  (([type]='SUBMIT' OR [type]='REQUEST' OR [type]='ACCEPT_REQUEST' OR [type]='JOIN_REQUEST' OR [type]='MONEY' OR [type]='ACCOUNT'))
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD CHECK  (([request_status]>=(0) AND [request_status]<=(3)))
GO
ALTER TABLE [dbo].[tb_conversation]  WITH CHECK ADD CHECK  (([type]='GROUP' OR [type]='PRIVATE'))
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD CHECK  (([type]='PAY_FOR' OR [type]='PAY_IN'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([gender]='OTHER' OR [gender]='FEMALE' OR [gender]='MALE'))
GO
USE [master]
GO
ALTER DATABASE [SWP391] SET  READ_WRITE 
GO
