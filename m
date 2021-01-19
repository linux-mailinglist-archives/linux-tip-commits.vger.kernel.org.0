Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9611F2FBC15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Jan 2021 17:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbhASQLV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Jan 2021 11:11:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391775AbhASQKl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Jan 2021 11:10:41 -0500
Date:   Tue, 19 Jan 2021 16:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611072596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/X7bnT0Fs4sPITr8k9z7TTU0AiLMBMoPoDOqNqcWbo=;
        b=0qXiEm+wwysMZJk8AGANYIvbLP8kledYnojIUmXol+1AVeFYXbTCDKBg7apquWozUXkg28
        omvL9MYUixAxbborLr3/B2jgojwtqSa7Xrrdc2Bpm56fTzrjUfLAQdkGTVLJkKcdlcvAeu
        +ETt411VByiwsZ9E6kJs7dihVERI8wWTInVvxTgXgaPXbS0glWjxGNJwQs/mLhmtgwDsDw
        sWMQ0RRDIIGPIv2Gn5e3l1UC1RysLc1OaT+5bWHrq/1GLkWXY33Fh5nuKbEV8gdbOL3LmM
        mgQ6jaPzXDsEoBriK6sOUYHsVml0Gv9QTmver//pv9ATm8xj+H32iuIKppMxYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611072596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/X7bnT0Fs4sPITr8k9z7TTU0AiLMBMoPoDOqNqcWbo=;
        b=+nMZrqv/PnClTnwLGYweWpXVEMuclFPJDv60inTobhnnFx+0pFp90Rgar0E9x10bAGrZy1
        MUFG6wFOf667sRBA==
From:   "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86: PM: Register syscore_ops for scale invariance
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1803209.Mvru99baaF@kreacher>
References: <1803209.Mvru99baaF@kreacher>
MIME-Version: 1.0
Message-ID: <161107259553.414.4642815387021919631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9c7d9017a49fb8516c13b7bff59b7da2abed23e1
Gitweb:        https://git.kernel.org/tip/9c7d9017a49fb8516c13b7bff59b7da2abed23e1
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Fri, 08 Jan 2021 19:05:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Jan 2021 17:04:03 +01:00

x86: PM: Register syscore_ops for scale invariance

On x86 scale invariace tends to be disabled during resume from
suspend-to-RAM, because the MPERF or APERF MSR values are not as
expected then due to updates taking place after the platform
firmware has been invoked to complete the suspend transition.

That, of course, is not desirable, especially if the schedutil
scaling governor is in use, because the lack of scale invariance
causes it to be less reliable.

To counter that effect, modify init_freq_invariance() to register
a syscore_ops object for scale invariance with the ->resume callback
pointing to init_counter_refs() which will run on the CPU starting
the resume transition (the other CPUs will be taken care of the
"online" operations taking place later).

Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Link: https://lkml.kernel.org/r/1803209.Mvru99baaF@kreacher
---
 arch/x86/kernel/smpboot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ca66af..117e24f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -2083,6 +2084,23 @@ static void init_counter_refs(void)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static struct syscore_ops freq_invariance_syscore_ops = {
+	.resume = init_counter_refs,
+};
+
+static void register_freq_invariance_syscore_ops(void)
+{
+	/* Bail out if registered already. */
+	if (freq_invariance_syscore_ops.node.prev)
+		return;
+
+	register_syscore_ops(&freq_invariance_syscore_ops);
+}
+#else
+static inline void register_freq_invariance_syscore_ops(void) {}
+#endif
+
 static void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
@@ -2109,6 +2127,7 @@ static void init_freq_invariance(bool secondary, bool cppc_ready)
 	if (ret) {
 		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
+		register_freq_invariance_syscore_ops();
 		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
