Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6877682C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Aug 2023 21:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjHITNC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Aug 2023 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjHITMj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7082735;
        Wed,  9 Aug 2023 12:12:26 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sR3nDrs3Cr1xYRjjn0vXM+LsccBUCcuR3YAbKXKCs98=;
        b=JRVUOraGKQfGr5eYdPSu8+tpsjdoLjNx0rXsoVx7zguUm3aeelARaZXVduSwfovtcKOYm+
        hEcqmSDsdKrh20Xlelr2NoqxhT3fjcnFuB3MNeigfUU1vYnzyrrY2svocAO6jFquh7K/2d
        HkLoG47BtU8fH3GksC7cl+gOLFUTFQiZIVXvIGmIQnls0lDlahuckB6PvM3c/LXBzy/YJV
        TlulV/SHf0eL//dnvy1CMFWiD154KhDUNHk38kCojz40Q1i8m1UuD9qQ6hFTram9PBNtTV
        27ZvqwJwh6F+W1unx2q/waYM5DsIGkppWBVIJPxo2KI5MCIOCxXHsv97t8MSvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sR3nDrs3Cr1xYRjjn0vXM+LsccBUCcuR3YAbKXKCs98=;
        b=WfP5s64eU7h1d1MmPPPe0qtIyp5FvqiAmYz2Kfdf/vacb/3P7yOgpVr5yffQMP2dtUENJd
        xln4MFx7t8dYbUAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Sanitize logical APIC ID handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834162.27769.17210690650569081383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e120e58ec2932d3dee05da71168c7ba841bf4cf4
Gitweb:        https://git.kernel.org/tip/e120e58ec2932d3dee05da71168c7ba841bf4cf4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:23 -07:00

x86/apic/32: Sanitize logical APIC ID handling

apic::x86_32_early_logical_apicid() is yet another historical joke.

It is used to preset the x86_cpu_to_logical_apicid per CPU variable during
APIC enumeration with:

  - 1 shifted left by the CPU number
  - the physical APIC ID in case of bigsmp

The latter is hillarious because bigsmp uses physical destination mode
which never can use the logical APIC ID.

It gets even worse. As bigsmp can be enforced late in the boot process the
probe function overwrites the per CPU variable which is never used for this
APIC type once again.

Remove that gunk and store 1 << cpunr unconditionally if and only if the
CPU number is less than 8, because the default logical destination mode
only allows up to 8 CPUs.

This is just an intermediate step before removing the per CPU insanity
completely. Stay tuned.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h      | 13 -------------
 arch/x86/kernel/apic/apic.c      |  4 ++--
 arch/x86/kernel/apic/apic_noop.c | 11 -----------
 arch/x86/kernel/apic/bigsmp_32.c | 18 ------------------
 arch/x86/kernel/apic/probe_32.c  |  7 -------
 5 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 098d193..daef681 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -315,19 +315,6 @@ struct apic {
 	/* wakeup secondary CPU using 64-bit wakeup point */
 	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
 
-#ifdef CONFIG_X86_32
-	/*
-	 * Called very early during boot from get_smp_config().  It should
-	 * return the logical apicid.  x86_[bios]_cpu_to_apicid is
-	 * initialized before this function is called.
-	 *
-	 * If logical apicid can't be determined that early, the function
-	 * may return BAD_APICID.  Logical apicid will be configured after
-	 * init_apic_ldr() while bringing up CPUs.  Note that NUMA affinity
-	 * won't be applied properly during early boot in this case.
-	 */
-	int (*x86_32_early_logical_apicid)(int cpu);
-#endif
 	char	*name;
 };
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6eee777..89f2a7e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2435,8 +2435,8 @@ static void cpu_update_apic(int cpu, int apicid)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
 #ifdef CONFIG_X86_32
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-		apic->x86_32_early_logical_apicid(cpu);
+	if (cpu < 8)
+		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = 1U << cpu;
 #endif
 	set_cpu_possible(cpu, true);
 	physid_set(apicid, phys_cpu_present_map);
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index c0c3b6b..ccd74e8 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -80,13 +80,6 @@ static void noop_apic_write(u32 reg, u32 val)
 	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 }
 
-#ifdef CONFIG_X86_32
-static int noop_x86_32_early_logical_apicid(int cpu)
-{
-	return BAD_APICID;
-}
-#endif
-
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 	.probe				= noop_probe,
@@ -130,8 +123,4 @@ struct apic apic_noop __ro_after_init = {
 	.icr_write			= noop_apic_icr_write,
 	.wait_icr_idle			= noop_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
-
-#ifdef CONFIG_X86_32
-	.x86_32_early_logical_apicid	= noop_x86_32_early_logical_apicid,
-#endif
 };
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 6f4bd71..b649048 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,12 +28,6 @@ static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
 	return false;
 }
 
-static int bigsmp_early_logical_apicid(int cpu)
-{
-	/* on bigsmp, logical apicid is the same as physical */
-	return early_per_cpu(x86_cpu_to_apicid, cpu);
-}
-
 /*
  * bigsmp enables physical destination mode
  * and doesn't use LDR and DFR
@@ -154,27 +148,15 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= native_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
-
-	.x86_32_early_logical_apicid	= bigsmp_early_logical_apicid,
 };
 
 void __init generic_bigsmp_probe(void)
 {
-	unsigned int cpu;
-
 	if (!probe_bigsmp())
 		return;
 
 	apic = &apic_bigsmp;
 
-	for_each_possible_cpu(cpu) {
-		if (early_per_cpu(x86_cpu_to_logical_apicid,
-				  cpu) == BAD_APICID)
-			continue;
-		early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-			bigsmp_early_logical_apicid(cpu);
-	}
-
 	pr_info("Overriding APIC driver with %s\n", apic_bigsmp.name);
 }
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index baa8b14..3ee0211 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -16,11 +16,6 @@
 
 #include "local.h"
 
-static int default_x86_32_early_logical_apicid(int cpu)
-{
-	return 1 << cpu;
-}
-
 static void setup_apic_flat_routing(void)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -101,8 +96,6 @@ static struct apic apic_default __ro_after_init = {
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= native_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
-
-	.x86_32_early_logical_apicid	= default_x86_32_early_logical_apicid,
 };
 
 apic_driver(apic_default);
