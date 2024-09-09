Return-Path: <linux-tip-commits+bounces-2227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C597208E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0691C23A07
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E55187FF9;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djHAei8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4JtOIgt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AA17CA04;
	Mon,  9 Sep 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902869; cv=none; b=r/5xzjVkNVS1JnUwY6hSMlnaWPwaTSoOha2XLRRz39vg2HKEOAO8VYt6kukmGZYT49BIfTdrJ+o9O5H8Jxc6yHkayy50BU4yKjXFd3T6vMsGXMK/TKEIdgZmDtzklfXzrK7h2xsSZEf9k9qq9yFP/letWG93eFjXYO+UAjse5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902869; c=relaxed/simple;
	bh=OQ4IBAFA7xr9WdhepaEMxi5vOQlZFF48v2uwnWPixeQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hz6M2QgbESZVoeuIdaTzDcopbFY4kPYLSeFwjwBHTLHamSoGihuotoHjlxvFEtbdW+aUl5I3j7Z3LkVvBqL2k8Z2GBb/r36HNm7s9aqU1yzLFj07OBID0b9Egb+CsvsAAbuGQl01lsDqb+dvhxrZODAEl/GznN0gKhPgiQd3FFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djHAei8a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4JtOIgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6jwdBkaWTCZsqq+9GZSV/UKLFIZOkXmCUtuoXUk5lg=;
	b=djHAei8agSsVG6rUBH6nUoQALXzYu9ZqjoMLy/oN4Jwjt90Vd2Z5Er/iBFteN4sz1isKtG
	bLjohFzqOZjYvRrDjrRdcbPlO4GaLK+It/3l7aeB7k2KnJN6RYh/nBoFZ9LyZUkBZqm371
	106Z45lNAM4BsrNaMdjh93vollywdcvJkwcmXKsci+xNSarhrugc96sO7UIPyWjg/pNUIG
	j+e6POO2vYHgPvIsciJfsnPby9IQK/4CuZsVEgLLI/HzJdMfhXSdADMbIE+r3mdkSYOot9
	aL2nuKPtXobyzGBExEzFdPn7BBkQXBQ8T+tp8Ik9kwEtpaZJRSaIlxRxMMPpNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6jwdBkaWTCZsqq+9GZSV/UKLFIZOkXmCUtuoXUk5lg=;
	b=h4JtOIgt7YfaZOjMyAE21N9fgaqAGmk8xURfbd4DDhCPzNBAmpsIbtTnJcNho5sx/Iofl2
	r8ozKvOYlKzeJQAQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: Implement legacy printer kthread for PREEMPT_RT
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-16-john.ogness@linutronix.de>
References: <20240904120536.115780-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286245.2215.16632429320217987842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     5f53ca3ff83b4f2f3ff360bb22bba7a9a3af71a3
Gitweb:        https://git.kernel.org/tip/5f53ca3ff83b4f2f3ff360bb22bba7a9a3af71a3
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:34 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:33 +02:00

printk: Implement legacy printer kthread for PREEMPT_RT

The write() callback of legacy consoles usually makes use of
spinlocks. This is not permitted with PREEMPT_RT in atomic
contexts.

For PREEMPT_RT, create a new kthread to handle printing of all
the legacy consoles (and nbcon consoles if boot consoles are
registered). This allows legacy consoles to work on PREEMPT_RT
without requiring modification. (However they will not have
the reliability properties guaranteed by nbcon atomic
consoles.)

Use the existing printk_kthreads_check_locked() to start/stop
the legacy kthread as needed.

Introduce the macro force_legacy_kthread() to query if the
forced threading of legacy consoles is in effect. Although
currently only enabled for PREEMPT_RT, this acts as a simple
mechanism for the future to allow other preemption models to
easily take advantage of the non-interference property provided
by the legacy kthread.

When force_legacy_kthread() is true, the legacy kthread
fulfills the role of the console_flush_type @legacy_offload by
waking the legacy kthread instead of printing via the
console_lock in the irq_work. If the legacy kthread is not
yet available, no legacy printing takes place (unless in
panic).

If for some reason the legacy kthread fails to create, any
legacy consoles are unregistered. With force_legacy_kthread(),
the legacy kthread is a critical component for legacy consoles.

These changes only affect CONFIG_PREEMPT_RT.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-16-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h    |  16 +++-
 kernel/printk/printk.c      | 157 +++++++++++++++++++++++++++++++----
 kernel/printk/printk_safe.c |   4 +-
 3 files changed, 159 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c365d25..3fcb485 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -21,6 +21,19 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 		(con->flags & CON_BOOT) ? "boot" : "",		\
 		con->name, con->index, ##__VA_ARGS__)
 
+/*
+ * Identify if legacy printing is forced in a dedicated kthread. If
+ * true, all printing via console lock occurs within a dedicated
+ * legacy printer thread. The only exception is on panic, after the
+ * nbcon consoles have had their chance to print the panic messages
+ * first.
+ */
+#ifdef CONFIG_PREEMPT_RT
+# define force_legacy_kthread()	(true)
+#else
+# define force_legacy_kthread()	(false)
+#endif
+
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -173,6 +186,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline void defer_console_output(void) { }
 static inline bool is_printk_legacy_deferred(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
@@ -200,7 +214,7 @@ extern bool legacy_allow_panic_sync;
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
  * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
- * @legacy_offload:	Offload the legacy loop into IRQ
+ * @legacy_offload:	Offload the legacy loop into IRQ or legacy thread
  *
  * Note that the legacy loop also flushes the nbcon consoles.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c27dc54..66cfe7b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -491,6 +491,7 @@ bool legacy_allow_panic_sync;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
@@ -2756,6 +2757,8 @@ void resume_console(void)
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
+	if (ft.legacy_offload)
+		defer_console_output();
 
 	pr_flush(1000, true);
 }
@@ -3166,19 +3169,7 @@ abandon:
 	return false;
 }
 
-/**
- * console_unlock - unblock the console subsystem from printing
- *
- * Releases the console_lock which the caller holds to block printing of
- * the console subsystem.
- *
- * While the console_lock was held, console output may have been buffered
- * by printk().  If this is the case, console_unlock(); emits
- * the output prior to releasing the lock.
- *
- * console_unlock(); may be called from any context.
- */
-void console_unlock(void)
+static void __console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
 	bool handover;
@@ -3222,6 +3213,29 @@ void console_unlock(void)
 		 */
 	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
 }
+
+/**
+ * console_unlock - unblock the legacy console subsystem from printing
+ *
+ * Releases the console_lock which the caller holds to block printing of
+ * the legacy console subsystem.
+ *
+ * While the console_lock was held, console output may have been buffered
+ * by printk(). If this is the case, console_unlock() emits the output on
+ * legacy consoles prior to releasing the lock.
+ *
+ * console_unlock(); may be called from any context.
+ */
+void console_unlock(void)
+{
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct)
+		__console_flush_and_unlock();
+	else
+		__console_unlock();
+}
 EXPORT_SYMBOL(console_unlock);
 
 /**
@@ -3449,6 +3463,8 @@ void console_start(struct console *console)
 	printk_get_console_flush_type(&ft);
 	if (is_nbcon && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
+	else if (ft.legacy_offload)
+		defer_console_output();
 
 	__pr_flush(console, 1000, true);
 }
@@ -3460,6 +3476,88 @@ static int unregister_console_locked(struct console *console);
 /* True when system boot is far enough to create printer threads. */
 static bool printk_kthreads_ready __ro_after_init;
 
+static struct task_struct *printk_legacy_kthread;
+
+static bool legacy_kthread_should_wakeup(void)
+{
+	struct console_flush_type ft;
+	struct console *con;
+	bool ret = false;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	printk_get_console_flush_type(&ft);
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
+		u64 printk_seq;
+
+		/*
+		 * The legacy printer thread is only responsible for nbcon
+		 * consoles when the nbcon consoles cannot print via their
+		 * atomic or threaded flushing.
+		 */
+		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+			continue;
+
+		if (!console_is_usable(con, flags, false))
+			continue;
+
+		if (flags & CON_NBCON) {
+			printk_seq = nbcon_seq_read(con);
+		} else {
+			/*
+			 * It is safe to read @seq because only this
+			 * thread context updates @seq.
+			 */
+			printk_seq = con->seq;
+		}
+
+		if (prb_read_valid(prb, printk_seq, NULL)) {
+			ret = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+
+	return ret;
+}
+
+static int legacy_kthread_func(void *unused)
+{
+	for (;;) {
+		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+
+		if (kthread_should_stop())
+			break;
+
+		console_lock();
+		__console_flush_and_unlock();
+	}
+
+	return 0;
+}
+
+static bool legacy_kthread_create(void)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_console_list_lock_held();
+
+	kt = kthread_run(legacy_kthread_func, NULL, "pr/legacy");
+	if (WARN_ON(IS_ERR(kt))) {
+		pr_err("failed to start legacy printing thread\n");
+		return false;
+	}
+
+	printk_legacy_kthread = kt;
+
+	return true;
+}
+
 /**
  * printk_kthreads_shutdown - shutdown all threaded printers
  *
@@ -3509,6 +3607,27 @@ static void printk_kthreads_check_locked(void)
 	if (!printk_kthreads_ready)
 		return;
 
+	if (have_legacy_console || have_boot_console) {
+		if (!printk_legacy_kthread &&
+		    force_legacy_kthread() &&
+		    !legacy_kthread_create()) {
+			/*
+			 * All legacy consoles must be unregistered. If there
+			 * are any nbcon consoles, they will set up their own
+			 * kthread.
+			 */
+			hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+				if (con->flags & CON_NBCON)
+					continue;
+
+				unregister_console_locked(con);
+			}
+		}
+	} else if (printk_legacy_kthread) {
+		kthread_stop(printk_legacy_kthread);
+		printk_legacy_kthread = NULL;
+	}
+
 	/*
 	 * Printer threads cannot be started as long as any boot console is
 	 * registered because there is no way to synchronize the hardware
@@ -4285,9 +4404,13 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+		if (force_legacy_kthread()) {
+			if (printk_legacy_kthread)
+				wake_up_interruptible(&legacy_wait);
+		} else {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -4702,6 +4825,8 @@ void console_try_replay_all(void)
 			nbcon_atomic_flush_pending();
 		if (ft.nbcon_offload)
 			nbcon_kthreads_wake();
+		if (ft.legacy_offload)
+			defer_console_output();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 86439fd..2b35a9d 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -44,7 +44,9 @@ bool is_printk_legacy_deferred(void)
 	 * The per-CPU variable @printk_context can be read safely in any
 	 * context. CPU migration is always disabled when set.
 	 */
-	return (this_cpu_read(printk_context) || in_nmi());
+	return (force_legacy_kthread() ||
+		this_cpu_read(printk_context) ||
+		in_nmi());
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)

