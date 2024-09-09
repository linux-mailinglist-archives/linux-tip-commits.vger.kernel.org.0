Return-Path: <linux-tip-commits+bounces-2257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5E9720E3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CF11F24888
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880518D625;
	Mon,  9 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8ZevcmX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/BfTvwvx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708F17C7BF;
	Mon,  9 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902880; cv=none; b=GAv6zGtWoEeBGABVx1+x/ZFTN8ah6HB7JPKG/6sMhE2MRjjeDksyZYdX0VGGeVAjKjKzCFnw2CiwxJSjtZ0jNttpgetCHaDZUhMAE5gg0+AdPTx1wl9bflyW27/umg4mwKp7OevdduNc10utN3Dzj2ngTWkz02VAC1DDm4zlI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902880; c=relaxed/simple;
	bh=Z7CqZicZ909bjuNnYUZdkfKAY/NZZQFXg77ZAn0s7Ko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CUHXwDpwyktN40ZQhWOszuVZs4LZ8Q5J9KCTjliZTov9ezoMngzOlsOyUb6V/EhRdzjsgEztMM/jp4eJE0OPp+T85F4mZ5JXJlkO3NRnp6sasNBxeBsZ6lD3ISvPAnQhqlLpTMXPmZti2/0Q/gLih2OLg+vItp0qKL87hFIRrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8ZevcmX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/BfTvwvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnZvR6dbT5qXe8yNj6Za/v9QDXrIZ8GuEfWeVZP4jZY=;
	b=f8ZevcmXmJmo278q0s/u8wFlWtcyPrdbf8x6DKJ9vAQwmMFswhN9QpRPMXLzAWkBxkGZ+D
	M1wisHr0XMXggb7FMHuNsEznn3EHm1L7rKCawIm46T1nspAqqo/UQNHKuc4aR0xVa/vXtL
	haCQ9FkCAO9GJTLzXKmpJuACyEGUaFe0sVXTkfkB0TLM5Z9nuTcE/1/MoQlIhiw3ZFMyS1
	U+hKpdnX24lHq58J5+Zgux9olaKezvrl97AmlpIpTq2dgFJ0GlYKqVI6HVm8SiYpGmSyfk
	KKHzSOcO07VohiF9RdGxPq5rtgVJeJ8TTrgnuozt/OhzYzt1jsBdQOQmFH3jvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnZvR6dbT5qXe8yNj6Za/v9QDXrIZ8GuEfWeVZP4jZY=;
	b=/BfTvwvxgiUjw6KpHBk671zy8h5iNCqVdH+r9YGS6U+GN70UHB1Uk1RiqNALoPAWY6ZmhE
	p/nrof+3W7I42KDQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] console: Improve console_srcu_read_flags() comments
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-13-john.ogness@linutronix.de>
References: <20240820063001.36405-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287631.2215.15361748969145767135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     dc219d8d858d95549543aa7a41b6e64a0da9e406
Gitweb:        https://git.kernel.org/tip/dc219d8d858d95549543aa7a41b6e64a0da9e406
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:38 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

console: Improve console_srcu_read_flags() comments

It was not clear when exactly console_srcu_read_flags() must be
used vs. directly reading @console->flags.

Refactor and clarify that console_srcu_read_flags() is only
needed if the console is registered or the caller is in a
context where the registration status of the console may change
(due to another context).

The function requires the caller holds @console_srcu, which will
ensure that the caller sees an appropriate @flags value for the
registered console and that exit/cleanup routines will not run
if the console is in the process of unregistration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-13-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 46b3c21..aafe312 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -446,28 +446,34 @@ extern void console_list_unlock(void) __releases(console_mutex);
 extern struct hlist_head console_list;
 
 /**
- * console_srcu_read_flags - Locklessly read the console flags
+ * console_srcu_read_flags - Locklessly read flags of a possibly registered
+ *				console
  * @con:	struct console pointer of console to read flags from
  *
- * This function provides the necessary READ_ONCE() and data_race()
- * notation for locklessly reading the console flags. The READ_ONCE()
- * in this function matches the WRITE_ONCE() when @flags are modified
- * for registered consoles with console_srcu_write_flags().
+ * Locklessly reading @con->flags provides a consistent read value because
+ * there is at most one CPU modifying @con->flags and that CPU is using only
+ * read-modify-write operations to do so.
  *
- * Only use this function to read console flags when locklessly
- * iterating the console list via srcu.
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
+ * and that no exit/cleanup routines will run if the console is currently
+ * undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
  *
  * Context: Any context.
+ * Return: The current value of the @con->flags field.
  */
 static inline short console_srcu_read_flags(const struct console *con)
 {
 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
 
 	/*
-	 * Locklessly reading console->flags provides a consistent
-	 * read value because there is at most one CPU modifying
-	 * console->flags and that CPU is using only read-modify-write
-	 * operations to do so.
+	 * The READ_ONCE() matches the WRITE_ONCE() when @flags are modified
+	 * for registered consoles with console_srcu_write_flags().
 	 */
 	return data_race(READ_ONCE(con->flags));
 }

