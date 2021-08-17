Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEBE3EF370
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhHQUPi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbhHQUPL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:11 -0400
Date:   Tue, 17 Aug 2021 20:14:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEJIuYUmfTbFCnEsvR49ouHVdSHy7OjoViEwhKhMX6E=;
        b=SQUJ8BvAFBbaWJ+lkSEnVWetzFYq484d4IswejCJIDsPCTFedAzcW+haM8BrTLFa+izUTy
        2F6LTblmPmZpxZi24C5729rE5DpUrHFmkhId+Ov/mFIedgpIijEAE992uGqxuaVzi3laTJ
        NpTysKO5K0kuj09Lln8c5R/1vdv4C6TiVGbIPVakFWh1XNPtmZeRw6HC1itUsGw9nzVJh8
        W1DPoY4ATO1hdlVZ/DwA5++Iyf4N7cd/0NkEobTfJG5ejL+gdWCN4qH+rpXNMPjYZ/Nui0
        8g79ybw4ujVjlEfzf5AbKjtq9Cm6oPmm3LJHQnS5AD7JZjgsclWnn9JrPHfRIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEJIuYUmfTbFCnEsvR49ouHVdSHy7OjoViEwhKhMX6E=;
        b=6nXtNviD3LPyEzSms9o2LZVPoBE5y0jOtfMfZI7yc1Ep6iLCovaWzheDXXNis3bIudCG/b
        ceWakBmrlWNZ+RCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/wakeup: Introduce the TASK_RTLOCK_WAIT state bit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.144989915@linutronix.de>
References: <20210815211302.144989915@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127650.25758.18126600613798008736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cd781d0ce8cb4d491910833c5eec90f150432da3
Gitweb:        https://git.kernel.org/tip/cd781d0ce8cb4d491910833c5eec90f150432da3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:45:15 +02:00

sched/wakeup: Introduce the TASK_RTLOCK_WAIT state bit

RT kernels have an extra quirk for try_to_wake_up() to handle task state
preservation across periods of blocking on a 'sleeping' spin/rwlock.

For this to function correctly and under all circumstances try_to_wake_up()
must be able to identify whether the wakeup is lock related or not and
whether the task is waiting for a lock or not.

The original approach was to use a special wake_flag argument for
try_to_wake_up() and just use TASK_UNINTERRUPTIBLE for the tasks wait state
and the try_to_wake_up() state argument.

This works in principle, but due to the fact that try_to_wake_up() cannot
determine whether the task is waiting for an RT lock wakeup or for a regular
wakeup it's suboptimal.

RT kernels save the original task state when blocking on an RT lock and
restore it when the lock has been acquired. Any non lock related wakeup is
checked against the saved state and if it matches the saved state is set to
running so that the wakeup is not lost when the state is restored.

While the necessary logic for the wake_flag based solution is trivial, the
downside is that any regular wakeup with TASK_UNINTERRUPTIBLE in the state
argument set will wake the task despite the fact that it is still blocked
on the lock. That's not a fatal problem as the lock wait has do deal with
spurious wakeups anyway, but it introduces unnecessary latencies.

Introduce the TASK_RTLOCK_WAIT state bit which will be set when a task
blocks on an RT lock.

The lock wakeup will use wake_up_state(TASK_RTLOCK_WAIT), so both the
waiting state and the wakeup state are distinguishable, which avoids
spurious wakeups and allows better analysis.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.144989915@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d..9a9f606 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,9 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+/* RT specific auxilliary flag to mark RT lock waiters */
+#define TASK_RTLOCK_WAIT		0x1000
+#define TASK_STATE_MAX			0x2000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
