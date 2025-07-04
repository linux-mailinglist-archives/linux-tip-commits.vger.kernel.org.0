Return-Path: <linux-tip-commits+bounces-6001-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CEAF91C9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0EE3AEBA9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75729D19;
	Fri,  4 Jul 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v8ZSQHYo"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FD2BE621;
	Fri,  4 Jul 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629616; cv=fail; b=eu60JBg8O/uZlSIvJUYnoWGsZ8IMaDpHeH93BSTAY7FYqI8HuRnHF21IInovTHq0RdIrs1Ln1sytZyqFrjvu5r/OeT/FgF2fwwCZ+h7QvbWBXgkydS9o98ITRlYPhttpgrepW4lCUIfmS3daxzENTL8xQr7FprqKVdGQVtm0J8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629616; c=relaxed/simple;
	bh=+UjnR/I2nQoIMj1CKQK3Bpqz43guDZI3T8O8kMrUfq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6ZuFXuKw14QHboVtNiOCyBHXXlLKeuH5LdbSIcstmxVmQ4qVtYLWTp9AI8udkh7iG711G13W15kglNYc5Pk3iofBVa/NPQ59YsZep79UnE/tpSpJOneeyjOtcXFPUUh6u61fhuY4MgDNMjpy2Q7h+GakdKkm//R4sQDfH5hABk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v8ZSQHYo; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF91YkfoIFXIrsXx37nF5MlQPISe1IU1THT/7GNt1ur8ZgKOcRKqXEApUtONfGqNnyQrxCOCykAZMTUoeKE+uRfHYNgI31tG93PI5xn6I858V6LzDmGPDWXbluhxN+yzr7dutTB34IPI+8HaQiDbESkHhXS/TDye981Vufp2Cuqxk8fTtzOZWolsC1c7cc5C5GSHWWtU/r0E3sr2EEXiToc1qY6Ahvohre5KUbHIQTl1cwI7a7Prkmi2PcQssqtS5Lfu6Me1B97HTkRRbyCjukPKJEfztqTJ5NG8IG48QSxYHsji9YR4eLh4rLAM66sFA34jw74ECaKSN4kuP8sVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zph5Z3A+Gt/dOShikSATWyUj2O+fig19Mpl4ekXfhl0=;
 b=v+zk9UpDlmRz18oVRMdTY6ANdVYe+bl7Ii2Mb34OtxKzTUFR1D1i35LuabK5KEzdVGQOr1tMwh0CjRn9N3EnZE/z1o6FjPL6N2UOBGpbGO9veUy8wCRKv4HDEnf+F+v3dK/TeR8ZlNxAMfvn3RIO0P5BdVx9A3XOmye7iCte9sf8RJ03xvUomBgX5X31q1lxu1vFJXrbHD9KiaPTsnBWdAX1rIDL8w154Q+JDNbTtPYWrXhGS/maLSTNRxVVRx/pyrC66yuMmcOjBD6GuifSZhhR1sUSYDgh1x0nQALEQQvAj0DZLjROOHna9V2/SdOJJ5ijZoLxdcnOhM8gJQbodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zph5Z3A+Gt/dOShikSATWyUj2O+fig19Mpl4ekXfhl0=;
 b=v8ZSQHYooC+j1Gm/1TT7wwWhLOhxWDv7Ad2ZTnoiRH2BuqtxF7YjryGB+Qpi4b+e+xS/hTk7nlqEH/jhZhcCtnRSNotYMxf93oXi2TwNImeoPyunIriMG3NARDaLowLw33IfWskrVg25DqTfk3/RW1VvLVbEbGn2udBfmN5hR+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 11:46:52 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 11:46:50 +0000
Message-ID: <c3e97fe5-f058-4958-8660-a661f6a662a3@amd.com>
Date: Fri, 4 Jul 2025 17:16:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
 <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
 <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e2e98c-e130-47dd-d623-08ddbaf0769e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkVaVjBYT0hJVzgvZEZXcEwyYmFibTcrYnYreDRDdktrbWxmWVFyYW9KRG9n?=
 =?utf-8?B?TGxaZ2gyTVk5UXBhWmZYMTliaGpYVUtIZDJBOENGYVdIcGxyM0RoRzZwZHQ4?=
 =?utf-8?B?MTJwWVNtZHdlYVNpTmVoamhyZU9EN25RT240eDJ6aGhVYkh2RThTa1U5Q2VQ?=
 =?utf-8?B?NGJzYlZRczVhRG5CNzFNWXhuZlNsaTAxanlLc2l6RTRkZkl6ei9Mc0pqSnJj?=
 =?utf-8?B?QjlDWjhHZ0ErVnlSNlBwdTEwWlZMd01zZ0pqWk9RT3NHVHBFUERjdklWRHZY?=
 =?utf-8?B?Q1VNUk5lcnpRZzVRcEFaaldnam5MeGlmcHlDRDNVRVl4aldjLzlXWGFvN2F2?=
 =?utf-8?B?MjNmamFjTURIRW94ODFKbjFMZmI4WTJERmtmdjQ5T1Ewa1daT1JJb210WnIw?=
 =?utf-8?B?Tkg4RG8xUlVNcVpUU2MvS1p1ZG5PYkk3UlRJbjVLVjhJTzJiV1piWk5sdlRy?=
 =?utf-8?B?K3o3azFjY3hybENCZlp0SDBqNDVINmtLZ1ZTUndLcDRkRVJyTnJ2NVV4S2Qx?=
 =?utf-8?B?SzNGZVRQcGRuM0ZpSXlIa0pRaDBZOVJlcnA2RlNxVG01K0xCWUFmQVpndDNY?=
 =?utf-8?B?Rk1hVGhHTTdOVG1LOUlUc1dKL1V1aU1sMWo4UHRCNXNPbkZDejRzdGhiSFcw?=
 =?utf-8?B?ZkxxS0l3Y1hNOHZNSW0yNythUElNMklwdGJFd3BxbGQrZ2VoWllrUFpaUjVs?=
 =?utf-8?B?ampxa0RJSGpMSUMyREQ4QXZ0eE1tejNNOUJvM0tGZXBWYkZTNXBCYyszWVdV?=
 =?utf-8?B?ZVJ3NFIrQmg5ZHFoTC80d1lUSVlJczFUZ29RYmd2OUpIRjdQR3kxdCsrSmIx?=
 =?utf-8?B?SFQ3MXgzeTVtcEYvS3l5bDRMQmo1TnVzSS9lVmd2MUhhM1FrazB6Um9sZTFJ?=
 =?utf-8?B?RzdLQy9YY1dSdGFvYTFaZnZ2US9NNzc4MUwrZ3hiOCs1WnFmbXgvc1RxMzBD?=
 =?utf-8?B?a2U3VVhzazB0c1Y5U0RlOWVNYTdNVzFBK1FlYWkxMmp0VGQ0YThMcHBoVmNH?=
 =?utf-8?B?OVl0KzQ0Yy9uT3VmR0RwN0FVQkFUV21Pa2hvY2JIRjBWWFR4K0VmTVNmNUlQ?=
 =?utf-8?B?NGZRMHYxTnJxSDlDNHZGbDdlMVZHVHVGd1d6OWhYdFVoTEV5bUdCUS9jSnda?=
 =?utf-8?B?ekUrTkJCN01mMG1lcW94QWhTL0FwYkUvRit2bUJyQ2QyckxuNE0rRXZpQlNB?=
 =?utf-8?B?RjRyNWYwZjMxVTJYSmhGNW95bTlLQkM4a3gyMkNkWFNHSzNLdVlFWDJaWWU2?=
 =?utf-8?B?eFdnOFpxZWNScVFsRDEzYlBRYXRwQUQrRFE2VkpSNHFVMVNTbHhpa3NHMXpJ?=
 =?utf-8?B?anVhanJrRVRnNXpEUjVHOUtCZHAyQnpyckZxeXU2elRyMERXdFY0TzNsMlpI?=
 =?utf-8?B?UElPaUY4NVFpTGdkRE1VQmdLbFJ5WjUvM0RPNjc2THg2Rmd0MTJxd3ZvQ1Qz?=
 =?utf-8?B?NjRrZE5vZEFsN0tvZTc3Q1VzOUNFaHR4dlNCYlV5eXZKUnAwY1Y3cm1aMWk4?=
 =?utf-8?B?UW8vdEVQSVdyNE00TElGOUVobUlmb05FaFZaa0Zxd0Q4OU5penpYWm1rVjdB?=
 =?utf-8?B?a2VrcmM3eU84QjA4VFJ1SGtvMkxLVlg5MzNpdkZiUWRMSjNscDBqQXViVXcw?=
 =?utf-8?B?S3Jib2NOTE9VbDQ4MkJ0RGJsSW1KYkp4OGJyalRDZmZYY1FKNS95ZzdzL0tw?=
 =?utf-8?B?UmR2YVRwZVpOeXlaT21IdlZva1dqbFkxMkdXTXN3Y05Lc3R1QllpamR6d2dz?=
 =?utf-8?B?WDFDcjJZNHpyMDR4eDh6d3hJbWtkdloreUxORW1xWGVOM0tPL0cwUDRCdFlN?=
 =?utf-8?B?djhsbHduNDhPcGxlS1puRGlGVGh4Nmw5RmllSnc5UjY4MGVXVExGYVgycUFH?=
 =?utf-8?B?TWdQYVlHczRzRFVTY2Vxb1dkR0daV2VWTFZFVU1ZcEViOWgzdWRGVDJFbjJo?=
 =?utf-8?Q?vY9c3FS3B3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1HbUZOeVpHQlVmbWlMbzVjZWRzSTRsWENkNzNkTjdqVnJWUmhGR0NNd3NP?=
 =?utf-8?B?Q3dOemFLeHozSTBKTEZsNytkR3dNUmdmMWtvL1RPY2NNczFGK2FnTWRyN3ZU?=
 =?utf-8?B?UXJSU21STDBmaVE3L2xaSHJwVVgrLzljeE9GVmdKcTI2SHZRcGZMUHlkYStq?=
 =?utf-8?B?WTI0ZDVqd2RzUmVWTFI5SGtzdzZMTkdiNEYrd2VqQW5DckpVVlZsMG1LckRE?=
 =?utf-8?B?R092YlBURlNoazZjL3dYc21iUEtHVEpIZUZWVi9lVjRJU2k1UmJ3dzZNbDdW?=
 =?utf-8?B?Yk9oeHJXa3AvUWg3eUVHKzQzdjAzd3Y4UHVvcFNsQnVXVFdqT0NEbUhaajFt?=
 =?utf-8?B?N3Ewak9qNm8wVHBVOHVWckR4YlZRNTBEVXRyZnRnMTMxTHFjQ0xONnBYNDN5?=
 =?utf-8?B?dEVqRnRoQ2k4Zm9TdHJMcjFmZnBac0pHQzdoSkNyRklxNmZoSnRJUDc5SkJZ?=
 =?utf-8?B?WUNqcTBnRUJqMzkwdGdDbmxiRFhsQmZCeWFIUGhXMytkUWRFcktFSko4bUlm?=
 =?utf-8?B?SjhiaEk4R2lLUTcrSm1iWk91SXRMZXRpWjVnVkFTVXl6NkVyZVhrZXpZNDFU?=
 =?utf-8?B?cjJDTmVrVDRHbkV5QmR2Z0FVMmd6UFFTMk1nNHg4ZDNHSXZ2S3FoWTk5OVky?=
 =?utf-8?B?ZXZOMHNyUFRiMHRNQ2tHZWxJSUt0NTdiSHJnd2cvMFY2QjJJVEZ1cUtCZk1E?=
 =?utf-8?B?Mjl0QnkwNHJkK3BQeG96WG5Bb3pPazlPWWt2cFFXaXRubzdnMFp3YmR3RlVU?=
 =?utf-8?B?d2FGdWlpTEJ3OVJqeHdpL05vRWtjRmpkNUJyNUptM1d6UVFFaG9UZ1l0ZnQ2?=
 =?utf-8?B?Vyt4RldlU2VCU21ORlJhdW9wUFZkY2lZRU5RWXpNdmdVd3l2VE9pZERuSlJQ?=
 =?utf-8?B?ZTJpUnZmVFpzOC80OW1heXZCUDV3aUsyRStpa2ZMVTFJdERHUm5McnNpNldP?=
 =?utf-8?B?Z2JiSjlscE5PY1dPNHlvbzBPL0k5WEtIWnpnYkJKVjhFQks1aUlVTWZMWlky?=
 =?utf-8?B?NDlnUklIS2lHdVJ0S3RGdUJMRytwZlVBamlGREV4OG5sSzFoQ1RvZ2VFOVFl?=
 =?utf-8?B?ZUh3a3F1d1RJUEMwemxqaE9sL3k1NkhIYUdDSGxkeVRPRm13bVRyWHVEbmV6?=
 =?utf-8?B?Q0NxQ1Jzei9XU3liVFcvbkhKWkIwV3VTWDBaMzkxbFdURFBCdGJNYkM0TWx0?=
 =?utf-8?B?YkhoQUZZQ0ZQQjU2cVhmNVA4enhWcXQ5S3V5NFlURFRjbGdjc3J2ekJ3dGtZ?=
 =?utf-8?B?YmZuUkxEeU5VNFY2aU9LdU9MVzdLZ1dHOVMyMmtjdjRkWGRQNHgrZVYwVHQ0?=
 =?utf-8?B?d2V5cWEycnE0SUE5TFhEYjRIVTRvTm5GSi9TR3B1YkVXeTF0dmpQSEdTWkIr?=
 =?utf-8?B?R2JwTk40QU9RdmtTdDB0UWNnSno4ZUs1QklUdm82aVZjcy8rTGZQMlhyUnJB?=
 =?utf-8?B?aDl4MUNVQlJFc0lsUGNHSjY1UEZtQ291ZldkN1VTVlI4cHpCamNacGFxYlcx?=
 =?utf-8?B?T1dVcm9lMGxuTjBTNEtGcHlOWDJpYk9iUFVBU3Q1V3lkVXIvK20vcmNNenhN?=
 =?utf-8?B?elJMcjlHeGo3aEt3MUVwRmdPa2c2RVJQcjF2c043ZEVxVTM1TSszdnJqWGI2?=
 =?utf-8?B?ZFZIQlNsRHNoQkQ0VnpnQzUyVnduTzJTNXR1QmowMFozaVl2Q3dsbU9KdUND?=
 =?utf-8?B?RGtZdEE4VE5wcmFwbkp1T3VXMVNXNnh0OHVaYXR3OVZlRVJkOUdubTByMC82?=
 =?utf-8?B?RU9aN3B1S0JLbktEMFVvd2FEc3ZxYlFhTXIxQzNuWWRaRFlIUzdtVW1BcUVz?=
 =?utf-8?B?Z2QxQzhrL3NCN0F3TE5EY1ljOHNTNGhoOWFpM2pSa0FNeFdqb1BZcnpoc05n?=
 =?utf-8?B?ZFVwUGl5VkJmSVpZOHo0MFFBYUJXZXgwcU1qZmR6UmR5NEUwWnpPOTBOK2o0?=
 =?utf-8?B?UnhqYWxsUTIwQUFkM0NpVDN2WDFVVDJQNHpVaDFxTXpzT0JkSXN0cEJIRmlH?=
 =?utf-8?B?TWpneHZBUm9hZXM4anM2SUxQUmNLVGpqcDNRaGdFMGZTcVpTazZEWG15SDZs?=
 =?utf-8?B?NERlaTV4QzhJUVJiOG01MkNuM0pQMDlkRFFUWmUrN0didDlLVTVhcWlDaU5K?=
 =?utf-8?Q?dAdtF+NvBWB0KYzHGSutxs3Do?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e2e98c-e130-47dd-d623-08ddbaf0769e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 11:46:50.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5cwInEIcVwHMoC2y+YPciPoGoT6DPK0feZ84u39jK7wmc5FaIGgdDdVtMYIJ2RinCLvmG/55Qg8QgKZmSMsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497

Hello Boris,

On 7/4/2025 3:51 PM, Borislav Petkov wrote:
> On Fri, Jul 04, 2025 at 09:13:16AM -0000, tip-bot2 for K Prateek Nayak wrote:
>> The following commit has been merged into the sched/urgent branch of tip:
>>
>> Commit-ID:     02bb4259ca525efa39a2531cb630329fb87fc968
>> Gitweb:        https://git.kernel.org/tip/02bb4259ca525efa39a2531cb630329fb87fc968
>> Author:        K Prateek Nayak <kprateek.nayak@amd.com>
>> AuthorDate:    Mon, 30 Jun 2025 06:10:59
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Fri, 04 Jul 2025 10:35:56 +02:00
>>
>> sched/fair: Use sched_domain_span() for topology_span_sane()
> 
> My guest doesn't like this one and reverting it ontop of the whole tip lineup
> fixes it.
> 
> Holler for more data if needed.

In an attempt to solve a complicated case, I think I overlooked the
simplest one. In your case, the PKG and NODE domain should have same
span (and covers all the CPUs in the system) and the
build_sched_domain() loop skips building the NODE domain altogether
since PKG has all the online CPUs.

Can you try the below incremental diff on top of this patch and
let me know if you still hit the error:

(Lightly tested on QEMU)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0e46068acb0a..cce540fe36c6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2423,6 +2423,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
  			struct cpumask *sd_span = sched_domain_span(sd);
  			int id;
  
+			/*
+			 * If the child already covers the cpumap, sd
+			 * remains un-initialized. Use sd->private to
+			 * detect uninitialized domains.
+			 */
+			if (!sd->private)
+				continue;
+
  			/* lowest bit set in this mask is used as a unique id */
  			id = cpumask_first(sd_span);
  
---

Thank you for the report and sorry for the oversight. Hope I have not
disrupted your Feierabend.

P.S. I'm used the below cmdline to reproduce this:

   sudo ~/dev/qemu/build/qemu-system-x86_64 -enable-kvm -cpu host -m 20G \
   -smp cpus=10,socket=1,thread=10 -machine q35 \
   -object memory-backend-ram,size=20G,id=m0 \
   -numa node,cpus=0-9,memdev=m0,nodeid=0 \
   ...

> 
> [    0.280062] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
> [    0.282922] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.287572] smp: Bringing up secondary CPUs ...
> [    0.288623] smpboot: x86: Booting SMP configuration:
> [    0.289085] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> [    0.302358] smp: Brought up 1 node, 16 CPUs
> [    0.304445] smpboot: Total of 16 processors activated (118401.12 BogoMIPS)
> [    0.307884] BUG: unable to handle page fault for address: 0000000089c402fb
> [    0.307884] #PF: supervisor read access in kernel mode
> [    0.307884] #PF: error_code(0x0000) - not-present page
> [    0.307884] PGD 0 P4D 0
> [    0.307950] Oops: Oops: 0000 [#1] SMP NOPTI
> [    0.308344] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc4+ #1 PREEMPT(full)
> [    0.309115] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
> [    0.309934] RIP: 0010:build_sched_domains+0x627/0x1550
> [    0.310086] Code: 84 75 06 00 00 f3 48 0f bc c0 48 63 f8 89 c0 48 0f a3 05 c4 cf 95 08 0f 83 6c 06 00 00 48 8b 3c fd c0 db 29 82 49 8b 44 24 18 <48> 8b 04 07 48 8b 80 90 00 00 00 48 33 86 90 00 00 00 66 85 c0 0f
> [    0.310086] RSP: 0018:ffffc9000001fe60 EFLAGS: 00010247
> [    0.310086] RAX: ffffffff89c402f8 RBX: ffff88800cea8e40 RCX: 0000000000000001
> [    0.310086] RDX: ffffffffffffffff RSI: ffff88800ceaacc0 RDI: 0000000100000003
> [    0.310086] RBP: ffff88800cc4e3e0 R08: 0000000000000000 R09: 0000000000000000
> [    0.310086] R10: 00000000fffedb1d R11: 00000000fffedb1d R12: ffff88800ceda4c0
> [    0.310086] R13: ffff88800cea9500 R14: 0000000000000010 R15: 000000000000000f
> [    0.310086] FS:  0000000000000000(0000) GS:ffff8880f39f2000(0000) knlGS:0000000000000000
> [    0.310086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.310086] CR2: 0000000089c402fb CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.310086] Call Trace:
> [    0.310086]  <TASK>
> [    0.310086]  ? sched_init_domains+0x58/0xa0
> [    0.310086]  sched_init_smp+0x29/0x90
> [    0.310086]  kernel_init_freeable+0xa3/0x290
> [    0.310086]  ? __pfx_kernel_init+0x10/0x10
> [    0.310086]  kernel_init+0x1a/0x1c0
> [    0.310086]  ret_from_fork+0x85/0xf0
> [    0.310086]  ? __pfx_kernel_init+0x10/0x10
> [    0.310086]  ret_from_fork_asm+0x1a/0x30
> [    0.310086]  </TASK>
> [    0.310086] Modules linked in:
> [    0.310086] CR2: 0000000089c402fb
> [    0.310086] ---[ end trace 0000000000000000 ]---
> [    0.310086] RIP: 0010:build_sched_domains+0x627/0x1550
> [    0.310086] Code: 84 75 06 00 00 f3 48 0f bc c0 48 63 f8 89 c0 48 0f a3 05 c4 cf 95 08 0f 83 6c 06 00 00 48 8b 3c fd c0 db 29 82 49 8b 44 24 18 <48> 8b 04 07 48 8b 80 90 00 00 00 48 33 86 90 00 00 00 66 85 c0 0f
> [    0.310086] RSP: 0018:ffffc9000001fe60 EFLAGS: 00010247
> [    0.310086] RAX: ffffffff89c402f8 RBX: ffff88800cea8e40 RCX: 0000000000000001
> [    0.310086] RDX: ffffffffffffffff RSI: ffff88800ceaacc0 RDI: 0000000100000003
> [    0.310086] RBP: ffff88800cc4e3e0 R08: 0000000000000000 R09: 0000000000000000
> [    0.310086] R10: 00000000fffedb1d R11: 00000000fffedb1d R12: ffff88800ceda4c0
> [    0.310086] R13: ffff88800cea9500 R14: 0000000000000010 R15: 000000000000000f
> [    0.310086] FS:  0000000000000000(0000) GS:ffff8880f39f2000(0000) knlGS:0000000000000000
> [    0.310086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.310086] CR2: 0000000089c402fb CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.310086] note: swapper/0[1] exited with irqs disabled
> [    0.310091] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    0.311130] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
> 

-- 
Thanks and Regards,
Prateek


