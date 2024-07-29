Return-Path: <linux-tip-commits+bounces-1803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DD93F2DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D341F22839
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE84145FF5;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h28YEXze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rx8bsSHF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C831459F0;
	Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249251; cv=none; b=CtF0Tkajqi4XVJ9102eNk874jX1ReQ88jcfHRdrcOnS2x1zHaGLsRFf+gwTYBGVMZnW1aXHpPlHAzsQr6ZFVzPv7h/0lbJh2Ut0k96aUhCBeQv0elTfROy6Yl9jC4GtjFGQiqVlSWyRyMP5sP4t29lnLyq7D25WPElA2yVryiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249251; c=relaxed/simple;
	bh=y94oUwd5wR0SgGj2t0nfDF4mGQ6zdyRAwqhLwzfdpmM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C5oHroUI7GT/SRAORQKjqIwChsaTjlc0gNjhdnpQMmj7BZ7IeDgtaUnjk1s+4LnDIfxZuxAhreqYVdI+Hk1MZtncSNsCFhk4+7qHs9BFydIrBpYuijXYYaTEXFzZAQ+Kl6CX5q9dl4uiwgAswiPSc0aujvo7ru8V04iuaxYxdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h28YEXze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rx8bsSHF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1NhJyqaHj5n0U/lXqdiO8r3r3TrlehMJk+3GUnA708=;
	b=h28YEXzeBBst97q6moBInZKgHR8zgTec5U6pQHHR7G+EsTQiKOSfhO4hUrJmGll5osq8+k
	JdYTv+vVOQUmnr8gfJMeCmzj/l5QSkB9ojm7Yg+7TPHsVZjUeg6o9fEhKMv5aqKcnxUNIn
	f+wszlF6JYG5fYR7fEdt2W8o/V3tREz6nRI+aFquUyn6YYQF6F5itOQK4pN3N9O2Vxozh5
	H0BVuxWzgUdjMR0HMbKvjvJRoGqQbtqgdXj1N+6iN50cEPWaJ6OMLrfoiL96O7IhzX1ZCx
	cfpRBWeSE3qNv7mYGuDRMBkhqMWxYRfB7oJFEQXrQ0IgBPuzgVYNgqfCYcVXAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1NhJyqaHj5n0U/lXqdiO8r3r3TrlehMJk+3GUnA708=;
	b=rx8bsSHFAO5FWs4x91m5yeB9E6Z7JYjAMcGThRBclhXMVI0Yp85sBL6BS3StKAEZ/14U+R
	wI5dW7tuc3kLZcCA==
From: "tip-bot2 for Peilin He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Add WARN_ON_ONCE() to check overflow
 for migrate_disable()
Cc: Peter Zijlstra <peterz@infradead.org>, Peilin He <he.peilin@zte.com.cn>,
 xu xin <xu.xin16@zte.com.cn>, Yunkai Zhang <zhang.yunkai@zte.com.cn>,
 Qiang Tu <tu.qiang35@zte.com.cn>, Kun Jiang <jiang.kun2@zte.com.cn>,
 Fan Yu <fan.yu9@zte.com.cn>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn>
References: <20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924751.2215.13825232512894013809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ec8d5aed4d14055aab4e2746def33f8b0d409c3
Gitweb:        https://git.kernel.org/tip/0ec8d5aed4d14055aab4e2746def33f8b0d409c3
Author:        Peilin He <he.peilin@zte.com.cn>
AuthorDate:    Tue, 16 Jul 2024 10:42:44 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00

sched/core: Add WARN_ON_ONCE() to check overflow for migrate_disable()

Background
==========
When repeated migrate_disable() calls are made with missing the
corresponding migrate_enable() calls, there is a risk of
'migration_disabled' going upper overflow because
'migration_disabled' is a type of unsigned short whose max value is
65535.

In PREEMPT_RT kernel, if 'migration_disabled' goes upper overflow, it may
make the migrate_disable() ineffective within local_lock_irqsave(). This
is because, during the scheduling procedure, the value of
'migration_disabled' will be checked, which can trigger CPU migration.
Consequently, the count of 'rcu_read_lock_nesting' may leak due to
local_lock_irqsave() and local_unlock_irqrestore() occurring on different
CPUs.

Usecase
========
For example, When I developed a driver, I encountered a warning like
"WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315
rcu_note_context_switch+0xa8/0x4e8" warning. It took me half a month
to locate this issue. Ultimately, I discovered that the lack of upper
overflow detection mechanism in migrate_disable() was the root cause,
leading to a significant amount of time spent on problem localization.

If the upper overflow detection mechanism was added to migrate_disable(),
the root cause could be very quickly and easily identified.

Effect
======
Using WARN_ON_ONCE() to check if 'migration_disabled' is upper overflow
can help developers identify the issue quickly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Link: https://lkml.kernel.org/r/20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn
---
 kernel/sched/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c61b4f..db5823f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2233,6 +2233,12 @@ void migrate_disable(void)
 	struct task_struct *p = current;
 
 	if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 *Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
 		p->migration_disabled++;
 		return;
 	}
@@ -2251,14 +2257,20 @@ void migrate_enable(void)
 		.flags     = SCA_MIGRATE_ENABLE,
 	};
 
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
+		return;
+#endif
+
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
 	}
 
-	if (WARN_ON_ONCE(!p->migration_disabled))
-		return;
-
 	/*
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().

