Return-Path: <linux-tip-commits+bounces-2263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A7B9720EB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F451F2344B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C618E356;
	Mon,  9 Sep 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDrPDLMJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvRTK7/k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C718CBF2;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902882; cv=none; b=gFoav059/oHRlKLhkcSfzgdZcq4Z/qssEiHn33/s8usTUhZyYGl8MbyyadtnUuXrPWOgTt+WwcyV4SzFHd3peg320VOU2ei/pObWxxvGTmrQOtrR6JCDI29sB71eDLWsb5f1//ADIf5PdzXtDwbnaQbeqIUorZFXFkzEB9car7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902882; c=relaxed/simple;
	bh=BsBjefIGg148F874zJUBi201u7BTDnPdONrzNFtoprY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gtb/XobplngSqbZmc3zHjiW227sr8mHppqyMz9ef9BhiOCKkSYihICVjrCcsZ9t60NcBwBJy/4tgt0x8RawyAUDypGJMKTlIh/t1Yw6PHYzGyYm/Hj5Jgixron9v3j+A3/w7Hx8QBpVDw8C+JmXyV7KtHwKPbiW64s9sKbLfnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDrPDLMJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvRTK7/k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J600n9c6P/cx4Q/GXjW78BaZDk/+8od9zTdzNS21kiA=;
	b=mDrPDLMJ+lVV7h1MN5ERGjLM/w0gLhRgEJeg9rNtSlE7+VmrET6v0tdRbtF6F4lFadCT7T
	/mRDB0OX+k/rD34I36Kyivy/bwbb9ShCMQg46e0GhNNa7+yUM0eUgV9tW6F2Woi14dhE7g
	NzWBNYshg4AUNqTs11zR8rsgOqTEQNGkZv75z1G2oXGqmDkUIm8iuHPO8DBZqKfhhLox7g
	cki1VGOmZ3oZwnxmobT+T3MK8ODWRu3fr/8rWLtmzaXoqW+mlq2rjOYR2+NbIwsu7iMllS
	/epm6UemjerL0NInTsXJxqVS8131FR39wZzJQpqCTMYpnjQMM7iMtI58zoJOLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J600n9c6P/cx4Q/GXjW78BaZDk/+8od9zTdzNS21kiA=;
	b=xvRTK7/kUztsWdHG0dgGurebnA3szLjCmYOVFkzpVkTRw9LBp94idAi2AaQuaJD4iJeucw
	3FuncQKh5W78BWBg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Add detailed doc for write_atomic()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-8-john.ogness@linutronix.de>
References: <20240820063001.36405-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287808.2215.8297876638550952916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     7d56936c1e5208b5eeea2a9a2f70e85248f6da49
Gitweb:        https://git.kernel.org/tip/7d56936c1e5208b5eeea2a9a2f70e85248f6da49
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:33 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: nbcon: Add detailed doc for write_atomic()

The write_atomic() callback has special requirements and is
allowed to use special helper functions. Provide detailed
documentation of the callback so that a developer has a
chance of implementing it correctly.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-8-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 577b157..35c64ee 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -303,7 +303,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -320,7 +320,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -345,8 +344,34 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	void			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context. (Optional)
+	 *
+	 * This callback is called with the console already acquired. However,
+	 * a higher priority context is allowed to take it over by default.
+	 *
+	 * The callback must call nbcon_enter_unsafe() and nbcon_exit_unsafe()
+	 * around any code where the takeover is not safe, for example, when
+	 * manipulating the serial port registers.
+	 *
+	 * nbcon_enter_unsafe() will fail if the context has lost the console
+	 * ownership in the meantime. In this case, the callback is no longer
+	 * allowed to go forward. It must back out immediately and carefully.
+	 * The buffer content is also no longer trusted since it no longer
+	 * belongs to the context.
+	 *
+	 * The callback should allow the takeover whenever it is safe. It
+	 * increases the chance to see messages when the system is in trouble.
+	 *
+	 * The callback can be called from any context (including NMI).
+	 * Therefore it must avoid usage of any locking and instead rely
+	 * on the console ownership for synchronization.
+	 */
+	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;

