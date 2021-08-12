Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C843EABE5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 22:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhHLUkm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhHLUkj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 16:40:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04363C061756;
        Thu, 12 Aug 2021 13:40:13 -0700 (PDT)
Date:   Thu, 12 Aug 2021 20:40:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628800810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEGvNJf5wejFR3UHreZQY6CKvNVQ7vg8tEuQa7f8Abw=;
        b=jxTCXGkMmxjZOUYBAR26KXKNaK7+E4PJyRkxP9yMKxfg2I4ZxOJ/XNK9wzZyNW2EPCBs/+
        h2jkcL/eShkiGEIUjxwTZG9YfZbDseXAvEEy8t/gCaXZDIcv5t8bcWCJ4/k4l31T1U8FUd
        HvBpI8unvvRrPtDl8YAtL9yHUolUL0HIP/KqM8AsQ2Gj44XOwLfaisyxXXYbYJlHqkQqeB
        2E0DCczbNlpOEAvXoILgY+FXA5wMd5KjGj8mcrU9gFSPGH0KwxthH6enTI9eW6lSDzeneI
        Mat+8dOlGKf02c1uVyXAPrcRHDC5myFmHrDTNOtqb0oSsI5j9C+j1b09V5joVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628800810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEGvNJf5wejFR3UHreZQY6CKvNVQ7vg8tEuQa7f8Abw=;
        b=7fHTUyiXUwazXpOk5dMf7GBipvZ9SKxQ9GeGfNBmgSt2sYf1RvdacpV7L/3vY8Mi7iIk76
        5QwQnjH8BG4yvKBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Use raw_cpu_ptr() in clock_was_set()
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <875ywacsmb.ffs@tglx>
References: <875ywacsmb.ffs@tglx>
MIME-Version: 1.0
Message-ID: <162880080996.395.7066106924439766648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
Gitweb:        https://git.kernel.org/tip/9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Aug 2021 22:31:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Aug 2021 22:34:40 +02:00

hrtimer: Use raw_cpu_ptr() in clock_was_set()

clock_was_set() can be invoked from preemptible context. Use raw_cpu_ptr()
to check whether high resolution mode is active or not. It does not matter
whether the task migrates after acquiring the pointer.

Fixes: e71a4153b7c2 ("hrtimer: Force clock_was_set() handling for the HIGHRES=n, NOHZ=y case")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/875ywacsmb.ffs@tglx

---
 kernel/time/hrtimer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88aefc3..33b00e2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -944,10 +944,11 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
  */
 void clock_was_set(unsigned int bases)
 {
+	struct hrtimer_cpu_base *cpu_base = raw_cpu_ptr(&hrtimer_bases);
 	cpumask_var_t mask;
 	int cpu;
 
-	if (!hrtimer_hres_active() && !tick_nohz_active)
+	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -958,9 +959,9 @@ void clock_was_set(unsigned int bases)
 	/* Avoid interrupting CPUs if possible */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
 		unsigned long flags;
 
+		cpu_base = &per_cpu(hrtimer_bases, cpu);
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 		if (update_needs_ipi(cpu_base, bases))
