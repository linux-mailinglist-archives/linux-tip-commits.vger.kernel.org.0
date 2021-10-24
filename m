Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEF438A03
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhJXPm3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhJXPm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:26 -0400
Date:   Sun, 24 Oct 2021 15:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TI/WEfBMvUahWrYOHjOd02URe64LLG1KPiSvk+BvIA=;
        b=v/SX3DG0E3nxPCMEXvxn6uWgYI1kP/RDihDvJVaalcwlO1kTLCWyKRhc9xPcseZ/IdllR2
        6FH1H6wwiiOzYo2NSdyxpnRHhZGCuEi+uOoMQQyXDqsR8G9WFHekf8Wh3P/Fjc/Ed5riLv
        VIYTf3wiPuMDU9bUPlau2xi2ubRtDkReNGt4TMDrAx9S6zQpYZiaWNMXcdpSyaur6WzKVc
        1Ukeqk4oQXsudXjs56+LAFv/JLwhyaaf5T9yzYfyM515IAQ1BaTr2qQVDZ9YZ0RH7l/b87
        yHX1DOUN43sL/qQRoHn7DxCYRUXgaf2yWyPZrg9aElRexmpkEhmliBUDxmSXaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TI/WEfBMvUahWrYOHjOd02URe64LLG1KPiSvk+BvIA=;
        b=r9n1rF9qvUd71pOus5TtAX28hmJcIlYf+DJIk2njg3hEpsIIxjuWxbbVRtEn4gI4jxD4Ob
        djN+an9X1yyK74AQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Move drop
 _tval from erratum function names
Cc:     Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-6-maz@kernel.org>
References: <20211017124225.3018098-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000392.626.4065759630604774487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ac9ef4f24cb2313fb047f2097396204b033799b8
Gitweb:        https://git.kernel.org/tip/ac9ef4f24cb2313fb047f2097396204b033799b8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:13 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:10 +02:00

clocksource/drivers/arm_arch_timer: Move drop _tval from erratum function names

The '_tval' name in the erratum handling function names doesn't
make much sense anymore (and they were using CVAL the first place).

Drop the _tval tag.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-6-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3221654..8afe8c8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -369,7 +369,7 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
 
-static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
+static void erratum_set_next_event_generic(const int access, unsigned long evt,
 						struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -390,17 +390,17 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long 
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
-static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_phys(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
 
@@ -412,8 +412,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "Freescale erratum a005858",
 		.read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_HISILICON_ERRATUM_161010101
@@ -423,8 +423,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "HiSilicon erratum 161010101",
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 	{
 		.match_type = ate_match_acpi_oem_info,
@@ -432,8 +432,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "HiSilicon erratum 161010101",
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -452,8 +452,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "Allwinner erratum UNKNOWN1",
 		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
-		.set_next_event_phys = erratum_set_next_event_tval_phys,
-		.set_next_event_virt = erratum_set_next_event_tval_virt,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1418040
