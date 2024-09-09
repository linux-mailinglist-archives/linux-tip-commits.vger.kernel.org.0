Return-Path: <linux-tip-commits+bounces-2270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF139720F7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD051F22AEB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59D518F2FE;
	Mon,  9 Sep 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9SVAYUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0pXP7FV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083D18D646;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902884; cv=none; b=mnjxuAeqA589lHxcDtRYZyazlWctkNPwL7JQk0yeE18Osxez+UpVSQgn49G2aXkwUTtCo6mWlabvz4L+hfHQ9n+8nHQ6shqOoq4x2yl6FrB6e7zgr9NUExM10T1zmplgmcxKUqdRHq+J/+0SzmcVvSHBGNMCj1Sne1RExgOIR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902884; c=relaxed/simple;
	bh=zPhAZfc9mNakDbhnnIbgqlRi9r6BAYgEyYeoDot7Dpg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KEPWxW2Qze2V2T6ePAbscyy2cqHdtqLzQndrZu6jcdxd1MuUFaj5/9IYqu8SlUMobTaaNKj1mNNoq94ChLICrv4pRoGusVvCegLQLijKSkwxtvcuVFIWB2HOPBQ3BWAcm+OKcCaArh0o+xphqtnG1yXC75ced0sudvyvJ9QFTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d9SVAYUu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0pXP7FV; arc=none smtp.client-ip=193.142.43.55
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
	bh=I1KLYAF7nyh1CgMk4koUNz/yz7jh0or1Q6DP6cHN0TI=;
	b=d9SVAYUukphzWWq8maqtfBRfwgn7dx3lBbGdgl4Q8wspRAtsJdFZgqDfObNu3GW0VgPTRy
	lEZkZZ0+5v5UENw9tC9ZOfGSm6JSJotcs9eAOFxGhjBGujMSnYAepdnlXMBkZuInQs+z8P
	VaNsaXAzjFIhZaJjgQELlccK3PNGyxBupOSWaRWcTFYtLFdkDkCTRtRQ9ehCC6aUqIxnpD
	9cL1lGTDMOpW8/4NsNjQQeZs0uPpEZy47SY8pK7PZZQiuDj+RG7/RxUzXx8xrVIa0GMay7
	WQMq8zLMMJ2XNbeDKRASJObQr8y/OQOBhsiVzRJP5eSks9oZQ0C4QltJa7B5ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1KLYAF7nyh1CgMk4koUNz/yz7jh0or1Q6DP6cHN0TI=;
	b=m0pXP7FVQgppQOYgiVmzXrbdsn3bpU1EIFvKlCJaWNEVt3zsirWhq0x98QnK8gYoKUPHyq
	hJgt2wFd9T96kNDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Check printk_deferred_enter()/_exit() usage
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-5-john.ogness@linutronix.de>
References: <20240820063001.36405-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287906.2215.12636425003203506745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     0e1d5731d3c1e2214249ef36dcd13ad51ad304cf
Gitweb:        https://git.kernel.org/tip/0e1d5731d3c1e2214249ef36dcd13ad51ad304cf
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:30 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:22 +02:00

printk: Check printk_deferred_enter()/_exit() usage

Add validation that printk_deferred_enter()/_exit() are called in
non-migration contexts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-5-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  9 +++++----
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk_safe.c | 12 ++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index b937cef..eee8e97 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -161,15 +161,16 @@ int _printk(const char *fmt, ...);
  */
 __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
+extern void __printk_deferred_enter(void);
+extern void __printk_deferred_exit(void);
+
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interrupts
  * must be disabled for the deferred duration.
  */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
+#define printk_deferred_enter() __printk_deferred_enter()
+#define printk_deferred_exit() __printk_deferred_exit()
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 398ecb4..dc8bc08 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -53,6 +53,9 @@ int vprintk_store(int facility, int level,
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
+void __printk_safe_enter(void);
+void __printk_safe_exit(void);
+
 bool printk_percpu_data_ready(void);
 
 #define printk_safe_enter_irqsave(flags)	\
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6d10927..4421cca 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -26,6 +26,18 @@ void __printk_safe_exit(void)
 	this_cpu_dec(printk_context);
 }
 
+void __printk_deferred_enter(void)
+{
+	cant_migrate();
+	__printk_safe_enter();
+}
+
+void __printk_deferred_exit(void)
+{
+	cant_migrate();
+	__printk_safe_exit();
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB

