Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C344D692
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhKKMZV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhKKMZU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:20 -0500
Date:   Thu, 11 Nov 2021 12:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDe7CFc2WvF8UNQCpj/xuE20HOk+koIDIKh9ZkiK2Qs=;
        b=UXUA44pyo+K2KnmwUFg4z2S2yJg96sD5tLHGzOt/xGaQiJqpLlCHaKdvkiSEGi29eODwYI
        rgA/lOg4klFRJc0f+PlF4FOVmvjOCbikphLjU/c27D3ZMYG0uSEwjr4WzBoWkFISaU1ZoO
        39jU7SVN4ZZ1PzcVu5Ua6L+bavHHzmmvbWjXCdI0bld30ZEd2WTPB6hZFJphZSxxPNiD8B
        OJfz3lJJTeCUdTZvvGbd2v/4VJzUlHHe7NvO2/CLXP5uwazF+LD6DEake4L3IAAEWJDkBC
        UQhAgrHEuGioIqCHRsdsxs2+i4KzdzZv5R+L+apW2af1v170mdLdDCPEhe6Nsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDe7CFc2WvF8UNQCpj/xuE20HOk+koIDIKh9ZkiK2Qs=;
        b=7/2eG8wD3EyK8tFCbIkQALuQBF4F17/rH90K/hjPWV60kLwz49UMo3TD+NdzkrG2a786pf
        QXsuhDXOTuSAWcDA==
From:   "tip-bot2 for Boris Ostrovsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86/smp: Factor out parts of native_smp_prepare_cpus()
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
References: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Message-ID: <163663334963.414.3620852464841533978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ce2612b6706b4d0a70732795253722e3bd4ed953
Gitweb:        https://git.kernel.org/tip/ce2612b6706b4d0a70732795253722e3bd4ed953
Author:        Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate:    Tue, 02 Nov 2021 19:36:36 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:32 +01:00

x86/smp: Factor out parts of native_smp_prepare_cpus()

Commit 66558b730f25 ("sched: Add cluster scheduler level for x86")
introduced cpu_l2c_shared_map mask which is expected to be initialized
by smp_op.smp_prepare_cpus(). That commit only updated
native_smp_prepare_cpus() version but not xen_pv_smp_prepare_cpus().
As result Xen PV guests crash in set_cpu_sibling_map().

While the new mask can be allocated in xen_pv_smp_prepare_cpus() one can
see that both versions of smp_prepare_cpus ops share a number of common
operations that can be factored out. So do that instead.

Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com
---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/smpboot.c  | 18 ++++++++++++------
 arch/x86/xen/smp_pv.c      | 12 ++----------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 08b0e90..81a0211 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -126,6 +126,7 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
+void smp_prepare_cpus_common(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8241927..ac2909f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1350,12 +1350,7 @@ static void __init smp_get_logical_apicid(void)
 		cpu0_logical_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
 }
 
-/*
- * Prepare for SMP bootup.
- * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
- *            for common interface support.
- */
-void __init native_smp_prepare_cpus(unsigned int max_cpus)
+void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
 
@@ -1386,6 +1381,17 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
+}
+
+/*
+ * Prepare for SMP bootup.
+ * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
+ *            for common interface support.
+ */
+void __init native_smp_prepare_cpus(unsigned int max_cpus)
+{
+	smp_prepare_cpus_common();
+
 	init_freq_invariance(false, false);
 	smp_sanity_check();
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 9e55bcb..6a8f3b5 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -225,7 +225,6 @@ static void __init xen_pv_smp_prepare_boot_cpu(void)
 static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned cpu;
-	unsigned int i;
 
 	if (skip_ioapic_setup) {
 		char *m = (max_cpus == 0) ?
@@ -238,16 +237,9 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	xen_init_lock_cpu(0);
 
-	smp_store_boot_cpu_info();
-	cpu_data(0).x86_max_cores = 1;
+	smp_prepare_cpus_common();
 
-	for_each_possible_cpu(i) {
-		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
-	}
-	set_cpu_sibling_map(0);
+	cpu_data(0).x86_max_cores = 1;
 
 	speculative_store_bypass_ht_init();
 
