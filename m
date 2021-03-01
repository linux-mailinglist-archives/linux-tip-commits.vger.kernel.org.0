Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1F327BBD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhCAKRG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhCAKQy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A14C061756;
        Mon,  1 Mar 2021 02:16:12 -0800 (PST)
Date:   Mon, 01 Mar 2021 10:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLlLRuAO9hY5yfzy69JdFcFS/cBaH61UJVjMiye7Liw=;
        b=rcUYAgpUfkPvHvvdvY9NhARIU5NbqNy+BZzFL7Oo1Ru4t2/AagiTazz2lGXso+Nc6F5yLl
        FU4rOONlcao8qMGfebG0TkxpwZoSTuTG8J055KToGFcTMRjWFxK0xDLCQEdot5sePGfO5C
        siCK7bqwrpOvgFcXtHFa2AlnqiCMu3LxxrYIwjDzCY9MBNma6HigpXAs9S9qlHjl+bIJDi
        OoRXJUZoUW+9JJCh73bOU8sgcfncLiGZ1SKUc+P652caMOMnyYM5x5Huydlttu+oCWI+Rc
        La8YNlZ69hxIpCCFdI3eUnQoa7HB9jWSh88Gz8sQ85wtG82qk2CqseUlpXce9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLlLRuAO9hY5yfzy69JdFcFS/cBaH61UJVjMiye7Liw=;
        b=U4Na7H87DNleX534w+/pdJu0Mv+Q1hKnLs9oUHqsdczSr3pmVnZO+dDtRjtsG6lWMl4Zsg
        WZKD5wLTIjR+IqCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large
 PEBS and LBR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130193842.10569-2-kan.liang@linux.intel.com>
References: <20201130193842.10569-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161459377043.20312.676489427209789411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a8abc881981762631a22568d5e4b2c0ce4aeb15c
Gitweb:        https://git.kernel.org/tip/a8abc881981762631a22568d5e4b2c0ce4aeb15c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 30 Nov 2020 11:38:41 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:19 +01:00

perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large PEBS and LBR

To supply a PID/TID for large PEBS, it requires flushing the PEBS buffer
in a context switch.

For normal LBRs, a context switch can flip the address space and LBR
entries are not tagged with an identifier, we need to wipe the LBR, even
for per-cpu events.

For LBR callstack, save/restore the stack is required during a context
switch.

Set PERF_ATTACH_SCHED_CB for the event with large PEBS & LBR.

Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201130193842.10569-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5bac48d..7bbb5bb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3662,8 +3662,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event)))
+			      ~intel_pmu_large_pebs_flags(event))) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
+				event->attach_state |= PERF_ATTACH_SCHED_CB;
+			}
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
@@ -3676,6 +3678,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
 			return ret;
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
 
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
