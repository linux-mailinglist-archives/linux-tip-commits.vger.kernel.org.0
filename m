Return-Path: <linux-tip-commits+bounces-2451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6699FB66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39301F24417
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646F1D63C8;
	Tue, 15 Oct 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ljcXXlV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ahx46UEc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886691B6D03;
	Tue, 15 Oct 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030993; cv=none; b=nx13clRABSS6oKr32ekWzz3XDtXeSTa1yhn4xdgoVu9KwzJJBi8U6qToXPTiFJPnCK8rvmico65F/ofx/zCL+g6fJDecn2T8+dLhVErXAF0WiGL/rKPfMH2AB/dpGdbdKYi9SyDqUAglbOIXEJahyj29FM+SxDTbaNYs6vN66ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030993; c=relaxed/simple;
	bh=o9vfLnA0PVpYsOXHBSqx2OVMsGv9eloplsNsIvRm2Gs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KKRBGKIzB1PgzD4kBqbQLJip51BsFLts1iNTC+sus57PwtMpdKZ/Co7Svk3J59Bnul4TEG6WWlz3QR98vyYwSOFlHuhKM3aPd43SaoI+S0deocizIZzYUDObEPHA7SyFBnRwatL6HIvWDope60f4n+JBHFRXXokRFT45mrPRhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ljcXXlV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ahx46UEc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729030989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftC1Q4peBK4VeT7fJOdAIvh7nxZA4v+C2r4LN5KiwTo=;
	b=2ljcXXlVMkV33n9vP+sw641Aeqomp/UJo305T6ulqr+AXwV6l5XH3jY3IUfltVg+SSJgPj
	JGk0QzAH0uIrvr3c913/cyGEQUkoP6EN1Hc6Y3wTZ83N2nLqjGgpsoq86rh1WB9Jr8x0mg
	L5JQAKB6EtZBXDryv/Feilxwl7J2UVC4aKC7OXLzTsTxSEb+TebHR9l2crDByk8VKUvmfI
	fZ1MgoQuNtIynG1Xmv+glL+AKCj6xtklLiFDPjA1Ek3YXKpu3/OPCw6GifJpSOWXmkbK/Y
	r/8XvcY6yegCQQ5GrZHIyuM6bAWrndTRkQLfr8h7SCA19n6lJQClatUwB01xOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729030989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftC1Q4peBK4VeT7fJOdAIvh7nxZA4v+C2r4LN5KiwTo=;
	b=Ahx46UEc23U5ZVM8M0aNazpB5cb2xeJSzBfC5rrpxkvM0j/u/pvdRQ+1HnQl/oOnegolHJ
	5s6amzwtBaFliTBw==
From: "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Introduce vdso/page.h
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014151340.1639555-3-vincenzo.frascino@arm.com>
References: <20241014151340.1639555-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903098878.1442.4347742445219581709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     efe8419ae78d65e83edc31aad74b605c12e7d60c
Gitweb:        https://git.kernel.org/tip/efe8419ae78d65e83edc31aad74b605c12e7d60c
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 14 Oct 2024 16:13:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:13:04 +02:00

vdso: Introduce vdso/page.h

The VDSO implementation includes headers from outside of the
vdso/ namespace.

Introduce vdso/page.h to make sure that the generic library
uses only the allowed namespace.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Link: https://lore.kernel.org/all/20241014151340.1639555-3-vincenzo.frascino@arm.com

---
 arch/alpha/include/asm/page.h      |  6 +-----
 arch/arc/include/uapi/asm/page.h   |  7 +++----
 arch/arm/include/asm/page.h        |  5 +----
 arch/arm64/include/asm/page-def.h  |  5 +----
 arch/csky/include/asm/page.h       |  8 ++------
 arch/hexagon/include/asm/page.h    |  4 +---
 arch/loongarch/include/asm/page.h  |  7 +------
 arch/m68k/include/asm/page.h       |  6 ++----
 arch/microblaze/include/asm/page.h |  5 +----
 arch/mips/include/asm/page.h       |  7 +------
 arch/nios2/include/asm/page.h      |  7 +------
 arch/openrisc/include/asm/page.h   | 11 +----------
 arch/parisc/include/asm/page.h     |  4 +---
 arch/powerpc/include/asm/page.h    | 10 +---------
 arch/riscv/include/asm/page.h      |  4 +---
 arch/s390/include/asm/page.h       | 13 +++++--------
 arch/sh/include/asm/page.h         |  6 ++----
 arch/sparc/include/asm/page_32.h   |  4 +---
 arch/sparc/include/asm/page_64.h   |  4 +---
 arch/um/include/asm/page.h         |  5 +----
 arch/x86/include/asm/page_types.h  |  5 +----
 arch/xtensa/include/asm/page.h     |  8 +-------
 include/vdso/page.h                | 30 +++++++++++++++++++++++++++++-
 23 files changed, 61 insertions(+), 110 deletions(-)
 create mode 100644 include/vdso/page.h

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 70419e6..261af54 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -4,11 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/pal.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arc/include/uapi/asm/page.h b/arch/arc/include/uapi/asm/page.h
index 7fd9e74..4606a32 100644
--- a/arch/arc/include/uapi/asm/page.h
+++ b/arch/arc/include/uapi/asm/page.h
@@ -14,7 +14,7 @@
 
 /* PAGE_SHIFT determines the page size */
 #ifdef __KERNEL__
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
+#include <vdso/page.h>
 #else
 /*
  * Default 8k
@@ -24,11 +24,10 @@
  * not available
  */
 #define PAGE_SHIFT 13
+#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
+#define PAGE_MASK	(~(PAGE_SIZE-1))
 #endif
 
-#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
 #define PAGE_OFFSET	_AC(0x80000000, UL)	/* Kernel starts at 2G onwrds */
 
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #endif /* _UAPI__ASM_ARC_PAGE_H */
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 62af9f7..ef11b72 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -7,10 +7,7 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index 792e9fe..d402e08 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -10,9 +10,6 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 0ca6c40..f8beae2 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -7,12 +7,8 @@
 #include <asm/cache.h>
 #include <linux/const.h>
 
-/*
- * PAGE_SHIFT determines the page size: 4KB
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
+
 #define THREAD_SIZE	(PAGE_SIZE * 2)
 #define THREAD_MASK	(~(THREAD_SIZE - 1))
 #define THREAD_SHIFT	(PAGE_SHIFT + 1)
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 8a6af57..b01f8df 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -45,9 +45,7 @@
 #define HVM_HUGEPAGE_SIZE 0x5
 #endif
 
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
-#define PAGE_SIZE  (1UL << PAGE_SHIFT)
-#define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index e85df33..83f3533 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -8,12 +8,7 @@
 #include <linux/const.h>
 #include <asm/addrspace.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 8cfb84b..b173ba2 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -6,10 +6,8 @@
 #include <asm/setup.h>
 #include <asm/page_offset.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PAGE_OFFSET	(PAGE_OFFSET_RAW)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 8810f4f..d1ec380 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -19,10 +19,7 @@
 
 #ifdef __KERNEL__
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_KERNEL_BASE_ADDR))
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 4609cb0..bc3e348 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -14,12 +14,7 @@
 #include <linux/kernel.h>
 #include <asm/mipsregs.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 /*
  * This is used for calculating the real page sizes
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 0722f88..2897ec1 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -18,12 +18,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 1d5913f..124a2db 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -15,16 +15,7 @@
 #ifndef __ASM_OPENRISC_PAGE_H
 #define __ASM_OPENRISC_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE       (1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK       (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define PAGE_OFFSET	0xc0000000
 #define KERNELBASE	PAGE_OFFSET
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 4bea2e9..6c4836f 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -4,9 +4,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 83d0a4f..af9a262 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -21,8 +21,7 @@
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_HUGETLB_PAGE
@@ -42,13 +41,6 @@ extern unsigned int hpage_shift;
 #endif
 
 /*
- * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
- * assign PAGE_MASK to a larger type it gets extended the way we want
- * (i.e. with 1s in the high bits)
- */
-#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
-
-/*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
  * the same as PAGE_OFFSET, but _might not be_.
  *
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 32d308a..9875399 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -12,9 +12,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 73e1e03..dbc25dc 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -11,14 +11,11 @@
 #include <linux/const.h>
 #include <asm/types.h>
 
-#define _PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define _PAGE_SIZE	(_AC(1, UL) << _PAGE_SHIFT)
-#define _PAGE_MASK	(~(_PAGE_SIZE - 1))
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	_PAGE_SHIFT
-#define PAGE_SIZE	_PAGE_SIZE
-#define PAGE_MASK	_PAGE_MASK
+#include <vdso/page.h>
+
+#define _PAGE_SHIFT	PAGE_SHIFT
+#define _PAGE_SIZE	PAGE_SIZE
+#define _PAGE_MASK	PAGE_MASK
 #define PAGE_DEFAULT_ACC	_AC(0, UL)
 /* storage-protection override */
 #define PAGE_SPO_ACC		9
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index f780b46..fc39b81 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -8,10 +8,8 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 9977c77..9954254 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -11,9 +11,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e9bd248..2a68ff5 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -4,9 +4,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 /* Flushing for D-cache alias handling is only needed if
  * the page size is smaller than 16K.
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8a..834313e 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -9,10 +9,7 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 52f1b4f..9746889 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -6,10 +6,7 @@
 #include <linux/types.h>
 #include <linux/mem_encrypt.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 4db56ef..595c103 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -18,13 +18,7 @@
 #include <asm/cache.h>
 #include <asm/kmem_layout.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(__XTENSA_UL_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifdef CONFIG_MMU
 #define PAGE_OFFSET	XCHAL_KSEG_CACHED_VADDR
diff --git a/include/vdso/page.h b/include/vdso/page.h
new file mode 100644
index 0000000..4ada1ba
--- /dev/null
+++ b/include/vdso/page.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_PAGE_H
+#define __VDSO_PAGE_H
+
+#include <uapi/linux/const.h>
+
+/*
+ * PAGE_SHIFT determines the page size.
+ *
+ * Note: This definition is required because PAGE_SHIFT is used
+ * in several places throuout the codebase.
+ */
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+
+#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
+
+#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_64BIT)
+/*
+ * Applies only to 32-bit architectures with a 64-bit phys_addr_t.
+ *
+ * Subtle: (1 << CONFIG_PAGE_SHIFT) is an int, not an unsigned long.
+ * So if we assign PAGE_MASK to a larger type it gets extended the
+ * way we want (i.e. with 1s in the high bits)
+ */
+#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
+#else
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#endif
+
+#endif	/* __VDSO_PAGE_H */

