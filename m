Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4D34D4EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC2QYf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC2QYM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E51C061762;
        Mon, 29 Mar 2021 09:24:12 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHxgev8/50vlIDW/xHm4rKa9ivM4BzKU/4j6gYRAZAs=;
        b=JfQbCkMlaO17QPnaJnbx8MTWw8dZgKAtI4iCPZ96u5C2Csjaqvde5xk8tb4HMEOoa3iUGf
        m6L0/S8nQnT6ILY4VLCao2fF/A5msniDrWVq2a1hEsZJznkI7VH4WF436H1DcoDGDTp8Oh
        xnHt40O2d/0g4nPM1Czh+AsQDH+sI/EF4hqa1Ii1UepnzeOPxZKuXtvKb6YFcURVuBWS9G
        QaLgB05Y37K6nwZFi61kf9m/necYME3Lx56hPFcUTqT7/PAaB7n6G6OnLgUSLgjpMAAqdr
        uARyl4WZa00DIr/iYEWeaNIw2iae2jFTIS+Yl5aYHh8IOv4TFMQ2TMuLk+OjXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHxgev8/50vlIDW/xHm4rKa9ivM4BzKU/4j6gYRAZAs=;
        b=JNKE+/B9H+QVn9ZRc708iV8f286q1Sq2oO6GSW9+vNj1OL5zU0Sxo8pm7fJPpLfRpJoT0t
        0NdBPC6zUY4/ZoAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Inline chainwalk depth check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.754254046@linutronix.de>
References: <20210326153943.754254046@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505022.29796.7546960613586605857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f7efc4799f8114ba85b68584f83293f435009de4
Gitweb:        https://git.kernel.org/tip/f7efc4799f8114ba85b68584f83293f435009de4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:03 +02:00

locking/rtmutex: Inline chainwalk depth check

There is no point for this wrapper at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.754254046@linutronix.de
---
 kernel/locking/rtmutex.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8a934db..2c77e72 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -343,14 +343,9 @@ static void rt_mutex_adjust_prio(struct task_struct *p)
 static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 					  enum rtmutex_chainwalk chwalk)
 {
-	/*
-	 * This is just a wrapper function for the following call,
-	 * because debug_rt_mutex_detect_deadlock() smells like a magic
-	 * debug feature and I wanted to keep the cond function in the
-	 * main source file along with the comments instead of having
-	 * two of the same in the headers.
-	 */
-	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
+		return waiter != NULL;
+	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
 /*
