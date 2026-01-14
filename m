Return-Path: <linux-tip-commits+bounces-7982-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE1D1E23E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 451653002D34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8ED3904D0;
	Wed, 14 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="irUm3gEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZXEDlDf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FB393DD3;
	Wed, 14 Jan 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387211; cv=none; b=cEzmKPyyMen6kSTOLR8a1Nkjvhk9KbHKbrLSyBcX4v4kEgwEhZgaF/6mbfyeXUdTv19MsG+1zZZYNW747ugW8r9esOKBhF7B6SHXxOfejJjfKeVq5UAjhT/lLb3kjmyX4gBUSTzvqi4PBRgLFp1Ho+Gd0oop/RiO4WFXceAo6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387211; c=relaxed/simple;
	bh=rz597Mpk/v9Zr6QMADYh7C7dqK05PStdxInTeqIvrd4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o4tx+UgD0HSBCjLx4DagnzgYphe4Xmge7RpC18FYUQJhuH47jTuHsFOex1wMAtKK5ePbKrQZv5i/+rPfSVd+ds1l8H/caR1X0JBEZlOWKuMp9i74T4ksf+i4POtdFUMRfllcXAXRSlNKCrbMHoKbr5p7KpdBaqFP5m7O61v2L0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=irUm3gEC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZXEDlDf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIR3r4hTIr+onhFeck0Dud9M1kjMsBkEFSFYSQxhBgo=;
	b=irUm3gECokxkpHEm8WaMRG46E+RO3Wo3E2kSnjTNpLy5E5w0Big+6L47m4J7Gx1m8PGEEP
	EXVMbcnZPttgmVE+OtlnZPYI+Y9cYUTezsijFm7lBLwrPNXV106ELONSSXNrjCQWuf9pYM
	j8iHfiZRRKPSS6vp61E/DIpyFYVxaPq1GMPi1c1pkieQZtQKiYO6SI3wz7GGWPyciUiZip
	BLfSi3Iuz5cS8MPGIulyP6NI8DJ8+oDmGhU8ehF1bF9bJxyeHzmVMt0wWr5RZ4Hpf0o2+2
	24Li2vWlf1X3B+PhxwJebp+XuczX/gNg7+02/Gci14teycIvikc79vWNYgG1+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIR3r4hTIr+onhFeck0Dud9M1kjMsBkEFSFYSQxhBgo=;
	b=8ZXEDlDfL/BTSDXU+y5qbMW7hWKw8KgHrCUMsKwlEn4NV3jVqsoF45PhORHAH6BhPFonVx
	XXhyII/wozjhUmBA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/pvlocks: Move paravirt spinlock functions
 into own header
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-22-jgross@suse.com>
References: <20260105110520.21356-22-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838719884.510.7009311237976082467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     b0b449e6fec4cd182bd4384f7eb9002596079f68
Gitweb:        https://git.kernel.org/tip/b0b449e6fec4cd182bd4384f7eb90025960=
79f68
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:20 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 14:57:45 +01:00

x86/pvlocks: Move paravirt spinlock functions into own header

Instead of having the pv spinlock function definitions in paravirt.h,
move them into the new header paravirt-spinlock.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105110520.21356-22-jgross@suse.com
---
 arch/x86/hyperv/hv_spinlock.c            |  10 +-
 arch/x86/include/asm/paravirt-base.h     |   6 +-
 arch/x86/include/asm/paravirt-spinlock.h | 145 ++++++++++++++++++++++-
 arch/x86/include/asm/paravirt.h          |  61 +---------
 arch/x86/include/asm/paravirt_types.h    |  17 +---
 arch/x86/include/asm/qspinlock.h         |  87 +-------------
 arch/x86/kernel/Makefile                 |   2 +-
 arch/x86/kernel/kvm.c                    |  12 +-
 arch/x86/kernel/paravirt-spinlocks.c     |  26 +++-
 arch/x86/kernel/paravirt.c               |  21 +---
 arch/x86/xen/spinlock.c                  |  10 +-
 tools/objtool/check.c                    |   1 +-
 12 files changed, 198 insertions(+), 200 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-spinlock.h

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 2a3c2af..210b494 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -78,11 +78,11 @@ void __init hv_init_spinlocks(void)
 	pr_info("PV spinlocks enabled\n");
=20
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =3D PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait =3D hv_qlock_wait;
-	pv_ops.lock.kick =3D hv_qlock_kick;
-	pv_ops.lock.vcpu_is_preempted =3D PV_CALLEE_SAVE(hv_vcpu_is_preempted);
+	pv_ops_lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock =3D PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops_lock.wait =3D hv_qlock_wait;
+	pv_ops_lock.kick =3D hv_qlock_kick;
+	pv_ops_lock.vcpu_is_preempted =3D PV_CALLEE_SAVE(hv_vcpu_is_preempted);
 }
=20
 static __init int hv_parse_nopvspin(char *arg)
diff --git a/arch/x86/include/asm/paravirt-base.h b/arch/x86/include/asm/para=
virt-base.h
index 3827ea2..982a0b9 100644
--- a/arch/x86/include/asm/paravirt-base.h
+++ b/arch/x86/include/asm/paravirt-base.h
@@ -26,4 +26,10 @@ u64 _paravirt_ident_64(u64);
 #endif
 #define paravirt_nop	((void *)nop_func)
=20
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void paravirt_set_cap(void);
+#else
+static inline void paravirt_set_cap(void) { }
+#endif
+
 #endif /* _ASM_X86_PARAVIRT_BASE_H */
diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/=
paravirt-spinlock.h
new file mode 100644
index 0000000..a5011ef
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_PARAVIRT_SPINLOCK_H
+#define _ASM_X86_PARAVIRT_SPINLOCK_H
+
+#include <asm/paravirt_types.h>
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock_types.h>
+#endif
+
+struct qspinlock;
+
+struct pv_lock_ops {
+	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
+	struct paravirt_callee_save queued_spin_unlock;
+
+	void (*wait)(u8 *ptr, u8 val);
+	void (*kick)(int cpu);
+
+	struct paravirt_callee_save vcpu_is_preempted;
+} __no_randomize_layout;
+
+extern struct pv_lock_ops pv_ops_lock;
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val=
);
+extern void __pv_init_lock_hash(void);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock=
);
+extern bool nopvspin;
+
+static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *l=
ock,
+							 u32 val)
+{
+	PVOP_VCALL2(pv_ops_lock, queued_spin_lock_slowpath, lock, val);
+}
+
+static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
+			  "movb $0, (%%" _ASM_ARG1 ");",
+			  ALT_NOT(X86_FEATURE_PVUNLOCK));
+}
+
+static __always_inline bool pv_vcpu_is_preempted(long cpu)
+{
+	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
+				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
+}
+
+#define queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release(&lock->locked, 0);
+}
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	pv_queued_spin_lock_slowpath(lock, val);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	kcsan_release();
+	pv_queued_spin_unlock(lock);
+}
+
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(long cpu)
+{
+	return pv_vcpu_is_preempted(cpu);
+}
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	PVOP_VCALL2(pv_ops_lock, wait, ptr, val);
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	PVOP_VCALL1(pv_ops_lock, kick, cpu);
+}
+
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+void __init native_pv_lock_init(void);
+__visible void __native_queued_spin_unlock(struct qspinlock *lock);
+bool pv_is_native_spin_unlock(void);
+__visible bool __native_vcpu_is_preempted(long cpu);
+bool pv_is_native_vcpu_is_preempted(void);
+
+/*
+ * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
+ *
+ * Native (and PV wanting native due to vCPU pinning) should keep this key
+ * disabled. Native does not touch the key.
+ *
+ * When in a guest then native_pv_lock_init() enables the key first and
+ * KVM/XEN might conditionally disable it later in the boot process again.
+ */
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
+/*
+ * Shortcut for the queued_spin_lock_slowpath() function that allows
+ * virt to hijack it.
+ *
+ * Returns:
+ *   true - lock has been negotiated, all done;
+ *   false - queued_spin_lock_slowpath() will do its thing.
+ */
+#define virt_spin_lock virt_spin_lock
+static inline bool virt_spin_lock(struct qspinlock *lock)
+{
+	int val;
+
+	if (!static_branch_likely(&virt_spin_lock_key))
+		return false;
+
+	/*
+	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
+	 * back to a Test-and-Set spinlock, because fair locks have
+	 * horrible lock 'holder' preemption issues.
+	 */
+
+ __retry:
+	val =3D atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		cpu_relax();
+		goto __retry;
+	}
+
+	return true;
+}
+
+#endif /* _ASM_X86_PARAVIRT_SPINLOCK_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index ec274d1..b21072a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -19,15 +19,6 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
=20
-__visible void __native_queued_spin_unlock(struct qspinlock *lock);
-bool pv_is_native_spin_unlock(void);
-__visible bool __native_vcpu_is_preempted(long cpu);
-bool pv_is_native_vcpu_is_preempted(void);
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-void __init paravirt_set_cap(void);
-#endif
-
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
@@ -522,46 +513,7 @@ static inline void __set_fixmap(unsigned /* enum fixed_a=
ddresses */ idx,
 {
 	pv_ops.mmu.set_fixmap(idx, phys, flags);
 }
-#endif
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
-
-static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *l=
ock,
-							u32 val)
-{
-	PVOP_VCALL2(pv_ops, lock.queued_spin_lock_slowpath, lock, val);
-}
-
-static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
-{
-	PVOP_ALT_VCALLEE1(pv_ops, lock.queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
-			  ALT_NOT(X86_FEATURE_PVUNLOCK));
-}
-
-static __always_inline void pv_wait(u8 *ptr, u8 val)
-{
-	PVOP_VCALL2(pv_ops, lock.wait, ptr, val);
-}
-
-static __always_inline void pv_kick(int cpu)
-{
-	PVOP_VCALL1(pv_ops, lock.kick, cpu);
-}
-
-static __always_inline bool pv_vcpu_is_preempted(long cpu)
-{
-	return PVOP_ALT_CALLEE1(bool, pv_ops, lock.vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
-				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
-}
=20
-void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
-bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
-
-#endif /* SMP && PARAVIRT_SPINLOCKS */
-
-#ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%r=
ax;",
@@ -588,8 +540,6 @@ static __always_inline unsigned long arch_local_irq_save(=
void)
 }
 #endif
=20
-void native_pv_lock_init(void) __init;
-
 #else  /* __ASSEMBLER__ */
=20
 #ifdef CONFIG_X86_64
@@ -613,12 +563,6 @@ void native_pv_lock_init(void) __init;
 #endif /* __ASSEMBLER__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
-
-#ifndef __ASSEMBLER__
-static inline void native_pv_lock_init(void)
-{
-}
-#endif
 #endif /* !CONFIG_PARAVIRT */
=20
 #ifndef __ASSEMBLER__
@@ -634,10 +578,5 @@ static inline void paravirt_arch_exit_mmap(struct mm_str=
uct *mm)
 }
 #endif
=20
-#ifndef CONFIG_PARAVIRT_SPINLOCKS
-static inline void paravirt_set_cap(void)
-{
-}
-#endif
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index b36d425..7ccd416 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -184,22 +184,6 @@ struct pv_mmu_ops {
 #endif
 } __no_randomize_layout;
=20
-#ifdef CONFIG_SMP
-#include <asm/spinlock_types.h>
-#endif
-
-struct qspinlock;
-
-struct pv_lock_ops {
-	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
-	struct paravirt_callee_save queued_spin_unlock;
-
-	void (*wait)(u8 *ptr, u8 val);
-	void (*kick)(int cpu);
-
-	struct paravirt_callee_save vcpu_is_preempted;
-} __no_randomize_layout;
-
 /* This contains all the paravirt structures: we get a convenient
  * number for each function using the offset which we use to indicate
  * what to patch. */
@@ -207,7 +191,6 @@ struct paravirt_patch_template {
 	struct pv_cpu_ops	cpu;
 	struct pv_irq_ops	irq;
 	struct pv_mmu_ops	mmu;
-	struct pv_lock_ops	lock;
 } __no_randomize_layout;
=20
 extern struct paravirt_patch_template pv_ops;
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinloc=
k.h
index 68da67d..25a1919 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -7,6 +7,9 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 #include <asm/rmwcc.h>
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt-spinlock.h>
+#endif
=20
 #define _Q_PENDING_LOOPS	(1 << 9)
=20
@@ -27,90 +30,10 @@ static __always_inline u32 queued_fetch_set_pending_acqui=
re(struct qspinlock *lo
 	return val;
 }
=20
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val=
);
-extern void __pv_init_lock_hash(void);
-extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock=
);
-extern bool nopvspin;
-
-#define	queued_spin_unlock queued_spin_unlock
-/**
- * queued_spin_unlock - release a queued spinlock
- * @lock : Pointer to queued spinlock structure
- *
- * A smp_store_release() on the least-significant byte.
- */
-static inline void native_queued_spin_unlock(struct qspinlock *lock)
-{
-	smp_store_release(&lock->locked, 0);
-}
-
-static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
-{
-	pv_queued_spin_lock_slowpath(lock, val);
-}
-
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	kcsan_release();
-	pv_queued_spin_unlock(lock);
-}
-
-#define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(long cpu)
-{
-	return pv_vcpu_is_preempted(cpu);
-}
+#ifndef CONFIG_PARAVIRT
+static inline void native_pv_lock_init(void) { }
 #endif
=20
-#ifdef CONFIG_PARAVIRT
-/*
- * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
- *
- * Native (and PV wanting native due to vCPU pinning) should keep this key
- * disabled. Native does not touch the key.
- *
- * When in a guest then native_pv_lock_init() enables the key first and
- * KVM/XEN might conditionally disable it later in the boot process again.
- */
-DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
-
-/*
- * Shortcut for the queued_spin_lock_slowpath() function that allows
- * virt to hijack it.
- *
- * Returns:
- *   true - lock has been negotiated, all done;
- *   false - queued_spin_lock_slowpath() will do its thing.
- */
-#define virt_spin_lock virt_spin_lock
-static inline bool virt_spin_lock(struct qspinlock *lock)
-{
-	int val;
-
-	if (!static_branch_likely(&virt_spin_lock_key))
-		return false;
-
-	/*
-	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
-	 * back to a Test-and-Set spinlock, because fair locks have
-	 * horrible lock 'holder' preemption issues.
-	 */
-
- __retry:
-	val =3D atomic_read(&lock->val);
-
-	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
-		cpu_relax();
-		goto __retry;
-	}
-
-	return true;
-}
-
-#endif /* CONFIG_PARAVIRT */
-
 #include <asm-generic/qspinlock.h>
=20
 #endif /* _ASM_X86_QSPINLOCK_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bc184dd..e9aeeea 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_DEBUG_NMI_SELFTEST) +=3D nmi_selftest.o
=20
 obj-$(CONFIG_KVM_GUEST)		+=3D kvm.o kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o
-obj-$(CONFIG_PARAVIRT_SPINLOCKS)+=3D paravirt-spinlocks.o
+obj-$(CONFIG_PARAVIRT)		+=3D paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+=3D pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) +=3D pmem.o
=20
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 21b4de5..de550b1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -829,8 +829,10 @@ static void __init kvm_guest_init(void)
 		has_steal_clock =3D 1;
 		static_call_update(pv_steal_clock, kvm_steal_clock);
=20
-		pv_ops.lock.vcpu_is_preempted =3D
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		pv_ops_lock.vcpu_is_preempted =3D
 			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
+#endif
 	}
=20
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -1126,11 +1128,11 @@ void __init kvm_spinlock_init(void)
 	pr_info("PV spinlocks enabled\n");
=20
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =3D
+	pv_ops_lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock =3D
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait =3D kvm_wait;
-	pv_ops.lock.kick =3D kvm_kick_cpu;
+	pv_ops_lock.wait =3D kvm_wait;
+	pv_ops_lock.kick =3D kvm_kick_cpu;
=20
 	/*
 	 * When PV spinlock is enabled which is preferred over
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-=
spinlocks.c
index 9e1ea99..9545244 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -3,12 +3,22 @@
  * Split spinlock implementation out into its own file, so it can be
  * compiled in a FTRACE-compatible way.
  */
+#include <linux/static_call.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
=20
-#include <asm/paravirt.h>
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
=20
+#ifdef CONFIG_SMP
+void __init native_pv_lock_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
+}
+#endif
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 __visible void __native_queued_spin_unlock(struct qspinlock *lock)
 {
 	native_queued_spin_unlock(lock);
@@ -17,7 +27,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
=20
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_ops.lock.queued_spin_unlock.func =3D=3D
+	return pv_ops_lock.queued_spin_unlock.func =3D=3D
 		__raw_callee_save___native_queued_spin_unlock;
 }
=20
@@ -29,7 +39,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
=20
 bool pv_is_native_vcpu_is_preempted(void)
 {
-	return pv_ops.lock.vcpu_is_preempted.func =3D=3D
+	return pv_ops_lock.vcpu_is_preempted.func =3D=3D
 		__raw_callee_save___native_vcpu_is_preempted;
 }
=20
@@ -41,3 +51,13 @@ void __init paravirt_set_cap(void)
 	if (!pv_is_native_vcpu_is_preempted())
 		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
 }
+
+struct pv_lock_ops pv_ops_lock =3D {
+	.queued_spin_lock_slowpath	=3D native_queued_spin_lock_slowpath,
+	.queued_spin_unlock		=3D PV_CALLEE_SAVE(__native_queued_spin_unlock),
+	.wait				=3D paravirt_nop,
+	.kick				=3D paravirt_nop,
+	.vcpu_is_preempted		=3D PV_CALLEE_SAVE(__native_vcpu_is_preempted),
+};
+EXPORT_SYMBOL(pv_ops_lock);
+#endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5dfbd3f..a6ed52c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -57,14 +57,6 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text=
);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
=20
-DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
-
-void __init native_pv_lock_init(void)
-{
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_enable(&virt_spin_lock_key);
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -221,19 +213,6 @@ struct paravirt_patch_template pv_ops =3D {
=20
 	.mmu.set_fixmap		=3D native_set_fixmap,
 #endif /* CONFIG_PARAVIRT_XXL */
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-	/* Lock ops. */
-#ifdef CONFIG_SMP
-	.lock.queued_spin_lock_slowpath	=3D native_queued_spin_lock_slowpath,
-	.lock.queued_spin_unlock	=3D
-				PV_CALLEE_SAVE(__native_queued_spin_unlock),
-	.lock.wait			=3D paravirt_nop,
-	.lock.kick			=3D paravirt_nop,
-	.lock.vcpu_is_preempted		=3D
-				PV_CALLEE_SAVE(__native_vcpu_is_preempted),
-#endif /* SMP */
-#endif
 };
=20
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index fe56646..83ac24e 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -134,10 +134,10 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
=20
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =3D
+	pv_ops_lock.queued_spin_lock_slowpath =3D __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock =3D
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait =3D xen_qlock_wait;
-	pv_ops.lock.kick =3D xen_qlock_kick;
-	pv_ops.lock.vcpu_is_preempted =3D PV_CALLEE_SAVE(xen_vcpu_stolen);
+	pv_ops_lock.wait =3D xen_qlock_wait;
+	pv_ops_lock.kick =3D xen_qlock_kick;
+	pv_ops_lock.vcpu_is_preempted =3D PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b3fec88..c2952df 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -527,6 +527,7 @@ static struct {
 	int idx_off;
 } pv_ops_tables[] =3D {
 	{ .name =3D "pv_ops", },
+	{ .name =3D "pv_ops_lock", },
 	{ .name =3D NULL, .idx_off =3D -1 }
 };
=20

