Return-Path: <linux-tip-commits+bounces-7999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC80D1E295
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A5153017137
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58A396B72;
	Wed, 14 Jan 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/Qolekp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dD9s4lZc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C41395274;
	Wed, 14 Jan 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387225; cv=none; b=DNxSLNxSQ30JnFDtjJt8XIuUKbDhxW+hJ2ch7l174LkWJBvDTQ9rSIzaIR8nqaVaX9pYeUvC92/UQrPw1QDGO2pK3ehF2u0VuVwqiyxNsqifdsqt4r+CY7uo3TzEgDH/E1n+FAASsP5Qxdhyhzf77EtITMTi0nIBbeK1RknPwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387225; c=relaxed/simple;
	bh=HLCzsn9A2rraJ3AzkXoJWu0Lkgwlg5+Hm2ewhKzhQwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ruE17H5ccWMa64+XrEZsBKFyk/jKV4QjM199SQQVpRqWCy12cT5mUqPp1h5Hg4i9TPbWux4/R12ilU+tU2LVKnapGCMUS5KMC18bGTlGjxhQ0c41FJljKi5cBgbSoBeQAGRzzDcXkGvryVqqPIcAA0EsQ5rs7g0l63UUieS6Epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/Qolekp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dD9s4lZc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zuqmlV4ZKNPmZLTdgVVCXDqih/7t/+Phvbowyt6N/k=;
	b=x/Qolekp5O86PqZSiwdOfrMZYnalGe6NUcefJtYuelOQ8ZIA7/9PhdqRUP3Nhd8OEcQpFW
	bAntDwCmeBY/l7RmBqxmw9VHS4oC7/KDdV4D1NLcsmeGjyN/Vjof+yrqlpvKBkTNzGFkFi
	iHqBt8rij8FcDYEQPX9oXWR4wEmFEOZEnS98b8DZwqpzYnrKt9qz5GYbDCEHz774Yq6Wqa
	7Wb7W4Bw7DN+BiUTE/iqc5At0F23HMXm01DwTAugjesCzcQ8AOqoqqYbiIcYArtdtkRii8
	XfD4VBvbm5KUsWwvernDxFHOYfKFsFjMIo/Hvdn6uJiQNrmceVTBZ9+wHKIVyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zuqmlV4ZKNPmZLTdgVVCXDqih/7t/+Phvbowyt6N/k=;
	b=dD9s4lZc2mq/du2gSMMN6IsDP2TE1GI14NcTZ1+y91C1XnjpAqlD3aBb3PYq/wEdA3nTEv
	lvkIANDPZbrh9YBQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] sched: Move clock related paravirt code to kernel/sched
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-7-jgross@suse.com>
References: <20260105110520.21356-7-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721676.510.6861975341362200838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     e6b2aa6d40045a3149071ca3af950ea8e6ff79c4
Gitweb:        https://git.kernel.org/tip/e6b2aa6d40045a3149071ca3af950ea8e6f=
f79c4
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:05 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 15:39:14 +01:00

sched: Move clock related paravirt code to kernel/sched

Paravirt clock related functions are available in multiple archs.

In order to share the common parts, move the common static keys
to kernel/sched/ and remove them from the arch specific files.

Make a common paravirt_steal_clock() implementation available in
kernel/sched/cputime.c, guarding it with a new config option
CONFIG_HAVE_PV_STEAL_CLOCK_GEN, which can be selected by an arch
in case it wants to use that common variant.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-7-jgross@suse.com
---
 arch/Kconfig                           |  3 +++
 arch/arm/include/asm/paravirt.h        |  4 ----
 arch/arm/kernel/paravirt.c             |  3 ---
 arch/arm64/include/asm/paravirt.h      |  4 ----
 arch/arm64/kernel/paravirt.c           |  4 +---
 arch/loongarch/include/asm/paravirt.h  |  3 ---
 arch/loongarch/kernel/paravirt.c       |  3 +--
 arch/powerpc/include/asm/paravirt.h    |  3 ---
 arch/powerpc/platforms/pseries/setup.c |  4 +---
 arch/riscv/include/asm/paravirt.h      |  4 ----
 arch/riscv/kernel/paravirt.c           |  4 +---
 arch/x86/include/asm/paravirt.h        |  4 ----
 arch/x86/kernel/cpu/vmware.c           |  1 +
 arch/x86/kernel/kvm.c                  |  1 +
 arch/x86/kernel/paravirt.c             |  3 ---
 drivers/xen/time.c                     |  1 +
 include/linux/sched/cputime.h          | 18 ++++++++++++++++++
 kernel/sched/core.c                    |  5 +++++
 kernel/sched/cputime.c                 | 13 +++++++++++++
 kernel/sched/sched.h                   |  2 +-
 20 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31220f5..102ddbd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1056,6 +1056,9 @@ config HAVE_IRQ_TIME_ACCOUNTING
 	  Archs need to ensure they use a high enough resolution clock to
 	  support irq time accounting and then call enable_sched_clock_irqtime().
=20
+config HAVE_PV_STEAL_CLOCK_GEN
+	bool
+
 config HAVE_MOVE_PUD
 	bool
 	help
diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index 95d5b0d..69da4bd 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -5,10 +5,6 @@
 #ifdef CONFIG_PARAVIRT
 #include <linux/static_call_types.h>
=20
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 u64 dummy_steal_clock(int cpu);
=20
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
index 7dd9806..3895a55 100644
--- a/arch/arm/kernel/paravirt.c
+++ b/arch/arm/kernel/paravirt.c
@@ -12,9 +12,6 @@
 #include <linux/static_call.h>
 #include <asm/paravirt.h>
=20
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
-
 static u64 native_steal_clock(int cpu)
 {
 	return 0;
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/parav=
irt.h
index 9aa193e..c9f7590 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -5,10 +5,6 @@
 #ifdef CONFIG_PARAVIRT
 #include <linux/static_call_types.h>
=20
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 u64 dummy_steal_clock(int cpu);
=20
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index aa718d6..943b60c 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -19,14 +19,12 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/static_call.h>
+#include <linux/sched/cputime.h>
=20
 #include <asm/paravirt.h>
 #include <asm/pvclock-abi.h>
 #include <asm/smp_plat.h>
=20
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
-
 static u64 native_steal_clock(int cpu)
 {
 	return 0;
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/a=
sm/paravirt.h
index 3f43236..d219ea0 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -5,9 +5,6 @@
 #ifdef CONFIG_PARAVIRT
=20
 #include <linux/static_call_types.h>
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
=20
 u64 dummy_steal_clock(int cpu);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravir=
t.c
index b1b51f9..8caaa94 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -6,11 +6,10 @@
 #include <linux/kvm_para.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/sched/cputime.h>
 #include <asm/paravirt.h>
=20
 static int has_steal_clock;
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
 static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
=20
diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/p=
aravirt.h
index b78b82d..92343a2 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -23,9 +23,6 @@ static inline bool is_shared_processor(void)
 }
=20
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 u64 pseries_paravirt_steal_clock(int cpu);
=20
 static inline u64 paravirt_steal_clock(int cpu)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/=
pseries/setup.c
index b10a253..50b26ed 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -42,6 +42,7 @@
 #include <linux/memblock.h>
 #include <linux/swiotlb.h>
 #include <linux/seq_buf.h>
+#include <linux/sched/cputime.h>
=20
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -83,9 +84,6 @@ DEFINE_STATIC_KEY_FALSE(shared_processor);
 EXPORT_SYMBOL(shared_processor);
=20
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
-
 static bool steal_acc =3D true;
 static int __init parse_no_stealacc(char *arg)
 {
diff --git a/arch/riscv/include/asm/paravirt.h b/arch/riscv/include/asm/parav=
irt.h
index c0abde7..17e5e39 100644
--- a/arch/riscv/include/asm/paravirt.h
+++ b/arch/riscv/include/asm/paravirt.h
@@ -5,10 +5,6 @@
 #ifdef CONFIG_PARAVIRT
 #include <linux/static_call_types.h>
=20
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 u64 dummy_steal_clock(int cpu);
=20
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index fa6b033..d3c334f 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -16,15 +16,13 @@
 #include <linux/printk.h>
 #include <linux/static_call.h>
 #include <linux/types.h>
+#include <linux/sched/cputime.h>
=20
 #include <asm/barrier.h>
 #include <asm/page.h>
 #include <asm/paravirt.h>
 #include <asm/sbi.h>
=20
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
-
 static u64 native_steal_clock(int cpu)
 {
 	return 0;
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1344d2f..0ef797e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -30,10 +30,6 @@ static __always_inline u64 paravirt_sched_clock(void)
 	return static_call(pv_sched_clock)();
 }
=20
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 __visible void __native_queued_spin_unlock(struct qspinlock *lock);
 bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index cb3f900..a3e6936 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df78dde..21b4de5 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -30,6 +30,7 @@
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/kvm_types.h>
+#include <linux/sched/cputime.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172..a3ba474 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,9 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
=20
-struct static_key paravirt_steal_enabled;
-struct static_key paravirt_steal_rq_enabled;
-
 static u64 native_steal_clock(int cpu)
 {
 	return 0;
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 5683383..d360ded 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -8,6 +8,7 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/static_call.h>
+#include <linux/sched/cputime.h>
=20
 #include <asm/paravirt.h>
 #include <asm/xen/hypervisor.h>
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 5f8fd5b..e90efaf 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_CPUTIME_H
 #define _LINUX_SCHED_CPUTIME_H
=20
+#include <linux/static_call_types.h>
 #include <linux/sched/signal.h>
=20
 /*
@@ -180,4 +181,21 @@ static inline void prev_cputime_init(struct prev_cputime=
 *prev)
 extern unsigned long long
 task_sched_runtime(struct task_struct *task);
=20
+#ifdef CONFIG_PARAVIRT
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+#ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
+u64 dummy_steal_clock(int cpu);
+
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return static_call(pv_steal_clock)(cpu);
+}
+#endif
+#endif
+
 #endif /* _LINUX_SCHED_CPUTIME_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60afadb..efac2fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -770,6 +770,11 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq=
_flags *rf)
  * RQ-clock updating methods:
  */
=20
+/* Use CONFIG_PARAVIRT as this will avoid more #ifdef in arch code. */
+#ifdef CONFIG_PARAVIRT
+struct static_key paravirt_steal_rq_enabled;
+#endif
+
 static void update_rq_clock_task(struct rq *rq, s64 delta)
 {
 /*
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 4f97896..7ff8dbe 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -251,6 +251,19 @@ void __account_forceidle_time(struct task_struct *p, u64=
 delta)
  * ticks are not redelivered later. Due to that, this function may on
  * occasion account more time than the calling functions think elapsed.
  */
+#ifdef CONFIG_PARAVIRT
+struct static_key paravirt_steal_enabled;
+
+#ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+#endif
+#endif
+
 static __always_inline u64 steal_account_process_time(u64 maxtime)
 {
 #ifdef CONFIG_PARAVIRT
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28e7cc4..fcc2a1c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -82,7 +82,7 @@ struct rt_rq;
 struct sched_group;
 struct cpuidle_state;
=20
-#ifdef CONFIG_PARAVIRT
+#if defined(CONFIG_PARAVIRT) && !defined(CONFIG_HAVE_PV_STEAL_CLOCK_GEN)
 # include <asm/paravirt.h>
 #endif
=20

