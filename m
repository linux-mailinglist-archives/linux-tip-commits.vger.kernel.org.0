Return-Path: <linux-tip-commits+bounces-2264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489699720EC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A4A1C23B26
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4DA18E361;
	Mon,  9 Sep 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwfCdXiB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VJVWKEt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EC18CC01;
	Mon,  9 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902883; cv=none; b=fokzb1No3AUREH1lsnmUJ6KZ+Zl2+bsZpBRXOCO/qJh4K/BvzG/AbChZpusXSrLwftpaPssawLloabXKy4Atcu7FRzU983HVzPOlRwbrBg5HkkWdBSf/2xCjE6qoU4i2P9UijPoWB7BrYyS4rxrHykkQ/fSLpnhaqOYKo4PYWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902883; c=relaxed/simple;
	bh=iI01eI7kg7MT3dPTxnq4KcNmAcBkN4rMJlip2CAKAJ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VSel/BmmfjW1MjO5Oe9NVpY8bNFYfPxY1Z075+ab2sHH2X/GtUjwbtCUh2MzHbz+cfWzuaKhAlM+5VPzCAcXbo1ajC4jxzkSZBTeXwiq++hjKCnb6I4bKgxa9CGcO8njPXp3MmU4TtHPCHVS+OZPdyLFz7cIHPlf4Z1l5yZsgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwfCdXiB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VJVWKEt; arc=none smtp.client-ip=193.142.43.55
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
	bh=nO8F5tJLBputdTHPp/ebEInBVW6FgJupfyZOs6vbz18=;
	b=gwfCdXiBGUIqTpUO6PmvzU/2vzW4lGFdpUf3+vDX2V8/qFk2+WUvm1GiIJbAyaqgr9j+wD
	XSNI42kDKcO1gy6naohkQchk+/l7y/8+pI7vH5/BTX/m3lbBYterQYhgz35lBVYwbANvQC
	1uXZcTAJT5d9213G224MAJuslQKygA4KFoQCkCYdAMq717Yj8oNCNmDrRAZOTb2CuiC7tF
	8rWmLz532eHkGo1AGFiBF6gIDyE0MrnlpvQQO8SXpcpWjRmq9vn0q9Oar5OcF1NQekFhEe
	pJ03nMthyLu+wZCo1yPcFhHnjkiilAFZ8CGNbYQ1SvNmaVAb5wczoZkI0XdAsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nO8F5tJLBputdTHPp/ebEInBVW6FgJupfyZOs6vbz18=;
	b=0VJVWKEttz2DGBCPgDEo2uqMbFAx9+tJS7fDTf4HHTlXRT9IO0tk/osuWSdWVEypmQsdxY
	ClsFiv2BuN9IA/Bw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Remove return value for write_atomic()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-7-john.ogness@linutronix.de>
References: <20240820063001.36405-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287840.2215.11944459764766860529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     b7049d88c1763d5f133b0e93e39da8e89a9f944b
Gitweb:        https://git.kernel.org/tip/b7049d88c1763d5f133b0e93e39da8e89a9f944b
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:32 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: nbcon: Remove return value for write_atomic()

The return value of write_atomic() does not provide any useful
information. On the contrary, it makes things more complicated
for the caller to appropriately deal with the information.

Change write_atomic() to not have a return value. If the
message did not get printed due to loss of ownership, the
caller will notice this on its own. If ownership was not lost,
it will be assumed that the driver successfully printed the
message and the sequence number for that console will be
incremented.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-7-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  2 +-
 kernel/printk/nbcon.c   | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 31a8f5b..577b157 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -345,7 +345,7 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	bool			(*write_atomic)(struct console *con,
+	void			(*write_atomic)(struct console *con,
 						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 931b8f0..f279f83 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -885,7 +885,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -925,16 +924,16 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	wctxt->unsafe_takeover = cur.unsafe_takeover;
 
 	if (con->write_atomic) {
-		done = con->write_atomic(con, wctxt);
+		con->write_atomic(con, wctxt);
 	} else {
-		nbcon_context_release(ctxt);
+		/*
+		 * This function should never be called for legacy consoles.
+		 * Handle it as if ownership was lost and try to continue.
+		 */
 		WARN_ON_ONCE(1);
-		done = false;
-	}
-
-	/* If not done, the emit was aborted. */
-	if (!done)
+		nbcon_context_release(ctxt);
 		return false;
+	}
 
 	/*
 	 * Since any dropped message was successfully output, reset the

