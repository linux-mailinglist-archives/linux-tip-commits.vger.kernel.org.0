Return-Path: <linux-tip-commits+bounces-2224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F030397208B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2ACB20DA2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2D186E56;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glW8eQmV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZGjsH4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6117DFEA;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902868; cv=none; b=QCKRmbywjKwN6noVSKMsESm/FVLLu8wqjoEfVyI/Cdtc19N0ZTFxWKFcp6Ege56+11l6QRhTFOFpYTEh++DvT5vKbXdTc9KV3ojMrstLUzwTImbMjJxlQlCb3sxc7pbempapQNIZGqssQCws3LhAewPZeoYIxu3nPLf27REUoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902868; c=relaxed/simple;
	bh=nZvx/kA3jPgsZoXIxkZUaLAf9lPIZIXNuByWwup3Qtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a+3BTAWVzB0dw4iWc3OJnTSt+bGn9ViH3j+VdFFHyeGQ01e1ddnOHVkIfMSyFGk6UyL3qW5pvOk28RJZQ5gpacGXHyq3cNe00wQ87fDlPpQk5fxL4IDCa3yhjwOWQBS30Ixr8PNg8I7H/DLofcD8Uz9iANmOozG+WKmszG+Ni/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glW8eQmV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZGjsH4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBcnyuKpbS4Q9jnPSVZfb1D2MkqjsEwHl6Cx+naJ2sc=;
	b=glW8eQmV9JeXNr/91CTly2viGbt/5QlDXcvs4igi+TT8ztWuuBQVxYHLOf+QKK4sB1n/AL
	lXuCBXw79WopD0vSzVPyftX0Zvo3iRwoFpmKhofSJrCvKeZeLE3bpIIoBv85ShMrNmfJJx
	jUa0V+3LbLcIQMGx5Gowx9drVvv8ESX/vCDhYDLiwtHQ3xDZstnsMgtJ5RxjKUeZcUAikc
	nvimzrjbwadMggA5e/BOE18ZtSxvVsJ+in/Ho1x86vg6C1pftPiX3EDpCyQ0lR4mQeqQBw
	ovj6hUMh+JoqvfmvOPMXTpElSIxN2uBRz4fFO0Ul00Ap2X8eUioS8VDStRC41g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBcnyuKpbS4Q9jnPSVZfb1D2MkqjsEwHl6Cx+naJ2sc=;
	b=RZGjsH4Dt5VOECQsZtfp/WC/qPuneD7irB40oQp3s5GUgCMT0SjDqtu2uwGkKmXpmc3PiY
	PjjIqXKV6HuB2dDA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Rely on kthreads for normal operation
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-10-john.ogness@linutronix.de>
References: <20240904120536.115780-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286449.2215.2579909127602575248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     13189fa73afae2b961d29132fd36d9cc0be77ecb
Gitweb:        https://git.kernel.org/tip/13189fa73afae2b961d29132fd36d9cc0be77ecb
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:28 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: nbcon: Rely on kthreads for normal operation

Once the kthread is running and available
(i.e. @printk_kthreads_running is set), the kthread becomes
responsible for flushing any pending messages which are added
in NBCON_PRIO_NORMAL context. Namely the legacy
console_flush_all() and device_release() no longer flush the
console. And nbcon_atomic_flush_pending() used by
nbcon_cpu_emergency_exit() no longer flushes messages added
after the emergency messages.

The console context is safe when used by the kthread only when
one of the following conditions are true:

  1. Other caller acquires the console context with
     NBCON_PRIO_NORMAL with preemption disabled. It will
     release the context before rescheduling.

  2. Other caller acquires the console context with
     NBCON_PRIO_NORMAL under the device_lock.

  3. The kthread is the only context which acquires the console
     with NBCON_PRIO_NORMAL.

This is satisfied for all atomic printing call sites:

nbcon_legacy_emit_next_record() (#1)

nbcon_atomic_flush_pending_con() (#1)

nbcon_device_release() (#2)

It is even double guaranteed when @printk_kthreads_running
is set because then _only_ the kthread will print for
NBCON_PRIO_NORMAL. (#3)

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-10-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 26 +++++++++++++++++++++-
 kernel/printk/nbcon.c    | 17 +++++++++-----
 kernel/printk/printk.c   | 48 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a96d411..8166e24 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -113,6 +113,13 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 		/* The write_atomic() callback is optional. */
 		if (use_atomic && !con->write_atomic)
 			return false;
+
+		/*
+		 * For the !use_atomic case, @printk_kthreads_running is not
+		 * checked because the write_thread() callback is also used
+		 * via the legacy loop when the printer threads are not
+		 * available.
+		 */
 	} else {
 		if (!con->write)
 			return false;
@@ -176,6 +183,7 @@ static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
+static inline void nbcon_kthreads_wake(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
@@ -190,6 +198,7 @@ extern bool legacy_allow_panic_sync;
 /**
  * struct console_flush_type - Define available console flush methods
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
  * @legacy_offload:	Offload the legacy loop into IRQ
  *
@@ -197,6 +206,7 @@ extern bool legacy_allow_panic_sync;
  */
 struct console_flush_type {
 	bool	nbcon_atomic;
+	bool	nbcon_offload;
 	bool	legacy_direct;
 	bool	legacy_offload;
 };
@@ -211,6 +221,22 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
+		if (have_nbcon_console && !have_boot_console) {
+			if (printk_kthreads_running)
+				ft->nbcon_offload = true;
+			else
+				ft->nbcon_atomic = true;
+		}
+
+		/* Legacy consoles are flushed directly when possible. */
+		if (have_legacy_console || have_boot_console) {
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+			else
+				ft->legacy_offload = true;
+		}
+		break;
+
 	case NBCON_PRIO_EMERGENCY:
 		if (have_nbcon_console && !have_boot_console)
 			ft->nbcon_atomic = true;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 784e5de..5146ce9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1494,6 +1494,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 					   bool allow_unsafe_takeover)
 {
+	struct console_flush_type ft;
 	unsigned long flags;
 	int err;
 
@@ -1523,10 +1524,12 @@ again:
 
 	/*
 	 * If flushing was successful but more records are available, this
-	 * context must flush those remaining records because there is no
-	 * other context that will do it.
+	 * context must flush those remaining records if the printer thread
+	 * is not available do it.
 	 */
-	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+	printk_get_console_flush_type(&ft);
+	if (!ft.nbcon_offload &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
 	}
@@ -1754,17 +1757,19 @@ void nbcon_device_release(struct console *con)
 
 	/*
 	 * This context must flush any new records added while the console
-	 * was locked. The console_srcu_read_lock must be taken to ensure
-	 * the console is usable throughout flushing.
+	 * was locked if the printer thread is not available to do it. The
+	 * console_srcu_read_lock must be taken to ensure the console is
+	 * usable throughout flushing.
 	 */
 	cookie = console_srcu_read_lock();
+	printk_get_console_flush_type(&ft);
 	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
 		 * If nbcon_atomic flushing is not available, fallback to
 		 * using the legacy loop.
 		 */
-		printk_get_console_flush_type(&ft);
 		if (ft.nbcon_atomic) {
 			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 		} else if (ft.legacy_direct) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 55d75db..149c3e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2384,6 +2384,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+
 	if (ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
@@ -2732,6 +2735,7 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	struct console_flush_type ft;
 	struct console *con;
 
 	if (!console_suspend_enabled)
@@ -2749,6 +2753,10 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+
 	pr_flush(1000, true);
 }
 
@@ -3060,6 +3068,7 @@ static inline void printk_kthreads_check_locked(void) { }
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
+	struct console_flush_type ft;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -3071,12 +3080,22 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
+		printk_get_console_flush_type(&ft);
+
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
 			u64 printk_seq;
 			bool progress;
 
+			/*
+			 * console_flush_all() is only responsible for nbcon
+			 * consoles when the nbcon consoles cannot print via
+			 * their atomic or threaded flushing.
+			 */
+			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+				continue;
+
 			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
 			any_usable = true;
@@ -3387,9 +3406,25 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	struct console_flush_type ft;
+	bool is_nbcon;
+
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	is_nbcon = console->flags & CON_NBCON;
 	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. The related
+	 * printing context must be able to see it is enabled so that
+	 * it is guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	printk_get_console_flush_type(&ft);
+	if (is_nbcon && ft.nbcon_offload)
+		nbcon_kthread_wake(console);
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -4115,6 +4150,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
@@ -4152,8 +4189,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, true))
+			if (!console_is_usable(c, flags, true) &&
+			    !console_is_usable(c, flags, false)) {
 				continue;
+			}
 
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
@@ -4629,8 +4668,15 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
  */
 void console_try_replay_all(void)
 {
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
 	if (console_trylock()) {
 		__console_rewind_all();
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
+		if (ft.nbcon_offload)
+			nbcon_kthreads_wake();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}

