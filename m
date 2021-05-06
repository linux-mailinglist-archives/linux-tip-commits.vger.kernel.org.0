Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D19375A19
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhEFSVs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 14:21:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhEFSVp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 14:21:45 -0400
Date:   Thu, 06 May 2021 18:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620325246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+epKSfuLZIwuHczT4aj4V0eMOXZpyOyZjXimp9cnIw=;
        b=gB5kR1ehT4nc/VB813lapN6jY2bQDVif2DjYrmq7TRmJ5GjkIysHurR/r6UsDKq8lujTRN
        zsONjIBtxcfgQenm3JjXLiEk4mOIsBNuKrLXpuCbJ09U283bFEResEiesZ1n/JZAm4f1VT
        qiHRnm5xXh4ki/6hRdcGjiAtIf/2ks7Ulu6BsrxHDUHixlj+FUs4Vtsp7xTBx2I0E13xsC
        GP+R8yfY7beLZZKZUtmwWYhxRZZvObX4rf2GpZJK3xnqNTnwEr5xGBHZs3W8Q1gj32gyq7
        y47f7Na2lZbAzj7sszAukmmFL/FD10gBOxIOObZAl++pu19DIWzW3Kt2tHFYSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620325246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+epKSfuLZIwuHczT4aj4V0eMOXZpyOyZjXimp9cnIw=;
        b=zpvoKR/VviPbFHKM54U2YW7iVdU+a/xZYavbeC7Ugf26zqEDAU27gTTTkP++FXLqyV+kkz
        DFp86zoeG1nejbBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Get rid of the val2 conditional dance
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422194705.125957049@linutronix.de>
References: <20210422194705.125957049@linutronix.de>
MIME-Version: 1.0
Message-ID: <162032524551.29796.2014810338967341881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b097d5ed33561507eeffc77120a8c16c2f0f2c4c
Gitweb:        https://git.kernel.org/tip/b097d5ed33561507eeffc77120a8c16c2f0f2c4c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 22 Apr 2021 21:44:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 May 2021 20:19:04 +02:00

futex: Get rid of the val2 conditional dance

There is no point in checking which FUTEX operand treats the utime pointer
as 'val2' argument because that argument to do_futex() is only used by
exactly these operands.

So just handing it in unconditionally is not making any difference, but
removes a lot of pointless gunk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210422194705.125957049@linutronix.de

---
 kernel/futex.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index b0f5304..4ddfdce 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3764,7 +3764,6 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 {
 	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
-	u32 val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
@@ -3784,15 +3783,8 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
-	/*
-	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
-	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
-	 */
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (u32) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
 #ifdef CONFIG_COMPAT
@@ -3960,7 +3952,6 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 {
 	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
-	int val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
@@ -3978,11 +3969,8 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (int) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
 
