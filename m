Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17E38AFDA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhETNZG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbhETNZA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:00 -0400
Date:   Thu, 20 May 2021 13:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GssaVVUB4tuTbEPEKGgdCgNUa/KlV/HoQKp+tjn3Lo0=;
        b=Hzp0bq5fVSpUlCEQWciW+XxxJ/YiOw+1GpmnChnGO18fDZfqM4EYQ79eLRaJs2I7gXTazU
        m4SXHiOiDHmQEwGbT7Tp7hzrNNJlxCex0q90jLa9kK1Cdi10MTb+3Xg5FSkid6WAX+b9dQ
        vO7NCCeWL+0SLD0Yx0czucjgVfA1GviOephSR+r4qNzfHk/Mx36/uJAYbLkkhCEAS4E5l7
        AQ8K2l1OYMYjlG8pHgif2r8Fzx2sbiCah61HS+fuflru+i4BUea0vEfx/1GlpskC8UFkR5
        8r+XmBIEWw1npXuXCjut//xPgFLH33p7K1uei3bhTCbeXLh0xnwW896tgP2jhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GssaVVUB4tuTbEPEKGgdCgNUa/KlV/HoQKp+tjn3Lo0=;
        b=id+eoWKV7sPOf99YUoYEoo8OGSotvOsVAqVsu5eJ7ts6fZftV88du0Fk1IT2YxMVgmfXpk
        KYkcAV0owZ045cDw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Stop filling syscall arrays with
 *_sys_ni_syscall
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-4-masahiroy@kernel.org>
References: <20210517073815.97426-4-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701446.29796.8206013974735746602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     44fe4895f47cbe9f4692e1d3cdc2ef8352f4d88e
Gitweb:        https://git.kernel.org/tip/44fe4895f47cbe9f4692e1d3cdc2ef8352f4d88e
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:11 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:59 +02:00

x86/syscalls: Stop filling syscall arrays with *_sys_ni_syscall

This is a follow-up cleanup after switching to the generic syscalltbl.sh.

The old x86 specific script skipped non-existing syscalls. So, the
generated syscalls_64.h, for example, had a big hole in the syscall numbers
335-423 range. That is why there exists [0 ... __NR_*_syscall_max] =
&__*_sys_ni_cyscall.

The new script, scripts/syscalltbl.sh automatically fills holes
with __SYSCALL(<nr>, sys_ni_syscall), hence such ugly code can
go away. The designated initializers, '[nr] =' are also unneeded.

Also, there is no need to give __NR_*_syscall_max+1 because the array
size is implied by the number of syscalls in the generated headers.
Hence, there is no need to include <asm/unistd.h>, either.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-4-masahiroy@kernel.org

---
 arch/x86/entry/syscall_32.c     | 10 ++--------
 arch/x86/entry/syscall_64.c     | 10 ++--------
 arch/x86/entry/syscall_x32.c    | 10 ++--------
 arch/x86/um/sys_call_table_32.c |  6 ------
 arch/x86/um/sys_call_table_64.c |  6 ------
 5 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 70bf46e..8cfc9bc 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -5,7 +5,6 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -19,13 +18,8 @@
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) __ia32_##sym,
 
-__visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_ia32_syscall_max] = &__ia32_sys_ni_syscall,
+__visible const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 82670bb..be120ee 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -5,20 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
+asmlinkage const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 6d2ef88..bdd0e03 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -5,20 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
+asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
 #include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index e83619c..f832310 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -37,11 +36,6 @@
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 6fb75af..5ed665d 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -45,11 +44,6 @@
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
 
