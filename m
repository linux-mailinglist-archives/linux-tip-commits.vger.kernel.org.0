Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F088B3F76F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Aug 2021 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhHYORz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Aug 2021 10:17:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYORy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Aug 2021 10:17:54 -0400
Date:   Wed, 25 Aug 2021 14:17:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629901028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unfHvJ2xNkGf7/GD30Dugt6RiMzZPszCLIHGb9/V8gI=;
        b=jyA9rV0FHJ4Wpm+RpaSzJ5KNoYeSJXj34bEkBbDXDJA0asE4clJEpTo6om1HxTxX0XrVEd
        OPuZfb3V1MqUCVfKB3q0LBQWUYtHxw4U/uQNhWWO9W/ptSVE074PKni/9GNXYj6Ot1/MG5
        hN0A9i9ZtCVj6QY4FEi1zDzZwX7TmZ5vy3V0gudfy4zgfS8g9EHTh7MePADMFx3A4IKdgi
        2Z92hpUcBQVR9nuQqcvlqXxFqkehrA7al+sArMu6B4r6/ydsTsyeDFuz/Zrdb9LosW9gTU
        LnzCBkY/ollx28jB9SgCQRQ7KS8+xkbzvCNwMaGahRt05uZWiRn4LHmRNmEpDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629901028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unfHvJ2xNkGf7/GD30Dugt6RiMzZPszCLIHGb9/V8gI=;
        b=DJlAvFOERi1oho9YnY8bZLpaBqrT4mxn0V6ulawXikOPeNZYknaixeTVsXyAoQhyu3nihb
        NfOy9NqSY3TJDHBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Dequeue waiter on ww_mutex deadlock
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210825102454.042280541@linutronix.de>
References: <20210825102454.042280541@linutronix.de>
MIME-Version: 1.0
Message-ID: <162990102700.25758.7905729704214999682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     37e8abff2bebbf9947d6b784f5c75ed48a717089
Gitweb:        https://git.kernel.org/tip/37e8abff2bebbf9947d6b784f5c75ed48a717089
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Aug 2021 12:33:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Aug 2021 15:42:33 +02:00

locking/rtmutex: Dequeue waiter on ww_mutex deadlock

The rt_mutex based ww_mutex variant queues the new waiter first in the
lock's rbtree before evaluating the ww_mutex specific conditions which
might decide that the waiter should back out. This check and conditional
exit happens before the waiter is enqueued into the PI chain.

The failure handling at the call site assumes that the waiter, if it is the
top most waiter on the lock, is queued in the PI chain and then proceeds to
adjust the unmodified PI chain, which results in RB tree corruption.

Dequeue the waiter from the lock waiter list in the ww_mutex error exit
path to prevent this.

Fixes: add461325ec5 ("locking/rtmutex: Extend the rtmutex core to support ww_mutex")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210825102454.042280541@linutronix.de
---
 kernel/locking/rtmutex.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b3c0961..c8fe74e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1082,8 +1082,13 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
-		if (res)
+		if (res) {
+			raw_spin_lock(&task->pi_lock);
+			rt_mutex_dequeue(lock, waiter);
+			task->pi_blocked_on = NULL;
+			raw_spin_unlock(&task->pi_lock);
 			return res;
+		}
 	}
 
 	if (!owner)
