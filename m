Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC83244BFA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Aug 2020 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHNPXr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 Aug 2020 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgHNPXn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812FC061384;
        Fri, 14 Aug 2020 08:23:43 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpwF0ezxNnJRH1EzzqXaJI767Fgm8ET3DDmGPuxhi4M=;
        b=kEPKwc998bARCNhozu0yT+aomyJTVYwEhFfpH+7eDwU0IsSOh60TzG/eO6Drysa26zd1Cn
        1gObYd/9qQoBAguBMeed2SypWyets6kdCxFih6e2yCsEuLXj12Is7H1I3NGIUvhDtvgvTc
        CiWpOHixctHPgaTMzX5dGm31Dp0OGiA2WFA5uM/Y/zPF6fRWcTjDoqVfAGQDiWrbK9RUU6
        ouX3WWeNoDGSXLffFg3qe/JP0ew3eG3GazwLb+bTPSE9Eh8PU3cjR2UQSJ+lcB6TXZXy1y
        Gd5MjbsW6UDmkJzgW11BnzcyaIwEg2GuSHPCJYz9XoZ0cVm2xFU1Gj2DdyfnpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpwF0ezxNnJRH1EzzqXaJI767Fgm8ET3DDmGPuxhi4M=;
        b=Vj6m/fjZvoIwN42fdwYVLw+fQ7geootdrQd4Nw71ChBAy6Gt747xxduATLZ0Pn6zm7+MTU
        XTT6ndTGogwlDyCw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Force hidden visibility for all
 symbol references
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200731230820.1742553-3-keescook@chromium.org>
References: <20200731230820.1742553-3-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159741862091.3192.5315750890786366138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     e544ea57ac0734bca752eb2d8635fecbe932c356
Gitweb:        https://git.kernel.org/tip/e544ea57ac0734bca752eb2d8635fecbe932c356
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 31 Jul 2020 16:07:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:52:34 +02:00

x86/boot/compressed: Force hidden visibility for all symbol references

Eliminate all GOT entries in the decompressor binary, by forcing hidden
visibility for all symbol references, which informs the compiler that
such references will be resolved at link time without the need for
allocating GOT entries.

To ensure that no GOT entries will creep back in, add an assertion to
the decompressor linker script that will fire if the .got section has
a non-zero size.

[Arvind: move hidden.h to include/linux instead of making a copy]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200731230820.1742553-3-keescook@chromium.org
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S |  1 +
 drivers/firmware/efi/libstub/Makefile  |  2 +-
 drivers/firmware/efi/libstub/hidden.h  |  6 ------
 include/linux/hidden.h                 | 19 +++++++++++++++++++
 5 files changed, 22 insertions(+), 7 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 include/linux/hidden.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3962f59..7c687a7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -43,6 +43,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b17d218..4bcc943 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -81,6 +81,7 @@ SECTIONS
 	DISCARDS
 }
 
+ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 #ifdef CONFIG_X86_64
 ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
 #else
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 296b18f..5eefd60 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -26,7 +26,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
-				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
+				   -include $(srctree)/include/linux/hidden.h \
 				   -D__NO_FORTIFY \
 				   -ffreestanding \
 				   -fno-stack-protector \
diff --git a/drivers/firmware/efi/libstub/hidden.h b/drivers/firmware/efi/libstub/hidden.h
deleted file mode 100644
index 3493b04..0000000
--- a/drivers/firmware/efi/libstub/hidden.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * To prevent the compiler from emitting GOT-indirected (and thus absolute)
- * references to any global symbols, override their visibility as 'hidden'
- */
-#pragma GCC visibility push(hidden)
diff --git a/include/linux/hidden.h b/include/linux/hidden.h
new file mode 100644
index 0000000..49a17b6
--- /dev/null
+++ b/include/linux/hidden.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * When building position independent code with GCC using the -fPIC option,
+ * (or even the -fPIE one on older versions), it will assume that we are
+ * building a dynamic object (either a shared library or an executable) that
+ * may have symbol references that can only be resolved at load time. For a
+ * variety of reasons (ELF symbol preemption, the CoW footprint of the section
+ * that is modified by the loader), this results in all references to symbols
+ * with external linkage to go via entries in the Global Offset Table (GOT),
+ * which carries absolute addresses which need to be fixed up when the
+ * executable image is loaded at an offset which is different from its link
+ * time offset.
+ *
+ * Fortunately, there is a way to inform the compiler that such symbol
+ * references will be satisfied at link time rather than at load time, by
+ * giving them 'hidden' visibility.
+ */
+
+#pragma GCC visibility push(hidden)
