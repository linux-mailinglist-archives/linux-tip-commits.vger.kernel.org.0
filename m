Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D52C4177
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgKYN5L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 08:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgKYN5K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 08:57:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC73C0613D4;
        Wed, 25 Nov 2020 05:57:10 -0800 (PST)
Date:   Wed, 25 Nov 2020 13:57:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0tXaYWAjXBDmD9YzTGUEJU0AyxTKBRwQOn7F60mkGg=;
        b=jdeQImsyBTErWCnQ7jgixUu6T2vrNMou55i7uQNzGsZ2++o8TRoYdsYaFUMvaMw4eQK1/t
        pKLmBEomdqRuPiFJ9H1Wy2J7w3FDsXChJYqXQrnBcAWXHD2pqR0O9T86p5+2LYir++dBlw
        Wdg35RR2Ua0+l10KbWDoWhfLxT2ttMJJZxx1ud6f3Gspf0+0eOQXrXGxOeY+hpcuVQJLRL
        zGRejc6eYAra1pOVAgDa1gnCEAVI5tYf/TEi3rx8k7FVWisWh13b6IQpFritpmR1Ab4U7L
        g+XsNIUW3ccHiR8Q2Drum+kdiG2dqZ4L0dXrSawg18c09C+HZlB6fhDmcbFBUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0tXaYWAjXBDmD9YzTGUEJU0AyxTKBRwQOn7F60mkGg=;
        b=Fnl/Ugu5YQjvwFbWeIJu5SIDXC1MMZUb1k2buky3MDddvLkCgehjghT5f5k861qMaUrXe6
        N5ZZ1MW1cZauOQAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] intel_idle: Fix intel_idle() vs tracing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201123143510.GR3021@hirez.programming.kicks-ass.net>
References: <20201123143510.GR3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160631262796.3364.8497872236526429888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     6e1d2bc675bd57640f5658a4a657ae488db4c204
Gitweb:        https://git.kernel.org/tip/6e1d2bc675bd57640f5658a4a657ae488db4c204
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Nov 2020 11:28:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:36 +01:00

intel_idle: Fix intel_idle() vs tracing

cpuidle->enter() callbacks should not call into tracing because RCU
has already been disabled. Instead of doing the broadcast thing
itself, simply advertise to the cpuidle core that those states stop
the timer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20201123143510.GR3021@hirez.programming.kicks-ass.net
---
 drivers/idle/intel_idle.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 01bace4..7ee7ffe 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -126,26 +126,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
-	bool tick;
-
-	if (!static_cpu_has(X86_FEATURE_ARAT)) {
-		/*
-		 * Switch over to one-shot tick broadcast if the target C-state
-		 * is deeper than C1.
-		 */
-		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
-			tick = true;
-			tick_broadcast_enter();
-		} else {
-			tick = false;
-		}
-	}
 
 	mwait_idle_with_hints(eax, ecx);
 
-	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
-		tick_broadcast_exit();
-
 	return index;
 }
 
@@ -1227,6 +1210,20 @@ static bool __init intel_idle_acpi_cst_extract(void)
 	return false;
 }
 
+static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
+{
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	if (boot_cpu_has(X86_FEATURE_ARAT))
+		return false;
+
+	/*
+	 * Switch over to one-shot tick broadcast if the target C-state
+	 * is deeper than C1.
+	 */
+	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
+}
+
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
@@ -1269,6 +1266,9 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (disabled_states_mask & BIT(cstate))
 			state->flags |= CPUIDLE_FLAG_OFF;
 
+		if (intel_idle_state_needs_timer_stop(state))
+			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
@@ -1507,6 +1507,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		     !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
+		if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
+			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
+
 		drv->state_count++;
 	}
 
