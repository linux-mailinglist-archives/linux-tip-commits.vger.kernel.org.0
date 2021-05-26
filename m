Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525B039160F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhEZL1q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhEZL0g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBBC061347;
        Wed, 26 May 2021 04:24:45 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdZW1her5+8ggXv55gfy7O4i3jOINxw5k28BuNYdOXc=;
        b=hHQq1DG/MVuSt2bbtcNrdkFXwh60sO1nQ29drasgW3H8cADqkK3KB7qboZvqdzq5/ECxlc
        86ctSwd2MIMfbHc7xw5ATCsMuxN/3+1uWG1Z1rthPpUDAnTwNe6jSaHx1W+7eHZjhp9fp6
        cvlKCpQxkoUR9mPg1gxNIWV8R6hCva+jmwYt3TMiHGuh5bALnLomDcpc+5r0PWeFIYtNfI
        nfXY85MVAcGAeVZNZn9apvXVE3VS/Aw0pw6wUbP58dSy9eM7HiRnfBIsOY7chOnZCrHqUR
        qtxRELe/Ym+yvW1RK4gOhfxLQqboVN6cMC7HreT/kToZ5glGymKLxXgguiDc2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdZW1her5+8ggXv55gfy7O4i3jOINxw5k28BuNYdOXc=;
        b=LfehzqkvpV9Oq+88ZglzzI8761NZ8CFgfz5SxKD4GnpTDXxZk/l0vzmQRncYWIvOQirL25
        /+RCyAVvKu1LOhBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: make ARCH_ATOMIC a Kconfig symbol
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-2-mark.rutland@arm.com>
References: <20210525140232.53872-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828313.29796.15137995454892646211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9be85de97786a75f62080de1c0c13656f65cba84
Gitweb:        https://git.kernel.org/tip/9be85de97786a75f62080de1c0c13656f65cba84
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: make ARCH_ATOMIC a Kconfig symbol

Subsequent patches will move architectures over to the ARCH_ATOMIC API,
after preparing the asm-generic atomic implementations to function with
or without ARCH_ATOMIC.

As some architectures use the asm-generic implementations exclusively
(and don't have a local atomic.h), and to avoid the risk that
ARCH_ATOMIC isn't defined in some cases we expect, let's make the
ARCH_ATOMIC macro a Kconfig symbol instead, so that we can guarantee it
is consistently available where needed.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-2-mark.rutland@arm.com
---
 arch/Kconfig                    | 3 +++
 arch/arm64/Kconfig              | 1 +
 arch/arm64/include/asm/atomic.h | 2 --
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/atomic.h  | 2 --
 arch/um/Kconfig                 | 1 +
 arch/x86/Kconfig                | 1 +
 arch/x86/include/asm/atomic.h   | 2 --
 include/linux/atomic.h          | 2 +-
 9 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770..3fb3b12 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,9 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
+config ARCH_ATOMIC
+	bool
+
 config CRASH_CORE
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d856..62ab429 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
+	select ARCH_ATOMIC
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index b56a4b2..c997927 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -223,6 +223,4 @@ static __always_inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#define ARCH_ATOMIC
-
 #endif /* __ASM_ATOMIC_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34..85374a3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -58,6 +58,7 @@ config S390
 	# Note: keep this list sorted alphabetically
 	#
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
+	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 7c93c65..7138d18 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -147,6 +147,4 @@ ATOMIC64_OPS(xor)
 #define arch_atomic64_fetch_sub(_i, _v)  arch_atomic64_fetch_add(-(s64)(_i), _v)
 #define arch_atomic64_sub(_i, _v)	 arch_atomic64_add(-(s64)(_i), _v)
 
-#define ARCH_ATOMIC
-
 #endif /* __ARCH_S390_ATOMIC__  */
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 57cfd9a..4370a95 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_ATOMIC
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b..11a2756 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -58,6 +58,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ARCH_ATOMIC
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index f732741..5e754e8 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -269,6 +269,4 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#define ARCH_ATOMIC
-
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 571a110..4f8d83f 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,7 +77,7 @@
 	__ret;								\
 })
 
-#ifdef ARCH_ATOMIC
+#ifdef CONFIG_ARCH_ATOMIC
 #include <linux/atomic-arch-fallback.h>
 #include <asm-generic/atomic-instrumented.h>
 #else
