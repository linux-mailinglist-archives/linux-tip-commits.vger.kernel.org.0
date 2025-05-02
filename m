Return-Path: <linux-tip-commits+bounces-5156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB61AA6A5E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B232D3BF160
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54A2F2F;
	Fri,  2 May 2025 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="POSQA3WS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D1DE4E3;
	Fri,  2 May 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746165375; cv=fail; b=HfI13KgHuFuMGJWKOgJ5aVoEeCeDe3CWhb4nUGY/IifCnu0Dy0qfNj3kfev7zGbbnw4LSZAmYgqVvjIs4FuKRWq8P8LMvyhGRT2a7cf/O2hdA4yYUcmBZcCHIkBwqe4JQe141QGVi4ekOF+C2+SRIu6FKXlfptOiaQqwLRgy4JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746165375; c=relaxed/simple;
	bh=0qfUT07JGACtx2qjITDIWhdE0q6KQHHE4nRylbuE7NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loWoSn7cLQge/K9FYTakyKl8+1CxWMgaXN1wFspHhUEnhY5GVBTVzX6LVWdXuDx2txX/ijujgKwKAhucNetyz9nz0am+NIBBdmuaPYaI3nE3SXJI0cBKCeKAJZMHsf5VxR2n3cv24FPUMxxgS4cjX4lq7NloloHQgm5Bj6/NAz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=POSQA3WS; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3yw8smeYHNzrzK0DrlvEumXNEwZVSXq/P2p4CoK+piOFPjV0mb0qINM23k1U7Xv2k9NLd21e9QcSpjwO+HFmoZXf68LM5M8chY6qUGhEZUo9kFvfx+hyTELK/0frsL2A9zlN+q0QCINJMttx9eQ6v9lY3ib8wa3Lih/41vB7SwQXDf3AoaNftlqa9rLwAXs5qWMU95uJRVS5cdvEFSKH5AAw1a90yCKEdM272xCAYonXw8rmjln8TklhX9cYz9EzXgbqz1E9FfbbXUp1JP8opUWJ2iQw+1q0wOawX1O9VYoucbkogbE2c7cwW1YU5CWFICjB0DideKuDPLIFF+SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxp5zslcUx3RlD3wbVstEOpKB5q0wCUu4ctzFwAvPiw=;
 b=Hh7fAIH5gJZvPJTqJk4fm+Ed+nnojkcyZasdThn2SD7c80pI++buHE1o5LbuoGN+WtS6TFiIxtB7OlDCpjY2Mw8tjSpducCPTWMur9zpbDy0Fw1jYbaBBUPuC9TM++GBev4ewXSYM4Ls/9EYEkLYArRft/PvMahECpfJiIjCBnKezHwb/W8+SAoKBwlUTEI5y4ZVlfeVJPQ4cwZYZh6A4Kfn6RcVA9EFlw/YcxtJ55eF771yUj1b+aWotzTVqCARnEcptzpUfHbC7PygcaeMu2b4AG+h35u+yWfBjUSJpIomB7NVA39JQuzbdglh9WVPxmUEHXb8YK6Oc5I2W11iDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxp5zslcUx3RlD3wbVstEOpKB5q0wCUu4ctzFwAvPiw=;
 b=POSQA3WS3dZLf14F0fNeDojEsgxmYPo76Rhu5ff0GlKCsN3Qv2vfrTwIyHoFcg7syALQcLDylI8POrv8qH+SiIWLIyb+1HNFdYi8MhbvDTCdDNcVAYjK6qT8wyJoSevd9NxbOElZZjeIaXTOm3oQv2Ea3rpTEn2Eas2TEQIlT8Q=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 05:56:08 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::f5) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 05:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:56:07 +0000
Received: from [10.85.37.104] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 00:56:02 -0500
Message-ID: <d875adc0-744e-4b1f-a1bf-7e051298a0ae@amd.com>
Date: Fri, 2 May 2025 11:26:00 +0530
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
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b46818-ca06-46c8-74a2-08dd893e084f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCtmUnZKYmE1dSszTUxJcnVJZGJicDNGeTVuUGI4OHd0NXBUVVRiRnlkbVlx?=
 =?utf-8?B?Q0cxeXdXdHNaMlBVTWlzRVRDSHhVWUNpZ3NRNE42alFvY3FzL2Mya1ZrY2xi?=
 =?utf-8?B?NXcvbW56ZW4zOGZFT0c2RFJ2bUhkZ1lGRGw4K1RjTk9UWjhVSjd6ZW5qWXRr?=
 =?utf-8?B?a0lBUGlGa2NvcWFjV2ZYNFdFOWUrY2tyV2NlM1RMUE95dm1ob014QTl1eW1U?=
 =?utf-8?B?T3IyclJZVUIwSXNFbU10a0ZMVExZREtYcFJWRU5Qd2NDbGtBTFJJZDNZbFgr?=
 =?utf-8?B?aTQxY09jVWdXZWhTVnpLVFN5ZWxvRG9oT2VtSlJ2YmdvRDhoN1c3MmhYZDBx?=
 =?utf-8?B?N0t1dTgrR0Q5ZHRPclBPbXRMbHFIV2Zzbkg0bGZBbW45aGFRQTNiQWkzaFNn?=
 =?utf-8?B?dGtnbmpNV3UzRjAraTVQc1BkOWRFOWlDajJRRmg0VS9qblpBL25NQ0JNNVly?=
 =?utf-8?B?NlAxNGFDUmhqN2tWMXBSZ0cwRkVTVERGMjhwQi9ObWloVnhtM1RFeGhxN3Jx?=
 =?utf-8?B?M29SMzkrVFVGOS9LQ2hGTzB6RS80aERHb2tRMG42ZDB1L1NrSFpTYVp4TXFi?=
 =?utf-8?B?dElZODZVSlBhQUFWR3FTNmdKNVh2UXlJTDBnZ0Z5V3AzUHUzZTQ1c3BCanV3?=
 =?utf-8?B?TzJJZTNzTjQvRkZnWjZNR0RYMEZXbHJ1WUgyMkRqZW5LRlcrUjEvWkhHR1pI?=
 =?utf-8?B?aGZ6SGhjWmtiakNGeFBSUVcrUWxVTVFtQVEwMGVDMDNFY0YvV3ViQnhncmQ1?=
 =?utf-8?B?SHNNWUZBQjlFc2JQclRYbTdod3NCRHdsUzQrZFFmMTFSelRiNnV6Sm1JTlp2?=
 =?utf-8?B?QmZiTEsrb2JmeGYvZDVmajRtMzRZK09CZzBIR2pLcGxpaUxhd2xQbzlVcEJY?=
 =?utf-8?B?b1VRSTFOR044SThsWDFjSVZIZkU1akk1Q0lZS1c2Yk9ua2dZeEtaUzQzYXp6?=
 =?utf-8?B?SEROeWpVTExRd3BNMFNIb0sycFg0dkdqM0c1dHRvSkRiUmJNcjdDU2ZSSXlG?=
 =?utf-8?B?UTJ4MDhPYXkvemFkWisvRE9SVmZEcENOWUR1TUpWaXBvS24yYWN5UzIwRVU1?=
 =?utf-8?B?ZHk2ZjRwSFJFNWhTc0ptU1Y2cm9aMllvNjM1NEdMbzdURFBKUDhsOUhrdGtL?=
 =?utf-8?B?SWd4Qm52S1p0UG9Ea1dlUXFjU1NUNnlYcE5lL3FPRWZxZkhCQUpZQkdVbldy?=
 =?utf-8?B?LzlwZ1ZJSU91OFAvdEJMMHBHOU9DZ1lpckpERDg5clF6STBPRFk2WXY3MVNp?=
 =?utf-8?B?Y2FLMkJkM2dBS2RJbklCRjhDbW50K0djSkJEbnpRdWZvNDlCQ3JvTlhRN25X?=
 =?utf-8?B?WFVNWGlpQ1pLdWVIOFlXNDlSdzFMZ0NTVjc4ZytsVHp0aDJDSUtpN2pEcmoz?=
 =?utf-8?B?MHVkLzRRZVArcy8weWhSRFJOeGR6K05VeE9SYzZtZDVDV2QyYXFDOE4rK2Fl?=
 =?utf-8?B?anN3Q0FVcUZxL2ZmT3pMRGlNcUhFME1JVEV3eVgrSThRSUM1UkJmUkxwUURv?=
 =?utf-8?B?VTJnYVBIaXhmV2dBUUhXQTBQakV5eFp0UWVaVXd1YVpoZTJ5Y3F2QlZtc3BO?=
 =?utf-8?B?Nk1aTmdrR214NkJvenVPT0hDRkdhZVdSOVVnZm9IMi93T29PY1dYMjJlYWZU?=
 =?utf-8?B?VnhLR0ltZVJDbTNYZU9qeGwxb3dZb0VXenhLSlV0VzhheWQ2NSt5RVBjOFNp?=
 =?utf-8?B?ZFpRbC9TaW8xVkRqVzRsMXhyNmJIZFI5YUZZVnVGemVMQVA3R2x0RVJ0T0M5?=
 =?utf-8?B?Z21aUkJudFB4bi92T0E2UUNaL1h2QWZUZjRia21ScnFpcmQwdkh2MGpUaXZH?=
 =?utf-8?B?V2sxZ2Z5L3UrMm9wYko0VXZIWUI1VHVUWmIvSjNRNDJHelNjMkNTVlE5SzAz?=
 =?utf-8?B?b0l3MWdqOVE5VWRXdDh0QUtHaldwdzZ6b2FoWDc1ajUrL096RURsUFVnQ2V3?=
 =?utf-8?B?NHBpMzhkdFVGc1lTZ0ZVRnFhZ0hXMU92L0doSTUwbTczcHdmNUplSUVhZ0pW?=
 =?utf-8?B?QThCQ3Z2RjJWOFVMNEhrTEVJRTMxM2FNaGxxbm56TG8vdXBtLzFpMndXT2RD?=
 =?utf-8?B?Z2tsUGp5VVBwMDZkamZXTTl3ekZ1L091UWY3Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:56:07.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b46818-ca06-46c8-74a2-08dd893e084f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

Hello Cristian,

On 5/1/2025 9:46 PM, Prundeanu, Cristian wrote:
> Hi Prateek,
> 
> ﻿On 2025-04-29, 22:33, "K Prateek Nayak" <kprateek.nayak@amd.com <mailto:kprateek.nayak@amd.com>> wrote:
> 
>>>>> Here are the latest results for the EEVDF impact on database workloads.
>>>>> The regression introduced in kernel 6.6 still persists and doesn't look
>>>>> like it is improving.
>>>>
>>>> Well, I was under the impression it had actually been solved :-(
>>>>
>>>> My understanding from the last round was that Prateek and co had it
>>>> sorted -- with the caveat being that you had to stick SCHED_BATCH in at
>>>> the right place in MySQL start scripts or somesuch.
>>>
>>> The statement in the previous thread [1] was that using SCHED_BATCH improves
>>> performance over default. While that still holds true, it is also equally true
>>> about using SCHED_BATCH on kernel 6.5.
>>>
>>> So, when we compare 6.5 with recent kernels, both using SCHED_BATCH, the
>>> regression is still visible. (Previously, we only compared SCHED_BATCH with
>>> 6.5 default, leading to the wrong conclusion that it's a fix).
>>
>> P.S. Are the numbers for v6.15-rc4 + SCHED_BATCH comparable to v6.5
>> default?
> 
> SCHED_BATCH does improve the performance both on 6.5 and on 6.12+; in my
> testing, 6.12-SCHED_BATCH does not quite reach the 6.5-default (without
> SCHED_BATCH) performance. Best case (6.15-rc3-SCHED_BATCH) is -3.6%, and
> worst case (6.15-rc4-SCHED_BATCH) is -7.0% when compared to 6.5.13-default.
> 
> (Please keep in mind that the target isn't to get SCHED_BATCH to the same
> level as 6.5-default; it's to resolve the regression from 6.5-default to
> 6.6+ default, and from 6.5-SCHED_BATCH to 6.6+ SCHED_BATCH).

Ack! I was just curious if all of the performance drop can be
attributed to aggressive wakeup preemption or not.

> 
>> One more curious question: Does changing the base slice to a larger
>> value (say 6ms) in conjunction with setting SCHED_BATCH on v6.15-rc4
>> affect the benchmark result in any way?
> 
> I reran 6.15-rc4, with both 3ms (default) and 6ms. The larger base slice
> slightly improves performance, more for SCHED_BATCH than for default.
> 
> 6ms compared to 3ms same kernel (not compared to 6.5):
> 
> Kernel               | Throughput | Latency
> ---------------------+------------+---------
> 6.15-rc4 default     |  +1.1%     |  -1.3%
> 6.15-rc4 SCHED_BATCH |  +2.9%     |  -2.7%
> 
> Full details, reports and data:
> https://github.com/aws/repro-collection/blob/main/repros/repro-mysql-EEVDF-regression/results/20250430/README.md
> (These perf files all have the same schedstat version, hopefully "perf
> sched stats diff" worked better this time).

Thank you for the information. Ravi and Swapnil are working to
get perf sched stats diff to behave well when comparing different
versions. It should be fixed in subsequent versions.

P.S. I'm still setting up the system and have got my SUT pretty
close to what you have described. I couldn't quite reproduce the
regression on baremetal with my previous configuration on v6.15-rc4.

Could you also provide some information on your LDG machine - its
configuration and he kernel it is running (although this shouldn't
really matter as long as it is same across runs)

> 
> -Cristian
> 

-- 
Thanks and Regards,
Prateek


