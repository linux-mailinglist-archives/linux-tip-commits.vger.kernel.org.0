Return-Path: <linux-tip-commits+bounces-2251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B59720DA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EFD283D01
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7518C34F;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VL9KSNq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pb0wzIwA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3D18B467;
	Mon,  9 Sep 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902878; cv=none; b=Qp/+funhZZ9Zar1IUInVcb8F597byMcDX1POewZpBURagE7t55Ia5ROmCtePWIbNTzs0AHedTjrjET2iX3YG2OVqOVGzpUDr7gpA6ikjrvgqFd8u++eZtXz/ZeSG6CVzr+waPgB8v0RR/NsXD5qMXyNfo1tOMj+TC8UX3o0Srww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902878; c=relaxed/simple;
	bh=pct4dL4eaZfDblBX99WCOLwMb655gzQDQ5ViIAd12yw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gkj7nUI1khRXD2H93OTQJPT8+9MpZJxO/J9XT1yyH2VRd40SxNk0GpPaTuDi334x9sQPFxnO/xHLCVrZT0TLSHK++qE6xNTtkV2J8SMKSsKyd45QTbLp2uvTMOjG9Vv7KwdWVYKUW/KhUCTNN5n4wFBsEWHjN48GtHde5CfvrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VL9KSNq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pb0wzIwA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng8i/ioIDlzNK0X/BZQQxIyDIt1yA+1O44yyaW5TxPg=;
	b=VL9KSNq79SZr5DdWkxWmmn/meUPFBo6GHZ35wofSNeaZRLwFQrWDUy/1Nr9PVSDB7gNQGB
	w3h4tTwNXF61oc+w0EZG5qZAob8b7pz5VDYsjOZjIUPTLfKh4nJx80bf4on4nDbW82aDCf
	qML184VQPJXO7zOZgpz7mQ1YHjUutYVAgBcLmzdXVmSX/ETtMbG2J/HZ5uPHaJtlnpRInK
	LP//VTdNNokPIkLqcroe2dtObQQ0PYfJ3eXlSlrEIdfEVhsS3OVWz5mIW/FWS0oh635nbt
	FQajYDoaBG9FtkRgMhWJvcKDAExaTuI1S/Uh9ApwowhSj+sH4n55gf1qXFh84A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng8i/ioIDlzNK0X/BZQQxIyDIt1yA+1O44yyaW5TxPg=;
	b=pb0wzIwALTGGCKEmME9da62UmHhzZe3oXjPmRdKx01mjSAxmx4cRB47na0ol1ayHXrOB+V
	r2RzNVqkVbv/jXCg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Add @flags argument for console_is_usable()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-19-john.ogness@linutronix.de>
References: <20240820063001.36405-19-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287405.2215.13378354005682548786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     fc400d5f63570afdadd718ae962cf5aa0feeace6
Gitweb:        https://git.kernel.org/tip/fc400d5f63570afdadd718ae962cf5aa0feeace6
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:44 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: Add @flags argument for console_is_usable()

The caller of console_is_usable() usually needs @console->flags
for its own checks. Rather than having console_is_usable() read
its own copy, make the caller pass in the @flags. This also
ensures that the caller saw the same @flags value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-19-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 8 ++------
 kernel/printk/printk.c   | 5 +++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 448a5fc..fe8d84d 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -89,13 +89,9 @@ void nbcon_free(struct console *con);
  * records. Note that this function does not consider the current context,
  * which can also play a role in deciding if @con can be used to print
  * records.
- *
- * Requires the console_srcu_read_lock.
  */
-static inline bool console_is_usable(struct console *con)
+static inline bool console_is_usable(struct console *con, short flags)
 {
-	short flags = console_srcu_read_flags(con);
-
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -141,7 +137,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b9c8fff..ffb56c2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3012,9 +3012,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3925,7 +3926,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {

