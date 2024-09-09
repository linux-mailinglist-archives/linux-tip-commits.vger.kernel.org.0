Return-Path: <linux-tip-commits+bounces-2222-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6323972083
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39F71C2384B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370B185B71;
	Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2YpH8Dz+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcEcKN1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B117D36A;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902868; cv=none; b=DB496BidbrPbrqdDFDOVRNwqhPvJsEaGbQoD4ADDhOAGK4NbSVKJif0ZyfqDrM8rvBauDI7joSzyEM59WdESuHxFlEfF97w5HNw45Gro4Sqr3Eal3LUJS7PIMKIAF9vScQvWx5wk0zIXqUrZlcn7L4RZy0qYmVhb/MKFpEyVPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902868; c=relaxed/simple;
	bh=UBJjaWNsKxP1rCNF6AI8ASPnX1F8YN8pecZ8vNNPEOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CENCcK0PIiGEbPkhqIbRIe+/mul7nVY0gwZSY9ktWc5QLzJUpF6IgzczSocpI1YjuKBTfI8ntaHKAbB0NUschWVyrl0wve4/HGOP6AmDMzTTI8ySNhOcGO6F0THSr0DeroNhigKWXqJjGIABOPFPtGGIJ83q8zXGt2W4VgC7ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2YpH8Dz+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wcEcKN1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVxbObWKhKKys4HzCDeqK1hsz2VJkn7y9o6rL1jUdlE=;
	b=2YpH8Dz+0xeZxUr1SaczMuJhRaF1cwDUkWsPbiqm+2I71SdRE2VmXgJKUHzq75slHJGtBA
	PaDd4Hrx++n3u28qaKThIpQSAsD1CP0iKnoEo1vsxpvQb/wnVQ8L4hwWuy8Hd4LCHXDPaG
	Hcvxa6jbrGO7BVpbcUwu1BqF4OGdXS/dIEYrXRcDGcpCpnQcNKnMs0BrcnnhRZzhl31h7/
	PzwYjBDaufOSOksCRXhOgc+bNBO/0SKLGR9FfSTFCXIWmM5d+KkS2bG0utLYCtidKekzrL
	p0DSdQrNOD+iC48b/nBQh2xR9Oxn5sFuAvou+jYmKFPAvpJq8H54l7VttVt1xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVxbObWKhKKys4HzCDeqK1hsz2VJkn7y9o6rL1jUdlE=;
	b=wcEcKN1Qspwe58uFm8+jybPdo1/q0pJrrMIGrmQBy0h/eUdK+mkPRVvDGPHAP3O6gGgYph
	TQag2Jnkmk24nxBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Show replay message on takeover
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-12-john.ogness@linutronix.de>
References: <20240904120536.115780-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286383.2215.9109506332328239935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     5102981d5e2a5a7a12424b5d26c7524ac2899898
Gitweb:        https://git.kernel.org/tip/5102981d5e2a5a7a12424b5d26c7524ac2899898
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:30 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: nbcon: Show replay message on takeover

An emergency or panic context can takeover console ownership
while the current owner was printing a printk message. The
atomic printer will re-print the message that the previous
owner was printing. However, this can look confusing to the
user and may even seem as though a message was lost.

  [3430014.1
  [3430014.181123] usb 1-2: Product: USB Audio

Add a new field @nbcon_prev_seq to struct console to track
the sequence number to print that was assigned to the previous
console owner. If this matches the sequence number to print
that the current owner is assigned, then a takeover must have
occurred. In this case, print an additional message to inform
the user that the previous message is being printed again.

  [3430014.1
  ** replaying previous printk message **
  [3430014.181123] usb 1-2: Product: USB Audio

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-12-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h  |  2 ++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 26 ++++++++++++++++++++++++++
 kernel/printk/printk.c   | 11 +++++++++++
 4 files changed, 40 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 788ce9c..eba367b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -325,6 +325,7 @@ struct nbcon_write_context {
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @nbcon_device_ctxt:	Context available for non-printing operations
+ * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
@@ -459,6 +460,7 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct nbcon_context	__private nbcon_device_ctxt;
+	atomic_long_t           __private nbcon_prev_seq;
 
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8166e24..c365d25 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -319,4 +319,5 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+void console_prepend_replay(struct printk_message *pmsg);
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5146ce9..9844088 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,7 +946,9 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
+	struct nbcon_state cur;
 	unsigned long dropped;
+	unsigned long ulseq;
 
 	/*
 	 * This function should never be called for consoles that have not
@@ -987,6 +989,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	if (dropped && !is_extended)
 		console_prepend_dropped(&pmsg, dropped);
 
+	/*
+	 * If the previous owner was assigned the same record, this context
+	 * has taken over ownership and is replaying the record. Prepend a
+	 * message to let the user know the record is replayed.
+	 */
+	ulseq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_prev_seq));
+	if (__ulseq_to_u64seq(prb, ulseq) == pmsg.seq) {
+		console_prepend_replay(&pmsg);
+	} else {
+		/*
+		 * Ensure this context is still the owner before trying to
+		 * update @nbcon_prev_seq. Otherwise the value in @ulseq may
+		 * not be from the previous owner and instead be some later
+		 * value from the context that took over ownership.
+		 */
+		nbcon_state_read(con, &cur);
+		if (!nbcon_context_can_proceed(ctxt, &cur))
+			return false;
+
+		atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_prev_seq), &ulseq,
+					__u64seq_to_ulseq(pmsg.seq));
+	}
+
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return false;
 
@@ -1646,6 +1671,7 @@ bool nbcon_alloc(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 
 	/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e945856..c27dc54 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2903,6 +2903,17 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 }
 
 /*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "replay message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ */
+void console_prepend_replay(struct printk_message *pmsg)
+{
+	console_prepend_message(pmsg, "** replaying previous printk message **\n");
+}
+
+/*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
  *

