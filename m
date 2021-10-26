Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D93543B6DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhJZQTY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhJZQTP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:15 -0400
Date:   Tue, 26 Oct 2021 16:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX+ud+iilBCpj28zSkg7J95MdecEcA3JVD1DgFnRKyk=;
        b=gRHmdh2bHS1GOvxesoEQnE2ID9NMkLtPWlL0rf4lusodp00+woEQQAGeDQvJt34zvCKf1d
        Vwq7+TUlF1aQj6QClmEQ/HiwFOOZvac9aKn/UcZluzHwRApbHlLUKOirirJoFymOQ94rXl
        Jcttj2QEk7rBX6f7qbPVdGJrCRwscIXSW+FwijyKLQq9hWh/0tVG1ZvrlURfQ68EzjSwLI
        yEDwoGGDDnisgDiHb5t2neQQ1OWshpHaEy33gZU/m7QaVf+PjyG0SANpK8Yr1CV/TgeaMG
        y5hCm7b+GDMobQDJB0e5UPih0unv1ZQI74WsdjA00Yfvd4+snmZJArPtidydUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX+ud+iilBCpj28zSkg7J95MdecEcA3JVD1DgFnRKyk=;
        b=MvOd+0WS6UVVNfpnPjEoS2PQ2rmtXmindHwbbsnJowcnkrXijITpOttD+cZOGmMz4x5+Bd
        UrOoww3OiSJADjDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] signal: Add an optional check for altstack size
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-2-chang.seok.bae@intel.com>
References: <20211021225527.10184-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500916.626.2226832710660820873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1bdda24c4af64cd2d65dec5192ab624c5fee7ca0
Gitweb:        https://git.kernel.org/tip/1bdda24c4af64cd2d65dec5192ab624c5fee7ca0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:05 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:15:12 +02:00

signal: Add an optional check for altstack size

New x86 FPU features will be very large, requiring ~10k of stack in
signal handlers.  These new features require a new approach called
"dynamic features".

The kernel currently tries to ensure that altstacks are reasonably
sized. Right now, on x86, sys_sigaltstack() requires a size of >=2k.
However, that 2k is a constant. Simply raising that 2k requirement
to >10k for the new features would break existing apps which have a
compiled-in size of 2k.

Instead of universally enforcing a larger stack, prohibit a process from
using dynamic features without properly-sized altstacks. This must be
enforced in two places:

 * A dynamic feature can not be enabled without an large-enough altstack
   for each process thread.
 * Once a dynamic feature is enabled, any request to install a too-small
   altstack will be rejected

The dynamic feature enabling code must examine each thread in a
process to ensure that the altstacks are large enough. Add a new lock
(sigaltstack_lock()) to ensure that threads can not race and change
their altstack after being examined.

Add the infrastructure in form of a config option and provide empty
stubs for architectures which do not need dynamic altstack size checks.

This implementation will be fleshed out for x86 in a future patch called

  x86/arch_prctl: Add controls for dynamic XSTATE components

  [dhansen: commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-2-chang.seok.bae@intel.com
---
 arch/Kconfig           |  3 +++
 include/linux/signal.h |  6 ++++++
 kernel/signal.c        | 35 +++++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c71..af5cf30 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1288,6 +1288,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config DYNAMIC_SIGFRAME
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3f96a63..7d34105 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -464,6 +464,12 @@ int __save_altstack(stack_t __user *, unsigned long);
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
 } while (0);
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+bool sigaltstack_size_valid(size_t ss_size);
+#else
+static inline bool sigaltstack_size_valid(size_t size) { return true; }
+#endif /* !CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f..9278f52 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4151,11 +4151,29 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	return 0;
 }
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+static inline void sigaltstack_lock(void)
+	__acquires(&current->sighand->siglock)
+{
+	spin_lock_irq(&current->sighand->siglock);
+}
+
+static inline void sigaltstack_unlock(void)
+	__releases(&current->sighand->siglock)
+{
+	spin_unlock_irq(&current->sighand->siglock);
+}
+#else
+static inline void sigaltstack_lock(void) { }
+static inline void sigaltstack_unlock(void) { }
+#endif
+
 static int
 do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 		size_t min_ss_size)
 {
 	struct task_struct *t = current;
+	int ret = 0;
 
 	if (oss) {
 		memset(oss, 0, sizeof(stack_t));
@@ -4179,19 +4197,24 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 				ss_mode != 0))
 			return -EINVAL;
 
+		sigaltstack_lock();
 		if (ss_mode == SS_DISABLE) {
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
 			if (unlikely(ss_size < min_ss_size))
-				return -ENOMEM;
+				ret = -ENOMEM;
+			if (!sigaltstack_size_valid(ss_size))
+				ret = -ENOMEM;
 		}
-
-		t->sas_ss_sp = (unsigned long) ss_sp;
-		t->sas_ss_size = ss_size;
-		t->sas_ss_flags = ss_flags;
+		if (!ret) {
+			t->sas_ss_sp = (unsigned long) ss_sp;
+			t->sas_ss_size = ss_size;
+			t->sas_ss_flags = ss_flags;
+		}
+		sigaltstack_unlock();
 	}
-	return 0;
+	return ret;
 }
 
 SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
