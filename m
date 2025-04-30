Return-Path: <linux-tip-commits+bounces-5138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F106EAA416C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5815A4A9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEE42AAF;
	Wed, 30 Apr 2025 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CPs27M+3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B92DC779;
	Wed, 30 Apr 2025 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984019; cv=fail; b=eRcbOd6+GLIEdzUl1A/4G6a8K5GcpySkLLQ6latTeS/Vft3B0OCU+tKGqhUo4eEqVUJRxJh70GG2gJOpxQQeu6XpkcckfZOjVBubvV2+njBtgYah50SVpfQbrUSQgfYZS4R6TB1W4NvV/yCRAtLyZtbsvJomZlYPkPopbxav868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984019; c=relaxed/simple;
	bh=sYBKg0xjnEaDiG/7kbg9bxO9gFTx5/iJ1Ii0J9xhqCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RG0SWJ8ZyUU9X+KiANJf1TJCBqY32C5tlj9JmZDgbnrvB+IBH+14C/n2bIY1YBJrT1RnBM84icsBrR1NKR0ub887AyHVO4JbmDxbyNG81lAvuj7RYNqQyUcL7XGlCfAlSGGImSJBYkSMdoLwPay/XC67o4r479wSUqbhtns6sKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CPs27M+3; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvv7rbrslAseoQcD42CIOSGcElrGVyguGJpx3yl3pKMWSx9TyFnimsGTsjkMoTOD46KNe63au+x6KwL+9JdxOJ9/XkjPSdEQ0t/Z24Nica1ytO+OeL78P5oHKiJouRlzUurkpQJuoda3+wUO+LxizOObXQtfKaYMzfgkAL6cZRyte/BzjSYNIoHTbFmTA3qAKmoNdynJhrr2KWzrL22xBeY5KmUJ7SS1Fe+eUchEOBMQwlv2YE39Vr+Eh86GnVJtwK6GTPSjihpqPrmeESPpv6SDU6D+2oadjBQH2P2RCs4Uk4PXj/LgiT9MA8HwFRunzWC0vuNFwyR1x6T/sJH5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/OZzCk7dQ2jPkJZhpKzWLihV1PDsLsOPWK0bne7TXw=;
 b=j/6o4caZhqNKrDmqtoYC2J/8vsA/iLVPwGwUZ5YoKZLXLQqreido5j1UocMDGgG6xfmZGukjlIBTC+SGoga3ojELHTdcd0uCVpSzwem/yHbGDXhzCWa4Ku7TVOCNBCz2Z179YlPiTvQCKZmPNZLdXb9HWvWCWsYmOF53EzxPS5nWvxbkanrEJrlZAOi/Y7InFRzjBO1H8iv0nY8xtkqH2/AlkCGoaXckadvKp4KdNJghwqupjQWHt3Se0pp7ZlwJykE+W1AIeZbiCGKXMBNikZI/nL1CU73e+XocKcoWsz1GkQRBjBDwEfvIPsfnFM08ge0C5o+3ZxJf/maAh1AFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/OZzCk7dQ2jPkJZhpKzWLihV1PDsLsOPWK0bne7TXw=;
 b=CPs27M+308gEnqtJVD3e1g4Z8hUD9pk0obdDCXCY/vAFUbKJmA7NuY0dUxH9usXKsOtHObxnrGsrSCIDM0uggyimVVZKYrxg8yKLnwxiBvpJDRXMSDgoxTnFFUhmDt0wzegRTjAsBKjn/hMfzSFWuUSMbRs94mWade/EDJYQ6jg=
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 03:33:34 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::10) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 03:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 03:33:34 +0000
Received: from [10.85.37.104] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 22:33:29 -0500
Message-ID: <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
Date: Wed, 30 Apr 2025 09:03:26 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF regression still exists
To: "Prundeanu, Cristian" <cpru@amazon.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Blake, Geoff" <blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>,
	"Doebel, Bjoern" <doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1f224d-3af6-43af-b353-08dd8797c95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YThEVXZNMzUwdWlpRWI3Q2U1VW1PTDIzTVZOSC9aUFB4dEtiV0dxYmFmbXk0?=
 =?utf-8?B?ZnI5SVc5MlNoQVd4Qk5GczcwZzhqY0xZR3pVU0FaYTNCRGxYd01zMjd3WUty?=
 =?utf-8?B?Y2p0OVdXenNyL1NRQkZFZ0RONmFQMVhtZ1BhUytaYU1QZlhORmt5OXg1U0Yr?=
 =?utf-8?B?OUlRWWNMOWkvUmVsNXRaTURWNzdpVk0vLytpRzNtMUtHbXZPT0pIYzcxQnQ5?=
 =?utf-8?B?VFBoMHAzK1YwTTVYV0J6bnFnaVVGMjhYWlZKVDhXeHJqQWZ3M3lselNRdjVL?=
 =?utf-8?B?UjlmMGlESG5ycHZmeWNaYWRkaExtelNHZlZwTzd2TkJhbFVxajdtblJTdUdF?=
 =?utf-8?B?czIxb3N4WnN1V3V2NlYvQnJoU1VObm5oY05rU0EvMFZoVDZoanVNTEwwZHlF?=
 =?utf-8?B?ZWJVT01hSXJUVmI5ZzkvVFlETVhkZS9aSm1Bdm1qMk1IN1U2SHc0T1B0S3Q5?=
 =?utf-8?B?Q2FBTC9yR284SXNqbHNibzNPbG9OSGtrM3NTSy9uR3NxU1NEbFFLaXM4c2Z5?=
 =?utf-8?B?Z2plL1FQMjlSNThQcjYxSWMvaUpPVG4rUG1EcFdtbHAzQVBJaDVxZGtxRlV5?=
 =?utf-8?B?c1V4MC9QenpNNVR4WEFUdGxRK0JxOGNrZ0Vsb2ZudGN0T2QvODk2STMyZy9l?=
 =?utf-8?B?dCt6d0E5WER0amNVQjRWaUJUY2NGSXNWVUtlU3F0V210ZnJVc3ViZ2ZmV24w?=
 =?utf-8?B?MVM4MFFTSmt2MTJldmRTSldwb3FhTVp6anFQUTBpODk5b2RkLzJGUTgvTVJ6?=
 =?utf-8?B?enQrL3NOSmU5WkxVMnFXOEpSTUFhZnhpTEZjV1diZ2RUUXpjdnMzZXdXWW5W?=
 =?utf-8?B?VllOS1FkelJ5cURMUXBWZ09IWVBZTEJWSzNjNTRXR3JLNWFJL1VjS1hGckgx?=
 =?utf-8?B?dVpWaTIwZDZ6OWVwZ0k1SjJwSU9JSEhhK0dWTm9wQ0xiR24xNENyMlBRNzF4?=
 =?utf-8?B?VnRERDVDUVlucFh1WHRhUGJ3bXZ1dHh6Y3RKaThlOWpoM1ZyMWcyZHlBZGd1?=
 =?utf-8?B?ekE3UHhzTVU2SWJRaTB6ZmpTZzVHRytMeWJyUUYzSHVKYWc5YmY5aFlXUlo2?=
 =?utf-8?B?SWdoZmkvL21aS2RDOC9EckxWQnphbTBOWnFIZHJWRndJbDhwM3I3MnRJWHBa?=
 =?utf-8?B?TVprQ2MwNnFLZjYwenY2NlRXcWdjb25hSm93OG41aVRLWngyZnlMbXVMN3dE?=
 =?utf-8?B?aWJuR1hGbng5OGtSNFI1d0JibXdWRTNIZG1ySDAvTlJ6Z0gwTjZyaWp1bWN4?=
 =?utf-8?B?RytzNGI2RDdUcTFGS1FkYXRtNUxwbGlKdFhCQkkzbzdQZW9wcHA1Yktmc0lw?=
 =?utf-8?B?NStQT1ZlWFR1ZmR3UVNZeUJMK1NyV1dxMzlqUjhyMWlQdTg1cWduWDdNMy9H?=
 =?utf-8?B?dWdjWnVNV05KSTdMaFhDcEJZakVJeVlzV2I4TFRVeTF5amxzZC83V1h0TVZm?=
 =?utf-8?B?M25Cc1B0a1ora0wzazJZN2tXVmxWRFdWbHFGVHdsSUZnZXlFWXVMOUdNRzA2?=
 =?utf-8?B?STlsMnpJaTdCdGtCeEZxQUhHaysrSlh3Zjd2S21LMjRZemNFaEo1V0xSMjJW?=
 =?utf-8?B?K0M3L0RrWU9sZmtvOEZJZkFhNkJZTllnb1p1UVhqT2xhNk9XOE9iZGVSdjJF?=
 =?utf-8?B?YmE5Tm9MMWUvQlNEM0N4b0pFSFlyZ3A0bWhuREpZaU9qeiszMjcrczhiRnFF?=
 =?utf-8?B?UUxzM3F6aXp1aHR6ck9MWlJTd0NWSGl3MUxCaHIvZk1YWTg1Q1hQZU5EV1VK?=
 =?utf-8?B?MXZZSHVGdEF6Vkw4bUl4cDBlTW9ES3dVKzVDL2RIMVhkV1JXZ3FBb0lFelg5?=
 =?utf-8?B?T3Y4Q2hSVTV0cksydUM1MldyTXJaaFpQVHhIZE9WeDhXakFlMXlSckdrMVN2?=
 =?utf-8?B?ajNxdGxEamNmNDNpa3BGQVVGLzVkQ2I4dVZsVFBITElCY21pRUdVVDNqOTB5?=
 =?utf-8?B?Y0l4SmJ5STE1dlQ2WXppcG1wT2dxZDYvMTNyS2xueUpEYXhkc2pNU254bG82?=
 =?utf-8?B?THNSdlB4T2FiVlp0R1BCQk1XeDFSU2FXM2hiWkpQaWx5WkYycWQyYUV0VTRF?=
 =?utf-8?B?SGkvNUFQZExJNHgyQ1g1WlhZOHJSU2xiRE9LQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 03:33:34.4221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1f224d-3af6-43af-b353-08dd8797c95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Hello Cristian,

On 4/30/2025 3:36 AM, Prundeanu, Cristian wrote:
> On 2025-04-29, 16:57, "Peter Zijlstra" <peterz@infradead.org <mailto:peterz@infradead.org>> wrote:
> 
>>> Here are the latest results for the EEVDF impact on database workloads.
>>> The regression introduced in kernel 6.6 still persists and doesn't look
>>> like it is improving.
>>
>> Well, I was under the impression it had actually been solved :-(
>>
>> My understanding from the last round was that Prateek and co had it
>> sorted -- with the caveat being that you had to stick SCHED_BATCH in at
>> the right place in MySQL start scripts or somesuch.
> 
> The statement in the previous thread [1] was that using SCHED_BATCH improves
> performance over default. While that still holds true, it is also equally true
> about using SCHED_BATCH on kernel 6.5.
> 
> So, when we compare 6.5 with recent kernels, both using SCHED_BATCH, the
> regression is still visible. (Previously, we only compared SCHED_BATCH with
> 6.5 default, leading to the wrong conclusion that it's a fix).

So I never tried comparing SCHED_BATCH on both old vs new kernel for
the HammerDB benchmark since SCHED_BATCH had not led to a great
improvement in the baseline numbers on v6.5 in my previous debugs and
I was mostly looking at context-switch data, trying to match the EEVDF
case to baseline numbers.

I'll try to setup the reproducer you have posted on my end and reach
out if I run into any issues. Hopefully the exact setup reveals
something I've overlooked.

P.S. Are the numbers for v6.15-rc4 + SCHED_BATCH comparable to v6.5
default?

One more curious question: Does changing the base slice to a larger
value (say 6ms) in conjunction with setting SCHED_BATCH on v6.15-rc4
affect the benchmark result in any way?

> 
> [1] https://lore.kernel.org/all/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/
> 

-- 
Thanks and Regards,
Prateek


