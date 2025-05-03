Return-Path: <linux-tip-commits+bounces-5204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAFAA7E4A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA016EAF2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22A158DD4;
	Sat,  3 May 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MWwqAF90"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44255156F45;
	Sat,  3 May 2025 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746243282; cv=fail; b=o3apDiwa4TuYlWq7UXuKncCm7BmVgGUzZepZQ9v3rgTVVbmFNwd9H4lZ/aogBpe7XMsVHLaNzL4H+l1vPcJUWVoVp0nwsuReF+D57K9dLxPJecP7/JwUFQ1+qxVk1O9G8cjezy9x3KaVI1KQQtpz5O7EsiQdxIklr0UegpdMSMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746243282; c=relaxed/simple;
	bh=GWv4tAsFye88dZ7WQkBzVCEYyMcmr8YLNrEFfljFdZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PIRLG5sg0FqV7SpaNeyGacg5DsBMvUukOdl5WyYJO2SqdpBAUF9gjT02WPc7y1xIhUUuU7pnELyB65PK3nUE3Dz42BhrT1EwiwFQ4FpuaLs0DtEYGKP2PoCxtKvUlVUZWM4EGj8Ilk1lpiH1zWAoXyPVloDRnPU5pSa2q36F+9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MWwqAF90; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey00R6so2Or0xJdfT0u7OIF+DGtlR2yBEtC4SoRzc4ZoQD5/NRBxS2pcQMrGZ45dUgcX42/8fEnEC2SaCm2vtnFutXqxD03AmmXoei+EMl2qzCk3hGAMhMNWCYuDuqeC8d52LBTtf0OR6EGBx20cqSnu7T6HmQdhGacR6zpa7PnigVJNV6sPx0WGb12ylrtpLX3VCLs7iyugUzRKHDiBabjStduob1xWzHb2u+HU5JuApFBBmzgUWM7MskoymQjmYpQr1o3INnsfWI9QF1YmGpajRMTV9xK84+k9oG+GQImAd+1Bo9QykgV6nMr6yDn+TGwQ5cQjBinnpgXcVnSqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPgNobfBTYOujqbLiEIdQ4nZqkuaEpAIqPG9ONJwXPA=;
 b=CCLVlBuznsfsdmjHuoOAvVljeL7aPgJeOomt8DgxnZju6fnni+5VDLQmwNHNvUsB1mJflS9pKl5tALfsjsUk90JbbTGKyJtlzgdYN4w7t0E+N//TvtXb1RICO59684Z95znWRi+K/9DBjqIK0RCXdwZ/T4w9bnJ001BwR2rT07bsSvY0B1bcISvs/8DQCm8OEWgFcZemCZC7FHF6RTi032de8G+5IBbrCd45gSNWENKll36mbE6eOO24V1JBCHr6NqGItzlL0yESVFgblPbTu+LdigRJxEPwvVsQVlxBxq2w9AtS4/mwaT42klehE9nrShejOTJCgyNtQ7uQxLpqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPgNobfBTYOujqbLiEIdQ4nZqkuaEpAIqPG9ONJwXPA=;
 b=MWwqAF90QgAErPxaenDlmCba1yUi/lf6Z7tQZFJ1abDC+DQnwKjgRO7yC4+2bzVIU4CWQDVUD9qFOH4NJkH2od51MYZ5+mQwaYPaZL6HUT9AQyZoaprw8pTYPqgqEmZKp4I1oulnAV5AzmndO5lilOJnIRapZgubdiLxk0uFW5c=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Sat, 3 May
 2025 03:34:36 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::3) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Sat,
 3 May 2025 03:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Sat, 3 May 2025 03:34:36 +0000
Received: from [10.143.196.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 22:34:30 -0500
Message-ID: <6a83c7fb-dbfa-49df-be8b-f1257ad1a47a@amd.com>
Date: Sat, 3 May 2025 09:04:28 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF regression still exists
To: Linus Torvalds <torvalds@linux-foundation.org>, "Prundeanu, Cristian"
	<cpru@amazon.com>
CC: Peter Zijlstra <peterz@infradead.org>, "Mohamed Abuelfotoh, Hazem"
	<abuehaze@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, "Blake, Geoff"
	<blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>, "Doebel, Bjoern"
	<doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250430100259.GK4439@noisy.programming.kicks-ass.net>
 <B27ECDA1-632D-44CD-AB99-B7A9C27393E4@amazon.com>
 <CAHk-=wgb5WcfMEgsOQg4wzVWuYNgCL-e17YX33ZET_G3-ZCo7g@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAHk-=wgb5WcfMEgsOQg4wzVWuYNgCL-e17YX33ZET_G3-ZCo7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: b938ea01-96e3-4e56-5716-08dd89f36d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUQvZndDQU14UWlZYnFxb3hsTnIyeFNmR0V0K0VXcTRTTTMwajVXbmxpK095?=
 =?utf-8?B?WFEreFNVUTJVd2M5RkRNbml3S1gwRDdYZCttdkZ3NGp5Q29HeTYreWUvMElN?=
 =?utf-8?B?N0RQWUwzMlpXT01IMTl1a0JEejEzNGxybDd3MlB4N0p4eDVlWHdTbThwTmpr?=
 =?utf-8?B?VmZQbUt6K01nOEQyalpIeEVWVm56UWNlVXk1QkN5L3dlYzhIa1JzKzZReEtX?=
 =?utf-8?B?SGFuc0w4MENObHdFUmcwbHBDbXJYQ2dIT3JPa2pYU0tMVGluZUI5ZWd0QmJF?=
 =?utf-8?B?dWRlWHlWWTNqeGR5QXlqSUZZd2h3TTB1V0xYeG0vbkxSaG1NYVdOd3ZycHd4?=
 =?utf-8?B?UDVwSm42TFJWR29ZYm40UncrTGhkN05TczZmRDJjckt1K2gzbkE2RUZscDNF?=
 =?utf-8?B?MFdmNjJveGdLY1hPT3ZnMTFGam5DOXhVMHV6VXNrZkNrNGRIaTh6Vnc5V1ph?=
 =?utf-8?B?bFZ0MnVhSlZrRGpmc2R1ZTF5WmFBN2dGSkJjVmE1YWdNQ3J0VmNEOWE5K0ds?=
 =?utf-8?B?TFdOdGc3S3o0VWxEYXB3QjRoNXJyS1JwQi9hS0REdUp4YjhLZ1NIbVFIS0Rv?=
 =?utf-8?B?cFY2MUhwaFo4M0kxTW1nU29hamE2R3lySlgwL1pSUUE2MXRNcm1hUFl4NXlI?=
 =?utf-8?B?bnZvNGxYajRzTmI2bko3VXV6NWJENTkwVUJncVpwSXN1RWxyL3cyS2QyRmND?=
 =?utf-8?B?aEJOUThucFU5bUhRVW5RYklyNTV3Qi8wVXVHcHdJd2tYaVNsU2RoSU8zamNE?=
 =?utf-8?B?N0pJb3J3TkgvVmFueDUrVWVEeVliRTVURUtYQVRocXFadmxwY0pCamVKMFZx?=
 =?utf-8?B?emppcFdSNDAyVG1hdlMyRzlMdDlqYkdRczhia05pTXgxZFlJdnB4Vi9pdE11?=
 =?utf-8?B?LzFEc3IxbCtsU3llZGpITFdjbmNFWmpvaGtpeUdVMk9uZUErdm9WREVjTGd6?=
 =?utf-8?B?NnpCREZGK1ZrblhiQzVyb2VudC9pUktFdW5kdGVNQVNhQWM1dm43c0NyQ1gw?=
 =?utf-8?B?bS9DSmc0SjFucWtBdnE2RDNaN3cxTWFMTzhFY3I3dU9mb1ZHRnFuSXNxdEo2?=
 =?utf-8?B?eEljNHFwcHhic0JaMy82SzM4dUlXWS8zQnFFSWxxc0I2SUk3ZHdtdkxBcWxO?=
 =?utf-8?B?Nng2andQS0pBTXorUFBENGRHdDRnL1UyTW1hYjVUQjFjSCt3aUtrdS80NldS?=
 =?utf-8?B?UEw2SmFVRFd6eFlCVUVkSE1iZ1BUZ3hxOWtPOXFxL2pJV2JwQU15K3FWUThu?=
 =?utf-8?B?MEt0dnpCUWxyVWJ5ayt2aGR0UHV1VjBtcytEUFdZRkxVZGpQaHhJeXNyL3lO?=
 =?utf-8?B?QU05U05CeUIzZi85RXltQ29xWlExYmRlcEJaTmF2NmpIZklKdDFSYkhMaEc0?=
 =?utf-8?B?b2ROY3VZK01LZ0hyK0wyWjZBMldlOSttNDFVNFM4bWoyTnA2RE1CN1dsdVkx?=
 =?utf-8?B?aFBQdnFxcHZjM1huVisxck93UFBIa3VSVUd1SlIxcDRGQXk0cXdodnorenFU?=
 =?utf-8?B?ZE4vR0RlUnh6R0lxbEkvQ3hNTTRzd05CMXRBZ0ZoRGVMQXVlaHZMcXc0MnVX?=
 =?utf-8?B?MnhZSTdDWGdXcm1HcWdjTVFUYWR1V201K29jcWxNTk1EbWsxSjEwNStLNkhC?=
 =?utf-8?B?ZDRYSmdOWnIrMlcyeWY1OGNpejFYTXZIMVhzRUJwWWlDWE5rdWEzZmdyRkM2?=
 =?utf-8?B?NVdKVkdkS1dWMWtDdkdWaDQ0ZnVUdGVZTlJpdXorZ1Z3V2tubDBNQzNuQUZm?=
 =?utf-8?B?bisrU0JEb1NyN0hoSE9oTzZqeThJeGNFcXMvNHJhdTZDUXgvdzVNcWNBZWp1?=
 =?utf-8?B?L1NXZGwyU2gzQTV4cjNyMkg5YWN1MCszQzN6SGR6bUd4NUJwRkdHMGx6YVVt?=
 =?utf-8?B?V2kxREhBTGljUjNUd3g0a0ZKSkIwbUpaWHVJNTVHVDc1VG9yV1duVE5tb3Nm?=
 =?utf-8?B?cEIvaHNyMHpMN0cxeWdEbm45bjNORjJhRHJIYTJDUGd2OXF6YkJLSVJHZVdw?=
 =?utf-8?B?T2lVODFDemlGQmdIVTZmUnU3d0swVFBXbFBubVRzSzIzcERqajU5NlNCL0hS?=
 =?utf-8?Q?8S5Zos?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 03:34:36.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b938ea01-96e3-4e56-5716-08dd89f36d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

Hello Linus,

On 5/2/2025 11:22 PM, Linus Torvalds wrote:
> On Fri, 2 May 2025 at 10:25, Prundeanu, Cristian <cpru@amazon.com> wrote:
>>
>> Another, more recent observation is that 6.15-rc4 has worse performance than
>> rc3 and earlier kernels. Maybe that can help narrow down the cause?
>> I've added the perf reports for rc3 and rc2 in the same location as before.
> 
> The only _scheduler_ change that looks relevant is commit bbce3de72be5
> ("sched/eevdf: Fix se->slice being set to U64_MAX and resulting
> crash"). Which does affect the slice calculation, although supposedly
> only under special circumstances.> 
> Of course, it could be something else.

Since it is the only !SCHED_EXT change in kernel/sched, Cristian can
perhaps try reverting it on top of v6.15-rc4 and checking if the
benchmark results jump back to v6.15-rc3 level to rule that single
change out. Very likely it could be something else.

> 
> For example, we have a AMD performance regression in general due to
> _another_ CPU leak mitigation issue, but that predates rc3 (happened
> during the merge window), so that one isn't relevant, but maybe
> something else is..
> 
> Although honestly, that slice calculation still looks just plain odd.
> It defaults the slice to zero, so if none of the 'break' conditions in
> the first loop happens, it will reset the slice to that zero value and

I believe setting slice to U64_MAX was the actual problem. Previously,
when the slice was initialized as:

       cfs_rq = group_cfs_rq(se);
       slice = cfs_rq_min_slice(cfs_rq);

If the "se" was delayed, it basically means that the group_cfs_rq() had
no tasks on it and cfs_rq_min_slice() would return "~0ULL" which will
get propagated and can lead to bad math.

> then the
> 
>          slice = cfs_rq_min_slice(cfs_rq);
> 
> ion that second loop looks like it might just pick up that zero value again.

If the first loop does not break, even for "if (cfs_rq->load.weight)",
it basically means that there are no tasks / delayed entities queued
all the way until root cfs_rq so the slices shouldn't matter.

Enqueue of the next task will correct the slices for the queued
hierarchy.

> 
> I clearly don't understand the code.
> 
>               Linus

-- 
Thanks and Regards,
Prateek


