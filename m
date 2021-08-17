Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8243EF33E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhHQUOo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbhHQUOk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:40 -0400
Date:   Tue, 17 Aug 2021 20:14:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvI+v7c3qtqsj4utKqtPgU0Iwt0R5CQ62ru/2Kk0oQI=;
        b=GknJtZ0GpfThhUTFWfldWDRCm6BFarBiIpgM5boOXTM2K4DNTyo5npYOOT3A0aBwkGo/6/
        aevpqW2Jm4CHJeFOJkRRMR1hhrh085HD2Xc/0vZj1lk1w4N0+1jy6Ee5Dr4xG3bcwlLglu
        iZakjzRrrSIUDHaoz8qThdD1P/vWIVOTxQ7Xlc824VxuGsUdEha2dCdoUjNpzdo6mz2KPT
        VGVHE2t2hjvpGypzVGbN7FPkHWf1zHDMhQXOc//uZrTvnjAqHIJkdA0dnFyj5yf5X2itom
        twdMjdccdraF9dw4YmGJuBVTbQhrUlkqrQb0OCGiQ1xxxCsq5Uj1ZC22Ww5jTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvI+v7c3qtqsj4utKqtPgU0Iwt0R5CQ62ru/2Kk0oQI=;
        b=GF3wB37RaKwBkcR72kqLyVLKhu1PW8Gk4n51Gnns1H/rXRn/3bFB5rfoQsgFFK2CUy6rpw
        yyVja2gEPlpsz2CA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lib/test_lockup: Adapt to changed variables
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.137982730@linutronix.de>
References: <20210815211305.137982730@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124570.25758.7338232998595098903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c49f7ece4617807c5de06857d196c825aadf60d5
Gitweb:        https://git.kernel.org/tip/c49f7ece4617807c5de06857d196c825aadf60d5
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:33 +02:00

lib/test_lockup: Adapt to changed variables

The inner parts of certain locks (mutex, rwlocks) changed due to a rework for
RT and non RT code. Most users remain unaffected, but those who fiddle around
in the inner parts need to be updated.

Match the struct names to the new layout.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.137982730@linutronix.de
---
 lib/test_lockup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 4d93b02..906b598 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -485,13 +485,13 @@ static int __init test_lockup_init(void)
 		       offsetof(spinlock_t, lock.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwlock_ptr,
-		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
+		       offsetof(rwlock_t, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_mutex_ptr,
-		       offsetof(struct mutex, lock.wait_lock.magic),
+		       offsetof(struct mutex, rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwsem_ptr,
-		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
+		       offsetof(struct rw_semaphore, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC))
 		return -EINVAL;
 #else
