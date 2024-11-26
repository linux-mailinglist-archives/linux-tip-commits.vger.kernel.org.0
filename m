Return-Path: <linux-tip-commits+bounces-2881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1CC9D90E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 04:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437BE288A5E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 03:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29D6A33F;
	Tue, 26 Nov 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F9mxYniX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7222940D;
	Tue, 26 Nov 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593566; cv=fail; b=edJIt8xhxEFTM3koMYuyXJoMdQ9rcbq28SvC3FX3bUEQHWxYANLKR8+JGjVXFstCwKonavgSNbyCm6/zkuuVgbxn1ZQqydFaR+SHSjgtrM4JrX89+9a1MoUXSjwv285UQBW+9suOE1hPqPEcsLGGXb7BK9+79Nag32IDL59J+EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593566; c=relaxed/simple;
	bh=hTSb0f7a9irnY0lP7vx0BHaVNy7fvBMFck/b0Gv2bJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kMJ4Lr1Gg/pNYCDWhDMpE5RRzCh0oIUXxLJ0cJpWStGboiMWQh66AExp13dqekZY2wdmbzTAaZShcgGk08zk9xbAaj5d/qcqQyN9I2zkYUZOy6iaFDUDh3ch8RHOpxu5NUgLIkJf/Mk1he0i3Z5wK0Nef64rv2SJVOM4zGSxSJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F9mxYniX; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBw7pW52Lh/cNF/NHSVKeY2wTI7c/xKIAaWnMbbO/vhphjYrG9WXnodc2QUXxOiCls7zKudkvJFgE6ylVObE51I9eTz5UNEsGQ0c2azHsl7CeUGMpGzlJ41HAXXEEnd2n7kHePaAnxa4hvwQs6SfAB6JxuNWR8Svvk8f9jEqkk43Ty8RHiqJOPFKpMFGbU5n/Zf67w1EJgkNAE8cgjWfk3fT7aXqHxfMMDaLsHKFMg44Njso7ZjUYYYotYkCTdOnutQhOd76D+jmz/t3wyQzcAjdvsdixF7v7uAFMt8yZBhSw3RlonHvlRhOBn/BD+BziVhpshnT+XiixdL+ExxZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBJPSBxVgkzbC+wLCIZfApLVh7wEB/aUC0AtF86Rx4Y=;
 b=Ja5P+rCe1O9llmrvYWQfcFcSiJDd4k4glnRU9CViMC7I9O4UWpvdaslySRRYDwy8jei+iREmaEnvcljBLD6DzlbWaO8odAA+bZAXymmWBmedd8tzKNZA5LiSu1j41m0ZpKMIjX70zJjyzTPLX/+C1zL/51ORf7dPQCwKIDJwLyxPjCpG3nqX4ECvNe9S8HInt8jDFCjbe/NMricxc6SYjl93d1oalEtcO2JZcNkK3v6K0TBS4satzho4i+b3ZF83ufXY4PP2oGmMcMUWaFmj9GPgwdMjfgwMsiyMeIJalr7+VaXCEAHruRgEp8ZPtARva9pDViUs7Xhh6FDe9+YJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBJPSBxVgkzbC+wLCIZfApLVh7wEB/aUC0AtF86Rx4Y=;
 b=F9mxYniXg4vO0O2y0nBl9vqZXv15B15iArZcstaNyPZ8urn+s2CnZR6Eq7igBXmGu2Iv7k6cBDYwjYLwDTx0oPPXzJjz4yujjtTGACTHpPGZoI7mIB7faOrdhO4fm2JVfJ2bhVfClxWReHRRfYJE5BKNEqVYZsxwnf12MCHODvE=
Received: from BYAPR02CA0009.namprd02.prod.outlook.com (2603:10b6:a02:ee::22)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 03:59:20 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::67) by BYAPR02CA0009.outlook.office365.com
 (2603:10b6:a02:ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend Transport; Tue,
 26 Nov 2024 03:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 03:59:20 +0000
Received: from [10.136.45.86] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 21:59:03 -0600
Message-ID: <41d0bc96-2e42-4fa1-85df-a6a93611240c@amd.com>
Date: Tue, 26 Nov 2024 09:28:49 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>
CC: <abuehaze@amazon.com>, <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
	<blakgeof@amazon.com>, <csabac@amazon.com>, <doebel@amazon.com>,
	<gautham.shenoy@amd.com>, <joseph.salisbury@oracle.com>,
	<dietmar.eggemann@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <x86@kernel.org>
References: <20241017052000.99200-1-cpru@amazon.com>
 <20241125113535.88583-1-cpru@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241125113535.88583-1-cpru@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1f27d8-6618-4f53-9ed2-08dd0dceb4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnN3QzdXZzNLYlNtN1Yyam8vbjY2TE1yVjNRRy9WcUhlMGR6Wk1PY2NtMnlH?=
 =?utf-8?B?dnpPenQvRzhCQmFGb0taYWowc3NiMzQ3NUZVM1ZXcFVJb0tzdlNwNTJIekl5?=
 =?utf-8?B?NkVFT2d1R2NTVSs0V0w5YVdJb0pSL0lJZGMzbUMyNkxUUkxrWk0yMWNycjVJ?=
 =?utf-8?B?MWxxOGpTU2lKMkdwL0tmUUFwVnNwN2dYVjRrQTViY25QZFczMWZvaHBCZlIr?=
 =?utf-8?B?ZGRhc25WYVFKOXdrTzZPb05iTHlxWS80dHR5WkF6am9DQzN6bmZSWURtWjNq?=
 =?utf-8?B?UzlNRE96NFdMQUdMc3cxcUg2cnluRUdxRmFuTGVucmIwR1duSjJtQWpOSEZJ?=
 =?utf-8?B?WEd1Uit5YTJYZiswYXNJdmMxVFlkek5TM2JsWmhoWVhFS0Z0cHFlSjBzK1F2?=
 =?utf-8?B?Kys0L3U5NzcyVklMelg2eUxWL1JzUmREaW9IYUVPWmlJSkpxRnJtVWxvZmVh?=
 =?utf-8?B?cXMrRkE5OFM2SEt2SUtUQ0ZYeGtWTGtUZ2RWUzlabDlEcUJDSE5adXVSSFRF?=
 =?utf-8?B?em5OVHg4Mkcyd0l0a05UY3N3elQrKyswK0luR05aMlZCNExlRE8xNUxSdmFq?=
 =?utf-8?B?TzREckdUakJKWmtqUkNsWHFnTFBKUTlVRlhtaXdTekxyeElKcHcrYVczcDVS?=
 =?utf-8?B?V3hnbUMxb0pDaThYWUFEbmZSUXBCUzFTOHBQdE9UUXk2dmt1UjVPKzJTK0J6?=
 =?utf-8?B?b1BRdkJOQmJMTGFTbER2cTA3blJSbVJhNTl2cjVITzdENUM2dzBZUnhtRGFW?=
 =?utf-8?B?bXBMLzdNNHlZTDFOazMwdmRlU2h1bHVtelorc3RjZ0FvT1dkazAxOExlRTVT?=
 =?utf-8?B?VWE4dTZEOXNCUHlzajVobXFWaE1nN1gyREhJcEg1YWNPNzRILzRjRU43WDdm?=
 =?utf-8?B?MUZlYzg4TkVUeXFoR3pVTW9qNTlkYmlYME8yWTlXY1dtYkJXVFJnenBLSita?=
 =?utf-8?B?c1c3NzdoM05lUjZqb3RNK1h5OElCNnFHdkJBZVQvaS9hbFEzVTBkNzl0M0tO?=
 =?utf-8?B?ZHFZZ1cyQWQwT2pwbkZJMWE3MEYvZkVkdmxFbjcwZXUxaDhBVC9YZmdpdDVH?=
 =?utf-8?B?bWJPeUY0bGsrbDZuUi9mcVJUMEhIUVRPWS9jRldGRGdUT2N2U0VDRHhQWE55?=
 =?utf-8?B?TGFiVWJhRG93UmtmTTkyQzlmZU0xNXEzaERqcEpmam1nTDlncFlSZkprcXdi?=
 =?utf-8?B?RGx0bkl5OUk4dkRaUGpuN2NBUnVlVEVJQ1RtOVRXbXJ4MmhwNDlhRmNpZ0tM?=
 =?utf-8?B?eDUwVWRTODNTcUw3SktpOVpva2ZKYnk2aHNzQ05ubFFZYjN1V2dUNU11Zlpr?=
 =?utf-8?B?dVlOZDFRVk1xNWQ2Zlh3TWxXd2Y0U0Z6dm05N2RGZGI3ZklIVHBKVFB4QWJp?=
 =?utf-8?B?YzRzUGtzRitDTlJYTW5WWVJWSUxNSzhNWk5BWk1XcHlMeXl1Z1g3bFNJY1BO?=
 =?utf-8?B?Tmw4eDhHbmZySUhRakMwalBMbldUL3FwUGdTdElTYmVMWmI5K05iVllrWkF4?=
 =?utf-8?B?VzlIRXhjbkFETG53ME8yd050WnY1SjF2Y0p6SnFzVHZ2L0l4SGg1MHk2cnBl?=
 =?utf-8?B?S21UbVRjajZXb05TZGVVMjNLVnVsVFJORVQrQVM4VXMzTTV1QXYrdGh5ZmVK?=
 =?utf-8?B?Y1RxREN4ZmhXZjJ5OGRNZmQyeSs2RDd3dUIyZ0RGcEM5dUhKcWcwb3IxZGY0?=
 =?utf-8?B?SnAyWHRrMTRTWnYzSVFIQTJDanovNTRzTXhCTng5SnlwS01sSWoyQ2pDS0xz?=
 =?utf-8?B?dFgzSW9GUnBnNnVRS2s2aWp1ZlRqWHVVREhkSnB1OEZnRXZrQ1dsdStXam1U?=
 =?utf-8?B?RXFnN3huSVZvbW1NMy9QZGZ5K3FHanUrS1UrR1dxd3lyWW93eWQ3QnZXQWM3?=
 =?utf-8?B?eWUzTHlqZEJvMVdoVjdYMWw1clJ4K3pVUythM2JISm41aE5Ha0lpWEJMMVVU?=
 =?utf-8?Q?AsVw3S+RLUMut6+7+ZhDYdMKeKCuoedx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 03:59:20.0420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1f27d8-6618-4f53-9ed2-08dd0dceb4aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

Hello Cristian,

On 11/25/2024 5:05 PM, Cristian Prundeanu wrote:
> Here are more results with recent 6.12 code, and also using SCHED_BATCH.
> The control tests were run anew on Ubuntu 22.04 with the current pre-built
> kernels 6.5 (baseline) and 6.8 (regression out of the box).
> 
> When updating mysql from 8.0.30 to 8.4.2, the regression grew even larger.
> Disabling PLACE_LAG and RUN _TO_PARITY improved the results more than
> using SCHED_BATCH.
> 
> Kernel   | default  | NO_PLACE_LAG and | SCHED_BATCH | mysql
>           | config   | NO_RUN_TO_PARITY |             | version
> ---------+----------+------------------+-------------+---------
> 6.8      | -15.3%   |                  |             | 8.0.30
> 6.12-rc7 | -11.4%   | -9.2%            | -11.6%      | 8.0.30
>           |          |                  |             |
> 6.8      | -18.1%   |                  |             | 8.4.2
> 6.12-rc7 | -14.0%   | -10.2%           | -12.7%      | 8.4.2
> ---------+----------+------------------+-------------+---------
> 
> Confidence intervals for all tests are smaller than +/- 0.5%.
> 
> I expect to have the repro package ready by the end of the week. Thank you
> for your collective patience and efforts to confirm these results.

Thank you! In the meantime, there is a new enhancement to perf-tool
being proposed to use the data from /proc/schedstat to profile workloads
and spot any obvious changes in the scheduling behavior at
https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/

It applies cleanly on tip:sched/core at tag "sched-core-2024-11-18"
Would it be possible to use the perf-tool built there to collect
the scheduling stats for MySQL benchmark runs on both v6.5 and v6.8 and
share the output of "perf sched stats diff" and the two perf.data files
recorded?

It would help narrow down the regression if this can be linked to a
system-wide behavior. Data from a run with NO_PLACE_LAG and
NO_RUN_TO_PARITY can also help look at metrics that are helping
improve the performance combared to vanilla v6.8 case. The proposed
perf-tools changes are arch agnostic and should work on any system
as long as it has /proc/schedstats with version 15 and above.

> 
> [..snip..] 
>

-- 
Thanks and Regards,
Prateek


