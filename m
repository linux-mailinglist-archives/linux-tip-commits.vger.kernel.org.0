Return-Path: <linux-tip-commits+bounces-2240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C09720B6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C8F1C23AB5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE4189F59;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtMQpkKb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yx5z/RPC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CF1891AC;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=sjcyrbKzQhQSqIWasAOmEHPl/rC4VcFLYaBZmgQUtqGJ4iClBtRdnUmYMuWAEfYduddfufGe+Wgda8N9uoutpwIcu06vx83ntPXqK0LuS5fsBxgrb0aTPAd4ZdCVuxQfrmyC2OmvDY36D0ODCB69Q0i32ogKHxBKaK0MUd0ox+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=MsBqC1VpthpHmaJSN20NGZZF5KMuFoehHHUgdc7HYoQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ydvf1oXrrsDVo72bY2/XX392x4wL89izXQHMJVZOZukxk2c5JAASOuAnsRCo414fWL4UfGG2KuMaBfw4hr3qHX0bcR7IYNEufzG4Mq9Bych63RbdkACBTopAEDkeM8hbPXXLIV+zLDS9PfPMhET+b+iazfDzTS2cjvFsv7GYdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtMQpkKb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yx5z/RPC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AIXJQOMz7Qu0zgk2ryH7vCVfbGuT1JmTEpWA0ZvpFM=;
	b=AtMQpkKbb4eLiBXhR1PCV3P9R98HJ1roo962b0mE2kuQqp1iwQuxIC7at8JLgGE39KS6KS
	WSoAWGdUe3jjo6EAerlJdsDXFDZsDlgTDQCGmkuMR1omnHdpiT/auVlqZlSPJRPHabTerM
	Mdfft/RC6BNQLHwl+f2Kxru++STt6pAdyySsQXp8sDWUjVAHebFoAjlW6BvycVZIRfEazf
	bhJjFPiql9r1eHdi41HQqKtUOYwA+9dUI3a5fLCseZMwVq9p/a13PSxiaS6rQf1xrKZA7t
	ptUBfWJlnLseI2eUlSuR/AIk+/WI07H7qG5ojoCAJaqNXz+l1LabBgKGsEsJAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AIXJQOMz7Qu0zgk2ryH7vCVfbGuT1JmTEpWA0ZvpFM=;
	b=yx5z/RPCPD2UEcxFDLFoUxMSnx5AYEkqsEYNhd4RBKEKZB7u5KIFb+EWgVZ/++lrZ7SU4P
	Ru9/4db7+ptpl4Dg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Coordinate direct printing in panic
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-30-john.ogness@linutronix.de>
References: <20240820063001.36405-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287018.2215.14952488477401338106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     e35a8884270bae11196eedf3b0a5bf22619f11f2
Gitweb:        https://git.kernel.org/tip/e35a8884270bae11196eedf3b0a5bf22619f11f2
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:55 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:25 +02:00

printk: Coordinate direct printing in panic

If legacy and nbcon consoles are registered and the nbcon
consoles are allowed to flush (i.e. no boot consoles
registered), the legacy consoles will no longer perform
direct printing on the panic CPU until after the backtrace
has been stored. This will give the safe nbcon consoles a
chance to print the panic messages before allowing the
unsafe legacy consoles to print.

If no nbcon consoles are registered or they are not allowed
to flush because boot consoles are registered, there is no
change in behavior (i.e. legacy consoles will always attempt
to print from the printk() caller context).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-30-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h   |  5 ++++-
 kernel/panic.c           |  2 +-
 kernel/printk/internal.h |  1 +-
 kernel/printk/printk.c   | 55 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2e083f0..eca9bb2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -200,6 +200,7 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
+void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
@@ -286,6 +287,10 @@ static inline void console_try_replay_all(void)
 {
 }
 
+static inline void printk_legacy_allow_panic_sync(void)
+{
+}
+
 static inline bool nbcon_device_try_acquire(struct console *con)
 {
 	return false;
diff --git a/kernel/panic.c b/kernel/panic.c
index df37c91..93096d5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -374,6 +374,8 @@ void panic(const char *fmt, ...)
 
 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
+	printk_legacy_allow_panic_sync();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7679e18..6b61350 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -154,6 +154,7 @@ static inline bool console_is_usable(struct console *con, short flags) { return 
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool legacy_allow_panic_sync;
 
 extern struct printk_buffers printk_shared_pbufs;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e30107d..fc3f897 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -471,7 +471,9 @@ static DEFINE_MUTEX(syslog_lock);
 static bool have_legacy_console;
 
 /*
- * Specifies if an nbcon console is registered.
+ * Specifies if an nbcon console is registered. If nbcon consoles are present,
+ * synchronous printing of legacy consoles will not occur during panic until
+ * the backtrace has been stored to the ringbuffer.
  */
 static bool have_nbcon_console;
 
@@ -483,6 +485,9 @@ static bool have_nbcon_console;
  */
 bool have_boot_console;
 
+/* See printk_legacy_allow_panic_sync() for details. */
+bool legacy_allow_panic_sync;
+
 /*
  * Specifies if the console lock/unlock dance is needed for console
  * printing. If @have_boot_console is true, the nbcon consoles will
@@ -2330,12 +2335,28 @@ out:
 	return ret;
 }
 
+/*
+ * This acts as a one-way switch to allow legacy consoles to print from
+ * the printk() caller context on a panic CPU. It also attempts to flush
+ * the legacy consoles in this context.
+ */
+void printk_legacy_allow_panic_sync(void)
+{
+	legacy_allow_panic_sync = true;
+
+	if (printing_via_unlock && !is_printk_legacy_deferred()) {
+		if (console_trylock())
+			console_unlock();
+	}
+}
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	bool do_trylock_unlock = printing_via_unlock;
+	bool defer_legacy = false;
 	int printed_len;
-	bool in_sched = false;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2349,17 +2370,35 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
+	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		in_sched = true;
+		defer_legacy = do_trylock_unlock;
+		do_trylock_unlock = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && printing_via_unlock) {
+	if (have_nbcon_console && !have_boot_console) {
+		nbcon_atomic_flush_pending();
+
+		/*
+		 * In panic, the legacy consoles are not allowed to print from
+		 * the printk calling context unless explicitly allowed. This
+		 * gives the safe nbcon consoles a chance to print out all the
+		 * panic messages first. This restriction only applies if
+		 * there are nbcon consoles registered and they are allowed to
+		 * flush.
+		 */
+		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
+			do_trylock_unlock = false;
+			defer_legacy = false;
+		}
+	}
+
+	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2379,7 +2418,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched && printing_via_unlock)
+	if (defer_legacy)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -3292,7 +3331,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (!have_boot_console)
 		nbcon_atomic_flush_pending();
 
-	console_flush_all(false, &next_seq, &handover);
+	/* Flush legacy consoles once allowed, even when dangerous. */
+	if (legacy_allow_panic_sync)
+		console_flush_all(false, &next_seq, &handover);
 }
 
 /*

