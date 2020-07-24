Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01B622C0DC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGXIet (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:34:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgGXIdo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:44 -0400
Date:   Fri, 24 Jul 2020 08:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=702aBie6bi8I89jOYtXhKsIwrRSITZ0vVwdgCP98K+U=;
        b=IFq4nQi3TQr6DsNBTNVXX6Mk9RbI2SnK9+Io6c1Mwd14ZZAqhyPvNhkZMBIUh8ebFn2XW+
        vL5NSo+Rm90/IOJwJtY2LjAFPucAXaHracfZCClqZmQf6gkx4AC6IeUDIiGkL98cN7PNpq
        RwMXsZhyuW0LwW+DyFCt6i5S+AUzDtHj1DhWyWV7JOORJ0/oom9zjxR43dsQYtymzUqoss
        U3eB0dWZ0IXmfYlhEFOx8AEVaZTAt9gAyJKB5eCewoBiUuzTzvUaT9TxKvuAWBdFvlb5+4
        vqtBgVBBVqZhEvi4iOYfNTtZH5VVfA2tVhKFeEB8FSZKh3FWOJ+V4NrN4IKL0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=702aBie6bi8I89jOYtXhKsIwrRSITZ0vVwdgCP98K+U=;
        b=nzxAQFdOEhwQmE6UOnkxG6Dr8PcIkpfFSzXPrQiurt10knowcKbngyuZebYnDTvrNDf24S
        CySrDI+mww72dvDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,watchdog: Convert to sched_set_fifo()
Cc:     wim@linux-watchdog.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962266.4006.1335947481341905530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     94beddacb53cddb78baab6b4597195bb766d70b0
Gitweb:        https://git.kernel.org/tip/94beddacb53cddb78baab6b4597195bb766d70b0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:24 +02:00

sched,watchdog: Convert to sched_set_fifo()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes prio from 99 to 50.

Cc: wim@linux-watchdog.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 7e4cd34..b9dc2c3 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1144,14 +1144,13 @@ void watchdog_dev_unregister(struct watchdog_device *wdd)
 int __init watchdog_dev_init(void)
 {
 	int err;
-	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1,};
 
 	watchdog_kworker = kthread_create_worker(0, "watchdogd");
 	if (IS_ERR(watchdog_kworker)) {
 		pr_err("Failed to create watchdog kworker\n");
 		return PTR_ERR(watchdog_kworker);
 	}
-	sched_setscheduler(watchdog_kworker->task, SCHED_FIFO, &param);
+	sched_set_fifo(watchdog_kworker->task);
 
 	err = class_register(&watchdog_class);
 	if (err < 0) {
