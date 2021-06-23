Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBF3B159A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFWIV2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFWIV2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:28 -0400
Date:   Wed, 23 Jun 2021 08:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eK7GRCwA6HO4XWyVewMswAnEzqvKLugjY6A+BEGGUL0=;
        b=ZE7cS7WAuAVXsYw3zUv52NMean/5Sn17ngt7TbKbCLxDJT0Nzc7UlQ8D3D8kqamin44kDt
        1mMkq5wWfBm7gdjT9vyA2RNgmFMDF+M/c6a6aJLbyAMZzTErPLEZQqyyb4qXUpJhY1QiBv
        /pTiN6izbjGPQ+lkv+42Dk0t9GON9M3dSvfl/PgfyuSaKVliKsAoIPg6iKQACLNgWPYl2D
        CcuwRd0nEUAd8W9gKWzDsl5TAIfyJkBMhbJR41TKwOA4ktKQ2m08yinXFvnxtvc9GzAc//
        ve9TYBURtPbtOpA7FmUVJ6w4oew/XbtNnlyTYmaS5DSwljHloo3grlz1+1g6Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eK7GRCwA6HO4XWyVewMswAnEzqvKLugjY6A+BEGGUL0=;
        b=DdguHOpPngcAODqdBPDwPmwSzkvKeA0iJHk4IcRWek6jZcC5QNVJwKaPFTepwp/5CLslNJ
        q5B9VD3CknDyM0CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Provide FUTEX_LOCK_PI2 to support clock selection
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422194705.440773992@linutronix.de>
References: <20210422194705.440773992@linutronix.de>
MIME-Version: 1.0
Message-ID: <162443634666.395.17352380561826819926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bf22a6976897977b0a3f1aeba6823c959fc4fdae
Gitweb:        https://git.kernel.org/tip/bf22a6976897977b0a3f1aeba6823c959fc4fdae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 22 Apr 2021 21:44:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:09 +02:00

futex: Provide FUTEX_LOCK_PI2 to support clock selection

The FUTEX_LOCK_PI futex operand uses a CLOCK_REALTIME based absolute
timeout since it was implemented, but it does not require that the
FUTEX_CLOCK_REALTIME flag is set, because that was introduced later.

In theory as none of the user space implementations can set the
FUTEX_CLOCK_REALTIME flag on this operand, it would be possible to
creatively abuse it and make the meaning invers, i.e. select CLOCK_REALTIME
when not set and CLOCK_MONOTONIC when set. But that's a nasty hackery.

Another option would be to have a new FUTEX_CLOCK_MONOTONIC flag only for
FUTEX_LOCK_PI, but that's also awkward because it does not allow libraries
to handle the timeout clock selection consistently.

So provide a new FUTEX_LOCK_PI2 operand which implements the timeout
semantics which the other operands use and leave FUTEX_LOCK_PI alone.

Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210422194705.440773992@linutronix.de
---
 include/uapi/linux/futex.h | 2 ++
 kernel/futex.c             | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0a..235e5b2 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -21,6 +21,7 @@
 #define FUTEX_WAKE_BITSET	10
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_LOCK_PI2		13
 
 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
@@ -32,6 +33,7 @@
 #define FUTEX_CMP_REQUEUE_PRIVATE (FUTEX_CMP_REQUEUE | FUTEX_PRIVATE_FLAG)
 #define FUTEX_WAKE_OP_PRIVATE	(FUTEX_WAKE_OP | FUTEX_PRIVATE_FLAG)
 #define FUTEX_LOCK_PI_PRIVATE	(FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_LOCK_PI2_PRIVATE	(FUTEX_LOCK_PI2 | FUTEX_PRIVATE_FLAG)
 #define FUTEX_UNLOCK_PI_PRIVATE	(FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG)
 #define FUTEX_TRYLOCK_PI_PRIVATE (FUTEX_TRYLOCK_PI | FUTEX_PRIVATE_FLAG)
 #define FUTEX_WAIT_BITSET_PRIVATE	(FUTEX_WAIT_BITSET | FUTEX_PRIVATE_FLAG)
diff --git a/kernel/futex.c b/kernel/futex.c
index f820439..f832b64 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3707,12 +3707,14 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 
 	if (op & FUTEX_CLOCK_REALTIME) {
 		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT_BITSET &&	cmd != FUTEX_WAIT_REQUEUE_PI)
+		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
+		    cmd != FUTEX_LOCK_PI2)
 			return -ENOSYS;
 	}
 
 	switch (cmd) {
 	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
 	case FUTEX_UNLOCK_PI:
 	case FUTEX_TRYLOCK_PI:
 	case FUTEX_WAIT_REQUEUE_PI:
@@ -3740,6 +3742,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
 		flags |= FLAGS_CLOCKRT;
+		fallthrough;
+	case FUTEX_LOCK_PI2:
 		return futex_lock_pi(uaddr, flags, timeout, 0);
 	case FUTEX_UNLOCK_PI:
 		return futex_unlock_pi(uaddr, flags);
@@ -3760,6 +3764,7 @@ static __always_inline bool futex_cmd_has_timeout(u32 cmd)
 	switch (cmd) {
 	case FUTEX_WAIT:
 	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
 	case FUTEX_WAIT_BITSET:
 	case FUTEX_WAIT_REQUEUE_PI:
 		return true;
