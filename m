Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF877685B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Aug 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHITOQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Aug 2023 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjHITNi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D730EF;
        Wed,  9 Aug 2023 12:12:54 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ohkpToT0HtnZg8M0bfPuMudjcjc4A7LmtZzcOqJUuz8=;
        b=DlMJOduGMyXWbMgY7Ta/63J2We8lAXGX58IM5lhKOkQdp4vKjIN7cOsbHDAzkFWgev21/l
        d0gKsLpE0WIdedtOSFot36pJaxnd7qe8I5q8cOC1cTY2mN80/HczZYSna8RRAS/f4Kuypo
        haWTn9xvTIiURj1gx8VGwY8NNmXakVnVgmvN5InCkkwV1uHgYo3M5+5JB/H9TUdfDpm1pb
        1VJr8ZBa4pMdQc1QTkVEvXNiVR65RHaC2vEbXn3MBe8jhCaZNeUDzPC9UzWg04nV3rC0+7
        SjJ1ezJz4ZGLOBOG760KcfEFOQ1MzyMv4NE0Ugpxk3r77o5ac4L7Igfw8JdPlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ohkpToT0HtnZg8M0bfPuMudjcjc4A7LmtZzcOqJUuz8=;
        b=9TouW4VY7hID63fezewiF7gbTA1tY4hhGweTBaX+uuEdp9eFZEWHxmRYHnAKlEEJ/JHxvc
        QIkF5hgHG97HHWBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Register boot CPU APIC early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834648.27769.1243536155677022854.tip-bot2@tip-bot2>
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

Commit-ID:     d63107fa882eadb59a040313510ef8511746efea
Gitweb:        https://git.kernel.org/tip/d63107fa882eadb59a040313510ef8511746efea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:18 -07:00

x86/apic: Register boot CPU APIC early

Register the boot CPU APIC right when the boot CPUs APIC is read from the
hardware. No point is doing this on random places and having wild
heuristics to save the boot CPU APIC ID slot and CPU number 0 reserved.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/apic.c | 120 ++++++++++++++---------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e26447a..b7ffae4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1734,6 +1734,8 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
 
+static __init void cpu_set_boot_apic(void);
+
 static __init void apic_read_boot_cpu_id(bool x2apic)
 {
 	/*
@@ -1748,9 +1750,9 @@ static __init void apic_read_boot_cpu_id(bool x2apic)
 		boot_cpu_physical_apicid = read_apic_id();
 		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
+	cpu_set_boot_apic();
 }
 
-
 #ifdef CONFIG_X86_X2APIC
 int x2apic_mode;
 EXPORT_SYMBOL_GPL(x2apic_mode);
@@ -2426,76 +2428,8 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
 
-int generic_processor_info(int apicid, int version)
+static void cpu_update_apic(int cpu, int apicid, int version)
 {
-	int cpu, max = nr_cpu_ids;
-	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
-				phys_cpu_present_map);
-
-	/*
-	 * boot_cpu_physical_apicid is guaranteed to contain the boot CPU
-	 * APIC ID read from the local APIC when this function is invoked.
-	 */
-	if (disabled_cpu_apicid != boot_cpu_physical_apicid &&
-	    disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	/*
-	 * If boot cpu has not been detected yet, then only allow upto
-	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
-	 */
-	if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
-	    apicid != boot_cpu_physical_apicid) {
-		int thiscpu = max + disabled_cpus - 1;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i almost"
-			" reached. Keeping one slot for boot cpu."
-			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	if (apicid == boot_cpu_physical_apicid) {
-		/*
-		 * x86_cpu_to_apicid is required to have processors listed
-		 * in same order as logical cpu numbers. Hence the first
-		 * entry is BSP, and so on.
-		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
-		 * for BSP.
-		 */
-		cpu = 0;
-
-		/* Logical cpuid 0 is reserved for BSP. */
-		cpuid_to_apicid[0] = apicid;
-	} else {
-		cpu = allocate_logical_cpuid(apicid);
-		if (cpu < 0) {
-			disabled_cpus++;
-			return -EINVAL;
-		}
-	}
-
-	/*
-	 * Validate version
-	 */
 	if (version == 0x0) {
 		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
 			cpu, apicid);
@@ -2521,10 +2455,56 @@ int generic_processor_info(int apicid, int version)
 
 	if (system_state != SYSTEM_BOOTING)
 		cpu_mark_primary_thread(cpu, apicid);
+}
+
+static __init void cpu_set_boot_apic(void)
+{
+	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
+	cpu_update_apic(0, boot_cpu_physical_apicid, boot_cpu_apic_version);
+}
+
+int generic_processor_info(int apicid, int version)
+{
+	int cpu, max = nr_cpu_ids;
+
+	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
+	if (cpuid_to_apicid[0] == BAD_APICID)
+		panic("Boot CPU APIC not registered yet\n");
+
+	if (apicid == boot_cpu_physical_apicid)
+		return 0;
+
+	if (disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
 
+		disabled_cpus++;
+		return -ENODEV;
+	}
+
+	if (num_processors >= nr_cpu_ids) {
+		int thiscpu = max + disabled_cpus;
+
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
+			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu = allocate_logical_cpuid(apicid);
+	if (cpu < 0) {
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu_update_apic(cpu, apicid, version);
 	return cpu;
 }
 
+
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
