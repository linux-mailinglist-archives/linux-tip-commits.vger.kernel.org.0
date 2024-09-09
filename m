Return-Path: <linux-tip-commits+bounces-2242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE009720BA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FF41C23A93
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413EF18A6B6;
	Mon,  9 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XOJx1mQj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0CYwkK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204971891B8;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902875; cv=none; b=fR10AMKXGM8a1pLLrr2W2u0zaOqWCwiQxPhI4qgUe9rykZZ7me0r3HEHOmTbUgwWa8ggXBwIvuDaoH68YbwWfU+D+lRdxvwrek7BdrXlqkQfTkZIeHuetnHAw/TFQiToLw1t6lZ9W1Vnu9sVuckQisfYv/KucYYYCEllq5XTyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902875; c=relaxed/simple;
	bh=cvpuLW7pFci7xl46WsuH9WMpr1g5vNt0hLpM798xAE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VTe341dtYuZdwFdmAogkM32RTCi22u/B+kTZqkCo8iakecPAe+VqzCsdDy5LXKZW2zKa5vWeQedtu3LkSpXxRevkVVMi/XL+NE+NTrZONPKhiEhaQYMMioM318T3KkWyOzXPyQlncJ1LUqHJsXWwQsTE9REtvJhnoX7dHmUXeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XOJx1mQj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0CYwkK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krUAAJiDok9bKZ4axUmxdVZB617tAx5dwrKY5j/woVg=;
	b=XOJx1mQjB28qHe4tiJBm5FGO8MBTUH+Zb1GmQXroLXSMng0++aw3CnPePzqK6cwjtgFZ0W
	PjWBQEc5di2fsxtF2TdAamyib/W0awtMhUmsMGAh01K4xUAlNr1QPNIJOlu67xci+a+CvM
	km/PsHyJk3wUwz5PBhchn8k8Xb6HfiuyQR65fy8u8L5TF3bgi8SAQafYlvdT8UnuOXyfgq
	LClxN6OiqVgeosdUqV2LzUl87gi++Em1G7BHNoMPwss52Yq5BV85oyMM74yPcgNfsFzcWD
	uIrJFKjJ55hF0xJPpsVooYm9Bg29RqEmLyd/eo6WZfgmwdE6c0pnMOb1BTJP7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krUAAJiDok9bKZ4axUmxdVZB617tAx5dwrKY5j/woVg=;
	b=Q0CYwkK3MgierehKeRRRsAtsHgiUiM3TtFdBHrdKx/SYtKzyRI1wQiKowNjyd/g42J4quY
	Fh4yO8CoPiIdvkCA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Add helper for flush type logic
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-31-john.ogness@linutronix.de>
References: <20240820063001.36405-31-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286986.2215.14603001390146123290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     6690d6b52726bcb2b743466a1833e0b9f049b9d7
Gitweb:        https://git.kernel.org/tip/6690d6b52726bcb2b743466a1833e0b9f04=
9b9d7
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:56 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:49 +02:00

printk: Add helper for flush type logic

There are many call sites where console flushing occur.
Depending on the system state and types of consoles, the flush
methods to use are different. A flush call site generally must
consider:

	@have_boot_console
	@have_nbcon_console
	@have_legacy_console
	@legacy_allow_panic_sync
	is_printk_preferred()

and take into account the current CPU state:

	NBCON_PRIO_NORMAL
	NBCON_PRIO_EMERGENCY
	NBCON_PRIO_PANIC

in order to decide if it should:

	flush nbcon directly via atomic_write() callback
	flush legacy directly via console_unlock
	flush legacy via offload to irq_work

All of these call sites use their own logic to make this
decision, which is complicated and error prone. Especially
later when two more flush methods will be introduced:

	flush nbcon via offload to kthread
	flush legacy via offload to kthread

Introduce a new internal struct console_flush_type that specifies
which console flushing methods should be used in the context of
the caller.

Introduce a helper function to fill out console_flush_type to
be used for flushing call sites.

Replace the logic of all flushing call sites to use the new
helper.

This change standardizes behavior, leading to both fixes and
optimizations across various call sites. For instance, in
console_cpu_notify(), the new logic ensures that nbcon consoles
are flushed when they aren=E2=80=99t managed by the legacy loop.
Similarly, in console_flush_on_panic(), the system no longer
needs to flush nbcon consoles if none are present.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-31-john.ogness@linutroni=
x.de
[pmladek@suse.com: Updated the commit message.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 73 +++++++++++++++++++++++++++++++++++++++-
 kernel/printk/nbcon.c    | 12 ++++--
 kernel/printk/printk.c   | 68 +++++++++++++++---------------------
 3 files changed, 112 insertions(+), 41 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6b61350..ba2e0f1 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -154,8 +154,81 @@ static inline bool console_is_usable(struct console *con=
, short flags) { return=20
 #endif /* CONFIG_PRINTK */
=20
 extern bool have_boot_console;
+extern bool have_nbcon_console;
+extern bool have_legacy_console;
 extern bool legacy_allow_panic_sync;
=20
+/**
+ * struct console_flush_type - Define available console flush methods
+ * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @legacy_direct:	Call the legacy loop in this context
+ * @legacy_offload:	Offload the legacy loop into IRQ
+ *
+ * Note that the legacy loop also flushes the nbcon consoles.
+ */
+struct console_flush_type {
+	bool	nbcon_atomic;
+	bool	legacy_direct;
+	bool	legacy_offload;
+};
+
+/*
+ * Identify which console flushing methods should be used in the context of
+ * the caller.
+ */
+static inline void printk_get_console_flush_type(struct console_flush_type *=
ft)
+{
+	memset(ft, 0, sizeof(*ft));
+
+	switch (nbcon_get_default_prio()) {
+	case NBCON_PRIO_NORMAL:
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic =3D true;
+
+		/* Legacy consoles are flushed directly when possible. */
+		if (have_legacy_console || have_boot_console) {
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct =3D true;
+			else
+				ft->legacy_offload =3D true;
+		}
+		break;
+
+	case NBCON_PRIO_PANIC:
+		/*
+		 * In panic, the nbcon consoles will directly print. But
+		 * only allowed if there are no boot consoles.
+		 */
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic =3D true;
+
+		if (have_legacy_console || have_boot_console) {
+			/*
+			 * This is the same decision as NBCON_PRIO_NORMAL
+			 * except that offloading never occurs in panic.
+			 *
+			 * Note that console_flush_on_panic() will flush
+			 * legacy consoles anyway, even if unsafe.
+			 */
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct =3D true;
+
+			/*
+			 * In panic, if nbcon atomic printing occurs,
+			 * the legacy consoles must remain silent until
+			 * explicitly allowed.
+			 */
+			if (ft->nbcon_atomic && !legacy_allow_panic_sync)
+				ft->legacy_direct =3D false;
+		}
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
 extern struct printk_buffers printk_shared_pbufs;
=20
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index afdb16c..18488d6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1344,6 +1344,7 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	struct console_flush_type ft;
 	int cookie;
=20
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1359,12 +1360,17 @@ void nbcon_device_release(struct console *con)
 	cookie =3D console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
-		if (!have_boot_console) {
+		/*
+		 * If nbcon_atomic flushing is not available, fallback to
+		 * using the legacy loop.
+		 */
+		printk_get_console_flush_type(&ft);
+		if (ft.nbcon_atomic) {
 			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
-		} else if (!is_printk_legacy_deferred()) {
+		} else if (ft.legacy_direct) {
 			if (console_trylock())
 				console_unlock();
-		} else {
+		} else if (ft.legacy_offload) {
 			printk_trigger_flush();
 		}
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc3f897..6accd17 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -468,14 +468,14 @@ static DEFINE_MUTEX(syslog_lock);
  * present, it is necessary to perform the console lock/unlock dance
  * whenever console flushing should occur.
  */
-static bool have_legacy_console;
+bool have_legacy_console;
=20
 /*
  * Specifies if an nbcon console is registered. If nbcon consoles are presen=
t,
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-static bool have_nbcon_console;
+bool have_nbcon_console;
=20
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -488,14 +488,6 @@ bool have_boot_console;
 /* See printk_legacy_allow_panic_sync() for details. */
 bool legacy_allow_panic_sync;
=20
-/*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
- */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
-
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2342,9 +2334,12 @@ out:
  */
 void printk_legacy_allow_panic_sync(void)
 {
+	struct console_flush_type ft;
+
 	legacy_allow_panic_sync =3D true;
=20
-	if (printing_via_unlock && !is_printk_legacy_deferred()) {
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -2354,8 +2349,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock =3D printing_via_unlock;
-	bool defer_legacy =3D false;
+	struct console_flush_type ft;
 	int printed_len;
=20
 	/* Suppress unimportant messages after panic happens */
@@ -2370,35 +2364,23 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
=20
+	printk_get_console_flush_type(&ft);
+
 	/* If called from the scheduler, we can not call up(). */
 	if (level =3D=3D LOGLEVEL_SCHED) {
 		level =3D LOGLEVEL_DEFAULT;
-		defer_legacy =3D do_trylock_unlock;
-		do_trylock_unlock =3D false;
+		ft.legacy_offload |=3D ft.legacy_direct;
+		ft.legacy_direct =3D false;
 	}
=20
 	printk_delay(level);
=20
 	printed_len =3D vprintk_store(facility, level, dev_info, fmt, args);
=20
-	if (have_nbcon_console && !have_boot_console) {
+	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
=20
-		/*
-		 * In panic, the legacy consoles are not allowed to print from
-		 * the printk calling context unless explicitly allowed. This
-		 * gives the safe nbcon consoles a chance to print out all the
-		 * panic messages first. This restriction only applies if
-		 * there are nbcon consoles registered and they are allowed to
-		 * flush.
-		 */
-		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
-			do_trylock_unlock =3D false;
-			defer_legacy =3D false;
-		}
-	}
-
-	if (do_trylock_unlock) {
+	if (ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2418,7 +2400,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
=20
-	if (defer_legacy)
+	if (ft.legacy_offload)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -2777,10 +2759,16 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen && printing_via_unlock) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+	struct console_flush_type ft;
+
+	if (!cpuhp_tasks_frozen) {
+		printk_get_console_flush_type(&ft);
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
+		if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 	return 0;
 }
@@ -3305,6 +3293,7 @@ static void __console_rewind_all(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console_flush_type ft;
 	bool handover;
 	u64 next_seq;
=20
@@ -3328,7 +3317,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode =3D=3D CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
=20
-	if (!have_boot_console)
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
=20
 	/* Flush legacy consoles once allowed, even when dangerous. */
@@ -3992,6 +3982,7 @@ static bool __pr_flush(struct console *con, int timeout=
_ms, bool reset_on_progre
 {
 	unsigned long timeout_jiffies =3D msecs_to_jiffies(timeout_ms);
 	unsigned long remaining_jiffies =3D timeout_jiffies;
+	struct console_flush_type ft;
 	struct console *c;
 	u64 last_diff =3D 0;
 	u64 printk_seq;
@@ -4005,7 +3996,8 @@ static bool __pr_flush(struct console *con, int timeout=
_ms, bool reset_on_progre
 	seq =3D prb_next_reserve_seq(prb);
=20
 	/* Flush the consoles so that records up to @seq are printed. */
-	if (printing_via_unlock) {
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
 	}

