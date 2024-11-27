Return-Path: <linux-tip-commits+bounces-2888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE09DA169
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2024 05:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B13283F18
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2024 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC518E0E;
	Wed, 27 Nov 2024 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwnFokOC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C51335C7;
	Wed, 27 Nov 2024 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681097; cv=fail; b=KC7tuwTZt9DR2Z/nhZt5yd8BCTRoKdIhv9oxF8LJRiTsN7MBlcVnDsQmtlCD7L34hXHqSIIo93iX02URm/NQUXvz+im+I/Xyqx+fKOBe7Zp5j1xAl+AmO5cMLkvSy3Gjef1w4SmwTcZ3tdUxlA37RYl6yKJianaCqJ4G1Ml3MgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681097; c=relaxed/simple;
	bh=itCxEcPe/CZpdPF59n3SrlZm5QOOderS+SaGx1nOQmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pnt8BhqZH10Qalf8W/SHb2LwzXegyKsT43vvI0VSPxGAHSH1AqDgP2ZlN90bbjMS/I9e9Uitrj8RP50LDgcBZyM/JcIbvj+7S52dxZP30aBbFa1L8rXOohMQxngL+3dXkSs5o0CxptzmfXlTKOi4L4x9elBaTne4ehVWNEbMRE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwnFokOC; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj8CWp2cHM/EMVhrW5oQ0jeVYMpnXOOi9VX+FokNef3+Hj+sKJuxIozpXcvsEsl1qb5S2q6FaHRGCpltGjGMdXVRoAymqBoO9CTYfvKcZG5tjzmp6MwfmN+smKT0FlFz+ofu/q+U5F9PI9ZaPy6epkTEoPnHSfu2vfZkx/sGhhcRndcxMoM272S1QXGLWd4HTOFS543LDq1ObH8tSVOvaNRvBZh1yy+D0hWcF1ZBdcEwDW+mysl8IL4pQfn/MXqcfZDSi1Ww/NTGvwuVGWzWcvRZ+kZ5QrRpxgcZdJbaLXl7tD/czlM27BTtsuAbIrGN0T078bjyOG7MYvLgX5f9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLFte9NJHWGKFwgw7WyKBSLb9MQICnc6QTE3GZUo5E8=;
 b=V0v0X2VcATjxOAkrPqvDB+U73/VkGdxeZXuX0vRoOT0zD832czS7gZ3XkG9+Ys4wggxuLEa2R+u+9C9cHVlfHW0ut7ccrl3TZgyIEpphlw6yjteSkEji5Qq5rVjSus86KBJYU+S4yb3Y2Me1l5DS6HDdlfJ4EFLeB0RcqWKAljRxbMnD3xdWQ9XWNr+u4WlpRi5D6ChikY4OM/2uhfRC/DWLqZ7K194hvjmnL2gKlbakxd1Z+ceaixRCCw/YveWU6hL3+zLoAGkr/2q3gt7GIezW5Ma6HhkQJ+Ew+iO8vb3lSqN4NlttrEaO96AynPRWw/NvOKRtov3eH9B91w98lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLFte9NJHWGKFwgw7WyKBSLb9MQICnc6QTE3GZUo5E8=;
 b=HwnFokOCtCgjcRt9HXAzRnlTjr66Fl++KjG+6Nq9lSF3huCsnsa+lpUlFh6yra550qAizQKgSyxt1qTfdd5yO5Hkw/jRhqtx5SuRlCpotHSDhy1QbW3PeuUAY2KXl4YnKS9eHidrRyQw7tC08wpJz1226rpyAfbqP5VIDGxC04c=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 04:18:11 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::69) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.22 via Frontend Transport; Wed,
 27 Nov 2024 04:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 04:18:10 +0000
Received: from [10.136.45.86] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 22:18:08 -0600
Message-ID: <ee2feb3b-0a1f-4276-b6fd-f36014654cbf@amd.com>
Date: Wed, 27 Nov 2024 09:47:54 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/eevdf: More PELT vs DELAYED_DEQUEUE
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>
References: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <172595576232.2215.18027704125134691219.tip-bot2@tip-bot2>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <172595576232.2215.18027704125134691219.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee1b81c-fb21-4f54-c205-08dd0e9a80dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlMwMDB6bXNvNXExV0w4Mm5kZm9oTmViY2JOdmlHVjVjNVdWTEsxRFBsRTZN?=
 =?utf-8?B?cTdtY05TRXFPUXR6NHZDYzRwbVRFUW5SU1J6YUFzMnJyaFgzVkFJdDNTNkxN?=
 =?utf-8?B?Rk4rZjc2SzR0WjFrUk1jaVBJMUtiUjZ0NWlCY2FXL1JVdUF0elEwa3NJVHFj?=
 =?utf-8?B?YnNDSk90bmQzbTBFVjk0blVrakkyU2ZSeERRME1aN3hhc0d5TVdUZzVlV1lS?=
 =?utf-8?B?ZnlmM0cyVWJoQzQvZW00Q2RTNERUVmNWR0duN2Q4OHBSZ0N5QlVyblRYeS91?=
 =?utf-8?B?cGkxbldyYVEvRjZHRHRmWCtsUXFvZ3RYYkhCOEtPbVpvNEJUbEVrRjlocVZD?=
 =?utf-8?B?bHZmNHVDQUYrTWNPWklqL1IzWE1jNWJ1MVV1OHVoQlpJeXBLdmZqTVlFUnNq?=
 =?utf-8?B?NXAwOW9tcUFsd3ZyZjAyMnBIN2VBNFFiNWVxNWZjNE9jN3ZkTzIzZHhnRDBl?=
 =?utf-8?B?aUZxc04xcXM2dU53enVpWVVaTTBYZmhuTVVuQ3ZVTjJJcDZGMFRidUVxVlpB?=
 =?utf-8?B?QmpzNFdmYS9ndjkyeGYveTRHNFhCVWtUNDJ5eUFOV3VDNS82Q0RESE9IdXV3?=
 =?utf-8?B?Zm9Remt6U2kyRzJ3NGtnaTVNdEFPUVY2dk83SGlWNWhETy96UVVxcXlqbDcz?=
 =?utf-8?B?dEwyMVNvNVZmYW9HdGcxSDVrNGh2b1hwSFJMN0cramh1Q2xURWwyMC9tazFQ?=
 =?utf-8?B?dHllTUN5cnQyY2JqWktkWDF0clF6T1lYNVBtays1RW16dE5YTkduZW9LbmdB?=
 =?utf-8?B?WFFlU0c5Vnlmd3JSWDJZaFg0VmI5ZnhDUXo5UFlpa3oya0ltM1Z0bUxiNTBp?=
 =?utf-8?B?ODFDcHRpdFNrNFhQZHdMQm9ZNDRtaTF4U3ZVSmpCcXByc2VGbzVZb3J6REtG?=
 =?utf-8?B?b1JFQnVkR3psejEzaXVyTFRvbk5DWGlkeTRqOHpYQnhwZUNtU2MwdWVieE1p?=
 =?utf-8?B?UGtpdklJWXdKRmYyb1Qzdmd1Q3ZkdkZYVEZZUTA2UnRnejNKaTF2Yy90WWIz?=
 =?utf-8?B?MktBOVpyOTM0ZUZQK0RUKzBmZlNXd2l3dno2Y3BsZDh3K21tSVJ6cW1NbUQz?=
 =?utf-8?B?RmE0MXdNWlpiRmdFbFhVTGx1V280enRVcmtwaFBzTFRpRFN5MVc1ZFVNRFZu?=
 =?utf-8?B?ZDd6MUtlNVhLUVZoRDdqT0RsZC9mNlRONkNucjdnakRrQzhRdUw3ZWdBQ0Ro?=
 =?utf-8?B?WVpjaXVLT1ZZemNnWXZPd0xMRDl4Z1NmRkVhRlgwQVRZSGtRVGVTTHI4OTNk?=
 =?utf-8?B?SGdOdDVMbEZVWnRoMWxPTVltR2F5ejlrcVdKaFRLR1BLeFlNR0E4Z1B4dzBk?=
 =?utf-8?B?M29oZWxVeGdUUjFUYWRKdXk5TlNudnk0NzR4MnN0dS9JL2sxSDJVbjA0OVd1?=
 =?utf-8?B?VU04MytCYjNCS2ZsOGVlNzZrQ3JQZXQ4ZlVtd2tMK2I3UWY5QjlrSjZwb09s?=
 =?utf-8?B?SmJyWFRyWDFVTkowdnlNYndNUEc2Sm1zQnozaytWNmJLTGFsbU1TUU5ESitY?=
 =?utf-8?B?ajMxbzU5ZTNNMThobzl6dmpnMHVpU1RrSURUSDVMRjlyVzV5MmxoN09TN0N3?=
 =?utf-8?B?TWdWeDFuZEpxc2xpRWhBU050Q3ZXQ0l4OU10aFJkV0hBNkx4M3N6aStoMW5X?=
 =?utf-8?B?UzBWODJoczM2VExOaW5zUnBVU2x6Q1hwajlEODl1dkEvQnZxakVvbDdLV21V?=
 =?utf-8?B?NGlRQTU5bksvTWtIRWQ2Unk4Z1JlRGZCcEg0WTlQdzFSdFRxU2trL2RDWFAv?=
 =?utf-8?B?T004ajYyNzBpWTFZVmZQKzF5VnRtdUFwZFhqOENMRGlvM2pGdU1wTlFUMGRM?=
 =?utf-8?B?UHgyNVF5NG4vSHMrSlRNbkJZZmFvM1pYeHVqTTZleXAyQmcxUlgvbUJnVUsv?=
 =?utf-8?B?TjhLSnhPaGVNZWpqNkZ3TmhYR3UrbDE1bndjN1pOcW9pQ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 04:18:10.4463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee1b81c-fb21-4f54-c205-08dd0e9a80dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Hello Peter,

On 9/10/2024 1:39 PM, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
> Gitweb:        https://git.kernel.org/tip/2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Fri, 06 Sep 2024 12:45:25 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00
> 
> sched/eevdf: More PELT vs DELAYED_DEQUEUE
> 
> Vincent and Dietmar noted that while commit fc1892becd56 fixes the
> entity runnable stats, it does not adjust the cfs_rq runnable stats,
> which are based off of h_nr_running.
> 
> Track h_nr_delayed such that we can discount those and adjust the
> signal.
> 
> Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20240906104525.GG4928@noisy.programming.kicks-ass.net

I've been testing this fix for a while now to see if it helps the
regressions reported around EEVDF complete. The issue with negative
"h_nr_delayed" reported by Luis previously seem to have been fixed as a
result of commit 75b6499024a6 ("sched/fair: Properly deactivate
sched_delayed task upon class change")

I've been running stress-ng for a while and haven't seen any cases of
negative "h_nr_delayed". I'd also added the following WARN_ON() to see
if there are any delayed tasks on the cfs_rq before switching to idle in
some of my previous experiments and I did not see any splat during my
benchmark runs.

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 621696269584..c19a31fa46c9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -457,6 +457,9 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
  
  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
  {
+	/* All delayed tasks must be picked off before switching to idle */
+	SCHED_WARN_ON(rq->cfs.h_nr_delayed);
+
  	update_idle_core(rq);
  	scx_update_idle(rq, true);
  	schedstat_inc(rq->sched_goidle);
--

If you are including this back, feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> [..snip..]

-- 
Thanks and Regards,
Prateek


