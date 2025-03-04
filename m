Return-Path: <linux-tip-commits+bounces-3879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C7A4D8B6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE617A7D40
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742C1FF1DC;
	Tue,  4 Mar 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NthV14LY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ad4TYRdP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318491FC7F6;
	Tue,  4 Mar 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081043; cv=none; b=Q1lg0aeBb1E09zw5M9jfzrsIMZEnhvNd0fn8FD44LntxMFSEVoFLFKUMpu/Y2h7pMh/H/+GZ53A4/nHqrervzYgZSbvUHTS0NLWYYYk0+Nn0bOQt0nHUA9M8xo1CbTuiGj3SKL6AH4rkKODReSxPxKy4249F8ClzStYNTfuuCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081043; c=relaxed/simple;
	bh=113PVFaPa4+TzerInU4d2BPqT/JisSb1AvqesKdyC3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KTq9CJuKoGa+WuxEHq0nGbAwGT8F1Xr3qKlFVo10zmQUruVR/PRGvyl2vPNFd5zRcRxVV7kBTLZ5DFPEYf0h/A36L+yl4LJiokf6AdOQPI7sOQXK9+0CGDB1adaTKSZNYT7eqKPiBm6zoOLhhPcb0uXwu7G2WAuBKTaySfZDmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NthV14LY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ad4TYRdP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmzX5en/CfvRSkr8JFMxbx+HqYHmUwj/LgDUtf5FKBM=;
	b=NthV14LY/qH1oLXF/5oPylWqUMPju2Dti+Yo8DqzKqFO06wWrEyCQBloanuSWhIlLxBf2u
	ZKuJ3acRQsS24dor6bBF3E8P0pVvPWXrq+C3lZPHEo42Cz9NOxvPvJufysz5dbNHvbskP/
	wmoqGFVjX93MKFBvODuYKdaCCHapG1I2Eqa8wIrCWzIVZp1XI8xU7lTMAm89o1nrv5Xk09
	oYNBm//9f99K2knUaTZy5NBpgP7OtB0n616VNCTdu6mop29aMo9prJ1dXf2hmsJFifBMv/
	9UuzrJrbW/qU95GCxeIuSlRiux3vuM6wDuIAqy1xOAYHyBXqM+rITQpJQAn9XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmzX5en/CfvRSkr8JFMxbx+HqYHmUwj/LgDUtf5FKBM=;
	b=Ad4TYRdP1aFgDx981fTlUSgTUIYua/RY9ReGsGFAPBvzMoqM5YgYVFoTb/dMi11xL61Z6o
	iTkB37zp/PxyvjBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Get rid of the smp_store_cpu_info() indirection
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-9-darwi@linutronix.de>
References: <20250304085152.51092-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108103883.14745.3512782926989212177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1419833d3c2de8ad648d053f230a7f3dcf4fa973
Gitweb:        https://git.kernel.org/tip/1419833d3c2de8ad648d053f230a7f3dcf4fa973
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:15:24 +01:00

x86/cpu: Get rid of the smp_store_cpu_info() indirection

smp_store_cpu_info() is just a wrapper around identify_secondary_cpu()
without further value.

Move the extra bits from smp_store_cpu_info() into identify_secondary_cpu()
and remove the wrapper.

[ darwi: Make it compile and fix up the xen/smp_pv.c instance ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-9-darwi@linutronix.de
---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/include/asm/smp.h       |  2 --
 arch/x86/kernel/cpu/common.c     | 11 +++++++++--
 arch/x86/kernel/smpboot.c        | 24 ++----------------------
 arch/x86/xen/smp_pv.c            |  2 +-
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0ea227f..d5d9a07 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -229,7 +229,7 @@ static inline unsigned long long l1tf_pfn_limit(void)
 void init_cpu_devs(void);
 void get_cpu_vendor(struct cpuinfo_x86 *c);
 extern void early_cpu_init(void);
-extern void identify_secondary_cpu(struct cpuinfo_x86 *);
+extern void identify_secondary_cpu(unsigned int cpu);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 1d3b11e..128e06a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -120,8 +120,6 @@ void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 
-void smp_store_cpu_info(int id);
-
 asmlinkage __visible void smp_reboot_interrupt(void);
 __visible void smp_reschedule_interrupt(struct pt_regs *regs);
 __visible void smp_call_function_interrupt(struct pt_regs *regs);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3a1a957..5f81c55 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1997,9 +1997,15 @@ static __init void identify_boot_cpu(void)
 	lkgs_init();
 }
 
-void identify_secondary_cpu(struct cpuinfo_x86 *c)
+void identify_secondary_cpu(unsigned int cpu)
 {
-	BUG_ON(c == &boot_cpu_data);
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	/* Copy boot_cpu_data only on the first bringup */
+	if (!c->initialized)
+		*c = boot_cpu_data;
+	c->cpu_index = cpu;
+
 	identify_cpu(c);
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
@@ -2010,6 +2016,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 		update_gds_msr();
 
 	tsx_ap_init();
+	c->initialized = true;
 }
 
 void print_cpu_info(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5746084..8ecf1bf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -190,7 +190,7 @@ static void ap_starting(void)
 	apic_ap_setup();
 
 	/* Save the processor parameters. */
-	smp_store_cpu_info(cpuid);
+	identify_secondary_cpu(cpuid);
 
 	/*
 	 * The topology information must be up to date before
@@ -215,7 +215,7 @@ static void ap_calibrate_delay(void)
 {
 	/*
 	 * Calibrate the delay loop and update loops_per_jiffy in cpu_data.
-	 * smp_store_cpu_info() stored a value that is close but not as
+	 * identify_secondary_cpu() stored a value that is close but not as
 	 * accurate as the value just calculated.
 	 *
 	 * As this is invoked after the TSC synchronization check,
@@ -315,26 +315,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-/*
- * The bootstrap kernel entry code has set these up. Save them for
- * a given CPU
- */
-void smp_store_cpu_info(int id)
-{
-	struct cpuinfo_x86 *c = &cpu_data(id);
-
-	/* Copy boot_cpu_data only on the first bringup */
-	if (!c->initialized)
-		*c = boot_cpu_data;
-	c->cpu_index = id;
-	/*
-	 * During boot time, CPU0 has this setup already. Save the info when
-	 * bringing up an AP.
-	 */
-	identify_secondary_cpu(c);
-	c->initialized = true;
-}
-
 static bool
 topology_same_node(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6863d3d..688ff59 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -70,7 +70,7 @@ static void cpu_bringup(void)
 		xen_enable_syscall();
 	}
 	cpu = smp_processor_id();
-	smp_store_cpu_info(cpu);
+	identify_secondary_cpu(cpu);
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();

