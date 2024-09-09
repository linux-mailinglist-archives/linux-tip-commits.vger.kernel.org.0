Return-Path: <linux-tip-commits+bounces-2243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E69720BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385251C239FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894318A6D4;
	Mon,  9 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNWD2wuY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCq0jqVU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728F17A924;
	Mon,  9 Sep 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902875; cv=none; b=DLdRXhBqVGYz/qJ7h+RynbvZXcgvBuFEzwBlW2+ijgJH21pDGq1Mah1TPviR+UrIG7f6FkgFT3VfdmV1gWk3VkTHkPaqzdzpRa71koraSWFhRLpaQ5OVg7xNtsrJNF1QY+/FboyasaSRaUf0D61qS41W/6x706ar1uIwIZWHEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902875; c=relaxed/simple;
	bh=XtkaIctCbT6l/v/DVDNDZIZmVDefY6uU3oZvvZdxxL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AkLJOJZ+/mtjZAumFDHJBw7/bblIHmF3aYxekCGzZT0rjJoqTgw8l0srQQiaqYuw/GHOSNRd6US6q6fcgl5RTsXgTER4KwONZcax3/xOeOXz4/l50rQGmojPlVAQaemDJWVmKmW59/a0v1GANDsIkivXoPmjZE7ScYOqC05B3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNWD2wuY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCq0jqVU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMmg9fgzsSfwkRCKLN9omhD0Epo2yIHA+fpbs23eniA=;
	b=oNWD2wuYS50e0BEDM+3IfQ/md5DYzQzbuF7hFLyTVpwk1GMDzYJrOFAudGD3YQ9zh5CO1d
	cJCjzSptcGQ87q7P93SoLhVAJOok3qaajSKFnlqWhlArCJxef7mGOXOVpeJRB+3pPB3zXA
	R9ypP/HgTiarzOx7q6ZUXCGe7c8OLUjBFk0m19TB97EGhWttjuPyI/aS3BIJkUE7Sr3de5
	Th69SGUwBxSdWaTgHwbhC4YMDx85EgfAOYb8N2UVtLLyzNxorYeqxYZUhrfoJ4dXH5pjfA
	c4FZGBmSVnuBKv2d1Rj5YSxDflEZTTiPP0Liels5MRZIhd42J3CkRbsUBqMkAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMmg9fgzsSfwkRCKLN9omhD0Epo2yIHA+fpbs23eniA=;
	b=aCq0jqVUC1CxKPDeZAlhYbv2H1ubhweEj7RNnoBe3xatfmNEmPL3JFFUyAp1XjLeZa92JU
	BFPGNu5oOgTaDyBw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Avoid console_lock dance if no legacy or boot
 consoles
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-28-john.ogness@linutronix.de>
References: <20240820063001.36405-28-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287088.2215.7321612194660582818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     60013065fdc677df7b71f9a0bac501020e3bbd4f
Gitweb:        https://git.kernel.org/tip/60013065fdc677df7b71f9a0bac501020e3bbd4f
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:53 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: Avoid console_lock dance if no legacy or boot consoles

Currently the console lock is used to attempt legacy-type
printing even if there are no legacy or boot consoles registered.
If no such consoles are registered, the console lock does not
need to be taken.

Add tracking of legacy console registration and use it with
boot console tracking to avoid unnecessary code paths, i.e.
do not use the console lock if there are no boot consoles
and no legacy consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-28-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c6e6333..b3ddcf3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -464,6 +464,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 /*
+ * Specifies if a legacy console is registered. If legacy consoles are
+ * present, it is necessary to perform the console lock/unlock dance
+ * whenever console flushing should occur.
+ */
+static bool have_legacy_console;
+
+/*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
  * the console lock. This is because boot consoles and nbcon consoles may
@@ -471,6 +478,14 @@ static DEFINE_MUTEX(syslog_lock);
  */
 bool have_boot_console;
 
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2339,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && printing_via_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2359,7 +2374,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched)
+	if (in_sched && printing_via_unlock)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -2718,7 +2733,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && printing_via_unlock) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3625,6 +3640,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_NBCON) {
 		nbcon_seq_force(newcon, init_seq);
 	} else {
+		have_legacy_console = true;
 		newcon->seq = init_seq;
 	}
 
@@ -3701,6 +3717,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool found_legacy_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3768,9 +3785,13 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
+		if (!(c->flags & CON_NBCON))
+			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
+	if (!found_legacy_con)
+		have_legacy_console = found_legacy_con;
 
 	return res;
 }
@@ -3931,8 +3952,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
-	console_lock();
-	console_unlock();
+	if (printing_via_unlock) {
+		console_lock();
+		console_unlock();
+	}
 
 	for (;;) {
 		unsigned long begin_jiffies;
@@ -3945,6 +3968,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		 * console->seq. Releasing console_lock flushes more
 		 * records in case @seq is still not printed on all
 		 * usable consoles.
+		 *
+		 * Holding the console_lock is not necessary if there
+		 * are no legacy or boot consoles. However, such a
+		 * console could register at any time. Always hold the
+		 * console_lock as a precaution rather than
+		 * synchronizing against register_console().
 		 */
 		console_lock();
 

