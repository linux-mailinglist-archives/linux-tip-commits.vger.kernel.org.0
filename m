Return-Path: <linux-tip-commits+bounces-3350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF62A30221
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 04:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17020165B6E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF401D54C0;
	Tue, 11 Feb 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ll5joJjY"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB102D600;
	Tue, 11 Feb 2025 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244508; cv=fail; b=kMA+fwD8A0CRB9vgUhaO7jrgup9dmjCUheXC2ojmOdKsxVfeQXyieZgTtfoIqFMztfgiobd4RWtwudoXwELshzbU2cQ97PrvAyD6Ry/OkMMawAtU4ibkQ5YqJAPtY01qHM0TYNYszktaqocncuCbLykqY4P9Nk9ChKK1gquJF5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244508; c=relaxed/simple;
	bh=MrYespyrv6AAg+eSw7GqUMnjnfE3mF3rRmsGDbuCSZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NC5VkeVluAj4KgMzlFhMpflKY4XCFbZKfVatfRovzo6XxEoAMNRKuYzWaPmwwFyEECsavyc5TGJS1OW3o+gF6X4Du6Nx9VbtI6e83GgomOkeZ0wSU7D1lgej3TOmYX9gx8PyKafDOGF8ZzGG6+07QalBmcO1+DX8xt9lVxnIEDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ll5joJjY; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9Mody9vfl++MsciHUVnfBhXzfOI4qQz7j26gk6FmlAl+XTGZudAjry895sKxoPPyko/7EIrCx1zyEwxjt7ZjZhCBgkv6AoRutgig4+aYjGSMNNKhZGej9sZe0RZPVB82hPksD9NxvwVuy2ENqNwTqfzksrbR+2jhhW6SBfice/JFBYNoho815I8OUjJrc8dWLPyYqV+NJum7hHYfjRi4LXVE/78FjB4tF/QHr2ByVrFfVb4fuwcTavJHurRs04UeUsX23vLoeHdcUBn27Ffew7jGZ6amXhk2eE/x7z0HXdMI8iJoSyN0wnAUHEO7D557Ojq0B+tkMa5hTfPuGvHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZl117H8wkWSW1GhR/WzmQXgYjEnvkDxV1qrSg8cIQA=;
 b=XGHAKugUpTkFH5VARU+Z1May4F4SUHO3OSFx3CSeU7MJG3iPwtoUHF9GSaFbDWJ02jNEbwRZC6dMOVAp3Xdsv/pROtxyYX7HOBFbHKc+H2/T47FEka2eHuQUQ9dcyUPJ/zBT82ygOmqdCW/Qi61v66pmd5h8Jhok8WoMVMd3uemRPA3jmC0sC/plzYiDi/dtniF1DcYZzx0Ig0Ut7sLRmqpKZLMYTYagb5rPfK36zTYgfPAYUmvIHAjiV2j8Qh0em3BtO+eeOsnspcsJG8PeBQCTDnMAaJ5GTfRwX0RGXOuDRqJju3PbA9AXAADH1kF/N8yCph//ZB+EyuuELy3qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZl117H8wkWSW1GhR/WzmQXgYjEnvkDxV1qrSg8cIQA=;
 b=ll5joJjY4WOiEsNEFAGtwAcxL/4glGpMcrlSH9llsty0POuGTwrXFpfrK09+8bZD3dGn9Bonaz5/XLygVWbXcocqQwCsochVIqws/UMuSujn5JZ3/wfgJQzfavriqIjAxditVdJsdDvSxzpdCLGTwlGqFD25FbYVfczHdypWcDs=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 03:28:22 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::2c) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 03:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 03:28:22 +0000
Received: from [10.136.45.220] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 21:28:16 -0600
Message-ID: <feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com>
Date: Tue, 11 Feb 2025 08:57:35 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: <abuehaze@amazon.com>, <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
	<blakgeof@amazon.com>, <csabac@amazon.com>, <doebel@amazon.com>,
	<gautham.shenoy@amd.com>, <joseph.salisbury@oracle.com>,
	<dietmar.eggemann@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<mingo@redhat.com>, <x86@kernel.org>, <torvalds@linux-foundation.org>,
	<bp@alien8.de>
References: <20250128230926.11715-1-cpru@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250128230926.11715-1-cpru@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: c89b1352-447c-4659-a1e2-08dd4a4c2310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEd3UHI4VitzOVZsbmtnVzFaSTBnbzVzYkNmK0UvV0JPT1pFYXd6cUNEa2Fi?=
 =?utf-8?B?eGNFRnVvQXYvMjl0MGZzYzR4dlcxMWRtOGhtNGx2R2VKdTY1YTVGZjNnd2NL?=
 =?utf-8?B?eTBad29pZ1VVSDJPRVhTcThHdWwxRjJQTXNMdHEyWGkybVFUQWxWM2Y3U0k1?=
 =?utf-8?B?TU5QczNocXpnNVVLd0duTis1R1hLY0RHNkVnNnB0VTFhODMrVml0SjNUWGFB?=
 =?utf-8?B?bGpiQTlkR1FMQjVwV3U5cXRiOXJjTFY2VEtSUzJhb2s2WDI4NzN4NWM2dHky?=
 =?utf-8?B?OFR1eHBmaEFFYXN1TDdTOGJmN3d5bW1vTGYzWWpsVnZidUNkaDFpWGdJdThP?=
 =?utf-8?B?b3V6MTN5WGZjZFV0TVRhZVlscVhwalhXTmp5OXdRbDl6d1Zzc3p1T0ZqYTdI?=
 =?utf-8?B?dWJmTzRjS0F4UWt4Zm9taEQwSUpzVG9TeXV1Zm1pUmNNc1lNeFNGckEyZEtE?=
 =?utf-8?B?WWMzSlZhbU9PR0toSTZVa0NKYStsMVRoY01zWmdKL0VuNlBTRmJMajY2WVlS?=
 =?utf-8?B?WWtPWWFnTE9ULzAxM3IwcW1zUFlJNG5pUTVrYW03bjNjT3NkMERjdENDVG8y?=
 =?utf-8?B?ZThJV1YveE81ZUFpQ05RNFdTQ2w5OVczVlNCeUdCZ1h6djBZcUFyQ0VyTUVx?=
 =?utf-8?B?dnpTQTVDb1dLQVE4cnRGajBsb1ZPclRMNSs4UEd5ZUx2R1dWRUYzTlZyTFpz?=
 =?utf-8?B?MVA5OWxqM3FsNVBhK3lnV21seGpHQnc3M3JWMVBReFdIRmF5eU9uV2haY0oz?=
 =?utf-8?B?eUw1TThvSzZvQ0c4QzZKSGdyMmtkWFFneUdpSmFtelY2Wm9oZkNhR0F6UnZv?=
 =?utf-8?B?NnFCUFlVMm94L1pNNDh5Zm5iWVVhbEd0UFJ5ZFZvVDl4QUptSmVZeGNNU1c3?=
 =?utf-8?B?YzR2amxLZnFjVGlWT0RXUmd2MEMvZzArOGFxb2Q0aUVCQ1RBQmJDSlFOUWZK?=
 =?utf-8?B?aDRoRmpaSE13d3h2KzZLZ1ljZUxWd1J5bElLNXQyUDZmZjcxWENpd1RJT3dt?=
 =?utf-8?B?M3NTNWJzZUpUYTh6TUduUHh2YjBaYkV5TVJwUHVmQ1AycG1YaVJwSU0wZk4v?=
 =?utf-8?B?SXUzeFd0bGx2Q3hJdGdVVG80UHdLNlI1SDlEbEhxc2RRa0pEeFh6bnpNdVls?=
 =?utf-8?B?WU1EbncrSDc3QTU1RlNRZWpjZ3VNREhrS09URTlIaXdXKzlDZ0NOQTdJeDNV?=
 =?utf-8?B?L21xWmRoSUZTZlhtWUs3NG10ampUeG9sWTBuQTFucHNNV0wwaG9zd2pYbGpy?=
 =?utf-8?B?VUdQM1J4M1JnVmRaaytyT2ZFSzJLZkZJNGFXcXIwK2RQd1NaSkhScExJdDc0?=
 =?utf-8?B?YmxKVXlTT0U2YWl1Wnp1VUJYL0NURlB2SjV3VEpyaXNJS0dFM2NleFpYK055?=
 =?utf-8?B?ZVArbnIxR25Id1hGY1hrZkExU2dRM1hXOEcxRW1nb1ArYjJYRXRSdlM0dWhR?=
 =?utf-8?B?emovU29lK3NpU0NKU0FJaVh4S09pcjBycEx3cVlsTGtPNG9GRnRyUW1pZG8v?=
 =?utf-8?B?WGtFbHYvTDc3ZTZKSzE5SFJpcDJqVDBJTHpSeWUxMlRaTTNkTG1UWlZKMWVG?=
 =?utf-8?B?YU1ORmV2MWZRc3VpOVRGNmJycTZzWUtZZlY2eW13aFAzVVBiU2VaUjI5ZUhQ?=
 =?utf-8?B?R0JwRWhkQlhUNDFiVk1qQ250eGpITkhJQUluTEJzMDF6VGErdFAwWWRZR3o1?=
 =?utf-8?B?NnZjV1JvbUZLeUZJMXdKV3NudWZrOUNkVER3VmFPeXRVTSsxN3luN3NCVmVq?=
 =?utf-8?B?MmEzNlNDeEM3bVR2VDdTSVVuUllSMUVRWUlwNTBMWEZmNk96Zk1xcGhEbGk4?=
 =?utf-8?B?Z0FPek51ZXRXUDdwUU92Zk1CQTd3emlhNXdZcFpaU081VlhYQUl0NHQxYlZs?=
 =?utf-8?B?NHl3RmNwYVdlckRLRk0vQjZBUEhWd09VMmJmdU5qN1ZmREFJNEZ2Y1pETXpq?=
 =?utf-8?Q?cXrnf0+8CuIS/oVZdjb2PtO0O+RbbLLV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:28:22.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b1352-447c-4659-a1e2-08dd4a4c2310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

Hello Christian,

Sorry for the delay in response. I'll leave some analysis from my side
below.

On 1/29/2025 4:39 AM, Cristian Prundeanu wrote:
> Peter,
> 
> Thank you for the recent scheduler rework which went into kernel 6.13.
> Here are the latest test results using mysql+hammerdb, using a standalone
> reproducer (details and instructions below).
> 
> Kernel | Runtime      | Throughput | P50 latency
> aarm64 | parameters   | (NOPM)     | (larger is worse)
> -------+--------------+------------+------------------
> 6.5    | default      |  baseline  |  baseline
> -------+--------------+------------+------------------
> 6.8    | default      |  -6.9%     |  +7.9%
>         | NO_PL NO_RTP |  -1%       |  +1%
>         | SCHED_BATCH  |  -9%       |  +10.7%
> -------+--------------+------------+------------------
> 6.12   | default      |  -5.5%     |  +6.2%
>         | NO_PL NO_RTP |  -0.4%     |  +0.1%
>         | SCHED_BATCH  |  -4.1%     |  +4.9%
> -------+--------------+------------+------------------
> 6.13   | default      |  -4.8%     |  +5.4%
>         | NO_PL NO_RTP |  -0.3%     |  +0.01%
>         | SCHED_BATCH  |  -4.8%     |  +5.4%
> -------+--------------+------------+------------------

Thank you for the reproducer. I haven't tried it yet (in part due
to the slightly scary "Assumptions" section) but I managed to find a
HammerDB test bench internally that I modified to match the
configuration from the repro you shared.

Testing methodology is slightly different - the scripts pins mysqld to
the CPUs on the first socket and the HammerDB clients on the second and
measures the throughput (It only reports throughput out of the box; I'll
see if I can get it to report Latency numbers as well.

With that out of the way, these were the preliminary results:

                                     %diff
     v6.14-rc1                       baseline
     v6.5.0 (pre-EEVDF)              -0.95%
     v6.14-rc1 + NO_PL + NO_RTP      +6.06%

So I had myself a reproducer.

Looking at the data from "perf sched stats" [1] (modified to support
reporting with the new schedstats v17) I could see the difference on the
on the mainline kernel (v6.14-rc1) default vs NO_PL + NO_RTP:

     ----------------------------------------------------------------------------------------------------
     Time elapsed (in jiffies)                                        :      109316,     109338
     ----------------------------------------------------------------------------------------------------

     ----------------------------------------------------------------------------------------------------
     CPU <ALL CPUS SUMMARY>
     ----------------------------------------------------------------------------------------------------
     DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
     ----------------------------------------------------------------------------------------------------
     sched_yield() count                                              :       27349,       5785  |   -78.85% |
     Legacy counter can be ignored                                    :           0,          0  |     0.00% |
     schedule() called                                                :      289265,     210475  |   -27.24% |
     schedule() left the processor idle                               :       73316,      73993  |     0.92% |  (    25.35%,     35.16% )
     try_to_wake_up() was called                                      :      154198,     125239  |   -18.78% |
     try_to_wake_up() was called to wake up the local cpu             :       32858,      13927  |   -57.61% |  (    21.31%,     11.12% )
     total runtime by tasks on this processor (in jiffies)            : 27003017867,27700849334  |     2.58% |
     total waittime by tasks on this processor (in jiffies)           : 64285802345,80525026945  |    25.26% |  (   238.07%,    290.70% )
     total timeslices run on this cpu                                 :      190952,     132092  |   -30.82% |
     ----------------------------------------------------------------------------------------------------

[1] https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/

The trend is as follows:

- Lower number of schedule() [-27.24%]
- Longer wait times [+25.26%]
- Sightly higher runtime across all CPUs

This is very similar to the situation with other database workloads we
had highlighted earlier that prompted Peter to recommend SCHED_BATCH.

Using the dump_python.py from [2], modifying it to only return pids for
tasks with "comm=mysqld" and running:

     python3 dump_python.py | while read i; do chrt -v -b --pid 0 $i; done

before starting the workload, I was able to match the performance of
SCHED_BATCH with the NO_PL + NO_RTP variant.

[2] https://lore.kernel.org/all/d3306655-c4e7-20ab-9656-b1b01417983c@amd.com/

So it was back to drawing boards on why the setting on your reproducer
might not be working.

> 
> A performance improvement is noticeable in kernel 6.13 over 6.12, both in
> latency and throughput. At the same time, SCHED_BATCH no longer has the
> same positive effect it had in 6.12.
> 
> Disabling PLACE_LAG and RUN_TO_PARITY is still as effective as before.
> For this reason, I'd like to ask once again that this patch set be
> considered for merging and for backporting to kernels 6.6+.
> 
>> This patchset disables the scheduler features PLACE_LAG and RUN_TO_PARITY
>> and moves them to sysctl.
>>
>> Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced
>> significant performance degradation in multiple database-oriented
>> workloads. This degradation manifests in all kernel versions using EEVDF,
>> across multiple Linux distributions, hardware architectures (x86_64,
>> aarm64, amd64), and CPU generations.
> 
> When weighing the relevance of various testing approaches, please keep in
> mind that mysql is a real-life workload, while the test which prompted the
> introduction of PLACE_LAG is much closer to a synthetic benchmark.
> 
> 
> Instructions for reproducing the above tests:
> 
> 1. Code: The repro scenario that was used for this round of testing can be
> found here: https://github.com/aws/repro-collection

Digging through the scripts, I found that SCHED_BATCH setting is done
via systemd in [3] via the "CPUSchedulingPolicy" parameter.

[3] https://github.com/aws/repro-collection/blob/main/workloads/mysql/files/mysqld.service.tmpl

Going back to my setup, the scripts does not daemonize mysqld for the
reasons of portability. It runs the following:

     <root>/bin/mysqld ...
     numactl $server_numactl_param /bin/sh <root>/bin/mysqld_safe ...&
     export BENCHMARK_PID=$!
     ...

$server_numactl_param are CPU and memory affinity for mysqld_safe. Now
interestingly, if I do (version 1):

     /bin/chrt -v -b 0 <root>/bin/mysqld ...
     numactl $server_numactl_param /bin/sh <root>/bin/mysqld_safe ...&
     export BENCHMARK_PID=$!
     ...

I more or less get the same results as baseline v6.14-rc1 (Weird!)
But then if I do (version 2):


     <root>/bin/mysqld ...
     numactl $server_numactl_param /bin/sh <root>/bin/mysqld_safe ...&
     export BENCHMARK_PID=$!

     /bin/chrt -v -b --pid 0 $BENCHMARK_PID;
     ...

I see the performance reach to the same level as that with NO_PL +
NO_RTP. Following are the improvements:

                                              %diff
     v6.14-rc1                                baseline
     v6.5.0 (pre-EEVDF)                       -0.95%
     v6.14-rc1 + NO_PL + NO_RTP               +6.06%
     v6.14-rc1 + (SCHED_BATCH version 1)      +1.42%
     v6.14-rc1 + (SCHED_BATCH version 2)      +6.96%

I'm no database guy but it looks like running mysqld_safe as
SCHED_BATCH which later does a bunch of setup and forks leads to better
performance.

I see there is a mysqld_safe references in your mysql config [4] but I'm
not sure how it works when running with daemonize. Could you login into
your SUT and check if you have a mysqld_safe running and just as a
precautionary measure, run all "mysqld*" tasks / threads under
SCHED_BATCH before starting the load gen? Thank you.

[4] https://github.com/aws/repro-collection/blob/main/workloads/mysql/files/my.cnf.tmpl

I'll keep digging to see if I find anything interesting but in my case,
on a dual socket 3rd Generation EPYC system (2 x 64C/128T) with mysqld*
pinned to one CCX (16CPUs) on one socket and running HammerDB with 64
virtual users, I see the above trends.

If you need any other information or the preliminary changes for perf
sched stats for the new schedstats version, please do let me know. The
series will be refreshed soon with the added support and some more
features.

> 
> 2. Setup: I used a 16 vCPU / 32G RAM / 1TB RAID0 SSD instance as SUT,
> running Ubuntu 22.04 with the latest updates. All kernels were compiled
> from source, preserving the same config (as much as possible) to minimize
> noise - in particular, CONFIG_HZ=250 was used everywhere.
> 
> 3. Running: To run the repro, set up a SUT machine and a LDG (loadgen)
> machine on the same network, clone the git repo on both, and run:
> 
> (on the SUT) ./repro.sh repro-mysql-EEVDF-regression SUT --ldg=<loadgen_IP>
> 
> (on the LDG) ./repro.sh repro-mysql-EEVDF-regression LDG --sut=<SUT_IP>
> 
> The repro will build and test multiple combinations of kernel versions and
> scheduler settings, and will prompt you when to reboot the SUT and rerun
> the same command to continue the process.
> 
> More instructions can be found both in the repo's README and by running
> 'repro.sh --help'.

-- 
Thanks and Regards,
Prateek


