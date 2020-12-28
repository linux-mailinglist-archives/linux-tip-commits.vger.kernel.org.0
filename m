Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5C2E372A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Dec 2020 13:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgL1Mok (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Dec 2020 07:44:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50834 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1Mok (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Dec 2020 07:44:40 -0500
Date:   Mon, 28 Dec 2020 12:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609159437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI5Ejg0c9pPA0nRy89EGfL2mTFil+KVlTZjDL4PqgyI=;
        b=e5Nkxk2e1rX7M+dDhrXoXERfNEDe7jYRML/k2LAgSRjc2czvPpHCctqkroic7Sg9dNY3bl
        1QLZTNwQyOs+i/rfP5uhjQ6oO0FQl3HfbExJqu2v0mvHudUW9MRjGt6N1qkD2P4ARss15o
        EgJWt3sY4Uwm5KLbU16Gl7mQB50b7riwbiU+qXm4anE5k4mxjfgsSuXw46AXnuNsJI0mKb
        VvUzA+VaN+F+F/Rahk5i0ErgNkoqfuelMNaJjoW7NjJ2ArNctE82hqRdL51h+CiLg6X89O
        vS5Oe58u1jkGS81VVBNqvp3a4QqIf1IFYiwr5VJ1AWOEtz0nhbUIHX3liA8A+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609159437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI5Ejg0c9pPA0nRy89EGfL2mTFil+KVlTZjDL4PqgyI=;
        b=QslU7CoSkegyU+blU7ZogeKI5RUyUawNzH2b0FMYNOBf8V16KCgGxW/MoNISsixZ7CsP/E
        ECGTze6tb01Py5DQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] fanotify: Fix sys_fanotify_mark() on native x86-32
Cc:     pawel@jasiak.xyz, Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@suse.de>, Jan Kara <jack@suse.cz>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130223059.101286-1-brgerst@gmail.com>
References: <20201130223059.101286-1-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <160915943610.414.834531552346912074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2ca408d9c749c32288bc28725f9f12ba30299e8f
Gitweb:        https://git.kernel.org/tip/2ca408d9c749c32288bc28725f9f12ba302=
99e8f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 30 Nov 2020 17:30:59 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 28 Dec 2020 11:58:59 +01:00

fanotify: Fix sys_fanotify_mark() on native x86-32

Commit

  121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking=
 64-bit arguments")

converted native x86-32 which take 64-bit arguments to use the
compat handlers to allow conversion to passing args via pt_regs.
sys_fanotify_mark() was however missed, as it has a general compat
handler. Add a config option that will use the syscall wrapper that
takes the split args for native 32-bit.

 [ bp: Fix typo in Kconfig help text. ]

Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls t=
aking 64-bit arguments")
Reported-by: Pawe=C5=82 Jasiak <pawel@jasiak.xyz>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jan Kara <jack@suse.cz>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20201130223059.101286-1-brgerst@gmail.com
---
 arch/Kconfig                       |  6 ++++++
 arch/x86/Kconfig                   |  1 +
 fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
 include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 78c6f05..24862d1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1105,6 +1105,12 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
=20
+config ARCH_SPLIT_ARG64
+	bool
+	help
+	   If a 32-bit architecture requires 64-bit arguments to be split into
+	   pairs of 32-bit arguments, select this option.
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10..21f8511 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -19,6 +19,7 @@ config X86_32
 	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
+	select ARCH_SPLIT_ARG64
=20
 config X86_64
 	def_bool y
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify=
_user.c
index 3e01d8f..dcab112 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1285,26 +1285,23 @@ fput_and_out:
 	return ret;
 }
=20
+#ifndef CONFIG_ARCH_SPLIT_ARG64
 SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 			      __u64, mask, int, dfd,
 			      const char  __user *, pathname)
 {
 	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
 }
+#endif
=20
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(fanotify_mark,
+#if defined(CONFIG_ARCH_SPLIT_ARG64) || defined(CONFIG_COMPAT)
+SYSCALL32_DEFINE6(fanotify_mark,
 				int, fanotify_fd, unsigned int, flags,
-				__u32, mask0, __u32, mask1, int, dfd,
+				SC_ARG64(mask), int, dfd,
 				const char  __user *, pathname)
 {
-	return do_fanotify_mark(fanotify_fd, flags,
-#ifdef __BIG_ENDIAN
-				((__u64)mask0 << 32) | mask1,
-#else
-				((__u64)mask1 << 32) | mask0,
-#endif
-				 dfd, pathname);
+	return do_fanotify_mark(fanotify_fd, flags, SC_VAL64(__u64, mask),
+				dfd, pathname);
 }
 #endif
=20
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f3929af..7688bc9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -251,6 +251,30 @@ static inline int is_syscall_trace_event(struct trace_ev=
ent_call *tp_event)
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* __SYSCALL_DEFINEx */
=20
+/* For split 64-bit arguments on 32-bit architectures */
+#ifdef __LITTLE_ENDIAN
+#define SC_ARG64(name) u32, name##_lo, u32, name##_hi
+#else
+#define SC_ARG64(name) u32, name##_hi, u32, name##_lo
+#endif
+#define SC_VAL64(type, name) ((type) name##_hi << 32 | name##_lo)
+
+#ifdef CONFIG_COMPAT
+#define SYSCALL32_DEFINE1 COMPAT_SYSCALL_DEFINE1
+#define SYSCALL32_DEFINE2 COMPAT_SYSCALL_DEFINE2
+#define SYSCALL32_DEFINE3 COMPAT_SYSCALL_DEFINE3
+#define SYSCALL32_DEFINE4 COMPAT_SYSCALL_DEFINE4
+#define SYSCALL32_DEFINE5 COMPAT_SYSCALL_DEFINE5
+#define SYSCALL32_DEFINE6 COMPAT_SYSCALL_DEFINE6
+#else
+#define SYSCALL32_DEFINE1 SYSCALL_DEFINE1
+#define SYSCALL32_DEFINE2 SYSCALL_DEFINE2
+#define SYSCALL32_DEFINE3 SYSCALL_DEFINE3
+#define SYSCALL32_DEFINE4 SYSCALL_DEFINE4
+#define SYSCALL32_DEFINE5 SYSCALL_DEFINE5
+#define SYSCALL32_DEFINE6 SYSCALL_DEFINE6
+#endif
+
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
  * address limit different than USER_DS can allow to overwrite kernel memory.
