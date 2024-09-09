Return-Path: <linux-tip-commits+bounces-2239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDB9720B2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944311C23620
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857E189F45;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQwwqN41";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkZ9X2Oj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A7187FE4;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=UJMjTLyd9WWpt+KuSNgRWUpZ2Wl19wnYYG6VKRuBaCDj5YUZl7/R0NJmlQSPMEZjSDIraaQ2+ACyNKT4NrXKAlGY3FMkFGwJwr6pXGhw39G3+7cII1X1nwNyScxfHFOuKQGMS8jzHRVYMpAa7jTM+s7MuDj2kFLSXgs6lpRbAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=dyPGhYvGCedi4oy6n9DU77CPx1R2YZyH10060q0qphg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M2TGYWTUyJ7HxzAeAd/EyElH4UQYG7zpHLhIKVhpJI9haeuQ64+Lt3ui3vr6/6OPnTyobvBTteEpRUB1W6ro7uTr6awCi/Oj9QXuPS5TwiZooPhkBmlDze5l1KBIUy89ZWY8HNTVfyYqz4hzFUt3FVIIjk8aPSujpjYv673ET8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQwwqN41; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkZ9X2Oj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=es7Fq0wvDeqDvU+ZBEtRrDuZlholJpo6mtJ1nn7ZXbE=;
	b=sQwwqN41jan0E8jN6TasN8LvHAIEZ+YbqZuvlbYdTq9zYAOw0vLZLBMLrw0GpiRgwPdv1h
	G0RPz/nIYc74+bFVGAVQih5QA88mECAkY3sIUxNIBAeuYYuMExvig0bXxN0g3u1YJ0epBw
	hqgjAWAio0QGXoqK+ff4yxSnR4PZmMw4Xo6rKRt6yAqVdMh8Z0yK8iUVei60qcmU7Io7AP
	HTFr3bzE2FynwPlVlCrXD+KXhZD3KGIRgPgB3pqWeMkSy2LDfsUc7Lr7BvAQBFt4CHqULP
	EJRWo3Fmtod7TmmtIZurhI2SJ2YBEO9YFPIEYU2tzuh3J+xPhvcv9Pxuy2/wwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=es7Fq0wvDeqDvU+ZBEtRrDuZlholJpo6mtJ1nn7ZXbE=;
	b=wkZ9X2OjRwOn0CYW/z+pKv6hlCFKvReoch2VEVXayBveUBgmiCu5tVjXr1NMJNkgB1wy/X
	Q53frQwzJ9/FJwBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Fail pr_flush() if before SYSTEM_SCHEDULING
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-3-john.ogness@linutronix.de>
References: <20240904120536.115780-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286671.2215.14539703799741711809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     e37577ebbf1e875f8cc6159f25a1b559018d087f
Gitweb:        https://git.kernel.org/tip/e37577ebbf1e875f8cc6159f25a1b559018d087f
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:21 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: Fail pr_flush() if before SYSTEM_SCHEDULING

A follow-up change adds pr_flush() to console unregistration.
However, with boot consoles unregistration can happen very
early if there are also regular consoles registering as well.
In this case the pr_flush() is not important because all
consoles are flushed when checking the initial console sequence
number.

Allow pr_flush() to fail if @system_state has not yet reached
SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
explosions that would otherwise occur:

[    0.436739][    T0] printk: legacy console [ttyS0] enabled
[    0.439820][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.446822][    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
[    0.450491][    T0] 1 lock held by swapper/0/0:
[    0.457897][    T0]  #0: ffffffff82ae5f88 (console_mutex){+.+.}-{4:4}, at: console_list_lock+0x20/0x70
[    0.463141][    T0] Modules linked in:
[    0.465307][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1+ #372
[    0.469394][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.474402][    T0] Call Trace:
[    0.476246][    T0]  <TASK>
[    0.481473][    T0]  dump_stack_lvl+0x93/0xb0
[    0.483949][    T0]  dump_stack+0x10/0x20
[    0.486256][    T0]  __schedule_bug+0x68/0x90
[    0.488753][    T0]  __schedule+0xb9b/0xd80
[    0.491179][    T0]  ? lock_release+0xb5/0x270
[    0.493732][    T0]  schedule+0x43/0x170
[    0.495998][    T0]  schedule_timeout+0xc5/0x1e0
[    0.498634][    T0]  ? __pfx_process_timeout+0x10/0x10
[    0.501522][    T0]  ? msleep+0x13/0x50
[    0.503728][    T0]  msleep+0x3c/0x50
[    0.505847][    T0]  __pr_flush.constprop.0.isra.0+0x56/0x500
[    0.509050][    T0]  ? _printk+0x58/0x80
[    0.511332][    T0]  ? lock_is_held_type+0x9c/0x110
[    0.514106][    T0]  unregister_console_locked+0xe1/0x450
[    0.517144][    T0]  register_console+0x509/0x620
[    0.519827][    T0]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.523042][    T0]  univ8250_console_init+0x24/0x40
[    0.525845][    T0]  console_init+0x43/0x210
[    0.528280][    T0]  start_kernel+0x493/0x980
[    0.530773][    T0]  x86_64_start_reservations+0x18/0x30
[    0.533755][    T0]  x86_64_start_kernel+0xae/0xc0
[    0.536473][    T0]  common_startup_64+0x12c/0x138
[    0.539210][    T0]  </TASK>

And then the kernel goes into an infinite loop complaining about:

1. releasing a pinned lock
2. unpinning an unpinned lock
3. bad: scheduling from the idle thread!
4. goto 1

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-3-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6accd17..acf6680 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3991,6 +3991,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 diff;
 	u64 seq;
 
+	/* Sorry, pr_flush() will not work this early. */
+	if (system_state < SYSTEM_SCHEDULING)
+		return false;
+
 	might_sleep();
 
 	seq = prb_next_reserve_seq(prb);

