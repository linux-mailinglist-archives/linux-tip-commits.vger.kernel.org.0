Return-Path: <linux-tip-commits+bounces-2241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164319720B4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4063F1C239FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474E189F58;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDt/QHXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ExN0S28A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD0189513;
	Mon,  9 Sep 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=Tk0+/ufyvEUN4PqYvCRe7xIJEINdJJD0fyQ0zhhsbBcAGf8cgf0iklm91QWcJxqYO2v467ME9COr7fWVctA6lDF+kWZ3+Dtm9Bo1NB01A8BXVs567UvMJVFbppkb6Hu9GLvWzd7aIk03ZKktyS2yR8++j2OEO+jdi6Hb6KuXMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=Pz6ZdJpoSvTEzgWu86TP6StDaVCzWE+NOP+gLzD32hY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y8wuaETSjqgFIzGniqg4ltTr93Boz8xZ4ZjCXB14029gsnehETHVSH/QdeF3ZPDBx0SmvzCF3buIuag8jVCfrxnvyxMUV6neagnLHOWova6GMfGGrIl+JElSZtZ/l5gQj+EASvedWdGEkoOYyzbavB8Cw3yEMsKxFn34BRcRe+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDt/QHXQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ExN0S28A; arc=none smtp.client-ip=193.142.43.55
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
	bh=MZx3DDF1r9Q/URo5IabeuJhmCjBew6G0Q/phPmn9yCk=;
	b=dDt/QHXQhrlVbvMs2c41KpKUdLfZynH1tDZQ0VPwFYoU6FxrDEMJVQos34dB/RrF2UiQxT
	vjgd2mVcM1DCpCiGUlfvCIvo+IF6/p4vv8CuebgJUiGfYfaVjTFpcXgnnkys9/kIrWPhv+
	3rKlStehbef3NPptcLHseqbx46+dEjKzBe1gz+iLjjve3Be7mz/FETTGTHZc0JvpD2rQHt
	mTDly+foCgCGaVOj7C7r9A7JyHaFo5cpXVMiEICnRb86tgyHDi5iRVmNTJDAKrqZLziIUd
	sFG+2ZO+nY239DbBJdU+4Im8REfgDkt5oqHGdv/M5mw5mamO0mqEN1qG6J4Cdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZx3DDF1r9Q/URo5IabeuJhmCjBew6G0Q/phPmn9yCk=;
	b=ExN0S28A9fFAY86SGCF61dP3lgryz+b2SaQlHUzBD+XXyQUCoMdknWXtFrgE+SvVc4eHn6
	wajbPQtNy1eJ7qDw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Track nbcon consoles
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-29-john.ogness@linutronix.de>
References: <20240820063001.36405-29-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287054.2215.3818665511141537296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     bebd87ae27e052e390c203893c7ee46f54b0bf9e
Gitweb:        https://git.kernel.org/tip/bebd87ae27e052e390c203893c7ee46f54b0bf9e
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:54 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:25 +02:00

printk: Track nbcon consoles

Add a global flag @have_nbcon_console to identify if any nbcon
consoles are registered. This will be used in follow-up commits
to preserve legacy behavior when no nbcon consoles are registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-29-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b3ddcf3..e30107d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -471,6 +471,11 @@ static DEFINE_MUTEX(syslog_lock);
 static bool have_legacy_console;
 
 /*
+ * Specifies if an nbcon console is registered.
+ */
+static bool have_nbcon_console;
+
+/*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
  * the console lock. This is because boot consoles and nbcon consoles may
@@ -3638,6 +3643,7 @@ void register_console(struct console *newcon)
 	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_seq_force(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
@@ -3718,6 +3724,7 @@ static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3785,13 +3792,18 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
-		if (!(c->flags & CON_NBCON))
+
+		if (c->flags & CON_NBCON)
+			found_nbcon_con = true;
+		else
 			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
 	if (!found_legacy_con)
 		have_legacy_console = found_legacy_con;
+	if (!found_nbcon_con)
+		have_nbcon_console = found_nbcon_con;
 
 	return res;
 }

