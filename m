Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9E420A3E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhJDLnb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhJDLnV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 07:43:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9AC061786;
        Mon,  4 Oct 2021 04:41:31 -0700 (PDT)
Date:   Mon, 04 Oct 2021 11:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633347690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkEmz7ba8kh7PcGw6fNgybkXynHhxckOfCd2M7K+XGI=;
        b=fBEAsAl74YlIqfL0zrMW5jFuEjfTyj1Tz+qgMwuEzGWepGuLnK0ePZ/NEwZIbgD1N95fv4
        ZImOpiBAHyDJjYFud8q2RJdVWKoaQCcJASTjHyXSVyLs0RhVjrB4esxOu5R2EamZT0fcyx
        /4ccBxZ++32lbQRFfmlHW0LmIO/yAoNGZhAGe3J5ediDl1O42m14UD1i3DuGYBZTvB75KP
        Xptg84HPtMdnxjCKAKmrcYrRSMYQ6jC82X2efPh2+bVtg+bT1L3zXmO9ud5ut09Bwmnzbr
        zr2e3S+qUEuRacpIEDsVlZerpC72s0JbIeMEO6pPSPTazKDaspCuNEd+a2zSSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633347690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkEmz7ba8kh7PcGw6fNgybkXynHhxckOfCd2M7K+XGI=;
        b=iuIqLcIogql8PN2Ax7pYEA+IY6sP15UtnOyR4nkQHeVpHUVfnlOnOUIQw2J3YG6cQI9GIS
        95qMdHyIQ5cTFCBA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/sev: Add an x86 version of cc_platform_has()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928191009.32551-4-bp@alien8.de>
References: <20210928191009.32551-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163334768930.25758.17620474558044432963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     aa5a461171f98fde0df78c4f6b5018a1e967cf81
Gitweb:        https://git.kernel.org/tip/aa5a461171f98fde0df78c4f6b5018a1e967cf81
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 08 Sep 2021 17:58:34 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:46:20 +02:00

x86/sev: Add an x86 version of cc_platform_has()

Introduce an x86 version of the cc_platform_has() function. This will be
used to replace vendor specific calls like sme_active(), sev_active(),
etc.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210928191009.32551-4-bp@alien8.de
---
 arch/x86/Kconfig                   |  1 +-
 arch/x86/include/asm/mem_encrypt.h |  1 +-
 arch/x86/kernel/Makefile           |  6 +++-
 arch/x86/kernel/cc_platform.c      | 69 +++++++++++++++++++++++++++++-
 arch/x86/mm/mem_encrypt.c          |  1 +-
 5 files changed, 78 insertions(+)
 create mode 100644 arch/x86/kernel/cc_platform.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22..9f190ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,6 +1518,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68..3fb9f5e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
+#include <linux/cc_platform.h>
 
 #include <asm/bootparam.h>
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8f4e8fa..2ff3e60 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,6 +21,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
+CFLAGS_REMOVE_cc_platform.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -29,6 +30,7 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
+KASAN_SANITIZE_cc_platform.o				:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -47,6 +49,7 @@ endif
 KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
+CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
@@ -147,6 +150,9 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
+
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
new file mode 100644
index 0000000..03bb2f3
--- /dev/null
+++ b/arch/x86/kernel/cc_platform.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+#include <linux/mem_encrypt.h>
+
+#include <asm/processor.h>
+
+static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_INTEL_TDX_GUEST
+	return false;
+#else
+	return false;
+#endif
+}
+
+/*
+ * SME and SEV are very similar but they are not the same, so there are
+ * times that the kernel will need to distinguish between SME and SEV. The
+ * cc_platform_has() function is used for this.  When a distinction isn't
+ * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
+ *
+ * The trampoline code is a good example for this requirement.  Before
+ * paging is activated, SME will access all memory as decrypted, but SEV
+ * will access all memory as encrypted.  So, when APs are being brought
+ * up under SME the trampoline area cannot be encrypted, whereas under SEV
+ * the trampoline area must be encrypted.
+ */
+static bool amd_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return sme_me_mask;
+
+	case CC_ATTR_HOST_MEM_ENCRYPT:
+		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
+
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ENABLED;
+
+	case CC_ATTR_GUEST_STATE_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+
+	default:
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	if (sme_me_mask)
+		return amd_cc_platform_has(attr);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc4..e29b141 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
