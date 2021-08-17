Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48173EF37D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhHQUPy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbhHQUPU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADDEC061226;
        Tue, 17 Aug 2021 13:14:25 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tmKOtHf2zAjaYIql41RHMDbyKRaDIvkEoYu0XmKLbY=;
        b=Ob3irTJ+QE+QfgTqx0/UpAxSutf98qbaypk4LkY3SMQyclqXWpUUD3UXLWi8uLmMZM6Ybg
        +wBjv9k5i3m7ZNOZCeM/RJjp1iuN/fjkMgTF8FJiuthp9fUh6GqModRzSP8uAY6gIrXW6m
        cMkRQ27+R2H3jAXOksG++P2qtVLZslqWHbjqfDtwxC6LOIu+136CZYv2aDqQ19U0sgNAoW
        lk3ICCcHnoz/in1UaGsRFdzRUnT5FxRwusqW5/NCcF/ufzhjj8Du7pUrBNYnehP9JaEX1H
        +UeW6e2ls3ozh4LjMxX6Sj94YOP3bHuL/gA2Pa9pbHnm+HIiwKhV+mGxxR8GWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tmKOtHf2zAjaYIql41RHMDbyKRaDIvkEoYu0XmKLbY=;
        b=qjFgWvaMNldSJKFn+VRR9aHeCQJtZcKQMcu2xzcNGPaC8qOuxhNB6eoKFgGTK7CK0gUxsB
        UWxBxd8G3WP4lADQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Prevent future include recursion hell
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.428224188@linutronix.de>
References: <20210815211303.428224188@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126358.25758.2395158360665556341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a403abbdc715986760821e67731d60ff65bde4bd
Gitweb:        https://git.kernel.org/tip/a403abbdc715986760821e67731d60ff65bde4bd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:27:28 +02:00

locking/rtmutex: Prevent future include recursion hell

rtmutex only needs raw_spinlock_t, but it includes spinlock_types.h, which
is not a problem on an non RT enabled kernel.

RT kernels substitute regular spinlocks with 'sleeping' spinlocks, which
are based on rtmutexes, and therefore must be able to include rtmutex.h.

Include <linux/spinlock_types_raw.h> instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.428224188@linutronix.de
---
 include/linux/rtmutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 174419e..4be97ae 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -16,7 +16,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 
