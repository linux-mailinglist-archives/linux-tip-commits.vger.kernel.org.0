Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB232FA56
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCFLzU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhCFLyn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65D1C06174A;
        Sat,  6 Mar 2021 03:54:42 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1m0FhQDBmpUaQyGUbiIHD5fCyq3WLJnpdMkE6d4USMQ=;
        b=SBZMNC+6ShIYonDnSYxIS1Z6v8XbXoCyCnJzxaPW82Iz82zorjvtWx528pfG15P//6SNln
        g0chBBCNNpdSNc5zb5cWDApgcFj77LWzmhFh63ErFLI/VNbn8CfA28OaBWTR2VR28Dp135
        NzpxaEFHUTzJkMkNdIqkGw/0smPsnogSkiUBauO3PIsR9LZw73MgvDmGD1szTEJJ/KN0WH
        PEQQKZOIDe7rJfdfmnYMDvjx2SkLPr3WzwiH5MEQ9u5qse701jpQPfK9CkCn0qlYPyCOc9
        DmZmLIw4Ybp4LgeX1UNAgS4+Mzq6oJZQHaEY0nS0ysBBfDeUILOM5OleatHhWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1m0FhQDBmpUaQyGUbiIHD5fCyq3WLJnpdMkE6d4USMQ=;
        b=GOfm5fVu28G2E5XjjLIaHp2whcwx6JynM1F86GPTVFBv0v2Erna/WO1MRYWbTunNDnlhPV
        oKrg36k5K16pBKAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large
 PEBS and LBR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130193842.10569-2-kan.liang@linux.intel.com>
References: <20201130193842.10569-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161503168079.398.18106264534965767356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     afbef30149587ad46f4780b1e0cc5e219745ce90
Gitweb:        https://git.kernel.org/tip/afbef30149587ad46f4780b1e0cc5e219745ce90
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 30 Nov 2020 11:38:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:52:44 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
