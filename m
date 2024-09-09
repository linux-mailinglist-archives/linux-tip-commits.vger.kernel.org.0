Return-Path: <linux-tip-commits+bounces-2253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E19720DC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348B81C235BF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EB18C910;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vID5eKY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieaakiKp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88718A93F;
	Mon,  9 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902879; cv=none; b=pHOViJeMlTfswd9mkqf7aqXpPuNlgJtg22Sks6V6WJ7/atJLVBq+ArFS3zTIo/y4WobLbJB7EyMOXwRFTC2r2zqSYMdsJq0n7SkAoYKrIGawDNzRhIazO62tBO65GonfQcnXy1WlN49EJ/wbjmJgQFx3fz8GBCe3l36wz71x7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902879; c=relaxed/simple;
	bh=L5Q0805keKUMtTQjBTrG/RzpsPtEP3U8slQiLaU6GVg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vFAyQLjbmLhzxS0BMc3o+cgfCRciAWv2Qryl4vKil5FzuQVXAWBy8Lf41n9LdlX3aE/j1lMHxw11iqpNhxsJhT+RAzHCPiLHCKApCljtSqpkZ7wiFkpnIWD4LpmPJJVzRFcLGsZQnZ44WgeJWbhUqSzeI7fWtfwelFHdxlpPJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vID5eKY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieaakiKp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kx6u65KJxRJA/DvBqJgFpjiP9uk8aU76BNblLUlmRcU=;
	b=vID5eKY1XPQU9V1rFK62UT6AAtSJUucZgHc7pETBq2uJ2BEw+0226xRIKmPCYPmsSK4ggc
	E2wSO30NYx6Xi/kAKVDkw4fgjpb4w6NBqi45frnq6Sw95fWGDjOK2MnKVUGZqdPxSiqHIT
	gNlEdgjut8UsYFDZtQ2SeN8oLiEiFjaKIICrwdUd0PpSSPFifzpHove6LDUEbbLH9junnT
	S5NGI6ELjMybNkF2lwCKyewQVmfLnZM+idL6jhs9mccsqbykY5rBQChmZLmQiaWQd0tL9p
	0smmxe9oVzGDmAHmDPNYr9ZxcLSBAHbcHPFRtwnb/nj/BIRgGMt9qLw1HniN+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kx6u65KJxRJA/DvBqJgFpjiP9uk8aU76BNblLUlmRcU=;
	b=ieaakiKpIbihOsTexyrP80lJqmnavy2CwO1mZG6YReAktCLSniTgrJ2neNBKpcoKSn+PB0
	xtStVtzv/yRY43AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: nbcon: Provide function to flush using write_atomic()
Cc: John Ogness <john.ogness@linutronix.de>,
 "Thomas Gleixner (Intel)" <tglx@linutronix.de>,
 Petr Mladek <pmladek@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-21-john.ogness@linutronix.de>
References: <20240820063001.36405-21-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287340.2215.6391263525535623657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d3a9f82ec5c095d6eb1eb94ecaa494470b4cef70
Gitweb:        https://git.kernel.org/tip/d3a9f82ec5c095d6eb1eb94ecaa494470b4cef70
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:46 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: nbcon: Provide function to flush using write_atomic()

Provide nbcon_atomic_flush_pending() to perform flushing of all
registered nbcon consoles using their write_atomic() callback.

Unlike console_flush_all(), nbcon_atomic_flush_pending() will
only flush up through the newest record at the time of the
call. This prevents a CPU from printing unbounded when other
CPUs are adding records. If new records are added while
flushing, it is expected that the dedicated printer threads
will print those records. If the printer thread is not
available (which is always the case at this point in the
rework), nbcon_atomic_flush_pending() _will_ flush all records
in the ringbuffer.

Unlike console_flush_all(), nbcon_atomic_flush_pending() will
fully flush one console before flushing the next. This helps to
guarantee that a block of pending records (such as a stack
trace in an emergency situation) can be printed atomically at
once before releasing console ownership.

nbcon_atomic_flush_pending() is safe in any context because it
uses write_atomic() and acquires with unsafe_takeover disabled.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-21-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |   2 +-
 kernel/printk/nbcon.c    | 151 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 72f2293..0dc9b92 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
+void nbcon_atomic_flush_pending(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -138,6 +139,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
+static inline void nbcon_atomic_flush_pending(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c6a9aa9..3982d68 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -886,7 +886,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -992,6 +991,156 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
+/*
+ * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ *
+ * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
+ *		failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		Unable to acquire console ownership.
+ *
+ *	-EAGAIN:	Another context took over ownership while printing.
+ *
+ *	-ENOENT:	A record before @stop_seq is not available.
+ *
+ * If flushing up to @stop_seq was not successful, it only makes sense for the
+ * caller to try again when -EAGAIN was returned. When -EPERM is returned,
+ * this context is not allowed to acquire the console. When -ENOENT is
+ * returned, it cannot be expected that the unfinalized record will become
+ * available.
+ */
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	int err = 0;
+
+	ctxt->console			= con;
+	ctxt->spinwait_max_us		= 2000;
+	ctxt->prio			= nbcon_get_default_prio();
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return -EPERM;
+
+	while (nbcon_seq_read(con) < stop_seq) {
+		/*
+		 * nbcon_emit_next_record() returns false when the console was
+		 * handed over or taken over. In both cases the context is no
+		 * longer valid.
+		 */
+		if (!nbcon_emit_next_record(&wctxt))
+			return -EAGAIN;
+
+		if (!ctxt->backlog) {
+			/* Are there reserved but not yet finalized records? */
+			if (nbcon_seq_read(con) < stop_seq)
+				err = -ENOENT;
+			break;
+		}
+	}
+
+	nbcon_context_release(ctxt);
+	return err;
+}
+
+/**
+ * nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ *
+ * This will stop flushing before @stop_seq if another context has ownership.
+ * That context is then responsible for the flushing. Likewise, if new records
+ * are added while this context was flushing and there is no other context
+ * to handle the printing, this context must also flush those records.
+ */
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+{
+	unsigned long flags;
+	int err;
+
+again:
+	/*
+	 * Atomic flushing does not use console driver synchronization (i.e.
+	 * it does not hold the port lock for uart consoles). Therefore IRQs
+	 * must be disabled to avoid being interrupted and then calling into
+	 * a driver that will deadlock trying to acquire console ownership.
+	 */
+	local_irq_save(flags);
+
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
+
+	local_irq_restore(flags);
+
+	/*
+	 * If there was a new owner (-EPERM, -EAGAIN), that context is
+	 * responsible for completing.
+	 *
+	 * Do not wait for records not yet finalized (-ENOENT) to avoid a
+	 * possible deadlock. They will either get flushed by the writer or
+	 * eventually skipped on panic CPU.
+	 */
+	if (err)
+		return;
+
+	/*
+	 * If flushing was successful but more records are available, this
+	 * context must flush those remaining records because there is no
+	 * other context that will do it.
+	 */
+	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		stop_seq = prb_next_reserve_seq(prb);
+		goto again;
+	}
+}
+
+/**
+ * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *					write_atomic() callback
+ * @stop_seq:			Flush up until this record
+ */
+static void __nbcon_atomic_flush_pending(u64 stop_seq)
+{
+	struct console *con;
+	int cookie;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
+
+		if (!(flags & CON_NBCON))
+			continue;
+
+		if (!console_is_usable(con, flags))
+			continue;
+
+		if (nbcon_seq_read(con) >= stop_seq)
+			continue;
+
+		nbcon_atomic_flush_pending_con(con, stop_seq);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
+/**
+ * nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *				write_atomic() callback
+ *
+ * Flush the backlog up through the currently newest record. Any new
+ * records added while flushing will not be flushed if there is another
+ * context available to handle the flushing. This is to avoid one CPU
+ * printing unbounded because other CPUs continue to add records.
+ */
+void nbcon_atomic_flush_pending(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+}
+
 /**
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize

