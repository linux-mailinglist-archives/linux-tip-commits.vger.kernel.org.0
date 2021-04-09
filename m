Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE6359BF8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhDIK1n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIK1j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:39 -0400
Date:   Fri, 09 Apr 2021 10:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCBMI1IKIzcIwvzOqR7fpPq9U5wh2sz8yqJL2Ewinmg=;
        b=YnU6B3Sb3G9FUuYyATDaoiPlFpaOeJ955IQNzpM6emepN5w2s8dxqiFnIYJ62YhoRkOaEF
        CrUL1S5IZT3hAVSsqPHB9JNLWP0k8Ec5sRXO4eHMCjKcrBkyK+ERp55keV/2ijknn5sRyk
        0jUYRLOfnbYECBgvAtrFBrUdh1xrGIGkBuZPE11WgifaiTtEHf9nj66CHjkIqDFqctkqCo
        XrFLmkfchs5E3Eyq+OE2hld7TFX7jgpVFLruCM9UgM2KlSV74lNMPJveyJbT+y7wW0u8sm
        gQjocL17LfG6SLV3QausQhCzblT2dKDUg1nbyAIDjITDSMuK0f1neLc9HvnZrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCBMI1IKIzcIwvzOqR7fpPq9U5wh2sz8yqJL2Ewinmg=;
        b=lX1d28+ICZ+9AXLLO1gTPKwfTNqAQsvGgYjp77S7Dxl9/HGB4d2SUikAJ0lJN+1XIq0DXE
        XHB8oDA5NFVOYBBw==
From:   "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Add
 __ro_after_init and __init
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210330140444.4fb2a7cb@xhacker.debian>
References: <20210330140444.4fb2a7cb@xhacker.debian>
MIME-Version: 1.0
Message-ID: <161796404455.29796.11116484336739405400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e2bf384d4329bb478ad003eae1ab644756a42266
Gitweb:        https://git.kernel.org/tip/e2bf384d4329bb478ad003eae1ab644756a42266
Author:        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
AuthorDate:    Tue, 30 Mar 2021 14:04:44 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 16:41:19 +02:00

clocksource/drivers/arm_arch_timer: Add __ro_after_init and __init

Some functions are not needed after booting, so mark them as __init
to move them to the .init section.

Some global variables are never modified after init, so can be
__ro_after_init.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210330140444.4fb2a7cb@xhacker.debian
---
 drivers/clocksource/arm_arch_timer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d017782..1b88596 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -51,7 +51,7 @@
 
 static unsigned arch_timers_present __initdata;
 
-static void __iomem *arch_counter_base;
+static void __iomem *arch_counter_base __ro_after_init;
 
 struct arch_timer {
 	void __iomem *base;
@@ -60,15 +60,16 @@ struct arch_timer {
 
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
-static u32 arch_timer_rate;
-static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
+static u32 arch_timer_rate __ro_after_init;
+u32 arch_timer_rate1 __ro_after_init;
+static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
-static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
-static bool arch_timer_c3stop;
-static bool arch_timer_mem_use_virtual;
-static bool arch_counter_suspend_stop;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
+static bool arch_timer_c3stop __ro_after_init;
+static bool arch_timer_mem_use_virtual __ro_after_init;
+static bool arch_counter_suspend_stop __ro_after_init;
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
 #else
@@ -76,7 +77,7 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
-static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
+static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
 
 static int __init early_evtstrm_cfg(char *buf)
 {
@@ -176,7 +177,7 @@ static notrace u64 arch_counter_get_cntvct(void)
  * to exist on arm64. arm doesn't use this before DT is probed so even
  * if we don't have the cp15 accessors we won't have a problem.
  */
-u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
+u64 (*arch_timer_read_counter)(void) __ro_after_init = arch_counter_get_cntvct;
 EXPORT_SYMBOL_GPL(arch_timer_read_counter);
 
 static u64 arch_counter_read(struct clocksource *cs)
@@ -925,7 +926,7 @@ static int validate_timer_rate(void)
  * rate was probed first, and don't verify that others match. If the first node
  * probed has a clock-frequency property, this overrides the HW register.
  */
-static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
+static void __init arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
@@ -939,7 +940,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 		pr_warn("frequency not available\n");
 }
 
-static void arch_timer_banner(unsigned type)
+static void __init arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
 		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
