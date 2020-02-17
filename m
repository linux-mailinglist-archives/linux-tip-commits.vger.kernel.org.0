Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1B161B74
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2020 20:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgBQTSx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 Feb 2020 14:18:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34659 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgBQTSx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 Feb 2020 14:18:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3lur-0006Df-Ti; Mon, 17 Feb 2020 20:18:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 594021C20B9;
        Mon, 17 Feb 2020 20:18:49 +0100 (CET)
Date:   Mon, 17 Feb 2020 19:18:49 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Cleanup clock mode storage leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124403.470699892@linutronix.de>
References: <20200207124403.470699892@linutronix.de>
MIME-Version: 1.0
Message-ID: <158196712909.13786.4696400737520235414.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f86fd32db706613fe8d0104057efa6e83e0d7e8f
Gitweb:        https://git.kernel.org/tip/f86fd32db706613fe8d0104057efa6e83e0d7e8f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:38:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 20:12:17 +01:00

lib/vdso: Cleanup clock mode storage leftovers

Now that all architectures are converted to use the generic storage the
helpers and conditionals can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124403.470699892@linutronix.de



---
 arch/arm/mm/Kconfig                 |  1 -
 arch/arm64/Kconfig                  |  1 -
 arch/mips/Kconfig                   |  1 -
 arch/x86/Kconfig                    |  1 -
 include/asm-generic/vdso/vsyscall.h |  7 -------
 include/linux/clocksource.h         |  4 ++--
 kernel/time/vsyscall.c              |  4 ----
 lib/vdso/Kconfig                    |  3 ---
 lib/vdso/gettimeofday.c             | 17 +++++------------
 9 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 865e888..65e4482 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -900,7 +900,6 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7809d49..c6c32fb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,7 +110,6 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 23b5c05..654369a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -37,7 +37,6 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_CLOCK_MODE
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 698e9c8..8b995db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,7 +125,6 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_CLOCK_MODE
 	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index cec543d..4a28797 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -18,13 +18,6 @@ static __always_inline bool __arch_update_vdso_data(void)
 }
 #endif /* __arch_update_vdso_data */
 
-#ifndef __arch_get_clock_mode
-static __always_inline int __arch_get_clock_mode(struct timekeeper *tk)
-{
-	return 0;
-}
-#endif /* __arch_get_clock_mode */
-
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
 						   struct timekeeper *tk)
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 6d5ed1b..7fefe0b 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -24,13 +24,13 @@ struct clocksource;
 struct module;
 
 #if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_VDSO_CLOCK_MODE)
+    defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
 enum vdso_clock_mode {
 	VDSO_CLOCKMODE_NONE,
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	VDSO_ARCH_CLOCKMODES,
 #endif
 	VDSO_CLOCKMODE_MAX,
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index f9a5178..d31a5ef 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -77,11 +77,7 @@ void update_vsyscall(struct timekeeper *tk)
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
 	clock_mode = tk->tkr_mono.clock->vdso_clock_mode;
-#else
-	clock_mode = __arch_get_clock_mode(tk);
-#endif
 	vdata[CS_HRES_COARSE].clock_mode	= clock_mode;
 	vdata[CS_RAW].clock_mode		= clock_mode;
 
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d9f43c8..d883ac2 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,7 +30,4 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
-config GENERIC_VDSO_CLOCK_MODE
-	bool
-
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 3f2d8b8..00f8d1f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -65,16 +65,13 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 
 	do {
 		seq = vdso_read_begin(vd);
-		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+
+		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
 			return -1;
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    unlikely((s64)cycles < 0))
-			return -1;
-
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;
@@ -137,16 +134,12 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		}
 		smp_rmb();
 
-		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
 			return -1;
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
-		    unlikely((s64)cycles < 0))
-			return -1;
-
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;
