Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803F93628EA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbhDPTvM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 15:51:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:50483 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243580AbhDPTvM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 15:51:12 -0400
IronPort-SDR: oE6XID9K//I172vzSKJ9RmZo6E/ge5P+GhKVYaFxOKT98cP1LA6D5/OIj6/4GLsheWj6wsUi7J
 ecQSNmUYXVLg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194657502"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="194657502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 12:50:45 -0700
IronPort-SDR: Gt3GR4KU1AB45Sgopd9PhzMm0zhqTPOFOXUypKXCEFFDMEj3Zpofzlg+BENSUYiMxXbggO+XmA
 lKaOkgL3dHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="384414012"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2021 12:50:45 -0700
Received: from [10.209.42.134] (kliang2-MOBL.ccr.corp.intel.com [10.209.42.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C38A85808F0;
        Fri, 16 Apr 2021 12:50:44 -0700 (PDT)
Subject: Re: [tip: perf/core] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, x86@kernel.org
References: <1618410990-21383-2-git-send-email-kan.liang@linux.intel.com>
 <161858530850.29796.5870405530830102241.tip-bot2@tip-bot2>
 <YHm/M4za2LpRYePw@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2d470931-a077-5e45-479d-019061c11665@linux.intel.com>
Date:   Fri, 16 Apr 2021 15:50:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHm/M4za2LpRYePw@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org



On 4/16/2021 12:45 PM, Peter Zijlstra wrote:
> On Fri, Apr 16, 2021 at 03:01:48PM -0000, tip-bot2 for Kan Liang wrote:
>> @@ -2331,6 +2367,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
>>   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>   		return;
>>   
>> +	if (x86_pmu.sched_task && event->hw.target)
>> +		perf_sched_cb_dec(event->ctx->pmu);
>> +
>>   	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>>   		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>>   }
> 
> 'perf test' on a kernel with CONFIG_DEBUG_PREEMPT=y gives:
> 
> [  244.439538] BUG: using smp_processor_id() in preemptible [00000000] code: perf/1771

If it's a preemptible env, I think we should disable the interrupts and 
preemption to protect the sched_cb_list.

Seems we don't need perf_ctx_lock() here. I don't think we touch the 
area in NMI. I think disabling the interrupts should be good enough to 
protect the cpuctx.

How about the below patch?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e34eb72..45630beed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2333,6 +2333,8 @@ static void x86_pmu_clear_dirty_counters(void)

  static void x86_pmu_event_mapped(struct perf_event *event, struct 
mm_struct *mm)
  {
+	unsigned long flags;
+
  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
  		return;

@@ -2341,8 +2343,10 @@ static void x86_pmu_event_mapped(struct 
perf_event *event, struct mm_struct *mm)
  	 * and clear the existing dirty counters.
  	 */
  	if (x86_pmu.sched_task && event->hw.target) {
+		local_irq_save(flags);
  		perf_sched_cb_inc(event->ctx->pmu);
  		x86_pmu_clear_dirty_counters();
+		local_irq_restore(flags);
  	}

  	/*
@@ -2363,12 +2367,16 @@ static void x86_pmu_event_mapped(struct 
perf_event *event, struct mm_struct *mm)

  static void x86_pmu_event_unmapped(struct perf_event *event, struct 
mm_struct *mm)
  {
+	unsigned long flags;

  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
  		return;

-	if (x86_pmu.sched_task && event->hw.target)
+	if (x86_pmu.sched_task && event->hw.target) {
+		local_irq_save(flags);
  		perf_sched_cb_dec(event->ctx->pmu);
+		local_irq_restore(flags);
+	}

  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
  		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);

Thanks,
Kan
