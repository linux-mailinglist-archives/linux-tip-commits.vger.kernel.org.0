Return-Path: <linux-tip-commits+bounces-2223-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A8972087
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF5D1C239DD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC861865FD;
	Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yase9QV7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFL/mvve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1517DFE3;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902868; cv=none; b=MBI+01HHh65is03vRTpe3V0F6x9fIqeS3GoGwMRBnOQBGEeHcwe3qHyTAES85+FSU5UjQCOv9RMsqUHIN8ywOc/5w4PrR5kYt3NSofnURgow9OWaxcyPDGL6xQiUmxYGS+7wiq2Cjbfzzj1MTQxXyBPZlyNykl9D4EEcUY3aTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902868; c=relaxed/simple;
	bh=wVBfxbk7Nn5baMWpEZcb5hX3LHhRxyJjSuy0c8zXC4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GoDIiYGYDaM/CamByTu7KJ1JGsjS82hUKyaYHs2ksZLHLZzAnN7VXWmPUvUXqql7NXKZekrbS74M0TC8Qp+rp8buCZOcYH/guK2qeX/GdgL9qis8/IN30gS7ROQIWN/H3cgn0jJgbQiaY+9uAbhETuTZ67haYgYNRnxOTf0xgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yase9QV7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFL/mvve; arc=none smtp.client-ip=193.142.43.55
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
	bh=OOsKS2zXCt1tT7uCsp3cPkfkb+PJ2oUsEnNszYtkKZM=;
	b=Yase9QV7AaYh3qXjcyPkdnFgjBQwCiJF3Al3S5OVdkt4I9djl4RVuqZ82vJTDpBsUU7gav
	FG+acVdGdMMwSs8OzoIbHKatrMtc3w2Zlekpkv5nGGV+GvD1SAg+0fk2MiXP48l8NKXzJt
	uLFsknkuAlFkh1zr8o/G4yjMB/gb1UYBwNMpfN5EHB2zufAuDWZToQtephUmiP4AtyIJxI
	wILzhDoX1aBDAAU9I8aj6Kv4R2imE47u/mjjdBsL8jgo2v1YS3jbVzhhGsJnuce3KirwoJ
	FihnNFxqd5yqseVlCALhtettyKvgrGI7Y99PfspYeTn9DBYLN2LhXAsUD/5Y4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOsKS2zXCt1tT7uCsp3cPkfkb+PJ2oUsEnNszYtkKZM=;
	b=PFL/mvveCPs+r73aQrXScpCGBK7Pqa3OdvbkoJvB/238K/f10A9XWvrQuakivSeyFc/Bt1
	F2Mk0+/equMLIyDQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Provide helper for message prepending
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-11-john.ogness@linutronix.de>
References: <20240904120536.115780-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286416.2215.17952690301915150002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     75d430372abba5210fbc56a813d2515c001a4f45
Gitweb:        https://git.kernel.org/tip/75d430372abba5210fbc56a813d2515c001a4f45
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:29 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: Provide helper for message prepending

In order to support prepending different texts to printk
messages, split out the prepending code into a helper
function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-11-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 149c3e0..e945856 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,30 +2843,31 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
- * is achieved by shifting the existing message over and inserting the dropped
- * message.
+ * Prepend the message in @pmsg->pbufs->outbuf. This is achieved by shifting
+ * the existing message over and inserting the scratchbuf message.
  *
- * @pmsg is the printk message to prepend.
- *
- * @dropped is the dropped count to report in the dropped message.
+ * @pmsg is the original printk message.
+ * @fmt is the printf format of the message which will prepend the existing one.
  *
- * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the dropped message, the message text will be sufficiently truncated.
+ * If there is not enough space in @pmsg->pbufs->outbuf, the existing
+ * message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+__printf(2, 3)
+static void console_prepend_message(struct printk_message *pmsg, const char *fmt, ...)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
+	va_list args;
 	size_t len;
 
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
+	va_start(args, fmt);
+	len = vscnprintf(scratchbuf, scratchbuf_sz, fmt, args);
+	va_end(args);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2889,6 +2890,19 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 }
 
 /*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ */
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+{
+	console_prepend_message(pmsg, "** %lu printk messages dropped **\n", dropped);
+}
+
+/*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
  *

