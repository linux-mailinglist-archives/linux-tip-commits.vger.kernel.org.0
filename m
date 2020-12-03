Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18E2CD21A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgLCJIN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbgLCJIM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A2C061A4D;
        Thu,  3 Dec 2020 01:07:31 -0800 (PST)
Date:   Thu, 03 Dec 2020 09:07:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDIknPMIm3lzC3RwS+ZU/AF5O0kS5a1gOT3SJgmIAtc=;
        b=pxA7WaGJr3/5jV38hxrN758aGsMCYXAvbTww4TnpSYT8fCdVB4srfnIYD4E0WwGVCAEhLq
        vStmfntdmMMInc+9+PREnLZWs2lOMUmLWzCZOOt73WFV1dL5S8ryHZLfpm63XT29LjwChF
        odc5CgyF01aj6HBH0iIUsnZDqhLI1FUa2DuXYdItmpUHBBqCclXNt50ntv0NjFuXjbdeXn
        q7ezJNDqwyWS6p7GU+1gTYmP5CytZWKxcroM4wHUxJIQoDdjwQNyjcORnHatGx4zFctEMQ
        yCmZGgNYv3UlSxpO1jgXNP8tBH3sn7hu4n0zDgf/oVbBGKeeopKwRs6ZC5QxUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDIknPMIm3lzC3RwS+ZU/AF5O0kS5a1gOT3SJgmIAtc=;
        b=CAE4SjaQsLhw4Z1E9Gklt8kpfMa8Bv5mMCnXbEKjr5p8fLpTIsvfs3MekH16ab2y3G7JW2
        GGU90/poZOjeCfDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] intel_idle: Build fix
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130115402.GO3040@hirez.programming.kicks-ass.net>
References: <20201130115402.GO3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160698644907.3364.1644696820259028448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4d916140bf28ff027997144ea1bb4299e1536f87
Gitweb:        https://git.kernel.org/tip/4d916140bf28ff027997144ea1bb4299e1536f87
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 30 Nov 2020 12:54:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:23 +01:00

intel_idle: Build fix

Because CONFIG_ soup.

Fixes: 6e1d2bc675bd ("intel_idle: Fix intel_idle() vs tracing")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201130115402.GO3040@hirez.programming.kicks-ass.net
---
 drivers/idle/intel_idle.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7ee7ffe..d793355 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1140,6 +1140,20 @@ static bool __init intel_idle_max_cstate_reached(int cstate)
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
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 #include <acpi/processor.h>
 
@@ -1210,20 +1224,6 @@ static bool __init intel_idle_acpi_cst_extract(void)
 	return false;
 }
 
-static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
-{
-	unsigned long eax = flg2MWAIT(state->flags);
-
-	if (boot_cpu_has(X86_FEATURE_ARAT))
-		return false;
-
-	/*
-	 * Switch over to one-shot tick broadcast if the target C-state
-	 * is deeper than C1.
-	 */
-	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
-}
-
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
