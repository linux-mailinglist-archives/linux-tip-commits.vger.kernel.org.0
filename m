Return-Path: <linux-tip-commits+bounces-2753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E09BB136
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF541F21B49
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606419E990;
	Mon,  4 Nov 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BaLsYvBF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651C155392;
	Mon,  4 Nov 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716513; cv=fail; b=mxepuRX6wR3XTNgKApVRPMU36ga1R9zf5uiFycKBAgmK/p7cWljARh0tG/Q7yzH/IBT/+cvZueTQckRCbt/C3SxKqBjKVlHM+Tx1Mm5VYIdR0V/B7cyHI8Vkgiy4tMPB43ttbD5/tUhIz6Rev65d2p3tLccrx4drJOSXPPdv72s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716513; c=relaxed/simple;
	bh=IPn93IHGiKK/GWnHwMz2N4KtAeLV8aEkeKFs0Dt0RTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GBdSBHCglqPz/vmB7VcibIXXGvn+6RYMGFTDrtfFErCtkeMZ6aAyMMgNzvy1Hy/BGDMOtEJazL0mH+6mx2YpBm0tVFCxKzCjByu8ydfA5+dSeOwfBG6naXklPRN7SKd0F0p8bc5pGF4+l65R6/iauLOvmItY+H/jkZp3tNqGCRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BaLsYvBF; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGqD7W8WFCOn4XT2Il06Myi5M0c3QNTJRQHI1wrwY5Bm9JyYoCMDy80cfmKJ0Gju6wGgI4LPAxbz2PV/YMOkrGgsVg1bvv1tJAo2QQGVy0xDPsBhwx5/jqVhqUeYRpVNEMRU9+6PZqGYv08mTGgMwa6cyz6givGtcnxOEoJu3B7TwxM6dj5dF+ydYNv+cj/kgyRaL4NaI6JFziosWUTTe6R313MCMctQ/s/PzSi7dCEjThYETwVw3JHC/dE5OvZL1VzDCvbsjB3GYD//qBVDZhYQmk5eqsT0YSY5Yup6rmODeIZu9aTyZ3CEz4C6EaAzpZez2JSFdEh8OdraTRG9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMPCvpty8bvYlxxda9KtYEpA33IxSbmzjG/LLp0K/yA=;
 b=JMPPEvs2UdimKwJURfFRDBOPwBbn7fgt3wN4yhCBSmzCH7ITNDPlUrjJYF1O8IbZMfr5wgQ1uhC8N+50zHiWMY9U0gI4Q0rL5cvIz4tLsWzPGcYel6C+CH5p1Q+DZULKQGyxkyYlNetMLra29KqmYjD/PRXAh9RBou0AQSBCcrL1GRqczoulen97eXf/ueswZfoyPHWvvZHz8i/e4PuT2w7oltyYG866VnmqxaZyGuGujW2ctRctKLJlkLddb2V5vN+5bDpLjpOADxvVwtJeGBNAgfgs1ZfRxQg+2meFuZHrj9gv6S4feW8QHYIK+OXX+FXK+ztWoNqkfyWhOCa4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMPCvpty8bvYlxxda9KtYEpA33IxSbmzjG/LLp0K/yA=;
 b=BaLsYvBF4S5OKQklaL4ZLSf/i829fvJco1Bz1VwT+sALCZDqXXRKTSZJ8gybhAJkgJF7tC02pz/cPmryR/NklQPnlOFiGLcIT0CnASJBbeGJHgYc6jJAG0prsq8D07mCN5FZtX1cH1MJJb+5lz7ckZPdDgvaIv5cupbJ1pz+BUw=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:35:09 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::56) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 10:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 10:35:08 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 04:35:03 -0600
Message-ID: <d3306655-c4e7-20ab-9656-b1b01417983c@amd.com>
Date: Mon, 4 Nov 2024 16:04:56 +0530
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
To: Cristian Prundeanu <cpru@amazon.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
CC: <linux-tip-commits@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>, Bjoern Doebel
	<doebel@amazon.com>, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, "Geoff
 Blake" <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
 <20241029045749.37257-1-cpru@amazon.com>
 <ZyifxfSV8k5vC0iG@BLRRASHENOY1.amd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZyifxfSV8k5vC0iG@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 407de3c6-8941-4e1c-38ba-08dcfcbc5abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2RpTlpodk02TVpRdHlEMXVFN3RIc00rVG83dWdQWHN4cWtMNCtuN0VLaXh3?=
 =?utf-8?B?M3RIRFRNaElHZVBFRzZzVW5ISDNhWlBGU3luUGs1NlVsQWw0Z2M2T0ZmTWdY?=
 =?utf-8?B?ZTgyQWRLM0N6TnJWZDZNL0Z5TDUyczhIWVVuRXVnUXA0eWJKZjZreFJrK2F4?=
 =?utf-8?B?S2NkcWtRVm1iUFRTNHJrdmZBMDVjcXMzZ3IydWZ6YzJvek1iZkRUcXQ2ZURt?=
 =?utf-8?B?bk01MWRlNjNTUkVXWEtVOXVkaWlyS3gxdUJ5RS8wck5NUXJMZW01Ni9NbFBT?=
 =?utf-8?B?QnlhcUpPdzU1eE8ybis2VTlGc2VVQzRXS2JTZ0E3Nlo2T1Y2clkzUjdzWmph?=
 =?utf-8?B?aVRid2xMd0F1NUdXS3Avb0ZJQStXblBwS3RVN0ZJV3pWdGtBTGtyNXVDQXlE?=
 =?utf-8?B?TWdKQU1TcUNyRVZabkhPdTRWN29wZmpDUzRZOTlqd1EyalZVV2o0cy9VM1N6?=
 =?utf-8?B?WHk3VXJpSjB2UGw3WHQ5cmduOEFNOTl6Z3BSOVZGb01BTHZYYXNEUnk0Q1Bs?=
 =?utf-8?B?ZlhIbVFFRGdhZGIycFFhVGdvbUNZNjZPaFZyOHNuWDdmNGhlUXltd2xNRmdk?=
 =?utf-8?B?YUIrLzVaNi9sMDBLaUNLTVN5bk9nZFJnaStjaTN0SGFmNkxrNnAwQ2FQZGZK?=
 =?utf-8?B?cFA2czZKcm54L3hFOUNTYTd3SUZGak1OckZMSmduM2NBTHZ3aS9pN3oyalBj?=
 =?utf-8?B?TkhySmNHQXYvMWQyYkNBTjEzT0ZMMGVmelZ3RXVQcGJ0RDhaVlJGZG5KaWt0?=
 =?utf-8?B?aldZYVpwK0NFSWp4OHY0VFJCQzEvWFJneEx6ejc1ZHdVSy9JdlNKczgwaUtS?=
 =?utf-8?B?aGhXMzEvYnB6UFM2c3JXSEhkZ21tWDNGU0hvWHZVa1J4SS9aMThOMWpyZGRv?=
 =?utf-8?B?M3pqWkdsQnc3dHFBK1JYRERPSHVXMnBGbzFYWmpYTE8vU2xKYWhvOUUyODBB?=
 =?utf-8?B?R0FOYThMV3JXYi9qeXZrVVcxMmFPODVadFdzOEI0ME5jTUZLQ21nNW1sWDRq?=
 =?utf-8?B?eFRTTjFVdVp0ajUzR3hVRVJPM0lyRVRIbGgzL1Btb3pyLzNVM1lMOUh6UzdI?=
 =?utf-8?B?eXhGNGZyZDJCRU04eTkyRjBZMXNyYU9GUkoyenFnZGtBSkRJZjIrNXBaYmVv?=
 =?utf-8?B?MmZRSGVtTys1VUl4cFg4aTBsUzhEQWZ2UjlTOTNWMTlQZEhpemlkQ2ZCbldh?=
 =?utf-8?B?Qmt6WndFc1JvWlFmSzZWTWlxUlRtcElqVkZBbHhKTkpUZUdOa0oxN0xyVmNq?=
 =?utf-8?B?T2oxSjZTVFVaM0pHd0U2ZENqVjBQalFTMWRncEMwNmtoUlo1eFNMWjdWQVNu?=
 =?utf-8?B?T2JabmdpS1oyWjl0cldSblZKZWxPUXpBdHBSVUQ1aTZXMm03bkdib0VlSHd2?=
 =?utf-8?B?M3FJbm9zVXpZbGdjYmpHaC9obG8xczlucXJmMWg5S0RWcTBNQ2Vlc1NZRHo0?=
 =?utf-8?B?ZWFyeHR2VnhyVVQvYUpkbnlYREtjcVE2LzJ2MWNwWVdrWDRaVmlxclhmSjVa?=
 =?utf-8?B?TitPdTM4S3VraHNQejBiK1lWUlpLSXlWQWl6ZzJ4ZVZtVld1SUZwUU56QVQ1?=
 =?utf-8?B?cE9wOFRJbUc1c3VPakxSUUMxaEtjcGE2eEV6dERTT1FyOFFJUWZaVlp0U2hn?=
 =?utf-8?B?TklNdHVSeXN3TU51VXBYa0xlZnowbUhlYUdUZFcvNkN6VWJ4KzVpdE5KZG1G?=
 =?utf-8?B?NjNZdnl0bHpjcEMyNkIxV05BRFNCeU5KSWNMWU1XQ295NVlDazRrY3g2dSs1?=
 =?utf-8?B?alYwZThiRFZBSGZ5dDJhNXVxUUQ2MXQyenJqVWdUbVBPSUFrZ0ZKR01Ma2pK?=
 =?utf-8?B?b2k3WXhUdTF5ZUJ0RzgwYlVsNWlOMHk5UFJjZzNyWWY4TStaVjBQck8zM3po?=
 =?utf-8?B?cTR4ZDY2cURua1I2ZndRV0ttR0lSL2JvZkQzMWJKY0ZJTEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:35:08.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407de3c6-8941-4e1c-38ba-08dcfcbc5abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

Hello Cristian, Gautham,

On 11/4/2024 3:49 PM, Gautham R. Shenoy wrote:
> On Mon, Oct 28, 2024 at 11:57:49PM -0500, Cristian Prundeanu wrote:
>> Hi Gautham,
>>
>> On 2024-10-25, 09:44, "Gautham R. Shenoy" <gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com>> wrote:
>>
>>> On Thu, Oct 24, 2024 at 07:12:49PM +1100, Benjamin Herrenschmidt wrote:
>>>> On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
>>>>>
>>>>> The hammerdb test is a bit more complex than sysbench. It uses two
>>>>> independent physical machines to perform a TPC-C derived test [1], aiming
>>>>> to simulate a real-world database workload. The machines are allocated as
>>>>> an AWS EC2 instance pair on the same cluster placement group [2], to avoid
>>>>> measuring network bottlenecks instead of server performance. The SUT
>>>>> instance runs mysql configured to use 2 worker threads per vCPU (32
>>>>> total); the load generator instance runs hammerdb configured with 64
>>>>> virtual users and 24 warehouses [3]. Each test consists of multiple
>>>>> 20-minute rounds, run consecutively on multiple independent instance
>>>>> pairs.
>>>>
>>>> Would it be possible to produce something that Prateek and Gautham
>>>> (Hi Gautham btw !) can easily consume to reproduce ?
>>>>
>>>> Maybe a container image or a pair of container images hammering each
>>>> other ? (the simpler the better).
>>>
>>> Yes, that would be useful. Please share your recipe. We will try and
>>> reproduce it at our end. In our testing from a few months ago (some of
>>> which was presented at OSPM 2024), most of the database related
>>> regressions that we observed with EEVDF went away after running these
>>> the server threads under SCHED_BATCH.
>>
>> I am working on a repro package that is self contained and as simple to
>> share as possible.
> 
> Sorry for the delay in response. I was away for the Diwali festival.
> Thank you for working on the repro package.
> 
> 
>>
>> My testing with SCHED_BATCH is meanwhile concluded. It did reduce the
>> regression to less than half - but only with WAKEUP_PREEMPTION enabled.
>> When using NO_WAKEUP_PREEMPTION, there was no performance change compared
>> to SCHED_OTHER.
>>
>> (At the risk of stating the obvious, using SCHED_BATCH only to get back to
>> the default CFS performance is still only a workaround, just as disabling
>> PLACE_LAG+RUN_TO_PARITY is; these give us more room to investigate the
>> root cause in EEVDF, but shouldn't be seen as viable alternate solutions.)
>>
>> Do you have more detail on the database regressions you saw a few months
>> ago? What was the magnitude, and which workloads did it manifest on?
> 
> 
> There were three variants of sysbench + MySQL which showed regression
> with EEVDF.
> 
> 1. 1 Table, 10M Rows, read-only queries.
> 2. 3 Tables, 10M Rows each, read-only queries.
> 3. 1 Segmented Table, 10M Rows, read-only queries.
> 
> These saw regressions in the range of 9-12%.
> 
> The other database workload which showed regression was MongoDB + YCSB
> workload c. There the magnitude of the regression was around 17%.
> 
> As mentioned by Dietmar, we observed these regressions to go away with
> the original EEVDF complete patches which had a feature called
> RESPECT_SLICE which allowed a running task to run till its slice gets
> over without being preempted by a newly woken up task.
> 
> However, Peter suggested exploring SCHED_BATCH which fixed the
> regression even without EEVDF complete patchset.

Adding to that, since we had to test a variety of workloads, often where
number of threads autoscales, we used the following methodology to check
if using SCHED_BATCH solves the regressions observed:

     # echo 1 > /sys/kernel/tracing/events/task/enable
     # cat dump_python.py
     import time
     import sys
     
     with open("/sys/kernel/tracing/trace_pipe") as tf:
       for l in tf:
         if not l.startswith("#") or "comm=bash" not in l:
           pid_start = l.index("pid=") + 4
           pid = int(l[pid_start: l.index(" ", pid_start)])
           print(pid)
           sys.stdout.flush()

     # watch 'python3 dump_python.py | while read i; do chrt -v -b --pid 0 $i; done'


Post running the above, we launch the benchmark. It is not pretty but it
has worked for various different kind of benchmarks we've tested.

On an addition note, since EEVDF got rid of both "wakeup_granularity_ns"
and "latency_ns", and SCHED_BATCH helps with the absence of former, have
you tested using a larger values of "base_slice_ns" in tandum with
SCHED_BATCH / NO_WAKEUP_PREEMPTION ?

> 
>>
>> -Cristian
> 
> --
> Thanks and Regards
> gautham.

-- 
Thanks and Regards,
Prateek

