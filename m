Return-Path: <linux-tip-commits+bounces-2246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E991B9720C7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DD71F23F32
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4818B463;
	Mon,  9 Sep 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbxFrkWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4sN6/eUy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC1189B91;
	Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902876; cv=none; b=kPxbH9hFN5IwImKPL9mDPP3rl5+20KwOZOpGZRky9mvb3CIRrxT4SjGBc6ILvpYcL77LvJCMZ9B4KbwttSwVp/DPGdl5H4dj28cn/ihkl0JzNl04P+Ex6VOhwSlvlNUSis5vcE/gubix9QePBxvv4F9YVtjzxOLL8wZ2VzxkwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902876; c=relaxed/simple;
	bh=fLTJdwqO1ex+RXhTGw89O5VjBzR1G2xtHNpfKWkVRXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o5AndukuyHP5m+ag1F+0gFs8DjAAxK1vK0uKJOIQ+/sZwxlGPPh7EU71HT9EiBjvmz4ub3HfTzOGu2Zb3FCHWwQnR2hvfJ5NiYPiwnF3Fibaj1XG9CTuEEaXXpH38cTsyOolvaGrmYNHoLch4aykMIQZnhXZxkzhAjtv2uFUP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbxFrkWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sN6/eUy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqjD7G3+0ukXSCMP5YmD8/CX4gU5RSs3gut/ku5XF1M=;
	b=MbxFrkWUaCy1V3+U1Vw0LYwlhCPkxIN0mcoOUT+Gu2SzhrWs2tYUAQhFKguae/YX8NK/S3
	jiswrIa4cDR/ZvuvBkLGAVQIB2FyZN1GznPicE0RImU+nMyubmeGXbRAPtAudHMNRDOflD
	xbqDjVy1LLwuCiFy7s2RtggFopmellFT7B3w6CMhQ0Vmu1kZPc6xNpFs8xbdce3ZuXWBug
	7dD7oUBJgfAxNvH3OhtpiklO5cLQN2DwWi2JMvnYh6XYIimDT1QEse/uAG09HkTV3M/Q8n
	WuNncuvKi3/+dPEODxX+zMZ6t1Q6hVeIV165Dj4c5juve51ecdCBzDn4Kw4TFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqjD7G3+0ukXSCMP5YmD8/CX4gU5RSs3gut/ku5XF1M=;
	b=4sN6/eUyzFZJTAz10KJLKwLak6Ft6a8E5NtyGP5WQNVzedsSqWbkkO885QdbK09NKNnNZc
	ixdPsEWsMkDHbcBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Flush new records on device_release()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-25-john.ogness@linutronix.de>
References: <20240820063001.36405-25-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287194.2215.12714179595232740042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     8ba77712a7501ca941603d6d5ed650cd0d42cafb
Gitweb:        https://git.kernel.org/tip/8ba77712a7501ca941603d6d5ed650cd0d42cafb
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:50 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: nbcon: Flush new records on device_release()

There may be new records that were added while a driver was
holding the nbcon context for non-printing purposes. These
new records must be flushed by the nbcon_device_release()
context because no other context will do it.

If boot consoles are registered, the legacy loop is used
(either direct or per irq_work) to handle the flushing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-25-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 20 ++++++++++++++++++++
 kernel/printk/printk.c   |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 84706c1..7679e18 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -153,6 +153,8 @@ static inline bool console_is_usable(struct console *con, short flags) { return 
 
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d09c084..269aeed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1326,10 +1326,30 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return;
 
 	nbcon_context_release(ctxt);
+
+	/*
+	 * This context must flush any new records added while the console
+	 * was locked. The console_srcu_read_lock must be taken to ensure
+	 * the console is usable throughout flushing.
+	 */
+	cookie = console_srcu_read_lock();
+	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		if (!have_boot_console) {
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+		} else if (!is_printk_legacy_deferred()) {
+			if (console_trylock())
+				console_unlock();
+		} else {
+			printk_trigger_flush();
+		}
+	}
+	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f08bf5e..7c9f8f6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -469,7 +469,7 @@ static DEFINE_MUTEX(syslog_lock);
  * the console lock. This is because boot consoles and nbcon consoles may
  * have mapped the same hardware.
  */
-static bool have_boot_console;
+bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);

