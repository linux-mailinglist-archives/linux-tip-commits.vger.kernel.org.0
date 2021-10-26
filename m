Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440F43B6DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhJZQTV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhJZQTO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:14 -0400
Date:   Tue, 26 Oct 2021 16:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaIzDbz/Ej9c/pZuumT9/gMezsBjm6uTQ0af3MMsJK8=;
        b=m1isvMXbVaCa69iYkZjgQiMn3svYyl6jpqG9HQnzethqeswGYF/r2EXhHun3bt5K1Jp4MR
        nY2o44LfvuVvAQt49mAwpUl26Ifj9JTCvWhd6rzN3DeoEmnWfiREJM/12qJilgn3Z4CSI5
        LfYEGK2Sy1lP/uh1l5S8UeT6zGC2KqrbK+WzMg3GipgOcOj3ZdxQ9PBfQcVNEmlwNnqw5l
        Nwg5vLtngERAK2uOpZaJLS2BeCVsA9Cr6nswuZWZkZfAbIvm2fW2FmH3oWgyrt0LpSFK0G
        dJW2N1poITNa9YCnnCkHKw+T/OlB0MDlrurd0zgPo6xJzOfrVpOBojuwfwfHWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaIzDbz/Ej9c/pZuumT9/gMezsBjm6uTQ0af3MMsJK8=;
        b=zn7CxFtIEJqtKmvSi7es1KqPWKUJKa62a3VI7FrRq61jtkfL8eepycfFQTN4wgRwbP531k
        4WrTaWc/2QDTynCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/signal: Implement sigaltstack size validation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-3-chang.seok.bae@intel.com>
References: <20211021225527.10184-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500840.626.12620968359463262479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     3aac3ebea08f2d342364f827c8979ab0e1dd591e
Gitweb:        https://git.kernel.org/tip/3aac3ebea08f2d342364f827c8979ab0e1dd591e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:06 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/signal: Implement sigaltstack size validation

For historical reasons MINSIGSTKSZ is a constant which became already too
small with AVX512 support.

Add a mechanism to enforce strict checking of the sigaltstack size against
the real size of the FPU frame.

The strict check can be enabled via a config option and can also be
controlled via the kernel command line option 'strict_sas_size' independent
of the config switch.

Enabling it might break existing applications which allocate a too small
sigaltstack but 'work' because they never get a signal delivered. Though it
can be handy to filter out binaries which are not yet aware of
AT_MINSIGSTKSZ.

Also the upcoming support for dynamically enabled FPU features requires a
strict sanity check to ensure that:

   - Enabling of a dynamic feature, which changes the sigframe size fits
     into an enabled sigaltstack

   - Installing a too small sigaltstack after a dynamic feature has been
     added is not possible.

Implement the base check which is controlled by config and command line
options.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-3-chang.seok.bae@intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++-
 arch/x86/Kconfig                                | 17 ++++++++-
 arch/x86/kernel/signal.c                        | 35 ++++++++++++++++-
 3 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 43dc35f..eb9a73a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5497,6 +5497,15 @@
 	stifb=		[HW]
 			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]
 
+        strict_sas_size=
+			[X86]
+			Format: <bool>
+			Enable or disable strict sigaltstack size checks
+			against the required signal frame size which
+			depends on the supported FPU features. This can
+			be used to filter out binaries which have
+			not yet been made aware of AT_MINSIGSTKSZ.
+
 	sunrpc.min_resvport=
 	sunrpc.max_resvport=
 			[NFS,SUNRPC]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d9830e7..8584b30 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
+	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
@@ -2388,6 +2389,22 @@ config MODIFY_LDT_SYSCALL
 
 	  Saying 'N' here may make sense for embedded or server kernels.
 
+config STRICT_SIGALTSTACK_SIZE
+	bool "Enforce strict size checking for sigaltstack"
+	depends on DYNAMIC_SIGFRAME
+	help
+	  For historical reasons MINSIGSTKSZ is a constant which became
+	  already too small with AVX512 support. Add a mechanism to
+	  enforce strict checking of the sigaltstack size against the
+	  real size of the FPU frame. This option enables the check
+	  by default. It can also be controlled via the kernel command
+	  line option 'strict_sas_size' independent of this config
+	  switch. Enabling it might break existing applications which
+	  allocate a too small sigaltstack but 'work' because they
+	  never get a signal delivered.
+
+	  Say 'N' unless you want to really enforce this check.
+
 source "kernel/livepatch/Kconfig"
 
 endmenu
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 58bd070..0111a6a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/tracehook.h>
@@ -40,6 +41,7 @@
 #include <linux/compat.h>
 #include <asm/proto.h>
 #include <asm/ia32_unistd.h>
+#include <asm/fpu/xstate.h>
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
@@ -907,6 +909,39 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 	force_sig(SIGSEGV);
 }
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+#ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
+static bool strict_sigaltstack_size __ro_after_init = true;
+#else
+static bool strict_sigaltstack_size __ro_after_init = false;
+#endif
+
+static int __init strict_sas_size(char *arg)
+{
+	return kstrtobool(arg, &strict_sigaltstack_size);
+}
+__setup("strict_sas_size", strict_sas_size);
+
+/*
+ * MINSIGSTKSZ is 2048 and can't be changed despite the fact that AVX512
+ * exceeds that size already. As such programs might never use the
+ * sigaltstack they just continued to work. While always checking against
+ * the real size would be correct, this might be considered a regression.
+ *
+ * Therefore avoid the sanity check, unless enforced by kernel config or
+ * command line option.
+ */
+bool sigaltstack_size_valid(size_t ss_size)
+{
+	lockdep_assert_held(&current->sighand->siglock);
+
+	if (strict_sigaltstack_size)
+		return ss_size > get_sigframe_size();
+
+	return true;
+}
+#endif /* CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_X86_X32_ABI
 COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
