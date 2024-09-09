Return-Path: <linux-tip-commits+bounces-2249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4C9720D4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D32283CC6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2A18C01B;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tG119+L2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/hGCA4NT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96918A6AE;
	Mon,  9 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902877; cv=none; b=K/TEMW33DSLiAyjp9BpC7rIGz1bgqwEP/rcxlruMVTL9xne7SOT7qc3SFueBg83rAwV9SbE3bO7ULB8hrhRlw6rI/qEt9/WD6tPgXp0ujVKkUxGiH8rgbZjp6FfzVHoMKp7RUtpMzkR47KjUb50d217ZrP/d8Mgdw7j4pn8+t7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902877; c=relaxed/simple;
	bh=IXqFvl1G2OtffA8mkMDHaCTMS/y175PPLKzB338m0+I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZiSTLwi2SjWLEFhDF1/4bRAA/QZNgS15KL7AalcILjxlSq7nYZ57o/SX/O0hFABxKIv2MQ6mAQ60wyeBJWgaRgwT0+RN3XaRMBdFIki1rO5hHzIuzo+DoBtriYlGJtdRWAu/op9epyIGmS646Ut0N6tukalBB2xFj8JYUnoIT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tG119+L2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/hGCA4NT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUcLXhgKXy4ADBbVgk1zKmmZPjqFPrZS3ZnQiUeFVbQ=;
	b=tG119+L2LvQnjJVxa95Vp5+2JT9TV7eWDexG/hbAx0rZJ2DBwowlfDoELqbxsu01zCrdv7
	hxnDSbzNFxU/bJ1ERaRwOIUtBCFINRmTzb1Dn33Zr3XD9TYHCEueaZvUghxTpI3MHEBv+2
	DNgQV7W0QEpvTSkKarZ6v5SbVUPHjDvyk/WvDrh8kuHYfjfeu5gsipeT3ktQPtnFmdVesy
	JyXVIO8q4PruR9vcbqfRDB2bMr3vM1Ap+4wvJPnut4cCdcMtOkDbT5ARJSgb1i3Vi2QT8U
	jowBWJsVWN6cK6SQons5/5qeJjSOYitRiJaj6CZogZ71ayS4fi0dv6q70Y2D8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUcLXhgKXy4ADBbVgk1zKmmZPjqFPrZS3ZnQiUeFVbQ=;
	b=/hGCA4NT+Fk1rfQgyen802mU5/Jv3ySchfp1l289crpYbyCCmIewHb8CB2JGab+F/v91Jd
	tLF8enU1NjDTLVBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Track registered boot consoles
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-22-john.ogness@linutronix.de>
References: <20240820063001.36405-22-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287304.2215.15088523540254572825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     97ea9bccfcbe4c97f127e736823cc8d984d781bf
Gitweb:        https://git.kernel.org/tip/97ea9bccfcbe4c97f127e736823cc8d984d781bf
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:47 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: Track registered boot consoles

Unfortunately it is not known if a boot console and a regular
(legacy or nbcon) console use the same hardware. For this reason
they must not be allowed to print simultaneously.

For legacy consoles this is not an issue because they are
already synchronized with the boot consoles using the console
lock. However nbcon consoles can be triggered separately.

Add a global flag @have_boot_console to identify if any boot
consoles are registered. This will be used in follow-up commits
to ensure that boot consoles and nbcon consoles cannot print
simultaneously.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-22-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ffb56c2..b8634a1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,14 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a boot console is registered. If boot consoles are present,
+ * nbcon consoles cannot print simultaneously and must be synchronized by
+ * the console lock. This is because boot consoles and nbcon consoles may
+ * have mapped the same hardware.
+ */
+static bool have_boot_console;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -3610,6 +3618,9 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -3680,7 +3691,9 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool found_boot_con = false;
 	unsigned long flags;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3738,6 +3751,17 @@ static int unregister_console_locked(struct console *console)
 	if (console->exit)
 		res = console->exit(console);
 
+	/*
+	 * With this console gone, the global flags tracking registered
+	 * console types may have changed. Update them.
+	 */
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			found_boot_con = true;
+	}
+	if (!found_boot_con)
+		have_boot_console = found_boot_con;
+
 	return res;
 }
 

