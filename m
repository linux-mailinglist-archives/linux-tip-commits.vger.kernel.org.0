Return-Path: <linux-tip-commits+bounces-2247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65D9720D1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471C8B22591
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B217E002;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJJVfqIi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKJdHvzF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D31189F41;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902876; cv=none; b=frzWjeL2gn0OdG6I/dmV8T0IUTHUlvJZgj01uAoT8AIH14Zd5Ae7KS9bKu7uwAJ+V64RPa23xFwwsvY7fYsMgi0K337iaH3ifr1Pt88T5Xp91RWYr02UUGJFw8ubmjjEPt+HSmsy3BJZZaT06g/uHhUh6/A+AG7yvQzG9WlLVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902876; c=relaxed/simple;
	bh=RbaCyhKPA8CPeTMCxT2BNWG2KVSr8BpxK+yNdMujuyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XWuJZP47A6gavJp9AZ/v6lXz50mP++HYV2i+wWydn1YioIOW3YeAWC1lkHEgD/BzGhRrFo43EE2dzwW+7eAP/FdrgcredAPrxEBPYk7pIrRnpkNLLWq9e4TSuKbuUux0NBE/NngNQjTX7lrvSwMPlYc0Axb8MYniRWzdOpWDNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJJVfqIi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKJdHvzF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73l5AWhzLJjAqXzYsNwLCLzh/0V1MtAA22XJAqopys8=;
	b=FJJVfqIiaOHQHHKEERQIuOycrW/j6IGA3AtDo7fFAd/NNrsFofjUYnDxeldrNprHOkh9n+
	bZMpbOz9OldmXuN1i1BWQgJ/UcvE4nnbcslipacY66OdL4lpRN7Ou78mbiG7pV8dqd+Bba
	SU80C6V3pMPrGJvqhdOKabO7GRRB5XSOyeWhwg0xX5P7jxJ4BeygDGN8UzJ9uegqL36pv2
	Hw6W5x7I9NbZtjd+7rIl03ROjUgWI4NdfIT0Ev5rJz4bhCjb2wWLQFLKRZegmi3sSdo3oo
	kFBDWTERYadlkObfsp6A9Bs1LoORlrrRG+Fk5esbRxqJsaRjOWtuy5zj/S22bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73l5AWhzLJjAqXzYsNwLCLzh/0V1MtAA22XJAqopys8=;
	b=kKJdHvzFZGU6MS2mZnGJnVAQ2OdvW3xLcme0jAPjjZMYBVOqs07cFnlk5S44TeVp5q5kiL
	p9qoC5eTBCrjb1Cg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Add is_printk_legacy_deferred()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-24-john.ogness@linutronix.de>
References: <20240820063001.36405-24-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287227.2215.3814724587860501318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     70411bf8d22ab3d2f794f199d81d70b62d3a85fa
Gitweb:        https://git.kernel.org/tip/70411bf8d22ab3d2f794f199d81d70b62d3a85fa
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:49 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:24 +02:00

printk: Add is_printk_legacy_deferred()

If printk has been explicitly deferred or is called from NMI
context, legacy console printing must be deferred to an irq_work
context. Introduce a helper function is_printk_legacy_deferred()
for a CPU to query if it must defer legacy console printing.

In follow-up commits this helper will be needed at other call
sites as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-24-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h    |  2 ++
 kernel/printk/printk_safe.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 44468f3..84706c1 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,6 +75,7 @@ bool printk_percpu_data_ready(void);
 	} while (0)
 
 void defer_console_output(void);
+bool is_printk_legacy_deferred(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
@@ -138,6 +139,7 @@ static inline bool console_is_usable(struct console *con, short flags)
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline bool is_printk_legacy_deferred(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 4421cca..86439fd 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,6 +38,15 @@ void __printk_deferred_exit(void)
 	__printk_safe_exit();
 }
 
+bool is_printk_legacy_deferred(void)
+{
+	/*
+	 * The per-CPU variable @printk_context can be read safely in any
+	 * context. CPU migration is always disabled when set.
+	 */
+	return (this_cpu_read(printk_context) || in_nmi());
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
@@ -50,7 +59,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi())
+	if (is_printk_legacy_deferred())
 		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */

