Return-Path: <linux-tip-commits+bounces-2226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327597208C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501301C23A42
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDC187859;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJtKl9L3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="imbDr4tX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03A17E002;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902869; cv=none; b=pnlAI0xFeGJchnRYjzS+Mocb0leWWL+uaP4GB6BFAOnWz0Lkga38f3kpnirkT8gtyTx3NbS56OIIDXgWyoTT5ngzc4rw2tguFGfI40zI9V85miuX08HV1J+vVAZ+ypD/YGMbS0+uXNDkaFDwVMV5mp5PaMISsSCKvVuUvgKIbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902869; c=relaxed/simple;
	bh=yo3AoVYoOeF7NZqIZwVJvF3/MK/QYru3MZU0Lo6lwII=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YeGA7yDY71yfayW7j416R7/Lbjj7is2WbpOabSbFfW9YNxhrNASmFz8uHmqES7H0ggJ7e90M4z8nC2/vlNGf5ZfOtgEEq7Z5/G5JKpu4HoJv+4HmoDDCnLCvRKWTr7FsWGVjG7p5oq7cTXJrJxGpaIRWFLCXlCEyktxC+juBmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJtKl9L3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=imbDr4tX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIRafuspra5pTqSAYJhnZJvdG1b9owDwXc4ZeZRNSdk=;
	b=iJtKl9L3LoB34PZTyWXvthwcc7xerM4poRxAlj2Ej8ViL0bKgvVfoZhkcGNI7Y6xOvznrl
	Xb8SbhRtSXIvF8jEsV34J/bU8XgSTtzXmVqhyV8qbbE6PNaSPF7O7nLdHhAGAcIroKBRQe
	QttZ+DjfZYl5qiWTUNtVd5oNLCuUCQV7k44BsljEmG1gk0F9COafk08I2TLS59/RPB6g/d
	9uNo4W+iZ8wT8IFwDxEqhqERc03HpI9ppTN9irwo5Am+ksDmc/iAyhFRmQPf5FkjCnq2Bm
	Zs55/IGuMwKnJwSTCk3J7HU15olDP7olKEg6LrvIRAy1Sznz75BeSAGMm0v8vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIRafuspra5pTqSAYJhnZJvdG1b9owDwXc4ZeZRNSdk=;
	b=imbDr4tXGKpxgm86nlYSlAyEFbzsQmMan5hJgLpwqJPHnIyVvUUYxtkCoNKiK18mlQQoUh
	m6DnlwHTm8LZeOAA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Use thread callback if in task context
 for legacy
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-9-john.ogness@linutronix.de>
References: <20240904120536.115780-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286484.2215.2443830657102907162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     5c586baa60e46d9fccd04f04e16f8a50b2fbc1af
Gitweb:        https://git.kernel.org/tip/5c586baa60e46d9fccd04f04e16f8a50b2fbc1af
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:27 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: nbcon: Use thread callback if in task context for legacy

When printing via console_lock, the write_atomic() callback is
used for nbcon consoles. However, if it is known that the
current context is a task context, the write_thread() callback
can be used instead.

Using write_thread() instead of write_atomic() helps to reduce
large disabled preemption regions when the device_lock does not
disable preemption.

This is mainly a preparatory change to allow avoiding
write_atomic() completely during normal operation if boot
consoles are registered.

As a side-effect, it also allows consolidating the printing
code for legacy printing and the kthread printer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-9-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  4 +-
 kernel/printk/nbcon.c    | 95 ++++++++++++++++++++++-----------------
 kernel/printk/printk.c   |  5 +-
 3 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 14f7fc7..a96d411 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -90,7 +90,7 @@ void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-				   int cookie);
+				   int cookie, bool use_atomic);
 bool nbcon_kthread_create(struct console *con);
 void nbcon_kthread_stop(struct console *con);
 void nbcon_kthreads_wake(void);
@@ -174,7 +174,7 @@ static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-						 int cookie) { return false; }
+						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 57a0e9b..784e5de 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1043,9 +1043,10 @@ update_con:
 }
 
 /*
- * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *				write_atomic() callback
+ * nbcon_emit_one - Print one record for an nbcon console using the
+ *			specified callback
  * @wctxt:	An initialized write context struct to use for this context
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True, when a record has been printed and there are still
  *		pending records. The caller might want to continue flushing.
@@ -1058,12 +1059,25 @@ update_con:
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
  */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!use_atomic) {
+		con->device_lock(con, &flags);
+
+		/*
+		 * Ensure this stays on the CPU to make handover and
+		 * takeover possible.
+		 */
+		cant_migrate();
+	}
 
 	if (!nbcon_context_try_acquire(ctxt))
-		return false;
+		goto out;
 
 	/*
 	 * nbcon_emit_next_record() returns false when the console was
@@ -1073,12 +1087,16 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt, true))
-		return false;
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
+		goto out;
 
 	nbcon_context_release(ctxt);
 
-	return ctxt->backlog;
+	ret = ctxt->backlog;
+out:
+	if (!use_atomic)
+		con->device_unlock(con, flags);
+	return ret;
 }
 
 /**
@@ -1163,30 +1181,8 @@ wait_for_event:
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false)) {
-			unsigned long lock_flags;
-
-			con->device_lock(con, &lock_flags);
-
-			/*
-			 * Ensure this stays on the CPU to make handover and
-			 * takeover possible.
-			 */
-			cant_migrate();
-
-			if (nbcon_context_try_acquire(ctxt)) {
-				/*
-				 * If the emit fails, this context is no
-				 * longer the owner.
-				 */
-				if (nbcon_emit_next_record(&wctxt, false)) {
-					nbcon_context_release(ctxt);
-					backlog = ctxt->backlog;
-				}
-			}
-
-			con->device_unlock(con, lock_flags);
-		}
+		if (console_is_usable(con, con_flags, false))
+			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
 
@@ -1367,6 +1363,13 @@ enum nbcon_prio nbcon_get_default_prio(void)
  *		both the console_lock and the SRCU read lock. Otherwise it
  *		is set to false.
  * @cookie:	The cookie from the SRCU read lock.
+ * @use_atomic: Set true when called in an atomic or unknown context.
+ *		It affects which nbcon callback will be used: write_atomic()
+ *		or write_thread().
+ *
+ *		When false, the write_thread() callback is used and would be
+ *		called in a preemtible context unless disabled by the
+ *		device_lock. The legacy handover is not allowed in this mode.
  *
  * Context:	Any context except NMI.
  * Return:	True, when a record has been printed and there are still
@@ -1382,26 +1385,36 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * Essentially it is the nbcon version of console_emit_next_record().
  */
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-				   int cookie)
+				   int cookie, bool use_atomic)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
 	unsigned long flags;
 	bool progress;
 
-	/* Use the same procedure as console_emit_next_record(). */
-	printk_safe_enter_irqsave(flags);
-	console_lock_spinning_enable();
-	stop_critical_timings();
-
 	ctxt->console	= con;
 	ctxt->prio	= nbcon_get_default_prio();
 
-	progress = nbcon_atomic_emit_one(&wctxt);
+	if (use_atomic) {
+		/*
+		 * In an atomic or unknown context, use the same procedure as
+		 * in console_emit_next_record(). It allows to handover.
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
+		stop_critical_timings();
+	}
 
-	start_critical_timings();
-	*handover = console_lock_spinning_disable_and_check(cookie);
-	printk_safe_exit_irqrestore(flags);
+	progress = nbcon_emit_one(&wctxt, use_atomic);
+
+	if (use_atomic) {
+		start_critical_timings();
+		*handover = console_lock_spinning_disable_and_check(cookie);
+		printk_safe_exit_irqrestore(flags);
+	} else {
+		/* Non-atomic does not perform legacy spinning handovers. */
+		*handover = false;
+	}
 
 	return progress;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f27c76c..55d75db 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3077,12 +3077,13 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			u64 printk_seq;
 			bool progress;
 
-			if (!console_is_usable(con, flags, true))
+			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
 			any_usable = true;
 
 			if (flags & CON_NBCON) {
-				progress = nbcon_legacy_emit_next_record(con, handover, cookie);
+				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
+									 !do_cond_resched);
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);

