Return-Path: <linux-tip-commits+bounces-2267-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759569720F3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAB92854BD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749318EFCB;
	Mon,  9 Sep 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAn2CC7M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoRoEzh4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018C18DF60;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902884; cv=none; b=ewK65HyRKVMsTgX3Vbn8XTEj/sXHpai8ryvZbxHKUtJi7YjCaHokbpL3rMmbrvjFOlxxGf/8Bc/9gkNa9ZqdAUcc58wJ4xIyqOzPJ003kr+uF3xQy2lr5HF98tcfmECMXc+psAyIPfmjKQ76674bNyrhXfQb9LAjyDHWd/6Zb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902884; c=relaxed/simple;
	bh=55O1q5/xjGmWaDiFKecd5ROsl2i56C4XcmLd12rwhkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O2PkXKFp3Sl5HtP54gp0y3kuISzyhxY7Y8ZXoP399iap0U8ImdovYjFpYUtLjEyf8gIB1vJ2B5xoWpO9BLRBd/tsuoAlrgqV0fkQ/6z8NnoKtWaq92HzlgJ9Xd3s8tOomdqK09affPeqbr+Hr4gr9klSoCGCdEfnhs+X61W/G5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAn2CC7M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoRoEzh4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0BuJlFz7B6uWBsbc/aN4Gt2KuT0X71Tm+RTlNLoMYA=;
	b=SAn2CC7MLGrYvgmeKrbakZJ4dglB7n24Y4t4Ez8coTNtNCqeb6c13mtiogR4eyXb3bOVke
	Qu8aLKLHXM7dszMMKwDZ+6iW54MjezB7q6Qb4He3TLOldnl+YgG12K8CJx8zt35dO8JY9S
	fvMcUQsB65SA3Eu5cie0+yJ9Lf1Qhmx+4fhP2+GkCGiXHPOeiN61+Wvz0fQRLMJT5uUj4i
	vjJAT8d9RVmyWECJEetwVQvc1CjeG6a3HuDUYYj0/EVQVg1odjfZ9JkBs93Xi20C0xv1pe
	7VDtuzGIM71ITBPPdISU0ly+F5Z2Dukitkd7fT1kh4mZ2Vrb3h2W6eFHb2GSYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0BuJlFz7B6uWBsbc/aN4Gt2KuT0X71Tm+RTlNLoMYA=;
	b=zoRoEzh4eQ5C3Ri03OcgolMw5OnrMbGmeJq+ojsYvOQbc8VJn1Jpl9fgQLZIlQ1LMEfYRT
	xejvQZQRq9O/5mBQ==
From: "tip-bot2 for Petr Mladek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Properly deal with nbcon consoles on seq init
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-4-john.ogness@linutronix.de>
References: <20240820063001.36405-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287939.2215.12784246691143815903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d3ff380d47b6312d537c00829008528d1caad639
Gitweb:        https://git.kernel.org/tip/d3ff380d47b6312d537c00829008528d1caad639
Author:        Petr Mladek <pmladek@suse.com>
AuthorDate:    Tue, 20 Aug 2024 08:35:29 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:22 +02:00

printk: Properly deal with nbcon consoles on seq init

If a non-boot console is registering and boot consoles exist,
the consoles are flushed before being unregistered. This allows
the non-boot console to continue where the boot console left
off.

If for whatever reason flushing fails, the lowest seq found from
any of the enabled boot consoles is used. Until now con->seq was
checked. However, if it is an nbcon boot console, the function
nbcon_seq_read() must be used to read seq because con->seq is
not updated for nbcon consoles.

Check if it is an nbcon boot console and if so call
nbcon_seq_read() to read seq.

Also, avoid usage of con->seq as temporary storage of the
starting record. Instead, rename console_init_seq() to
get_init_console_seq() and just return the value. For nbcon
consoles set the sequence via nbcon_seq_force(), for legacy
consoles set con->seq.

The cleaned design should make sure that the value stays and is
set before the console is added to the console list. It also
unifies the sequence number initialization for legacy and nbcon
consoles.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20240820063001.36405-4-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c  |  3 +---
 kernel/printk/printk.c | 41 +++++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 670692d..776746d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -172,9 +172,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
-
-	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
-	con->seq = 0;
 }
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a47017c..20c3950 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3448,19 +3448,21 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-static void console_init_seq(struct console *newcon, bool bootcon_registered)
+/* Return the starting sequence number for a newly registered console. */
+static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
 	bool handover;
+	u64 init_seq;
 
 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
+		init_seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
 		/* Begin with next message added to ringbuffer. */
-		newcon->seq = prb_next_seq(prb);
+		init_seq = prb_next_seq(prb);
 
 		/*
 		 * If any enabled boot consoles are due to be unregistered
@@ -3481,7 +3483,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3494,19 +3496,30 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 				if (handover)
 					console_lock();
 
-				newcon->seq = prb_next_seq(prb);
+				init_seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!(con->flags & CON_BOOT) ||
+					    !(con->flags & CON_ENABLED)) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
+					if (seq < init_seq)
+						init_seq = seq;
 				}
 			}
 
 			console_unlock();
 		}
 	}
+
+	return init_seq;
 }
 
 #define console_first()				\
@@ -3538,6 +3551,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3615,10 +3629,13 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
-		nbcon_seq_force(newcon, newcon->seq);
+	if (newcon->flags & CON_NBCON) {
+		nbcon_seq_force(newcon, init_seq);
+	} else {
+		newcon->seq = init_seq;
+	}
 
 	/*
 	 * Put this console in the list - keep the

