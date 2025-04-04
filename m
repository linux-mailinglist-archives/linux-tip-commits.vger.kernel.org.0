Return-Path: <linux-tip-commits+bounces-4657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452DA7BFB1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF20189A688
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A31F4630;
	Fri,  4 Apr 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZppPA5gn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dj+MLyes"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538001F4189;
	Fri,  4 Apr 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777379; cv=none; b=SI6+yQ93e/W9E1OlwArGfJwMkB0xoSQlcgxfS0ReNls+y6qZtDQtqp56lZNW66FpLTMyUAzB9VA1218eu+ckGr+Fu8WVRmp0ACz0VuodYep/gyFgGx/1BUXAeDai1F/IcXtUuGJIgPAChN25oRHh0Tb5bPchdcqyeanie75n7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777379; c=relaxed/simple;
	bh=QCvI6ZjvnyYue1vLXBG9QlxDcfj3VEE5B7SAp3eaLt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HGMyAr5gQ7u0TnJ0fYMwWfSvCXeSNTAwwyfefLWbJ0QvfrfxcndlFg2hpTJgZwe+PKLN7Ln3QjD8XmOCCai/4EiDw673YX7K2UiAho91IzpeoNAoC6gvvZUCbAVGo2p8zk44HG6ugeGkUnCgqOKtLGM/ZV8z6V1C2H6Ap6XJ8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZppPA5gn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dj+MLyes; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IuTpGegc/jyYrXbq1D2cyjUtg1/wEiL0c1/+6cYhRE=;
	b=ZppPA5gnibIptyB0JrFekBLsUlgYyP/iuNQMyUdQkJ8rkJeRRzL8zhFWKGLpOMzLgSpreD
	0IA1/zGj+Z1mPKvpnAJOkT/T7Y/0QUWhs0fQzcWQ0D4BUPWzi/r6GvxcYPy16POkpw6pVK
	+Z5VWg5pNt3ZTsdOpHDLMMY6PA7vll5gNABd+oY8EVmEqSeH4UkRb3MFf3gG8A1yQOz2ZI
	MsvV3po6h3+wSdqnWi+g0IF4tSHfi8LbqF8rw+sXE62PLVhceTJH51p9ZNh8L/PA96Fp5p
	tLLyFgKDcI4yyxKU2/HJYE7ETSvw6cCRCq/E/BC9TB3haFvvaVmBCiWscJuaPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IuTpGegc/jyYrXbq1D2cyjUtg1/wEiL0c1/+6cYhRE=;
	b=dj+MLyes+CBXrzGWPoAlzhFrWPAvUr8pXzjISFTToM9zH8IfMJId7q6KQoJP8ANLu19Uvk
	GjWo1rt6dWw5o2BA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename __hrtimer_init_sleeper() to
 __hrtimer_setup_sleeper()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377737622.31282.13181544954627613652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f74b287f30c9268c9eefe963df51911604b2f458
Gitweb:        https://git.kernel.org/tip/f74b287f30c9268c9eefe963df51911604b2f458
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:10 +02:00

hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper() as well, to
keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/807694aedad9353421c4a7347629a30c5c31026f.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e883f65..8cb2c85 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2016,7 +2016,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_setup_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -2026,8 +2026,8 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
 
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	/*
 	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
@@ -2067,7 +2067,7 @@ void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
+	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
 

