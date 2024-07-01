Return-Path: <linux-tip-commits+bounces-1560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C891DD7D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 13:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E6C1C21545
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990713C821;
	Mon,  1 Jul 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GS2nNIVN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2oiki1gB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233C13AD04;
	Mon,  1 Jul 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832030; cv=none; b=L0T4XO4okjVszrgtB+PLskYPK+YUGI73K+RLBbks2zNfwDdASblUyO663i11eMjq5xTOnPYyx66yDO55wMr0sVzTk0KNJdM36PZslJTsqIbNQ1U2CbUDDD8yveHnmZHE2BMNHjV1/uUEss2gyaSgWiZ9KQ2dzNapCdqpZ3x9pN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832030; c=relaxed/simple;
	bh=mvtsqMs3gp5gu0N1y2/j7wXDpZZj1OladHpyamYt960=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EMxuGEVRqAneIwmUOyCvQxl/6ABK7r1XsPeW016GC/nc4Xn9KVpqDGyqJUkAW/1MBBX3q1w3vybIfKb4xoKT6ztgY6YOKsXpz+w23e8Ni7U3d+ulOZ++EY96AAfIEUnJbE+mgo5jTobntFIPfhUyiwj8SMweyYebZqLuJd3iAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GS2nNIVN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2oiki1gB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 11:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AFFpRwtfIPFQsoejzf0bJ9VPXwAUievkYiiK0ep8gY=;
	b=GS2nNIVNGhsfptplYsYuIxdbXiZoTAcZykiD6yNxxzidipFcNSfUiAmzbCboW+0CJpCw1C
	Oenl3yuGg6Rxhy2TKEELe6hh2IeViG0FbmaSANbhAYb2S2xXDialrWrebsmxs+cRGhonFR
	SX+oD32gmZtwgQA6uQduo5+6p46yUR6co7ThqQuveUIUVWr4o1epjz9qr6O0jyqtuLJqvR
	dn4prQqpeYVLED5+F0ATyafFglD9SoGUXwdEqr7eteuPkBManwBy1Tc8wUvL4sfTcy85qg
	BvHupfGNYca8yRTX8cMbqZ7DK2QPBC/F0xDvEUQswOIyhwVL5kRLSvQKEhYY6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AFFpRwtfIPFQsoejzf0bJ9VPXwAUievkYiiK0ep8gY=;
	b=2oiki1gB+zRbpPGwi3cZOwPC1Wfai3SjFylkK1xS9MYCdlCv8HdE45rGgFxNumBQsK6QNT
	3VnSl+sVvs/0FeCQ==
From: "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix task_struct reference leak
Cc: Wander Lairson Costa <wander@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240620125618.11419-1-wander@redhat.com>
References: <20240620125618.11419-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171983202713.2215.17043038912457274824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b58652db66c910c2245f5bee7deca41c12d707b9
Gitweb:        https://git.kernel.org/tip/b58652db66c910c2245f5bee7deca41c12d707b9
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Thu, 20 Jun 2024 09:56:17 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Jul 2024 13:01:44 +02:00

sched/deadline: Fix task_struct reference leak

During the execution of the following stress test with linux-rt:

stress-ng --cyclic 30 --timeout 30 --minimize --quiet

kmemleak frequently reported a memory leak concerning the task_struct:

unreferenced object 0xffff8881305b8000 (size 16136):
  comm "stress-ng", pid 614, jiffies 4294883961 (age 286.412s)
  object hex dump (first 32 bytes):
    02 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  debug hex dump (first 16 bytes):
    53 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00  S...............
  backtrace:
    [<00000000046b6790>] dup_task_struct+0x30/0x540
    [<00000000c5ca0f0b>] copy_process+0x3d9/0x50e0
    [<00000000ced59777>] kernel_clone+0xb0/0x770
    [<00000000a50befdc>] __do_sys_clone+0xb6/0xf0
    [<000000001dbf2008>] do_syscall_64+0x5d/0xf0
    [<00000000552900ff>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

The issue occurs in start_dl_timer(), which increments the task_struct
reference count and sets a timer. The timer callback, dl_task_timer,
is supposed to decrement the reference count upon expiration. However,
if enqueue_task_dl() is called before the timer expires and cancels it,
the reference count is not decremented, leading to the leak.

This patch fixes the reference leak by ensuring the task_struct
reference count is properly decremented when the timer is canceled.

Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240620125618.11419-1-wander@redhat.com
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d130..9bedd14 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1804,8 +1804,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
+			 *
+			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+			 * it will eventually call put_task_struct().
 			 */
-			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
+			    !dl_server(&p->dl))
+				put_task_struct(p);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {

