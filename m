Return-Path: <linux-tip-commits+bounces-1981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140FF94AE11
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56F7B23797
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E913DDCC;
	Wed,  7 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uxz+KEQn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwkIscfx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092913BC35;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047933; cv=none; b=BYl9/4Wnll6aZkCaANh7LaQ0+oKYUbqQV83PEoAZENYXTY1beeM2qcySRWN2Pbv4+Hbq64jLqtas9xMfs2F8Kt+NBCdYcwYg3xb53wfbuHuFeoVBwUxmT1Ka4Hn1+6rM65eFwmL66+OsPMltzOqi56ushSZ8FvS63O0rjPecU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047933; c=relaxed/simple;
	bh=MIbWs/87wxCmIrC/1kDGnlJFBSLDrL4nHbuOB8aqntY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fpyunc+wLAJXLOX8QqrxkXh9cKLEewd+x56F4OhqHivdu/8C55Cv5yWMwYK+/GeYmg5vEt3ddCE4L0t7ELWRJdnlTxyseXhlLzqFf4fPBxB38vcmm5zPvnC55r0AaWPZtLOxlvyYWwdTwG1IzFlMDI+GBF2cYp3W3AyQI7KfFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uxz+KEQn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwkIscfx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVWL0BkJ7as0aWjZrS//Z4FPW1pQzPPqs9dzbW1BBnU=;
	b=Uxz+KEQnfdUucgSp+EG+126gBb+wjArgm2RwmnEGNwsavr4j2kRApqw9dgF0VUt8YpNCVe
	FfXcVlLG2h74aLOgUe99JqiGuHD+fcuLNb/IGKDSydO4XAFqMFUAfWW8EvIjT4mYWhjezD
	lz0V57IL9bH3TrPlNXo2HG/og6VrUInGdMEVEM+oU7kNRdDN8atD9rKWyrwWCbztD1X7v8
	9IR7E5+/TJSjMolHiP0zs73mH8/1jrJvU18PPOnsFPksoG+lCfkvxEIH5P6f4wMubjJDRi
	UN5zagRycEpPcJ6qCtNDoFKGz4Mhj7H0u4osbx34j0PWhINmmOk234zvKmK1zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVWL0BkJ7as0aWjZrS//Z4FPW1pQzPPqs9dzbW1BBnU=;
	b=ZwkIscfxsNNAGFvjvTOeCNmkJsQztF2uy7TVDXykw82RrbbXmZk6CthygotSI7CIPSuHiC
	bAqzbRs7OIVqfxAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Cleanup apic_printk()s
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.589821068@linutronix.de>
References: <20240802155440.589821068@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792900.2215.12452311447986487810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ac1c9fc1b571d5355602daa642f74288ae4b701d
Gitweb:        https://git.kernel.org/tip/ac1c9fc1b571d5355602daa642f74288ae4b701d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/apic: Cleanup apic_printk()s

Use the new apic_pr_*() helpers and cleanup the apic_printk() maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.589821068@linutronix.de

---
 arch/x86/kernel/apic/apic.c | 81 +++++++++++++++---------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2..1838a73 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -677,7 +677,7 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %u\n", deltapm);
+	apic_pr_verbose("... PM-Timer delta = %u\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)
@@ -687,14 +687,14 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 
 	if (deltapm > (pm_100ms - pm_thresh) &&
 	    deltapm < (pm_100ms + pm_thresh)) {
-		apic_printk(APIC_VERBOSE, "... PM-Timer result ok\n");
+		apic_pr_verbose("... PM-Timer result ok\n");
 		return 0;
 	}
 
 	res = (((u64)deltapm) *  mult) >> 22;
 	do_div(res, 1000000);
-	pr_warn("APIC calibration not consistent "
-		"with PM-Timer: %ldms instead of 100ms\n", (long)res);
+	pr_warn("APIC calibration not consistent with PM-Timer: %ldms instead of 100ms\n",
+		(long)res);
 
 	/* Correct the lapic counter value */
 	res = (((u64)(*delta)) * pm_100ms);
@@ -707,9 +707,8 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		res = (((u64)(*deltatsc)) * pm_100ms);
 		do_div(res, deltapm);
-		apic_printk(APIC_VERBOSE, "TSC delta adjusted to "
-					  "PM-Timer: %lu (%ld)\n",
-					(unsigned long)res, *deltatsc);
+		apic_pr_verbose("TSC delta adjusted to PM-Timer: %lu (%ld)\n",
+				(unsigned long)res, *deltatsc);
 		*deltatsc = (long)res;
 	}
 
@@ -792,8 +791,7 @@ static int __init calibrate_APIC_clock(void)
 	 * in the clockevent structure and return.
 	 */
 	if (!lapic_init_clockevent()) {
-		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_period);
+		apic_pr_verbose("lapic timer already calibrated %d\n", lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -802,8 +800,7 @@ static int __init calibrate_APIC_clock(void)
 		return 0;
 	}
 
-	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
-		    "calibrating APIC timer ...\n");
+	apic_pr_verbose("Using local APIC timer interrupts. Calibrating APIC timer ...\n");
 
 	/*
 	 * There are platforms w/o global clockevent devices. Instead of
@@ -866,7 +863,7 @@ static int __init calibrate_APIC_clock(void)
 
 	/* Build delta t1-t2 as apic timer counts down */
 	delta = lapic_cal_t1 - lapic_cal_t2;
-	apic_printk(APIC_VERBOSE, "... lapic delta = %ld\n", delta);
+	apic_pr_verbose("... lapic delta = %ld\n", delta);
 
 	deltatsc = (long)(lapic_cal_tsc2 - lapic_cal_tsc1);
 
@@ -877,22 +874,19 @@ static int __init calibrate_APIC_clock(void)
 	lapic_timer_period = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
 
-	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
-	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
-	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_period);
+	apic_pr_verbose("..... delta %ld\n", delta);
+	apic_pr_verbose("..... mult: %u\n", lapic_clockevent.mult);
+	apic_pr_verbose("..... calibration result: %u\n", lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			    "%ld.%04ld MHz.\n",
-			    (deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-			    (deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+		apic_pr_verbose("..... CPU clock speed is %ld.%04ld MHz.\n",
+				(deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
+				(deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
 	}
 
-	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		    "%u.%04u MHz.\n",
-		    lapic_timer_period / (1000000 / HZ),
-		    lapic_timer_period % (1000000 / HZ));
+	apic_pr_verbose("..... host bus clock speed is %u.%04u MHz.\n",
+			lapic_timer_period / (1000000 / HZ),
+			lapic_timer_period % (1000000 / HZ));
 
 	/*
 	 * Do a sanity check on the APIC calibration result
@@ -911,7 +905,7 @@ static int __init calibrate_APIC_clock(void)
 	 * available.
 	 */
 	if (!pm_referenced && global_clock_event) {
-		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
+		apic_pr_verbose("... verify APIC timer\n");
 
 		/*
 		 * Setup the apic timer manually
@@ -932,11 +926,11 @@ static int __init calibrate_APIC_clock(void)
 
 		/* Jiffies delta */
 		deltaj = lapic_cal_j2 - lapic_cal_j1;
-		apic_printk(APIC_VERBOSE, "... jiffies delta = %lu\n", deltaj);
+		apic_pr_verbose("... jiffies delta = %lu\n", deltaj);
 
 		/* Check, if the jiffies result is consistent */
 		if (deltaj >= LAPIC_CAL_LOOPS-2 && deltaj <= LAPIC_CAL_LOOPS+2)
-			apic_printk(APIC_VERBOSE, "... jiffies result ok\n");
+			apic_pr_verbose("... jiffies result ok\n");
 		else
 			levt->features |= CLOCK_EVT_FEAT_DUMMY;
 	}
@@ -1221,9 +1215,8 @@ void __init sync_Arb_IDs(void)
 	 */
 	apic_wait_icr_idle();
 
-	apic_printk(APIC_DEBUG, "Synchronizing Arb IDs.\n");
-	apic_write(APIC_ICR, APIC_DEST_ALLINC |
-			APIC_INT_LEVELTRIG | APIC_DM_INIT);
+	apic_pr_debug("Synchronizing Arb IDs.\n");
+	apic_write(APIC_ICR, APIC_DEST_ALLINC | APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
 
 enum apic_intr_mode_id apic_intr_mode __ro_after_init;
@@ -1409,10 +1402,10 @@ static void lapic_setup_esr(void)
 	if (maxlvt > 3)
 		apic_write(APIC_ESR, 0);
 	value = apic_read(APIC_ESR);
-	if (value != oldvalue)
-		apic_printk(APIC_VERBOSE, "ESR value before enabling "
-			"vector: 0x%08x  after: 0x%08x\n",
-			oldvalue, value);
+	if (value != oldvalue) {
+		apic_pr_verbose("ESR value before enabling vector: 0x%08x  after: 0x%08x\n",
+				oldvalue, value);
+	}
 }
 
 #define APIC_IR_REGS		APIC_ISR_NR
@@ -1599,10 +1592,10 @@ static void setup_local_APIC(void)
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!cpu && (pic_mode || !value || ioapic_is_disabled)) {
 		value = APIC_DM_EXTINT;
-		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Enabled ExtINT on CPU#%d\n", cpu);
 	} else {
 		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
-		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Masked ExtINT on CPU#%d\n", cpu);
 	}
 	apic_write(APIC_LVT0, value);
 
@@ -2066,8 +2059,7 @@ static __init void apic_set_fixmap(bool read_apic)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
 	apic_mmio_base = APIC_BASE;
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-		    apic_mmio_base, mp_lapic_addr);
+	apic_pr_verbose("Mapped APIC to %16lx (%16lx)\n", apic_mmio_base, mp_lapic_addr);
 	if (read_apic)
 		apic_read_boot_cpu_id(false);
 }
@@ -2170,18 +2162,17 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 	apic_eoi();
 	atomic_inc(&irq_err_count);
 
-	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
-		    smp_processor_id(), v);
+	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
 
 	v &= 0xff;
 	while (v) {
 		if (v & 0x1)
-			apic_printk(APIC_DEBUG, KERN_CONT " : %s", error_interrupt_reason[i]);
+			apic_pr_debug_cont(" : %s", error_interrupt_reason[i]);
 		i++;
 		v >>= 1;
 	}
 
-	apic_printk(APIC_DEBUG, KERN_CONT "\n");
+	apic_pr_debug_cont("\n");
 
 	trace_error_apic_exit(ERROR_APIC_VECTOR);
 }
@@ -2201,8 +2192,7 @@ static void __init connect_bsp_APIC(void)
 		 * PIC mode, enable APIC mode in the IMCR, i.e.  connect BSP's
 		 * local APIC to INT and NMI lines.
 		 */
-		apic_printk(APIC_VERBOSE, "leaving PIC mode, "
-				"enabling APIC mode.\n");
+		apic_pr_verbose("Leaving PIC mode, enabling APIC mode.\n");
 		imcr_pic_to_apic();
 	}
 #endif
@@ -2227,8 +2217,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 		 * IPIs, won't work beyond this point!  The only exception are
 		 * INIT IPIs.
 		 */
-		apic_printk(APIC_VERBOSE, "disabling APIC mode, "
-				"entering PIC mode.\n");
+		apic_pr_verbose("Disabling APIC mode, entering PIC mode.\n");
 		imcr_apic_to_pic();
 		return;
 	}

