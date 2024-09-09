Return-Path: <linux-tip-commits+bounces-2255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F69720E0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BF61F24425
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5018CC17;
	Mon,  9 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3lE4cYL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNixib0b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511218A926;
	Mon,  9 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902880; cv=none; b=nMmX1rlBOMMbs9G2btYc40otK1kyiwwNGcrzEKoS1SoxcjtJv5c+B2HnvKYpG1xrkoWsjWz9lge2rCUxd8v/w/yNE6/10SUHCfCfOeplWVF11CN2eyyapFrNVP942TdLKLUpfOzoOzXK1s5KRYWQw3YkpRuWtPbKO/WrDMfMzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902880; c=relaxed/simple;
	bh=0L801lFbiZudXNezIm4R2QddQ2NmkUivgHbffYYQk+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IG02WmpYz9mQwOIzIWAPUf9qjKBkdWFOt6JTLq2fK1TXpzXN6ZXdIHgj78yyQe+59C2K2t8MCnPZ1IjBoySvsb1dWIQRWtOIuk8/H3Nr70FZUEVFdN+oMGY9oLGr79eQuVUbW2wGDWKVijghQ6LBnpdm5FLhm5MtD69Jx3q18wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3lE4cYL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNixib0b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqweCNZtdFv4pHOoVXelU3v9sqhXwupBP482NQ1QmU8=;
	b=G3lE4cYLR4roUOUNWK7Lmgj5d17anOtJlZmIfCTlgA0dpku0PMc2CinuSL1jyp1KrqxhzS
	mxdSvYGoTwwzVwjYZe48JP3QckIh4kM7FKkWA2ZFuO/GFiz3/zaUm0wlnU9WgKoBPUlMzI
	wWcAnqZ/Xoke3t3/hAAfGUjQ5kEppmxzgnfEBUTLNcXrSiIV8ID6HCLTENeVwbjseLaoji
	mouQwUK+YigQO/4+A27VkXKiWGpkN5P3OTVeWoL2nrA6YSCCLWi3LYki6OYecA1ReYyJvT
	0uPVUitJzHvfhPcwUJQW6PPnYEGvPihbRPN4KtcJy7xhJ160FWI3wkBQrEIjqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqweCNZtdFv4pHOoVXelU3v9sqhXwupBP482NQ1QmU8=;
	b=JNixib0bxT9S3GFpeIXZ1JL2LIzgUsbDFBCD7YaRnczf28Ag8WBU/qIXTBnDEP5oWujpgT
	PlkDE867LJwbrsCg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Add helper to assign priority based on
 CPU state
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-20-john.ogness@linutronix.de>
References: <20240820063001.36405-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287373.2215.357602443102850406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     06683a6649895ccf279c35ca2fb77fd7afb7a6c5
Gitweb:        https://git.kernel.org/tip/06683a6649895ccf279c35ca2fb77fd7afb7a6c5
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:45 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: nbcon: Add helper to assign priority based on CPU state

Add a helper function to use the current state of the CPU to
determine which priority to assign to the printing context.

The EMERGENCY priority handling is added in a follow-up commit.
It will use a per-CPU variable.

Note: nbcon_device_try_acquire(), which is used by console
      drivers to acquire the nbcon console for non-printing
      activities, is hard-coded to always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-20-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index fe8d84d..72f2293 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -83,6 +83,7 @@ u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -136,6 +137,7 @@ static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e8ddcb6..c6a9aa9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -974,6 +974,25 @@ update_con:
 }
 
 /**
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Context:	Any context.
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ *
+ * The function is safe for reading per-CPU data in any context because
+ * preemption is disabled if the current CPU is in the panic state.
+ */
+enum nbcon_prio nbcon_get_default_prio(void)
+{
+	if (this_cpu_in_panic())
+		return NBCON_PRIO_PANIC;
+
+	return NBCON_PRIO_NORMAL;
+}
+
+/**
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize
  *

