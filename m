Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2440F8F6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhIQNSt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbhIQNSq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 09:18:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4ACC061574;
        Fri, 17 Sep 2021 06:17:22 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631884640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkWzICDmRF+TRzyFslvZ3rwCtSeGiN6dnAL7/P/W8Cs=;
        b=I75bpC5QydGq6e1Wu+IfhJXp4lif0xqlb3l1NPnuD3CbCkjq9uozf3rraJWhisd8RcXDsK
        2tO+8mPdHRA3vCI5P+OgDnkp/qV5u0PzkgTRzd/InkVl67zxA+/88CvDAG5pcntG5aozGb
        dtK8htGWAUPTS20v4H3aPLZRoPpvLLzWCDkXtEl9Xht0KcE6iGTavlpJwdITh+hztpJ5QQ
        FGcDDI7nPT6i7Y3BsR415ZqdhCI6xf0hUilGXWVJ72DI9MH3R/kPCo68SNYg+yDrPhFtTO
        cv4TZ7BIyi7ogTVWDTCd0iPqFWsj7jSzUTtpHwPAl0nJYj5uoBckYVPc96gxqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631884640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkWzICDmRF+TRzyFslvZ3rwCtSeGiN6dnAL7/P/W8Cs=;
        b=nrkfwmR9b8EjPQpZFmnmXcq4CJIB7DMdoJAbcyF0wlx7anDNo+2MNZ3hjrM+nL0cMmbIpN
        Os247f0eV3RMsDDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Let lock_is_held_type() detect recursive
 read as read
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210903084001.lblecrvz4esl4mrr@linutronix.de>
References: <20210903084001.lblecrvz4esl4mrr@linutronix.de>
MIME-Version: 1.0
Message-ID: <163188463991.25758.18010584189127334945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2507003a1d10917c9158077bf6030719d02c941e
Gitweb:        https://git.kernel.org/tip/2507003a1d10917c9158077bf6030719d02c941e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 03 Sep 2021 10:40:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:44 +02:00

lockdep: Let lock_is_held_type() detect recursive read as read

lock_is_held_type(, 1) detects acquired read locks. It only recognized
locks acquired with lock_acquire_shared(). Read locks acquired with
lock_acquire_shared_recursive() are not recognized because a `2' is
stored as the read value.

Rework the check to additionally recognise lock's read value one and two
as a read held lock.

Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20210903084001.lblecrvz4esl4mrr@linutronix.de
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c..bfa0a34 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			if (read == -1 || hlock->read == read)
+			if (read == -1 || !!hlock->read == read)
 				return LOCK_STATE_HELD;
 
 			return LOCK_STATE_NOT_HELD;
