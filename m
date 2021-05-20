Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E438AFDD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhETNZG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhETNZA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E489C061760;
        Thu, 20 May 2021 06:23:37 -0700 (PDT)
Date:   Thu, 20 May 2021 13:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqqFte3ZXTFPVX8GrVI6a4OF0oujtuBcqt4W0/VS44U=;
        b=rOq6IRwPJbjnn1/fKQG9hpGVPBNhiH6pLzPDG84FHPNIS01E7hMtt8H1xWzBrKOfGc+wEc
        NWRzuljI//Lhph0UN1oDbqtgoNjU3Lv5ltciWl8+8Gvh+jo8p8wKyEbkNmS5mPJqp4GBOU
        R/TF3Nm+1YOevagU8jdlIADTIdK3ad4GZV2inn7Db6lyQXz7vDyuU+VAaLiaKGbvyrgnAV
        sv7Rf06eaqGDiphKoosDt2aJYRpg5oQzyp0KZF9+/y+fjos0yivjnNUEnliXERtiPZDK7P
        XP1JRXXiBCl1Q8GjurmQRL0HiXNLXpErcOoQVEoowfUPaZvGAbyo39jiVNILBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqqFte3ZXTFPVX8GrVI6a4OF0oujtuBcqt4W0/VS44U=;
        b=pqypgWCIpsVzbXMXRPBehw3uc7xAiqxPLJMQ3sHBLz+TnpFq784ze9qK+vAHabVUhRz8jh
        PEYUfYR9psfRJ7AQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Use __NR_syscalls instead of __NR_syscall_max
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-6-masahiroy@kernel.org>
References: <20210517073815.97426-6-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701347.29796.10604327250110012936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     49f731f1972e6e44d8a5c3982a72902b3944bc34
Gitweb:        https://git.kernel.org/tip/49f731f1972e6e44d8a5c3982a72902b3944bc34
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:13 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:59 +02:00

x86/syscalls: Use __NR_syscalls instead of __NR_syscall_max

__NR_syscall_max is only used by x86 and UML. In contrast, __NR_syscalls is
widely used by all the architectures.

Convert __NR_syscall_max to __NR_syscalls and adjust the usage sites.

This prepares x86 to switch to the generic syscallhdr.sh script.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-6-masahiroy@kernel.org

---
 arch/um/kernel/skas/syscall.c         | 2 +-
 arch/x86/entry/syscalls/syscallhdr.sh | 2 +-
 arch/x86/include/asm/unistd.h         | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 3d91f89..9ee19e5 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -41,7 +41,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-	if (syscall >= 0 && syscall <= __NR_syscall_max)
+	if (syscall >= 0 && syscall < __NR_syscalls)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
index cc1e638..75e66af 100644
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ b/arch/x86/entry/syscalls/syscallhdr.sh
@@ -28,7 +28,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
     echo ""
     echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscall_max $max"
+    echo "#define __NR_${prefix}syscalls $(($max + 1))"
     echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 1bc6020..80e9d52 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -13,7 +13,7 @@
 #  define __ARCH_WANT_SYS_OLD_MMAP
 #  define __ARCH_WANT_SYS_OLD_SELECT
 
-#  define __NR_ia32_syscall_max __NR_syscall_max
+#  define IA32_NR_syscalls (__NR_syscalls)
 
 # else
 
@@ -26,12 +26,12 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
-#  define X32_NR_syscalls (__NR_x32_syscall_max + 1)
+#  define X32_NR_syscalls (__NR_x32_syscalls)
+#  define IA32_NR_syscalls (__NR_ia32_syscalls)
 
 # endif
 
-# define NR_syscalls (__NR_syscall_max + 1)
-# define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
+# define NR_syscalls (__NR_syscalls)
 
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
