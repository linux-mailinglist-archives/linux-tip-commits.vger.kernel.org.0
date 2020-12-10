Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240BD2D6B93
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 00:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgLJXJo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 18:09:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbgLJWbQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 17:31:16 -0500
Date:   Thu, 10 Dec 2020 22:04:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607637874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rt9QRnOtg+5ZrOtIegVhtf1b8NkMrLmsSF+RRgRYRwc=;
        b=zyS23411np1EesNAPS3/0QkXqXbcLTNJ9bvRklWXJxmeaTVaUwlvRXUrvdYbScQsi38vMe
        3AAX9eHRVmI4BMfugypp3km4HTry+Vcc1OrR6LHF99ZKDkLU1evXByuA4YEA20D2/XCSR/
        b25zszoPCMDwiNf9Svxi0wicMuROYC/N0uvd6FnW7l4YYSDJcQQavHfv5yt225eK7wei2Z
        z8KsDKFkCPMPQjQqnNJUif3YphrcnNVTivoBOQsH8dcoHNJ8qJQie3utrluZtFEuRd3EdL
        yFE1rVEgovCkwWZJypL5lS5nqR/yVTuupCF91UotFb+q8XG26/gIIYIvp1fbFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607637874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rt9QRnOtg+5ZrOtIegVhtf1b8NkMrLmsSF+RRgRYRwc=;
        b=GGzJsG+RrDcZh2nfb05i+etdJnUURH5vfMs0kbJY5ToeoGMgz4XtMd5vw3TwQWwmpJuW0b
        uC/4nMx7S7bEz9CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup the timer_works() irqflags mess
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87k0tpju47.fsf@nanos.tec.linutronix.de>
References: <87k0tpju47.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160763787415.3364.14966268731529828798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     058df195c23403f91acc028e39ca2ad599d0af52
Gitweb:        https://git.kernel.org/tip/058df195c23403f91acc028e39ca2ad599d0af52
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 21:15:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Dec 2020 23:02:31 +01:00

x86/ioapic: Cleanup the timer_works() irqflags mess

Mark tripped over the creative irqflags handling in the IO-APIC timer
delivery check which ends up doing:

        local_irq_save(flags);
	local_irq_enable();
        local_irq_restore(flags);

which triggered a new consistency check he's working on required for
replacing the POPF based restore with a conditional STI.

That code is a historical mess and none of this is needed. Make it
straightforward use local_irq_disable()/enable() as that's all what is
required. It is invoked from interrupt enabled code nowadays.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/87k0tpju47.fsf@nanos.tec.linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 089e755..e4ab480 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1620,21 +1620,16 @@ static void __init delay_without_tsc(void)
 static int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
-	unsigned long flags;
 
 	if (no_timer_check)
 		return 1;
 
-	local_save_flags(flags);
 	local_irq_enable();
-
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		delay_with_tsc();
 	else
 		delay_without_tsc();
 
-	local_irq_restore(flags);
-
 	/*
 	 * Expect a few ticks at least, to be sure some possible
 	 * glue logic does not lock up after one or two first
@@ -1643,10 +1638,10 @@ static int __init timer_irq_works(void)
 	 * least one tick may be lost due to delays.
 	 */
 
-	/* jiffies wrap? */
-	if (time_after(jiffies, t1 + 4))
-		return 1;
-	return 0;
+	local_irq_disable();
+
+	/* Did jiffies advance? */
+	return time_after(jiffies, t1 + 4);
 }
 
 /*
@@ -2163,13 +2158,12 @@ static inline void __init check_timer(void)
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	int node = cpu_to_node(0);
 	int apic1, pin1, apic2, pin2;
-	unsigned long flags;
 	int no_pin1 = 0;
 
 	if (!global_clock_event)
 		return;
 
-	local_irq_save(flags);
+	local_irq_disable();
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -2237,7 +2231,6 @@ static inline void __init check_timer(void)
 			goto out;
 		}
 		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
-		local_irq_disable();
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
 			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
@@ -2261,7 +2254,6 @@ static inline void __init check_timer(void)
 		/*
 		 * Cleanup, just in case ...
 		 */
-		local_irq_disable();
 		legacy_pic->mask(0);
 		clear_IO_APIC_pin(apic2, pin2);
 		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
@@ -2278,7 +2270,6 @@ static inline void __init check_timer(void)
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	legacy_pic->mask(0);
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
@@ -2297,7 +2288,6 @@ static inline void __init check_timer(void)
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
 	if (apic_is_x2apic_enabled())
 		apic_printk(APIC_QUIET, KERN_INFO
@@ -2306,7 +2296,7 @@ static inline void __init check_timer(void)
 	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
 		"report.  Then try booting with the 'noapic' option.\n");
 out:
-	local_irq_restore(flags);
+	local_irq_enable();
 }
 
 /*
