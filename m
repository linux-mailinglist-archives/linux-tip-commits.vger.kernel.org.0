Return-Path: <linux-tip-commits+bounces-2245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E869720C3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721D11C23B20
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CDB18A94C;
	Mon,  9 Sep 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yiPXVb7i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="it9KF5nx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A3189909;
	Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902876; cv=none; b=XIk/3iux4Cpm3erso8YEG3mVF3q6nvExW2rms9Uscq3N99GPLlF9f9vyjO/YJRd1FrVi7YGiKI2rJ+/P27iL2ifu8Kh8n97D2slZIkwM2fnVHevYdhSnGZpjhwaITCdVwfdHFLOJceKD9OY/BlYep+BcgCWPgWMbIX+RLyumQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902876; c=relaxed/simple;
	bh=//Q6JKgjgx3TREAt1ZpllMDXIur/Y2CQhM4dQJA8Zb0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mD6/LLidhc74IqUtXmDOFgzerTf+QaX8epz8fwq4/Km62WVYkx3Gk7LlXns2KrtEg5eovobXXKwoKr5wSaUo3jHdquqLRRAI22hk9pAEa9g46wL7QQf8XXOW/Ig/ctb+pmHdZUwMkGmTIRthcZQrzIrc6pbI4jL34cB+THVtRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yiPXVb7i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=it9KF5nx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyG362vkK69UFIxNhM3eNZLnM5MbmpDkS/F6e9poWnc=;
	b=yiPXVb7i4p7NrIJxgtlBGOC12hwsiTx8rykezPBaf00YiyMPuUQuDW16vPX6Dg0nfPMOnp
	EO4mk7YAaylw12fHDYSWLNKDX2hmEV14P4GeycDpeCoPH6JBeOyuWLq8wi9XBYkV8bs//T
	4xIJ+PAV0KJzJ0JjzRwO6AxWbGJVHm4jU7VbixVQcfIc5jW0e6xbkfdzyC+z98l4x/26X/
	p3dSCxDhVmvrElfGJ9Hprw9VPgzEWXJcD8AFTNlsKAz5qNnvf7yI/mgCTlZr8sh0j4zcVV
	v1/pb/uEuJCUCX4hpkqRXYnjCQTWX637pn/W+NijWlKXcFhHAEihNqY8THwg2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyG362vkK69UFIxNhM3eNZLnM5MbmpDkS/F6e9poWnc=;
	b=it9KF5nxJxZ/39bgHwSFjVldRcmkB2nFq1zLQCZna+eUW0QI+l0b55T8yuzXBk/tN4rOAv
	AUAOevahtAjeK+Aw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Add unsafe flushing on panic
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-27-john.ogness@linutronix.de>
References: <20240820063001.36405-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287121.2215.12103643247151228241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     5dde3b7354133846079fa51e55e74ef90a836759
Gitweb:        https://git.kernel.org/tip/5dde3b7354133846079fa51e55e74ef90a836759
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:52 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: nbcon: Add unsafe flushing on panic

Add nbcon_atomic_flush_unsafe() to flush all nbcon consoles
using the write_atomic() callback and allowing unsafe hostile
takeovers. Call this at the end of panic() as a final attempt
to flush any pending messages.

Note that legacy consoles use unsafe methods for flushing
from the beginning of panic (see bust_spinlocks()). Therefore,
systems using both legacy and nbcon consoles may still fail to
see panic messages due to unsafe legacy console usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-27-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h |  5 +++++
 kernel/panic.c         |  1 +
 kernel/printk/nbcon.c  | 32 +++++++++++++++++++++++++-------
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9687089..2e083f0 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -202,6 +202,7 @@ void printk_trigger_flush(void);
 void console_try_replay_all(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
+void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -294,6 +295,10 @@ static inline void nbcon_device_release(struct console *con)
 {
 }
 
+static inline void nbcon_atomic_flush_unsafe(void)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 2a04491..df37c91 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -463,6 +463,7 @@ void panic(const char *fmt, ...)
 	 * Explicitly flush the kernel log buffer one last time.
 	 */
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	nbcon_atomic_flush_unsafe();
 
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 269aeed..afdb16c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1083,6 +1083,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
  *		failure.
@@ -1101,7 +1102,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * returned, it cannot be expected that the unfinalized record will become
  * available.
  */
-static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					    bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1110,6 +1112,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
 	ctxt->prio			= nbcon_get_default_prio();
+	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
 	if (!nbcon_context_try_acquire(ctxt))
 		return -EPERM;
@@ -1140,13 +1143,15 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * This will stop flushing before @stop_seq if another context has ownership.
  * That context is then responsible for the flushing. Likewise, if new records
  * are added while this context was flushing and there is no other context
  * to handle the printing, this context must also flush those records.
  */
-static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					   bool allow_unsafe_takeover)
 {
 	unsigned long flags;
 	int err;
@@ -1160,7 +1165,7 @@ again:
 	 */
 	local_irq_save(flags);
 
-	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
 
 	local_irq_restore(flags);
 
@@ -1190,8 +1195,9 @@ again:
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq)
+static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct console *con;
 	int cookie;
@@ -1209,7 +1215,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 		if (nbcon_seq_read(con) >= stop_seq)
 			continue;
 
-		nbcon_atomic_flush_pending_con(con, stop_seq);
+		nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
 	}
 	console_srcu_read_unlock(cookie);
 }
@@ -1225,7 +1231,19 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
  */
 void nbcon_atomic_flush_pending(void)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
+}
+
+/**
+ * nbcon_atomic_flush_unsafe - Flush all nbcon consoles using their
+ *	write_atomic() callback and allowing unsafe hostile takeovers
+ *
+ * Flush the backlog up through the currently newest record. Unsafe hostile
+ * takeovers will be performed, if necessary.
+ */
+void nbcon_atomic_flush_unsafe(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
 /**
@@ -1342,7 +1360,7 @@ void nbcon_device_release(struct console *con)
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		if (!have_boot_console) {
-			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 		} else if (!is_printk_legacy_deferred()) {
 			if (console_trylock())
 				console_unlock();

