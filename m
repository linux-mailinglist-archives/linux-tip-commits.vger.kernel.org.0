Return-Path: <linux-tip-commits+bounces-2508-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0789A3698
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F4B23414
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945B18C931;
	Fri, 18 Oct 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydFUEcwA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF818C936;
	Fri, 18 Oct 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235263; cv=fail; b=NBTt2vusOH8NBHFvQW+P/Gy6SSIC6YwPqf/02ROfVN7BZBgZtkT9r3Bq9SaSrNo85S5zXYRvSupwq5YvcjOPGGA59813SiOaBzfPiA/epDwXZQLpCCBiCXeCGHX5+61N5EE6TpVroEv3xFX1hUsDLyetF998bZdOCdnL5XRUSPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235263; c=relaxed/simple;
	bh=9powKJ6gjdi29a/C1l6gLOmrVpqBvGakikuCMRhXStk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UkdCvMa7q/CqeqEE2Yk25RuSSiU0m5CyhYYuSv/kamegcpLd7f39S2F++BlNWRIunZIy5ANY8j8BxejVWIY6PyustRDdk11euwOEOkbl0gpvDfoZ0lOqHNFuEbJKtQVIRZYbUr7QcaeAZt4dOgInixFq85ZESPDJVArEs3aaZYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydFUEcwA; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAtiqLlwXgnATy1ZWnGwGMnbClzrBdDxWiO8qbArc/bryNTaN3goPwzyjDQdpsu66tL4kr35gOun/AJ/ks382DollVnn1i5uv7BQ8MDiE4kCPiq5gRfVwxxfi/87B1l+fhldOOQyJLPu+DIwN0chAwwgoi2irZfwKAFJGsAnlolXAqzWfZlWgXEmZqwexwHUZM6Q+0X8AovVY21nG0NNHc69ousRe4J0cuzaWZRqszbmOrX4HEa9xg20h7QSSz17MPSb+vpOTTZM8C9jhWzs5/FlEZe8Wwd77Ocl5tSdO9LaRXgN2waxiYcHErd6829asv1PL5DWLlrcWilnjjGPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJjEa7QoSHSdGuQFF4vNNJFUmP8FiS6W3FGiEl0tsU0=;
 b=rTdE83d4s08ApDO0W1Xebpds4gLgBh6HL4bmDdurHo6qJOmIsXzWEf1ZFjyO9Iv31YOZ9hdR9Wy6346ErbIUfKFsCQOoG+fKV1qCOdYPUtILYRdwWPpOiHF3nNITk23LARezs2w7Mm5K3I5+oNeqaxrQq/j4tJd/6CmqU+Fxce9HrxqMb5j8RfTiFihxBT0QC91v+qvzn/ADHDG4e4NoSojxTGgBg8S2bQDAxOLLyAhQdHVxaChaMgewdpVXu422sOpulOyPK96RRVwwd0x47f+BjZN1+yEmHSlaSUti/XXo2AyH3kWz6lKQV48wn5oroDM2rdk4KWauLdQf1RXjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJjEa7QoSHSdGuQFF4vNNJFUmP8FiS6W3FGiEl0tsU0=;
 b=ydFUEcwABVtpvML7eEbjTfJY3DI+saTkyTW/hY9i5icEMIoo1ptO2X0gZGLrhsQvTAiPcF4H950Noy4Cx228jz0+xRAuYDQKame7Y16uEKga0ydrW9VsAgfgnSP2OhlYt+PqpeOQcoDuZfBH0nYGnnBkUxnzVr/q5iWq8YprkJE=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 07:07:37 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::e2) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.10 via Frontend
 Transport; Fri, 18 Oct 2024 07:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 07:07:36 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 02:07:31 -0500
Message-ID: <27dae7fa-2533-bca6-fbfd-5e3fd2f6d0a2@amd.com>
Date: Fri, 18 Oct 2024 12:37:24 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Content-Language: en-US
To: "Prundeanu, Cristian" <cpru@amazon.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Doebel, Bjoern" <doebel@amazon.de>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Blake, Geoff"
	<blakgeof@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Csoma, Csaba"
	<csabac@amazon.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
References: <20241017052000.99200-1-cpru@amazon.com>
 <20241017091036.GT16066@noisy.programming.kicks-ass.net>
 <70D6B66E-B4BC-4A92-9A23-0DADE9B8C3FE@amazon.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <70D6B66E-B4BC-4A92-9A23-0DADE9B8C3FE@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: d92440b7-341e-4073-7c6f-08dcef438bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N24rQjVGTnVDVlV5S21WWlBIRTZ5a1piVXdTZ0N1aVNMUEIxL3UvT0JvMm9l?=
 =?utf-8?B?MTRmRTV5M0NlK3g5NTVJRmsrOFZSTFlVQUUxcEJ6cTFGcHUrdEVPMzc1VGVW?=
 =?utf-8?B?R2pnNjg1elU4MjRmcW1ianRWaDFHWWl6aENLZEhVcGYwdnZOT2RVZ0s2SjQ1?=
 =?utf-8?B?dTVaSXQrREN3TXQ1aGFraVZ4TFo3ak9wZUkzMTh3WEhHb3NmVzVHSy85R0VR?=
 =?utf-8?B?SExyclNWS0RRQ3hmb0ZSVlFTOWs1UHhodjRhTnFpK040Q0U4QkRLOUs1eUtK?=
 =?utf-8?B?SVFEZXhQSFJlcWduWVFkdU1BOUNtZ1RVZzIzb1ZBNjFDVzZ2RkhwNkVIYkZQ?=
 =?utf-8?B?NXgwS2d2U3lHR1pickpxYjludHNrTEx1V1hTVWROYVQ0MXdMazc2SkgreVdE?=
 =?utf-8?B?TE9mWXlIUXNMZ2JGK21YQkFieWsyOEZEN0FWWUFyeXVIQzY4a2F3WVViRkZ3?=
 =?utf-8?B?RXhwKzByUDNSZEI3b0wzTU56dnRXRGFHd3BhZDVhY0tNVWFieGRrQ2ludlp1?=
 =?utf-8?B?dGtrK1FQaFNCUWpQMTgvVUVIV0dtZmhvNXowMVJGeTBTUEVadi93emhyek5m?=
 =?utf-8?B?RitBbFcxYWk4dWJWZWFTVGN0MnZnQ1NHeG1waVNXbmJCd256SFlhYnAxTEh1?=
 =?utf-8?B?eXk0U0I4UGg4OVFiYlNEUG1HZVhuMVBBOGN0T2dOK3A2TS9FTDBHRisyMmkv?=
 =?utf-8?B?S3d4THlnVG1DWlFyeUxmdzlyUzlvakNoUWU4V05VMTQ4SnpwVXJoRkwyV3A4?=
 =?utf-8?B?VHUyOEoyMkpxc1VqRzVQTEFuTk1pbThObUgyUTI4T0Z2Z3hRSVlZVGwwQVdU?=
 =?utf-8?B?TXp6RVE4VWs0angrQStoL2VOUzgzR3lkN1RNSTNJSGNlRG4yRlZiUWRQcnJJ?=
 =?utf-8?B?NVJVUWg0dWJRR2t4dEFPN3pGbzl6N1hkN0Z4MGdoWkk1VW02RWtFR1JXK2xy?=
 =?utf-8?B?Wk1QTWtoQ0tiWm1PVC8rdlhUbHFKRFY5VE16WWl5QklORUpSYTNWVEZMMWw4?=
 =?utf-8?B?TVA0bVlWUW9tUzNCaVNzeHl0NE8vdk94KzYxOGN5Z0tmRkxCREV6Y2xRNDVz?=
 =?utf-8?B?REdOMEEyVXJ1K1RvcE03c1R2MmlYenNVRmxzdVNQZWJEanAvK3RuSmhsd3VS?=
 =?utf-8?B?WmQvQ2xNQ085dGlHWUgzc2ZQbmpvYWJoa1BZTHZQeUMxcS9pRFJXWXBhUjJY?=
 =?utf-8?B?d3FWSTJzbTVZRXZNZGRaQlpxVmx6ZHpsYk11SHhEY1hsa2w3Tk9FUml6V0VI?=
 =?utf-8?B?VWRrV3I5L0IwRHRDamxGK0N1Zm82YVlPcVVJSU9GQXFGMmZsWlUrcTNrSUZq?=
 =?utf-8?B?RWRPSW50N3VvVTVzQ2FxQ1N5QWFEWDRmT0tFNUpkUGJTY2R2NFJIUVpCZHpa?=
 =?utf-8?B?elZlREp0SVhiNWM1SUNXTlBydTY5eVFBZG05Q0pHSVJ1c1FGL2V5K3ZpdDVa?=
 =?utf-8?B?MktQbExOeldYUWI2NHFrSWxzdkZXU3ZGVk5ROG54aFlnTm1ZNG1Ld20zZUw5?=
 =?utf-8?B?eWRocDFPRjNKbE9pYW5CMWtraUtwVEZmaHV1cGhKTEpjSDhqWXY5c0pVMzgr?=
 =?utf-8?B?YWRQV0N5V3AzVVlnM0xJWTlJNDhEdnMrV2xZbXFnSnplbnNneHNpWlRoYnYw?=
 =?utf-8?B?aHhNWVJORkV4QUExcUFHSzJGYk1oRGtEVVQwWkxmdDVrTWdmT0ZTVzBCUGRE?=
 =?utf-8?B?SG12NHFWdys0cU9zT1JCY1piL3BzWFBTQm9WaTY3cUJuYW5BN0hCdlVNeTNr?=
 =?utf-8?B?UzZiZUxYSndPdDFjUERBbUdZWjA4bmY5TjNmemZIMUlpQWZReDRYWTJ0WjRX?=
 =?utf-8?B?Y3IwNTdwbDVKVUhsTkttcTZHR2lyYnEyN0RRUERCZ0Y4MVJNZjF5aGc1MTFU?=
 =?utf-8?B?cHRKdXFwQ3ZmcGg2U2pwMTVvelRXYUUrUVU3RjVYQWZ1UjdVQU13dzhyYW5t?=
 =?utf-8?Q?UUno1IwyUEU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 07:07:36.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92440b7-341e-4073-7c6f-08dcef438bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

Hello Christian,

On 10/17/2024 11:49 PM, Prundeanu, Cristian wrote:
> On 2024-10-17, 04:11, "Peter Zijlstra" <peterz@infradead.org> wrote:
> 
>>> For example, running mysql+hammerdb results in a 12-17% throughput
>> Gautham, is this a benchmark you're running?

Most of our testing used sysbench as the benchmark driver. How does
mysql+hammerdb work specifically? Do the tasks driving the request are
located on a separate server or are co-located with the benchmarks
threads on the same server? Most of our testing uses affinity to make
sure the drivers do not run on same CPUs as the workload threads.
If the two can run on the same CPU, then we have observed interesting
behavior with a wide amount of deviation.

> 
> Most of my testing for this investigation is on mysql+hammerdb because it
> simplifies differentiating statistically meaningful results, but
> performance impact (and improvement from disabling the two features) also
> shows on workloads based on postgresql and on wordpress+nginx.

Did you see any glaring changes in scheduler statistics with the
introduction of EEVDF in v6.6? EEVDF commits up till v6.9 were easy to
revert from my experience but I've not tried it on v6.12-rcX with the
EEVDF complete series. Is all the regression seen purely
attributable to EEVDF alone on the more recent kernels?

> 
>> How does using SCHED_BATCH compare?
> 
> I haven't tested with SCHED_BATCH yet, will update the thread with results
> as they accumulate (each variation of the test takes multiple hours, not
> counting result processing and evaluation).

Could you also test running with:

     echo NO_WAKEUP_PREEMPTION > /sys/kernel/debug/sched/features

In our testing, the using SCHED_BATCH prevents aggressive wakeup
preemption, and those benchmarks also showed improvements with
NO_WAKEUP_PREEMPTION. On a side note, what is the CONFIG_HZ and the
preemption model on your test kernel (most of my testing was with
CONFIG+HZ=250, voluntary preemption)

> 
> Looking at man sched for SCHED_BATCH: "the scheduler will apply a small
> scheduling penalty with respect to wakeup behavior, so that this thread is
> mildly disfavored in scheduling decisions". Would this correctly translate
> to "the thread will run more deterministically, but be scheduled less
> frequently than other threads", i.e. expectedly lower performance in
> exchange for less variability?
> 
>> So disabling them by default will undoubtedly affect a ton of other
>> workloads.
> 
> That's very likely either way, as the testing space is near infinite, but
> it seems more practical to first address the issue we already know about.

RUN_TO_PARITY was introduced when Chenyu discovered that a large
regression in blogbench reported by Intel Test Robot
(https://lore.kernel.org/all/202308101628.7af4631a-oliver.sang@intel.com/)
was the result of very aggressive wakeup preemption
(https://lore.kernel.org/all/ZNWgAeN%2FEVS%2FvOLi@chenyu5-mobl2.bbrouter/)

The data in the latter link helped root-cause the actual issue with the
algorithm that the benchmark disliked. Similar information for the
database benchmarks you are running, can help narrow down the issue.

> 
> At this time, I don't have any data points to indicate a negative
> impact of disabling them for popular production workloads (as opposed to
> the flip case). More testing is in progress (looking at the major areas:
> workloads heavy on CPU, RAM, disk, and networking); so far, the results
> show no downside.

Analyzing your approach, what you are essentially doing with the two
sched features is as follows:

o NO_PLACE_LAG - Without place lag, a newly enqueued entity will always
   start from the avg_vruntime point in the task timeline i.e., it will
   always be eligible at the time of enqueue.

o NO_RUN_TO_PARITY - Do not run the current task until the vruntime
   meets its deadline after the first pick. Instead, preempt the current
   running task if it found to be ineligible at the time of wakeup.

 From what I can tell, your benchmark has a set of threads that like to
get cpu time as fast as possible. With EEVDF Complete (I would recommend
using current tip:sched/urgent branch to test them out) setting a more
aggressive nice value to these threads should enable them to negate the
effect of RUN_TO_PARITY thanks to PREEMPT_SHORT.

As for NO_PLACE_LAG, the DELAY_DEQUEUE feature should help task shed off
any lag it has built up and should very likely start from the zero-lag
point unless it is a very short sleeper.

> 
>> And sysctl is arguably more of an ABI than debugfs, which
>> doesn't really sound suitable for workaround.
>>
>> And I don't see how adding a line to /etc/rc.local is harder than adding
>> a line to /etc/sysctl.conf
> 
> Adding a line is equally difficult both ways, you're right. But aren't
> most distros better equipped to manage (persist, modify, automate) sysctl
> parameters in a standardized manner?
> Whereas rc.local seems more "individual need / edge case" oriented. For
> instance: changes are done by editing the file, which is poorly scriptable
> (unlike the sysctl command, which is a unified interface that reconciles
> changes); the load order is also typically late in the boot stage,

Is there any reason to flip it very early into the boot? Have you seen
anything go awry with system processes during boot with EEVDF?

> making
> it not an ideal place for settings that affect system processes.
> 

-- 
Thanks and Regards,
Prateek

