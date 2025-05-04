Return-Path: <linux-tip-commits+bounces-5229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C74AA88E0
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5927A1106
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212824677F;
	Sun,  4 May 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzfYCnbI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856256DCE1;
	Sun,  4 May 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382109; cv=fail; b=DoEiAlIKab7UaejI1HBOJTjqj0ElNQ92YPucyQUAhm/u0Tk+ANhTDKT4xCL8eZQFVtyRfeFs5FjTwHMcMOPp0/x7s4CHB5XryG2mwF7QTPOYMbrMWHM6lI4WQNxygFSgVfhmt9teHooXGlugzj1hQc629/0XL/A45FSk9DfeWaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382109; c=relaxed/simple;
	bh=FJFZf9eGVYw4xRZwHsvh4DTfcOFXeVDg4TiDxjyxnEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q6aeWF9pIKOgdGQyPQOH5qw3REma2lNf1KYtwGfGzXeu1al6yymP+cYTRd1HLgbuDCWz1y8RFQotqSFmoSxckUU80tS3nMB+9FIcjMBM1qVBUcjcG5Zuk8HwWLMEewcLZPKL7ZI+Txx5aXqJnteVCHWgU0VoPQzgmVJIkVHmvhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzfYCnbI; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCIYpJcKOJ+oTyOBn/h5HxDvWlbfhVCep1/gUpj4MQ717nfUx2fulInautGHBTGTvmkT8WrhmM5YNrfDT8j9uQHx4cdYShKCx4vKzZmxjuPwa0JmesOoOAsgdc2ZSmC51zPk6xrYMpHvig5T48C2avzMZhfohJ7WGNxs8FA8XQ5fjRuWFSyoC9XQJa6eoffqW4S2m6KRplSfGlkZ5RwLEyL8jPP9gVk7bvgZGqAPUfO8tuSSolEKnHQQNZ6oic8q32LOqaLo9Z5ZKdxHzt0anJKRZPquGrg4H6Vnq7wvWEkafIuPisEe+cSaQkY3h1UVnUTvT34LzFw+5p98K7bM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1l1hh6xozOata6HtHNWygWruwzAeN2tPIb/oaT1nnA=;
 b=LZU4yibP9PzOCIeXRVi7gBgzpcWqYSShg7bLgaGsgH93aV1gmWtG8+7sr6b2VadU4il7IMFJdw3j6EE6tZ+zkGc1FLCrktIzbccS9yr9Nk22CTNtRHmgrI8I+p/wZzMrxBD7XqQO+WjdHF9hoBtn1X/NEZpZi3LTfOJMZqHOqmZIRLyV8SjLFu8Jueo+JTp66xW6T8Wm7Faq9ymccjRQPoIdrVBlcfZm2/FYiH3bgpHrtEI6x6P4o9sOrE3efw7HdBPXW4ANADcaTItrXGBVwKC9F293CLA77FXIuEi31Eg9i+6Rt8zKUAKSpzOPUfC/jvOMRKwB0tViQSjWj/Em2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1l1hh6xozOata6HtHNWygWruwzAeN2tPIb/oaT1nnA=;
 b=mzfYCnbIfEE2BSZTkdKsDBrF99weaJ+UhN+qmojDxCLK4evT6ieCkaKkcOLXE0j+bIuece3mddZRwxvLwDE4KRbBKRr/kVzQcHcW4MarQjEb13oWDHIWZ1geJz+snD1tl41u8/xC5BRrNlZ7zHa4qio+ee/U9FSj71DgdnyDpaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Sun, 4 May
 2025 18:08:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 18:08:23 +0000
Message-ID: <a3fc2553-6a2c-45d8-a514-bc9d43b1d525@amd.com>
Date: Sun, 4 May 2025 13:08:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Clean up the last-reset printing code a bit
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
References: <20250422234830.2840784-6-superm1@kernel.org>
 <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>
 <aBcLJxjTQGa1-r5S@gmail.com> <aBcRXYkJlfySzBEx@gmail.com>
 <20250504095212.GBaBc4zOxcAKQ26cbn@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250504095212.GBaBc4zOxcAKQ26cbn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:806:126::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: ff001e1f-8e87-4f1a-6c83-08dd8b36a8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZBUkdsQTNNSEtCZXNhdDhGcWp0amdqOU10MlhtQ2NTQUNpWEM2UXZZTktr?=
 =?utf-8?B?NUVBWjlSRitTcER6clk0dm1CQ2FsN0ZZd2hSR29vWmQ3Y1VGN245K0ErTlg1?=
 =?utf-8?B?TitUUzBGK1h5My84aFBSeDUwMWYrTWREWi8wTGNzNFZUUjAyc1JiNEptQjl2?=
 =?utf-8?B?Q05BNWxzTW11T1BlQ2VWSU9iTy82WER5d2Vmd2RtRStpSVRZRHVGbjlMRlpC?=
 =?utf-8?B?Y1ZLdXNkdnJOaXhncEJyU3lWLzVYbXZGbFA4ZjlleEdwcjJYczBVblV0Vkx3?=
 =?utf-8?B?Ym51NS9HckFKdE1jYjZ1bnUyd25EK3ZKU2l5MEVhOVNMVlMxcjVnQmxsTmdx?=
 =?utf-8?B?eHBrZDdja0xOUmxKNFEvMEtIRElQVjZLMFNwYmV3Nk9kSkQ1Mm16b1RqbC9Z?=
 =?utf-8?B?N0piVW51V25nblA0TXpnbDdpd2lrdHJiNUxSUkx5aXVPeDVac2sreDJZZnFu?=
 =?utf-8?B?dWQxTTZsTERFY3IxcE1aQmNxN21iSXZHWDNpVis2WWpYUXI1Rkprc2pVUk5C?=
 =?utf-8?B?UU5uWXhrUUlla3Y3NFBhbkdSN24xeno2MkkyRTRhN3J5V0c0V3ZTY0pPTGgw?=
 =?utf-8?B?SVFsSmVtb1R3RGpwYm1FNUl5MTJYbTNraWFTaGdncm95MXlFSjU0UDNiemtx?=
 =?utf-8?B?azliSzlyTWFFUDExaCs3eE5UdnhkazZzYkRZVnRyQkJyZzJsOUwxb3MzNVBp?=
 =?utf-8?B?WnFsNnBmdUh5TkU1WGNzVTVXb0dNcDlIYzNDWGhhVWYvdVRHeWlSSWdpT2V6?=
 =?utf-8?B?bXdMSkFyNzljcm11b2tPRVp0cHRsNXBrV0xPaVExWHR1eHdLYWllZ3FxK0Ew?=
 =?utf-8?B?cUg4RlJkZTk5YytIdG5FUENUSzhyamlFdUdjQk14OC9WR0FEeUxhaGJYNVEx?=
 =?utf-8?B?UFFEejY1eDBudC9iekQzeXgrY2M3STFvNkp5TDR6eGx4VEVWTG4zMkZRV0M2?=
 =?utf-8?B?ZWtWOXBSbDhKSDdYblJrcjB0Z1RqTjRmM0RiQXBpbDhSWk10K00wNkxySEJX?=
 =?utf-8?B?cTAzVDZPcElva2NFYlYwSHJmTTJPRTVLZEhMaHFuQklLSnZvMlliUmVUREha?=
 =?utf-8?B?MFNJbnRSUFRtOGJoMkRhcU9laWgrVUpLRmRSOU5xT2IrMFlmSm5UbXF6R1dp?=
 =?utf-8?B?aU5xcVFDNDErR3J0Q3NnWEhnUTAwKzZhVFY3cTNBcWtPNnRaQ2VUVUZRd01Y?=
 =?utf-8?B?VFh5aXpQUmNxdVZwRDZqOXg2MU00U2w1a2NUQ3g0NnQvbjNRZXVUSTh3NzlI?=
 =?utf-8?B?TkFXcStSUnlNU1VXUTdieTJ1SkFIYitZdGRSWHlGb0NzeVRQV1JFM1lJb1hx?=
 =?utf-8?B?enJXdGtpb1ZxWmtLOUxGUkJ1R3crUE9BVjlZTnY4UGFobGxxUVpsVVdmTmdq?=
 =?utf-8?B?aTBSc0JCUmVEYVJRcXlobmtJSXVJa0JGNU5pcFo1TTF4c2dpMFB3SnhoNWRH?=
 =?utf-8?B?RTN0RG45dzBqV21mRS9yTFBEYUpoeklKRTdab1NiU3dMMzJ4UDhzWFk5Vzcx?=
 =?utf-8?B?TlpFeFFvMFZvNlYrMFZLZ3M1bDlmanZlNXQvSXhUODAzMGdUMXNDbjY5cDBU?=
 =?utf-8?B?S0FtYVVoaTRidk9jOENpaEltR2E0UndSWEVGRVUvbG54WHJ6UnJSNlZmNHJV?=
 =?utf-8?B?dGIydnhHSUs1bEQ4QTBiWXJVbXlQbmhHMHY4ai9IcjZyWmhrcWsxcUFYb1kz?=
 =?utf-8?B?Z0EyN2RFenU2Szd5MUtVeTdVNTE2Si9XVjRzZWtaSGxnaVlXTEtObGJiRklw?=
 =?utf-8?B?OEltSi8vcWIxZkdXMEpYM21Wdk9GWUNaaHQ3VXcwb2UxTlBDcTBLMlRyS3dG?=
 =?utf-8?B?bDBrUzJkNXQrOUMxQkQ1QmYxNUdseVk2WkZ2VFptMWE3ZzdNdFZ4QzBQYjha?=
 =?utf-8?B?OTFyNGErT05pNGJjeHhCOE81NFNDbHhUVUpOOXhwaXJUMEFXYkdOb2RycUF0?=
 =?utf-8?Q?+btXELa/toI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azhiTnFJWnlVL1ZORTlJMUVxOFY3bzFJeEdEU3BndDFkZGRLc2xMeThKQTJB?=
 =?utf-8?B?QnNZUmt3a0FPRnlGVkdSUld0czJoUE9WM20vTmRSenA0Y290TVJWMnVQTExr?=
 =?utf-8?B?TTQrNGxyWEMzYnJRTHZINFdhaUJCeFpnc0psYnBpc2FGOS9DRGZ2d0ZxMDhN?=
 =?utf-8?B?YkFSSkd2V2NWZkpjKzVFWTJzSjdTQU1BVmlNL0pWUHFMU2R5YkkycmhxcUZE?=
 =?utf-8?B?b2YrbG5hS2puQ2ZTY2UzNUVETHR2R0drTWpGT0FsdHZFdDV2cDJjd0R0dU9O?=
 =?utf-8?B?SXlPZDZKMXhVMGJpeXNsTDFnYXJEUmRvVHNqSzRvamdxbUhOcUNkTHBSd3Z2?=
 =?utf-8?B?dXV1M3U4U3RGY21WRUpIVmxkMmRVYWN5Nko3aFZHL2RWU3hVWkZUSXpSZnlT?=
 =?utf-8?B?RVA0Y2ovcnhVcVcrWFNkbEwxOGUvaTVla1ByYXJRUmFTdTdrUTRiMUJReGtG?=
 =?utf-8?B?QUlQMVJNQ2luZCs1c3FvVVZ2MkJteU9KY1F0dHBjMnRxbjdvY0xzSS9GdXVz?=
 =?utf-8?B?MG9YNzM5TU9JOFVSSHY3eUZiY29YREJUd2ZZQXovZ0Z2Q3M1SDI5VEZNUWxk?=
 =?utf-8?B?RXlnY3pLeHFucEVEWjRQdGZuUTVMTkZxOWhiR1lrSUxnQXFsK3ZHRE4yRHVF?=
 =?utf-8?B?UnVtZGhEaUY2L3Bha2hvOUF1Q0VMSDlPQWV3RzgwOS9BeGJicHFCaW1EM0Rk?=
 =?utf-8?B?ejFQM3U1SmZBQ1BoRFpRR3FJbFM2Q25WOEJTT3p2VHVudVFoejhPK1dVK2xX?=
 =?utf-8?B?dy9GQk5MaDc3STFjTUNKMGlKTmVLQkpMcmJSTzN2RjI5bDREQ3lybmVqc016?=
 =?utf-8?B?aWRCSUg2NGZ3S2kwTzVRZ1g4SFUyUjhIQXpNZUJjOVhBVlBXUVlWUS9QRDlo?=
 =?utf-8?B?cmYyZGdJWkhjUXA0RzFCMzQxRlh1d3ZZM0ZUWnB4cVZRL0NtaldYQ3NLcmdD?=
 =?utf-8?B?cjQ3WCt1d1J4Tmh3a3lEY2RFeDRTYzVDSFdVVjZiM2plcUxUNENCZVB2WG9v?=
 =?utf-8?B?TEpmUXRpcFkrWC9va2RubVU1VVV6QTVvdU42U3BZanRMK003MmlQV1pieU9K?=
 =?utf-8?B?MVFiU3ZNYlNMcGhEOWgrSHdaMlZjdFJIYWJLcTlmcW5BTkpTa2R1VmNqUUU1?=
 =?utf-8?B?Rnk3Ym9PSGIramhPSXlwNElPejArZ3dadXYvZkErb2FJcEpGaWxKR3NKWHNM?=
 =?utf-8?B?S3FjR0JTZmRnNEplYlh5bndtemlZbVZ3bFBOQ1dGd0htQ3BOL2YyMm5EcUNq?=
 =?utf-8?B?cUFMbEdpZFcxU2JRRUYxcG9rMlBrZ2p5M3FLZ0t3c0d4RlVSSUVnVk9CY0Zh?=
 =?utf-8?B?ZGdJVWQ3TmtLNDd4RGVkU3NQWWNYM3hKNzhRbGswMVg1ZVRDQ3VpVkIxMjhw?=
 =?utf-8?B?em1KTHRIZU1ESy9PSFJJL1V1YS9sSjMvYVhxa0pJd0tZSTJSQXRKcTVCUlNE?=
 =?utf-8?B?SEQ3UkE0L2ZiSEQyODB3M2hzTDhJNlJ2bVcySmt2UUhqVTlTeWF1a2RsVUNx?=
 =?utf-8?B?QlR3WEwwcU42bXZ1NmpvVHV5bGFEbEhtY0RpUWZpRHU0Q1g1MEJDMm5adGN4?=
 =?utf-8?B?c0dWcU5hVmlKUGRnOVRjNWdSRHJQT2xSUUExOVdNUEJldWY1RmUwekE0c0dM?=
 =?utf-8?B?di9UaUVyYndqa0UvVjk2Qnl6OXRreHE4V280SDVScnhLZ01KKzl2V0JzTTRl?=
 =?utf-8?B?ZkVPdTVPamE1UkN4WS9oN3o5ZDlJUmFQaXFDSFhoeUN6ei84MDRFejdnanRL?=
 =?utf-8?B?cHdSdmkzQXBzcmRuSnFMc1FxeDNaV1pkd0lOdHFwRE8zNy9paFlYNXNqZ2tN?=
 =?utf-8?B?bVNtTzBOeUExR05wUmpsTlRHYlNuVWI3OE5sTmJXS09aTDQzU1ArRWljU3lh?=
 =?utf-8?B?VUg2eXBLRnV1SXhrVXcrM0RjUkcrOWxpMjZkNWhRZVZ4d3liUFJBYUZBeURK?=
 =?utf-8?B?bytpYThLSTBVT0tUWkxGSVdwUjg0NXlVZDV3azN1dHIxTDhjbXQ5L0ZjNE56?=
 =?utf-8?B?eThXcThwc2QvZHJTZDEwV3Z4ZUY4ZGhJWHN5UWI3MEt1dHhreU1hZE5TSnNp?=
 =?utf-8?B?VldmSjNmalV4U200WnJTcmN3WlVFQ0xFOEZhejJCQ3UvdE1sUHZ3UXVhR09m?=
 =?utf-8?Q?jWIc4hsAkFRw7l9CKvWktr2qi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff001e1f-8e87-4f1a-6c83-08dd8b36a8ab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 18:08:23.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp/a6TryElaj2eoKSzEI9oSyaHfd532r/9tGTZDv0+YuZ55H0wAlnUmMxbA0z1rhWCNJ1EoDAb1k8i38E5kD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

On 5/4/2025 4:52 AM, Borislav Petkov wrote:
> On Sun, May 04, 2025 at 09:03:57AM +0200, Ingo Molnar wrote:
>> Patch attached to clean this all up.
> 
> Ack, just merge it into Mario's original patch.
> 
> Thx.
> 

Yeah no concerns on my side to just squash it in.  If you keep it 
separate though here's a tag:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

