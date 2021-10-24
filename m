Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABE0438A02
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhJXPm2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJXPmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:23 -0400
Date:   Sun, 24 Oct 2021 15:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAIw9szqZk2YKmpdPnhPqHcK8KgJjwzUe4c9lBW5ocY=;
        b=MrYZHa6oeYLyZJa1vDROFIo03TCEpW2v2+JVrfFdUucKx0504pkJQt/pjtvqL9kkbUmMhO
        0KOS7TwjkOXB8xEURyV0WgoCWYwNwGEGX3c9ECM0bURGVuhclpf0DCE1Ej47vGursWwTnZ
        xaWmUEudw0dNPI14UQK4VUigj9yHM2/Sh4338L2x0+8UpBmo429UJmwgQJ/KQR48iv0pT/
        pjYe0dAJfujjh3R8lZXSnsJtTZv7iiqrkOCsdrwpAINNdX5+rvs7nPyNFLPT/kHtV+AzQH
        JWvDy4M53PwymoMFPTAeBdpX8IY6QcMWa4l8ihTeDP2MOqrEDlCeHii9b4gD5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAIw9szqZk2YKmpdPnhPqHcK8KgJjwzUe4c9lBW5ocY=;
        b=9XqN2g5G0oQ7fYKmm5VxKgGsTO9L3a192kzyaZfsGlAAFbU3WcIUDX6Ek4vO7Hccw1X6Vv
        2gbmwxBdduno0YDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Work around
 broken CVAL implementations
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-10-maz@kernel.org>
References: <20211017124225.3018098-10-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000113.626.11844784487721751742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     012f188504528b8cb32f441ac3bd9ea2eba39c9e
Gitweb:        https://git.kernel.org/tip/012f188504528b8cb32f441ac3bd9ea2eba39c9e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:17 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:31 +02:00

clocksource/drivers/arm_arch_timer: Work around broken CVAL implementations

The Applied Micro XGene-1 SoC has a busted implementation of the
CVAL register: it looks like it is based on TVAL instead of the
other way around. The net effect of this implementation blunder
is that the maximum deadline you can program in the timer is
32bit wide.

Use a MIDR check to notice the broken CPU, and reduce the width
of the timer to 32bit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-10-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 36e0914..ef3f838 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -780,9 +780,32 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
+static u64 __arch_timer_check_delta(void)
+{
+#ifdef CONFIG_ARM64
+	const struct midr_range broken_cval_midrs[] = {
+		/*
+		 * XGene-1 implements CVAL in terms of TVAL, meaning
+		 * that the maximum timer range is 32bit. Shame on them.
+		 */
+		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
+						 APM_CPU_PART_POTENZA)),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), broken_cval_midrs)) {
+		pr_warn_once("Broken CNTx_CVAL_EL1, limiting width to 32bits");
+		return CLOCKSOURCE_MASK(32);
+	}
+#endif
+	return CLOCKSOURCE_MASK(56);
+}
+
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
+	u64 max_delta;
+
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
 	if (type == ARCH_TIMER_TYPE_CP15) {
@@ -814,6 +837,7 @@ static void __arch_timer_setup(unsigned type,
 		}
 
 		clk->set_next_event = sne;
+		max_delta = __arch_timer_check_delta();
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -830,11 +854,13 @@ static void __arch_timer_setup(unsigned type,
 			clk->set_next_event =
 				arch_timer_set_next_event_phys_mem;
 		}
+
+		max_delta = CLOCKSOURCE_MASK(56);
 	}
 
 	clk->set_state_shutdown(clk);
 
-	clockevents_config_and_register(clk, arch_timer_rate, 0xf, CLOCKSOURCE_MASK(56));
+	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
 
 static void arch_timer_evtstrm_enable(int divider)
