Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2556434D4E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2QYb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2QYJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:09 -0400
Date:   Mon, 29 Mar 2021 16:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNqTDQnvvd1MjmMYKMkM8e5ZVwHJl4jSOSADJL8lhAU=;
        b=KIMjS1qZqTyeQWaj5y9yulG7oeCmU0zSmCRXIX4UnkuM0noQFi9KjCn3Fd27s1uxSr1sYp
        6QacNFAp4LeRbGTJX0eICbpg9tJcF6X/9kk9uPMT3yVlkVbs+PXIkXWy0eteYrhHyfkEoS
        E7S4UYKMUskrfzX6wJ2LoMk7g/sOqPWKUSqBaY2/P45AljSSdp7PiKDoEOvhn/XgAbWbaZ
        exxWctrAR4S9lJ0CrOZTf+AMW8Euqxb0UQ5ZvWWjLGV52/9pJPL/MNWLSqq7XM4DFSAf3h
        nwYGnTajbWGykp6uki9qhhQ82w3mmM2fZN+boeYUTiLgFGMnu+Y0Y0NwvZK/bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNqTDQnvvd1MjmMYKMkM8e5ZVwHJl4jSOSADJL8lhAU=;
        b=c6BU/WDgCcf38XqmoDFUStKnpTv4+eMQLLNUZ33vBL8fsqe+4QMQ2mdipTzwVhT0BdR82L
        T1KjEw7bgMW9MaCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Clean up signal handling in
 __rt_mutex_slowlock()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153944.533811987@linutronix.de>
References: <20210326153944.533811987@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504736.29796.5573161276586106576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a51a327f3bcdcb1a37ed9325ad07e1456cd4d426
Gitweb:        https://git.kernel.org/tip/a51a327f3bcdcb1a37ed9325ad07e1456cd4d426
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:05 +02:00

locking/rtmutex: Clean up signal handling in __rt_mutex_slowlock()

The signal handling in __rt_mutex_slowlock() is open coded.

Use signal_pending_state() instead.

Aside of the cleanup this also prepares for the RT lock substituions which
require support for TASK_KILLABLE.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153944.533811987@linutronix.de
---
 kernel/locking/rtmutex.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c68542d..4068181 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1146,18 +1146,13 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (likely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		raw_spin_unlock_irq(&lock->wait_lock);
