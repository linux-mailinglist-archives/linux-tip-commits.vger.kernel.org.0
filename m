Return-Path: <linux-tip-commits+bounces-2694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9159B9E8B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A466B1C20B77
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15616F8E9;
	Sat,  2 Nov 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aetCnBGU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIFRkwko"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF23EA98;
	Sat,  2 Nov 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542212; cv=none; b=W4Dp2f//nSzzEXohq3EalmsI/023f74hcV+2f3ya3Cchm8sbrlp0By/taIj4frlIW6MS87PrDRXHHFcOzVttpVScCbtBjewciIvuSnyd730Bv0CYVZ7Fto729FonaiW8TZp7mcDFHiTYpQuMKg6anEU8OSJONLBUdtxlFtKWDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542212; c=relaxed/simple;
	bh=h+oLhylA1wQocLgErjWwIh3jcje/y3CI1D+otl1JZqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ov0V8cuFHJeqNq6NSaXcv5cyA9XjHoYKZ1hpQgoofEYsq3pCB2x7GuhhVGUoFzPQHpcXFJaEN8MkHv6WInYdZFA3Q+OAwOITzv2y3C8YHvEZVJCG+fBqC1MLhT699MG80NY5txGqnFy0NsE2IvVvaHUJ3c/WZO39kn6gTmhCDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aetCnBGU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIFRkwko; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiH5zC7VRz+ra+OAgwlQT6/sMmfY6QSKKXe4ym4JzJQ=;
	b=aetCnBGU3F9RO+b8j0gGqhTuCNWeX/d4yR67XjbLu+H42HyOzWWhlvldR9Wm978Y/UGgRs
	SqSZz8IjKf6EBocm4bSxeKKtZRdai4tiU8u7pfJk0lyh6jFAaPs7h4SR9BCL0QGFjwo7bw
	nzH4isEvMNb7ShI9ZdfbUTv+7YCrqA+kmqFo1hHKjfNwUiJ3KgOzmGSV0sujbJ16QJ+QhX
	pmuVtroGj6KqvqzMCs5/YqJUO8Nm9x3VRDLu1TMVy4yEg4gfZMvOhtyj37kVtIJJg8g4io
	dVgXIbc4OUPdAsnZqans0Vt/JHWTJEz4xvAhOh3KdZ5eCY8ZHTwz5ysN45ARIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiH5zC7VRz+ra+OAgwlQT6/sMmfY6QSKKXe4ym4JzJQ=;
	b=tIFRkwkoD52qkXN5gCAw5iO2nH0i9rrQO2o/YK2V0Ub0x+UzgUHkz7K/CstWAQqJpGbJ3p
	5E8OoIXiWl+69ZDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso: Rename struct arch_vdso_data to arch_vdso_time_data
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-28-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-28-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220135.3137.10781057478330597889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     3bf96deae5ad9664bdf2db95599e52221f9ddc33
Gitweb:        https://git.kernel.org/tip/3bf96deae5ad9664bdf2db95599e52221f9ddc33
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:16 +01:00

vdso: Rename struct arch_vdso_data to arch_vdso_time_data

The struct arch_vdso_data is only about vdso time data. So rename it to
arch_vdso_time_data to make it obvious.
Non time-related data will be migrated out of these structs soon.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-28-b64f0842d512@linutronix.de

---
 arch/Kconfig                            |  2 +-
 arch/riscv/Kconfig                      |  2 +-
 arch/riscv/include/asm/vdso/data.h      | 17 -----------------
 arch/riscv/include/asm/vdso/time_data.h | 17 +++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c         |  2 +-
 arch/riscv/kernel/vdso/hwprobe.c        |  4 ++--
 arch/s390/Kconfig                       |  2 +-
 arch/s390/include/asm/vdso/data.h       | 12 ------------
 arch/s390/include/asm/vdso/time_data.h  | 12 ++++++++++++
 include/vdso/datapage.h                 |  8 ++++----
 10 files changed, 39 insertions(+), 39 deletions(-)
 delete mode 100644 arch/riscv/include/asm/vdso/data.h
 create mode 100644 arch/riscv/include/asm/vdso/time_data.h
 delete mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/time_data.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374e..7f1ec32 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1530,7 +1530,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
-config ARCH_HAS_VDSO_DATA
+config ARCH_HAS_VDSO_TIME_DATA
 	bool
 
 config HAVE_STATIC_CALL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6254594..c278280 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,7 +50,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VDSO_TIME_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/riscv/include/asm/vdso/data.h b/arch/riscv/include/asm/vdso/data.h
deleted file mode 100644
index dc2f76f..0000000
--- a/arch/riscv/include/asm/vdso/data.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RISCV_ASM_VDSO_DATA_H
-#define __RISCV_ASM_VDSO_DATA_H
-
-#include <linux/types.h>
-#include <vdso/datapage.h>
-#include <asm/hwprobe.h>
-
-struct arch_vdso_data {
-	/* Stash static answers to the hwprobe queries when all CPUs are selected. */
-	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
-
-	/* Boolean indicating all CPUs have the same static hwprobe values. */
-	__u8 homogeneous_cpus;
-};
-
-#endif /* __RISCV_ASM_VDSO_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/time_data.h b/arch/riscv/include/asm/vdso/time_data.h
new file mode 100644
index 0000000..dfa6522
--- /dev/null
+++ b/arch/riscv/include/asm/vdso/time_data.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
+#define __RISCV_ASM_VDSO_TIME_DATA_H
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <asm/hwprobe.h>
+
+struct arch_vdso_time_data {
+	/* Stash static answers to the hwprobe queries when all CPUs are selected. */
+	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
+
+	/* Boolean indicating all CPUs have the same static hwprobe values. */
+	__u8 homogeneous_cpus;
+};
+
+#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2..711a31f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -402,7 +402,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
 static int __init init_hwprobe_vdso_data(void)
 {
 	struct vdso_data *vd = __arch_get_k_vdso_data();
-	struct arch_vdso_data *avd = &vd->arch_data;
+	struct arch_vdso_time_data *avd = &vd->arch_data;
 	u64 id_bitsmash = 0;
 	struct riscv_hwprobe pair;
 	int key;
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
index 1e926e4..a158c02 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -17,7 +17,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
 				 unsigned int flags)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	const struct arch_vdso_data *avd = &vd->arch_data;
+	const struct arch_vdso_time_data *avd = &vd->arch_data;
 	bool all_cpus = !cpusetsize && !cpus;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
@@ -52,7 +52,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs, size_t pair_count,
 			       unsigned int flags)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	const struct arch_vdso_data *avd = &vd->arch_data;
+	const struct arch_vdso_time_data *avd = &vd->arch_data;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
 	unsigned char *c = (unsigned char *)cpus;
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d339fe4..8cdd835 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -88,7 +88,7 @@ config S390
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VDSO_TIME_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
deleted file mode 100644
index 0e2b40e..0000000
--- a/arch/s390/include/asm/vdso/data.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __S390_ASM_VDSO_DATA_H
-#define __S390_ASM_VDSO_DATA_H
-
-#include <linux/types.h>
-
-struct arch_vdso_data {
-	__s64 tod_steering_delta;
-	__u64 tod_steering_end;
-};
-
-#endif /* __S390_ASM_VDSO_DATA_H */
diff --git a/arch/s390/include/asm/vdso/time_data.h b/arch/s390/include/asm/vdso/time_data.h
new file mode 100644
index 0000000..8a08752
--- /dev/null
+++ b/arch/s390/include/asm/vdso/time_data.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __S390_ASM_VDSO_TIME_DATA_H
+#define __S390_ASM_VDSO_TIME_DATA_H
+
+#include <linux/types.h>
+
+struct arch_vdso_time_data {
+	__s64 tod_steering_delta;
+	__u64 tod_steering_end;
+};
+
+#endif /* __S390_ASM_VDSO_TIME_DATA_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b85f24c..d967baa 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,10 +19,10 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARCH_HAS_VDSO_DATA
-#include <asm/vdso/data.h>
+#ifdef CONFIG_ARCH_HAS_VDSO_TIME_DATA
+#include <asm/vdso/time_data.h>
 #else
-struct arch_vdso_data {};
+struct arch_vdso_time_data {};
 #endif
 
 #define VDSO_BASES	(CLOCK_TAI + 1)
@@ -114,7 +114,7 @@ struct vdso_data {
 	u32			hrtimer_res;
 	u32			__unused;
 
-	struct arch_vdso_data	arch_data;
+	struct arch_vdso_time_data arch_data;
 };
 
 /**

