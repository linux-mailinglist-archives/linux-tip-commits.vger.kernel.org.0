Return-Path: <linux-tip-commits+bounces-2254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7679720DE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10718B2246E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05718C937;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgWD9j07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7BsnAeF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96318B48F;
	Mon,  9 Sep 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902879; cv=none; b=nXJUj2llOWYWATAr5uKtiUgtV+0TOF8UoJQ/+SAGvpQJ0q4kbtFnRAWdL2dRZs+aGh9U7ayWQ5PNlT0dtjq5c95lKydHnwQFXgw5+hWJ7wWmgbzZOriKFfW3Mfffn7KlZAIhFe8xA8lsZY8Igvnv7fLXOmlj8WtnUiACPJ/2Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902879; c=relaxed/simple;
	bh=W/nctKL1qXXYxMDysZWxmwjxQiAFI7ZE5XR0hgNITjo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H59BCsb3+m6WXZBTW5FH4D8yxIfMsXvpQxZn495ruBfOdFmhMQJ0QXDbFr/dSyiqs4j4yWzjbGUvX/Wdd+VBHr6DuMYPHoEyhHDcG3+ok1ud3V7Uvy+8ah3Td+dY9Wl3kJdmA806a4ye5MpXHobOKAkotge05nCcgceZTtuyf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgWD9j07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7BsnAeF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6RbI5dJDyTqL2tEBZfvALuu7YvrI88njbtqeJQwQMg=;
	b=xgWD9j07NCad973r2G0Z3Kn9LI9afuLACS3fKl2OBe7JwUgnQSTM5ciug1W/dNIqIefT58
	sgMLsSY5u52rNOpIzz89Hyw0HGnUCBMv4eX1v1FG5JVNfv1x4usmshAel9XgkwNoNpcInF
	ysVSnu3BQ7Pjiu7ZPb3Hf9LF27rpLdWFFfXo9FEWcFHwgTHnxEfqOL2hYNW7SajlAUenGn
	GscN5tCVR1WXN5d0Ub+XHkOgE39+R1EWgcPM2pSi21Z4ygoDNYg/9pVTAt3/CJvAfL51CK
	076FyxLsQQ3JJrbJ5FsG4RJGNX+h0r+moc/1o2H9cC7WUbGhxK8jWkCdLw5p9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6RbI5dJDyTqL2tEBZfvALuu7YvrI88njbtqeJQwQMg=;
	b=E7BsnAeFdcbnHQ3/YSL5UGm/9D8eJvR0Muysan1eMY56yZ4w9dOaF6BkTKuKBQx+c8RtTV
	6I7AqxG41Tu8hjDw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Make console_is_usable() available to nbcon.c
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-17-john.ogness@linutronix.de>
References: <20240820063001.36405-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287472.2215.15832666093520891015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     864c25c83d834bdf2cb5a24c768d37236b418410
Gitweb:        https://git.kernel.org/tip/864c25c83d834bdf2cb5a24c768d37236b418410
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:42 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: Make console_is_usable() available to nbcon.c

Move console_is_usable() as-is into internal.h so that it can
be used by nbcon printing functions as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-17-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 32 ++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ccb9166..5d9deb5 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,36 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_srcu_read_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -104,6 +134,8 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4cd2c50..b9c8fff 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2767,36 +2767,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con)
-{
-	short flags = console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;

