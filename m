Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DC3EC876
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Aug 2021 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHOJ5v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Aug 2021 05:57:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhHOJ5v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Aug 2021 05:57:51 -0400
Date:   Sun, 15 Aug 2021 09:57:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629021440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLgbFOoro+bSQksf+y5hEo9xERUv24bcPXKULPyedVI=;
        b=PhvNpc+P3qm0o6kpNx6N132Bm/K//Wz+wOGiozhbaZAb6VJiqO+QtdL4LBWP+6hEa6ND8+
        WwpArWqThbUnU0YBjYbVJcJKmNjzSUWYd2jT/l/oMb6ustAPNMfj8dlp1ZNb40czZbTuy4
        PI0YCpLsV/YdoJLQAeYLbNgA7Au8peJg8YDQNHbnykRBcM/zdf4kZBCuVAwiwNsBIDNi0y
        WWO6l4NqniJaWGfJlAo53DrIkewgx1BV42MfZN9kVV/gjgrEwTpMJETOFPKyOj80nVZgWr
        9UFTzfCqNlKflaLovcMi+kb8ywQ94lzIIMB/ThCi1wtD1Ht4UfqJocNB06czlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629021440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLgbFOoro+bSQksf+y5hEo9xERUv24bcPXKULPyedVI=;
        b=SuyaP481S2WOuEWlL1J5qW1Xqmp6azGISJ2uEhG5OIB/rNVCHPkffK8mkCJQAxWsPMSGnX
        P+cZHFXOC+CEYTBQ==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove stale cc-option checks
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210812183848.1519994-1-ndesaulniers@google.com>
References: <20210812183848.1519994-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <162902143957.395.7404280890417854945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     1463c2a27d59c69358ad1cbd869d3a8649695d8c
Gitweb:        https://git.kernel.org/tip/1463c2a27d59c69358ad1cbd869d3a8649695d8c
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Thu, 12 Aug 2021 11:38:48 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 15 Aug 2021 10:32:52 +02:00

x86/build: Remove stale cc-option checks

cc-option, __cc-option, cc-option-yn, and cc-disable-warning all invoke
the compiler during build time, and can slow down the build when these
checks become stale for our supported compilers, whose minimally
supported versions increases over time.

See Documentation/process/changes.rst for the current supported minimal
versions (GCC 4.9+, clang 10.0.1+). Compiler version support for these
flags may be verified on godbolt.org.

The following flags are supported by all supported versions of GCC and
Clang. Remove their cc-option, __cc-option, and cc-option-yn tests.

  -Wno-address-of-packed-member
  -mno-avx
  -m32
  -mno-80387
  -march=k8
  -march=nocona
  -march=core2
  -march=atom
  -mtune=generic
  -mfentry

-mpreferred-stack-boundary= is specific to GCC, while -mstack-alignment=
is specific to Clang. Rather than test for this three times via
cc-option and __cc-option, rely on CONFIG_CC_IS_* from Kconfig.

GCC did not support values less than 4 for -mpreferred-stack-boundary=
until GCC 7+. Change the cc-option test to check for a value of 2,
rather than 4.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1436
Link: https://lkml.kernel.org/r/20210812183848.1519994-1-ndesaulniers@google.com
---
 arch/x86/Makefile | 53 ++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307fd00..0d33ba0 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,10 +14,13 @@ endif
 
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+ifdef CONFIG_CC_IS_GCC
+ifneq ($(call cc-option, -mpreferred-stack-boundary=2),)
       cc_stack_align4 := -mpreferred-stack-boundary=2
       cc_stack_align8 := -mpreferred-stack-boundary=3
-else ifneq ($(call cc-option, -mstack-alignment=16),)
+endif
+endif
+ifdef CONFIG_CC_IS_CLANG
       cc_stack_align4 := -mstack-alignment=4
       cc_stack_align8 := -mstack-alignment=8
 endif
@@ -31,8 +34,8 @@ REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 
 REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
+REALMODE_CFLAGS += -Wno-address-of-packed-member
+REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
 export REALMODE_CFLAGS
 
@@ -48,8 +51,7 @@ export BITS
 #
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
 #
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
+KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
 # Intel CET isn't enabled in the kernel
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
@@ -59,9 +61,8 @@ ifeq ($(CONFIG_X86_32),y)
         UTS_MACHINE := i386
         CHECKFLAGS += -D__i386__
 
-        biarch := $(call cc-option,-m32)
-        KBUILD_AFLAGS += $(biarch)
-        KBUILD_CFLAGS += $(biarch)
+        KBUILD_AFLAGS += -m32
+        KBUILD_CFLAGS += -m32
 
         KBUILD_CFLAGS += -msoft-float -mregparm=3 -freg-struct-return
 
@@ -72,7 +73,7 @@ ifeq ($(CONFIG_X86_32),y)
         # Align the stack to the register width instead of using the default
         # alignment of 16 bytes. This reduces stack usage and the number of
         # alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
+        KBUILD_CFLAGS += $(cc_stack_align4)
 
         # CPU-specific tuning. Anything which can be shared with UML should go here.
         include arch/x86/Makefile_32.cpu
@@ -93,7 +94,6 @@ else
         UTS_MACHINE := x86_64
         CHECKFLAGS += -D__x86_64__
 
-        biarch := -m64
         KBUILD_AFLAGS += -m64
         KBUILD_CFLAGS += -m64
 
@@ -104,7 +104,7 @@ else
         KBUILD_CFLAGS += $(call cc-option,-falign-loops=1)
 
         # Don't autogenerate traditional x87 instructions
-        KBUILD_CFLAGS += $(call cc-option,-mno-80387)
+        KBUILD_CFLAGS += -mno-80387
         KBUILD_CFLAGS += $(call cc-option,-mno-fp-ret-in-387)
 
         # By default gcc and clang use a stack alignment of 16 bytes for x86.
@@ -114,20 +114,17 @@ else
         # default alignment which keep the stack *mis*aligned.
         # Furthermore an alignment to the register width reduces stack usage
         # and the number of alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))
+        KBUILD_CFLAGS += $(cc_stack_align8)
 
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
         # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
-        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
-
-        cflags-$(CONFIG_MCORE2) += \
-                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
-	cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
-		$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
-        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
+        cflags-$(CONFIG_MK8)		+= -march=k8
+        cflags-$(CONFIG_MPSC)		+= -march=nocona
+        cflags-$(CONFIG_MCORE2)		+= -march=core2
+        cflags-$(CONFIG_MATOM)		+= -march=atom
+        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
@@ -158,18 +155,6 @@ export CONFIG_X86_X32_ABI
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
   ifndef CONFIG_HAVE_FENTRY
 	ACCUMULATE_OUTGOING_ARGS := 1
-  else
-    ifeq ($(call cc-option-yn, -mfentry), n)
-	ACCUMULATE_OUTGOING_ARGS := 1
-
-	# GCC ignores '-maccumulate-outgoing-args' when used with '-Os'.
-	# If '-Os' is enabled, disable it and print a warning.
-        ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-          undefine CONFIG_CC_OPTIMIZE_FOR_SIZE
-          $(warning Disabling CONFIG_CC_OPTIMIZE_FOR_SIZE.  Your compiler does not have -mfentry so you cannot optimize for size with CONFIG_FUNCTION_GRAPH_TRACER.)
-        endif
-
-    endif
   endif
 endif
 
@@ -193,7 +178,7 @@ ifdef CONFIG_RETPOLINE
   # only been fixed starting from gcc stable version 8.4.0 and
   # onwards, but not for older ones. See gcc bug #86952.
   ifndef CONFIG_CC_IS_CLANG
-    KBUILD_CFLAGS += $(call cc-option,-fno-jump-tables)
+    KBUILD_CFLAGS += -fno-jump-tables
   endif
 endif
 
