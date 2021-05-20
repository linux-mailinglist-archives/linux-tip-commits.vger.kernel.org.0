Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2803538AFE3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhETNZI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhETNZC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:02 -0400
Date:   Thu, 20 May 2021 13:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54QiIANgDwEis8LoGaQFA64egvb06YQ+llA3r3bmrc4=;
        b=nKTChZiXwG8lJ5JOcrXF3uLWMThhg59WeSYi4c+YnkyLuIe2BmmccZN91OpzmPOywAcAj/
        /1K3fbMyG41HHScwpjn4m4HQUZdH4IFx1IY1exoYUFW3xxCYcpvi0LJpKvgvcMM813VSnl
        NrgjtgKL8Xatv7/wPS6qCZicWzOaTyeL7wHeEEuNi4Z5CIWXQYDQQoiS/ebspD5zDeME+S
        /kmXjh4Aq8llHXDtKiFmNqWXlkNQFLGoUPeoMe1CdAH+xnys+Bhdrl3r7v6Z/T7b0cJLWi
        dXQv4vw1g6hiVk86RtjsOUFLMANqhf76/Bf/dV8rOKnvGYj3RNKINntivpBkZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54QiIANgDwEis8LoGaQFA64egvb06YQ+llA3r3bmrc4=;
        b=eOGCI4b1Cng31KzWSxIo74R1QUVxpEFYMAdU8hU/Xp4LElD3LUHA8PwTegow9eXpQlZXSU
        /PRA78oeIiKZGYCQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Switch to generic syscalltbl.sh
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-3-masahiroy@kernel.org>
References: <20210517073815.97426-3-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701493.29796.6340166351206707005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     6218d0f6b8dece1f2e82f0a47a0e6b8ecb631ef6
Gitweb:        https://git.kernel.org/tip/6218d0f6b8dece1f2e82f0a47a0e6b8ecb631ef6
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:10 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:58 +02:00

x86/syscalls: Switch to generic syscalltbl.sh

Many architectures duplicate similar shell scripts.

Convert x86 and UML to use scripts/syscalltbl.sh. The generic script
generates seperate headers for x86/64 and x86/x32 syscalls, while the x86
specific script coalesced them into one. Adjust the code accordingly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-3-masahiroy@kernel.org
---
 arch/x86/entry/syscall_32.c           | 12 +++++--
 arch/x86/entry/syscall_64.c           |  9 +----
 arch/x86/entry/syscall_x32.c          | 15 ++------
 arch/x86/entry/syscalls/Makefile      | 10 ++++--
 arch/x86/entry/syscalls/syscalltbl.sh | 46 +--------------------------
 arch/x86/include/asm/Kbuild           |  1 +-
 arch/x86/um/sys_call_table_32.c       |  8 +++--
 arch/x86/um/sys_call_table_64.c       |  9 +----
 8 files changed, 34 insertions(+), 76 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 86eb0d8..70bf46e 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,12 +8,18 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
+#ifdef CONFIG_IA32_EMULATION
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
+
+#define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
-#undef __SYSCALL_I386
+#undef __SYSCALL
 
-#define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) [nr] = __ia32_##sym,
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 1594ec7..82670bb 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
-#undef __SYSCALL_64
+#undef __SYSCALL
 
-#define __SYSCALL_64(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3fea8fb..6d2ef88 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,16 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym)
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#include <asm/syscalls_x32.h>
+#undef __SYSCALL
 
-#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_64.h>
-#undef __SYSCALL_X32
-#undef __SYSCALL_COMMON
-
-#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
@@ -25,5 +20,5 @@ asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	 * when the & below is removed.
 	 */
 	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
+#include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index d8c4f6c..c4bd8dd 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -10,7 +10,7 @@ syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
 
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
@@ -18,7 +18,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))' \
 		   '$(syshdr_offset_$(basetarget))'
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<, $(real-prereqs))
@@ -46,10 +46,15 @@ syshdr_pfx_unistd_64_x32 := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
+$(out)/syscalls_32.h: abis := i386
 $(out)/syscalls_32.h: $(syscall32) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_64.h: abis := common,64
 $(out)/syscalls_64.h: $(syscall64) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_x32.h: abis := common,x32
+$(out)/syscalls_x32.h: $(syscall64) $(systbl) FORCE
+	$(call if_changed,systbl)
 
 $(out)/xen-hypercalls.h: $(srctree)/scripts/xen-hypercalls.sh FORCE
 	$(call if_changed,hypercalls)
@@ -60,6 +65,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
+syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
deleted file mode 100644
index 929bde1..0000000
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-
-syscall_macro() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-
-    echo "__SYSCALL_${abi}($nr, $entry)"
-}
-
-emit() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-    local compat="$4"
-
-    if [ "$abi" != "I386" -a -n "$compat" ]; then
-	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
-	exit 1
-    fi
-
-    if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-    else
-	echo "#ifdef CONFIG_X86_32"
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-	echo "#else"
-	syscall_macro "$abi" "$nr" "$compat"
-	echo "#endif"
-    fi
-}
-
-grep '^[0-9]' "$in" | sort -n | (
-    while read nr abi name entry compat; do
-	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	emit "$abi" "$nr" "$entry" "$compat"
-    done
-) > "$out"
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index b19ec82..1e51650 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -3,6 +3,7 @@
 
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
+generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 2ed81e5..e83619c 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,11 +26,13 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 
-#undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 2e8544d..6fb75af 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,14 +36,11 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
-#undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
