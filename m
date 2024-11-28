Return-Path: <linux-tip-commits+bounces-2891-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561D9DB2CE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Nov 2024 07:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FC1282684
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Nov 2024 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F913FD83;
	Thu, 28 Nov 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I+2BytfU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C841C94;
	Thu, 28 Nov 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775766; cv=fail; b=NJdVcihcWfJb57ouY8AlH9NctawK4GUW8c3y9tEzfYNXei5NSYCwgBBsZAtI7COPtKwf42adxd4I3fMWGiVs078Vi7Ao4y1faGg3VJqXOczL1oV7JmCAd2MW35FwGFEJot/a+MfgkuE5W8dbFdhTdTNViNvzLThzprZg7K9epBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775766; c=relaxed/simple;
	bh=ndScTRvBYErUKZLrvxtF1PeySRbhzz9Jvhd4Aed7KuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MjE1Wv0m/+CNffh2+12YHq3LH0DHISNdKkzLBqaZqoSRCG0BdqsA423X2HFGqA7oyrUTuSmS2hkOj/dN/3C8yWXttSFfWrHajuVi9fr/gXeIsGkuC/SXNHHsRKpr3oecYiofkeQPDmfQnntN9fajkjkqbNm83TnQ3ET/r+z9hW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I+2BytfU; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRh/tuI6DzkDxQg3n8WQytmJlRCjXtmcI5Zffu9RvYHUfWh8hUEKN2a+xY6yHNtOAeOjX20h3AAOfKN8dWwKmKhcy4LU6ygJYyQzkaOgzvXsrr6GQM3R+aAX9KuWxxFSgwhOxtGaxqVSS3LRGdl1g65oYeRAt6FnEcYHa1IlAs/vE+gUyxINb8WRaXxbV/95IDsq2D/fvmfer9/KW7F7D0GSmjueyC2C2rZ+UGTDlBW7Eo5qOVs6XWbBV5s/OImtXXN7IDDfYp5oxJb0GQWDsXmKGdb/9jhOoJ5XhCvkAtAXuQJRl0JJGKvi6s7h+3jWuZWtFTP1AXuHbUcsNBlLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04JGOiJIKv1n2siOElgQBu80VFhGpTEzSrNDxKa+Z5o=;
 b=xsdu+b0lco/mGfFfoD9/RvV3AakmadxOtc1GD5ts9B/QdkI8MYUW3JM2CLv3+UYZDYA22pH0UGXnrB8hOFzbvehVDXU5fVP1RH/N7pu06AB8m8mYYhRDcNzVFcTvBKXfKQZf2b2HyxPVKTJycX/kQ6LY4HaLGpM/rsPp7z1+k+A44kqm1MkzzccFTZGdnRnB6TRjStlt1j8iBb6bIinlEkIrYh+nRkl3IkENtO6pXFlACbf13msQ3Tzuaf4z13j226gRK7Ca5enBhX5zcvZ/sTXsyHxxNtLoOL1VjYtrvO2omVc2SXr+/XbPti/WGj3/6pANwFWk9OBxIhZyBzm14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04JGOiJIKv1n2siOElgQBu80VFhGpTEzSrNDxKa+Z5o=;
 b=I+2BytfUS+6ve9VYccYWBb2Zl3todZ0LVzKj9x8xlshKo+Df6RUcZdbKebNWt3G4h2ooP3YCtIDxQ9IbvQ0uwJOcGzwQb8PjSdu2oXshfwwJIbqfRi33nVxz8wt+nkncmRn+4B0QPgoABkhpoX96JwtEjwZZEs6FNWXsiCHVmfA=
Received: from BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Thu, 28 Nov 2024 06:36:00 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::79) by BYAPR01CA0041.outlook.office365.com
 (2603:10b6:a03:94::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 06:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 06:35:59 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 00:35:56 -0600
Message-ID: <531b4ea1-b2e2-4b48-a7cc-4ca63107aff6@amd.com>
Date: Thu, 28 Nov 2024 12:05:53 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/eevdf: More PELT vs DELAYED_DEQUEUE
To: Luis Machado <luis.machado@arm.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>, Saravana
 Kannan <saravanak@google.com>, Samuel Wu <wusamuel@google.com>, Android
 Kernel Team <kernel-team@android.com>
References: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <172595576232.2215.18027704125134691219.tip-bot2@tip-bot2>
 <ee2feb3b-0a1f-4276-b6fd-f36014654cbf@amd.com>
 <30f13deb-7dda-4a17-ab88-f386377bc30b@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <30f13deb-7dda-4a17-ab88-f386377bc30b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c97295-9f5d-43be-6535-08dd0f76ec28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTcwbXJwR1o1aFZuUCtVN1JuZXJYZlYzbUtNZkNUZEVjQmZJY1NCcFJrTkFy?=
 =?utf-8?B?NkRXcXVTcSs3WEU3NTA4U2dMdFRDYnZ6cGtsZGFjcUhPQ0VzNTNBdWtEOEs3?=
 =?utf-8?B?K3g3Q1YrYUNLdU9LVGZkSkc2TzM5TVFYNGRZbjFYamNERUJlWjRtaDlreHRJ?=
 =?utf-8?B?UzZwSEVKSGxVRHVKU29CajVXKy94bzcySXBpOFNJeXQvTmQxQ0xhRldGakVD?=
 =?utf-8?B?TWF4SkZ2bm8xTDNrNFcxS2V4ZklkWTlYV1ZIRkJMeHNRWFlrV2Q4SCtZQXE1?=
 =?utf-8?B?ZDkzRzRtREtIVmlRY0RDVFZvUTFDaWFKdjhJemxJVTcwSlprdDd1eXRWcFcz?=
 =?utf-8?B?cC8yQllXbTRSSllGaXpLTERKUnRWVW8wZVk2bUFhelBlRG0rNTdkc1dPQ0xL?=
 =?utf-8?B?em1TVHJFOE5vL0JBOVV0eWxiTlZzWUlCK29YaW9ReUp6QXE3MzdKOTY3eFli?=
 =?utf-8?B?WDc4Q25oN05LeDZuM1dEREEvNWhVRnZwYkNMb0sxVlluM1o2QVcwSXRDdW84?=
 =?utf-8?B?VkhMN1J3ZWZ3ekJ0WHFpYnpKUkpUTTJwVjlTdUIvRWNTTHJOK29tenpHcHlQ?=
 =?utf-8?B?T01VdXpuMm8rZnMvdFBFNm5xRFgwc0dCTGNHV0lkcG9TWUFyRk9Wa0JOOEpa?=
 =?utf-8?B?Sk5NNGVyeUtUVVl6dk1UaWdjakdwWStGL1hMMFpNWlJNanZmVUJ3ZEhzN2Nv?=
 =?utf-8?B?QlZaSGorQ0VQVEpleXR2NG9qM0xZUUU0RDhuVWN1RFljdDBPbGl5Q1pMY2M2?=
 =?utf-8?B?UkxVQVF1RkpvSEl2R2djWlVFeUk1c0FJVlYwL09nVEJTR1g2bVJyNE04RDJM?=
 =?utf-8?B?U1ByZGlmc1MrYVJFazBKSmtlaFFwRXovQ3BwSVoyeVF0bGlzVDliOGROMDRh?=
 =?utf-8?B?U01QRjJIS083NmJ6Qkhtb0M0U1R1TERielJGci8rYzVBa3VDYUs2MkZsaTFi?=
 =?utf-8?B?czhRWG5NUExUQlo3N3k0UXJNOWE1bCtCZHI3MUcvaWZKaFlBYnlsVnhUaGJr?=
 =?utf-8?B?SW52blhQV1pVZWVGUUFFSFZoQTFiVE1BY3lIc2lXV0Z6MGw3ZitsQ3l4ZVBP?=
 =?utf-8?B?aFdvY2NtRm54cklpYXIwUE9LTTcwbTd3UUpYV05FTUl4YkNlQ1hBMWl0NjZD?=
 =?utf-8?B?S1hIUnF6eUg2dTR0cXMva2hWSDN4K1lsUGZWZ1A3ZXZWSlBpQ1hyVnZrRHJO?=
 =?utf-8?B?K2IvVDFFL0Y2Q3A1TkNxSC9Wd0hFZldVUEFzZE02V043bm0raE50aFBYTkIz?=
 =?utf-8?B?MktyUCtibTUwSVBSVGM1THhvMmN1QW9LdG91ejg2dEcwWE5Wd044SDlpcWt3?=
 =?utf-8?B?a1ZqNHU0K0s5UXd1VUR0K2hjaTVzWEx1YU5nQzUycXNXN1RqSWFwN3VYL3Jh?=
 =?utf-8?B?MVo3aWdYenlJMGxiZENIR1BoZnpyekk0YTRqME1KVGYwaXBsQTE0K3BwM3B4?=
 =?utf-8?B?VDBQVWtTL2lKVVcrejdPa21reGpHS1MrcS9KcE1Ea3pwZ0NPNmZCakxYc0pv?=
 =?utf-8?B?T05aQ0Znb0pLK3ZkRVJqM3AwenYxQjRnd0NuYUlVdWIvTDJ5Zkt0MU9QR3Ru?=
 =?utf-8?B?blZIZHhhSkx5aXNyNE55VTFMTzFDbmRmVVFFTUZaNkxIbUlKODBaaEJXNjdp?=
 =?utf-8?B?VGZWTi8xQUZVcUc3dTg0Y0VMYkdkdGFJNi9xcWhoWFpRWTRyVlBMMktQMkFT?=
 =?utf-8?B?UTlHZkpCQ3hZbGpySlljSHRja1MrMlBvbHdydnpibEJGbC9zRDVnWU9aNS81?=
 =?utf-8?B?eGRMcjJLZHBQNXNNRnlyQ1QzYVdxTDhFZTJ4Nk56VHJUbWVlUHpGUURYZkZG?=
 =?utf-8?B?WnRBOHpCanYwMlpSNWZWTEFPallreWdBMHN3SUJORmp6b20vblhzQ1k0RFpm?=
 =?utf-8?B?b2pUWkl1NHlqWkZab2pZR0dJTXNMQmJHcW55bVV5UTc4M0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:35:59.7543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c97295-9f5d-43be-6535-08dd0f76ec28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

(+ Saravana, Samuel)

Hello Luis,

On 11/27/2024 3:04 PM, Luis Machado wrote:
> Hi,
> 
> On 11/27/24 04:17, K Prateek Nayak wrote:
>> Hello Peter,
>>
>> On 9/10/2024 1:39 PM, tip-bot2 for Peter Zijlstra wrote:
>>> The following commit has been merged into the sched/core branch of tip:
>>>
>>> Commit-ID:     2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
>>> Gitweb:        https://git.kernel.org/tip/2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
>>> Author:        Peter Zijlstra <peterz@infradead.org>
>>> AuthorDate:    Fri, 06 Sep 2024 12:45:25 +02:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00
>>>
>>> sched/eevdf: More PELT vs DELAYED_DEQUEUE
>>>
>>> Vincent and Dietmar noted that while commit fc1892becd56 fixes the
>>> entity runnable stats, it does not adjust the cfs_rq runnable stats,
>>> which are based off of h_nr_running.
>>>
>>> Track h_nr_delayed such that we can discount those and adjust the
>>> signal.
>>>
>>> Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
>>> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Link: https://lkml.kernel.org/r/20240906104525.GG4928@noisy.programming.kicks-ass.net
>>
>> I've been testing this fix for a while now to see if it helps the
>> regressions reported around EEVDF complete. The issue with negative
>> "h_nr_delayed" reported by Luis previously seem to have been fixed as a
>> result of commit 75b6499024a6 ("sched/fair: Properly deactivate
>> sched_delayed task upon class change")
> 
> I recall having 75b6499024a6 in my testing tree and somehow still noticing
> unbalanced accounting for h_nr_delayed, where it would be decremented
> twice eventually, leading to negative numbers.
> 
> I might have to give it another go if we're considering including the change
> as-is, just to make sure. Since our setups are slightly different, we could
> be exercising some slightly different paths.

That would be great! Thank you :)

Now that I see, you did have Valentine's patches in your tree during
testing
https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/
Perhaps it could be the fixup commit 98442f0ccd82 ("sched: Fix
delayed_dequeue vs switched_from_fair()") or the fact that my benchmark
didn't stress this path enough to break you as you mentioned. I would
have still expected it to hit that SCHED_WARN_ON() I had added in
set_next_task_idle() if something went sideways.

> 
> Did this patch help with the regressions you noticed though?

I believe it was Saravana who was seeing anomalies in PELT ramp-up with
DELAY_DEQUEUE. My test setup is currently not equipped to catch it but
Saravana was interested in these fixes being backported to v6.12 LTS in
https://lore.kernel.org/lkml/CAGETcx_1pZCtWiBbDmUcxEw3abF5dr=XdFCkH9zXWK75g7457w@mail.gmail.com/

I believe tracking h_nr_delayed and disregarding delayed tasks in
certain places is a necessary fix. None of the benchmarks in my test
setup seem to mind running without it but I'm also doing most of my
testing with performance governor and the PELT anomalies seem to affect
more from a PM perspective and not load balancing perspective.

> 
>>
>> I've been running stress-ng for a while and haven't seen any cases of
>> negative "h_nr_delayed". I'd also added the following WARN_ON() to see
>> if there are any delayed tasks on the cfs_rq before switching to idle in
>> some of my previous experiments and I did not see any splat during my
>> benchmark runs.
>>
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index 621696269584..c19a31fa46c9 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -457,6 +457,9 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
>>   
>>   static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>>   {
>> +    /* All delayed tasks must be picked off before switching to idle */
>> +    SCHED_WARN_ON(rq->cfs.h_nr_delayed);
>> +
>>       update_idle_core(rq);
>>       scx_update_idle(rq, true);
>>       schedstat_inc(rq->sched_goidle);
>> -- 
>>
>> If you are including this back, feel free to add:
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>
>>> [..snip..]
>>
> 

-- 
Thanks and Regards,
Prateek


