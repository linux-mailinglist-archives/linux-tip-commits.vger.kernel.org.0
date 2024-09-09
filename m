Return-Path: <linux-tip-commits+bounces-2231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F199720A0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7A51F22B2E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D4189502;
	Mon,  9 Sep 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwzHL2z7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHNo8FpB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9118787C;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902872; cv=none; b=f30uTBBfMHdiHHPhhKTgS74VqAa4NkhphfjZUZoAedXtlTVVwNY9CCW8BGyZPjjjnn/yVAHQlfUOc6T/HoaOqHJl51xO0hqleYfmCPn2w20Ud+YRTSMwLRkcL2AoLD3vJmCmqh8b6Yvww6ON1LafgDODd8k9Um4lBhyWGYLSW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902872; c=relaxed/simple;
	bh=NA/QeUgoXE021H7DE3xzMhHFnDOhlYq9obQWV6avaGw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DBRvgsh1LB5GTX2Wt5iXpGHqMtugZHIBZ0t4Px0opZx80x/dmEPkZmgqDuRQYAh7KIWrVoPPbQ0oz7IT+WOA2/0vUYFZknJlRQKlb6c6kJ4cNr0tXkuWI3Up0o9CgxXDOInutYEfF2mAN6iUPbBtnC9lQRG1qh1OHpXMqa7LyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwzHL2z7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHNo8FpB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxSZraKbQt9N629wFDgO1+KObss8xAu2dfxNOhW9kzo=;
	b=ZwzHL2z7CwQm1ZADzr7kAIY3pd1dvc86xhl41mfUujoAwaNXP0HgKk+kcEYuVVAHoglC3v
	MRb4NVzPVI0Pd45moTROQwjfSQriuSrFZXhUEVYDzoaiB3npQwowcc6eL61MX9/b5I4+lL
	7ULawXbndhxAno0y44LdhL/tw1PexDYM/UYOXHmo2z+igyoLyR8ZRIAvjNHONMiNCGaBrA
	jvm6MDNgZIRgc+RsUVw4rPKByV2cdd+iEH5IzEZnIv+ui/ct6MCMtPhzerBKr0gM0SpvZL
	ITaDxySwqByH1d4ZTVqhc1njuoTaJ5Iqk87lYF97/8hY0yNbaxWQjggQLThqAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxSZraKbQt9N629wFDgO1+KObss8xAu2dfxNOhW9kzo=;
	b=RHNo8FpB3ZYwvS36uHNnU+uEOVwQ+ie4dxpEOEh7Mx8zrvDfpEEA1WPiRWIEgZ+hddqreZ
	xKSiTZ8XNwz6EHAw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Add function for printers to reacquire
 ownership
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-2-john.ogness@linutronix.de>
References: <20240904120536.115780-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286704.2215.14185841229700981969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     bd07d864522e7c3e4ee364e91aee8754992f5855
Gitweb:        https://git.kernel.org/tip/bd07d864522e7c3e4ee364e91aee8754992f5855
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:20 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:31 +02:00

printk: nbcon: Add function for printers to reacquire ownership

Since ownership can be lost at any time due to handover or
takeover, a printing context _must_ be prepared to back out
immediately and carefully. However, there are scenarios where
the printing context must reacquire ownership in order to
finalize or revert hardware changes.

One such example is when interrupts are disabled during
printing. No other context will automagically re-enable the
interrupts. For this case, the disabling context _must_
reacquire nbcon ownership so that it can re-enable the
interrupts.

Provide nbcon_reacquire_nobuf() for exactly this purpose. It
allows a printing context to reacquire ownership using the same
priority as its previous ownership.

Note that after a successful reacquire the printing context
will have no output buffer because that has been lost. This
function cannot be used to resume printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-2-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  6 +++-
 kernel/printk/nbcon.c   | 74 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9a13f91..88050d3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -366,6 +366,10 @@ struct console {
 	 *
 	 * The callback should allow the takeover whenever it is safe. It
 	 * increases the chance to see messages when the system is in trouble.
+	 * If the driver must reacquire ownership in order to finalize or
+	 * revert hardware changes, nbcon_reacquire_nobuf() can be used.
+	 * However, on reacquire the buffer content is no longer available. A
+	 * reacquire cannot be used to resume printing.
 	 *
 	 * The callback can be called from any context (including NMI).
 	 * Therefore it must avoid usage of any locking and instead rely
@@ -558,12 +562,14 @@ extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index cf62f67..8a1bf6f 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -830,6 +830,19 @@ out:
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
+static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	wctxt->outbuf = buf;
+	wctxt->len = len;
+	nbcon_state_read(con, &cur);
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+}
+
 /**
  * nbcon_enter_unsafe - Enter an unsafe region in the driver
  * @wctxt:	The write context that was handed to the write function
@@ -845,8 +858,12 @@ out:
 bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool is_owner;
 
-	return nbcon_context_enter_unsafe(ctxt);
+	is_owner = nbcon_context_enter_unsafe(ctxt);
+	if (!is_owner)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return is_owner;
 }
 EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 
@@ -865,12 +882,44 @@ EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool ret;
 
-	return nbcon_context_exit_unsafe(ctxt);
+	ret = nbcon_context_exit_unsafe(ctxt);
+	if (!ret)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
 /**
+ * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
+ *				while printing
+ * @wctxt:	The write context that was handed to the write callback
+ *
+ * Since ownership can be lost at any time due to handover or takeover, a
+ * printing context _must_ be prepared to back out immediately and
+ * carefully. However, there are scenarios where the printing context must
+ * reacquire ownership in order to finalize or revert hardware changes.
+ *
+ * This function allows a printing context to reacquire ownership using the
+ * same priority as its previous ownership.
+ *
+ * Note that after a successful reacquire the printing context will have no
+ * output buffer because that has been lost. This function cannot be used to
+ * resume printing.
+ */
+void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	while (!nbcon_context_try_acquire(ctxt))
+		cpu_relax();
+
+	nbcon_write_context_set_buf(wctxt, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
+
+/**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
  *
@@ -895,7 +944,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
-	struct nbcon_state cur;
 	unsigned long dropped;
 
 	/*
@@ -930,10 +978,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		goto update_con;
 
 	/* Initialize the write context for driver callbacks. */
-	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
-	wctxt->len = pmsg.outbuf_len;
-	nbcon_state_read(con, &cur);
-	wctxt->unsafe_takeover = cur.unsafe_takeover;
+	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
 	if (con->write_atomic) {
 		con->write_atomic(con, wctxt);
@@ -947,6 +992,21 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		return false;
 	}
 
+	if (!wctxt->outbuf) {
+		/*
+		 * Ownership was lost and reacquired by the driver. Handle it
+		 * as if ownership was lost.
+		 */
+		nbcon_context_release(ctxt);
+		return false;
+	}
+
+	/*
+	 * Ownership may have been lost but _not_ reacquired by the driver.
+	 * This case is detected and handled when entering unsafe to update
+	 * dropped/seq values.
+	 */
+
 	/*
 	 * Since any dropped message was successfully output, reset the
 	 * dropped count for the console.

