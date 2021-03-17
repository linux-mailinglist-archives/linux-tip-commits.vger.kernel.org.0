Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1861533F076
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCQMif (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCQMiY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFAC06174A;
        Wed, 17 Mar 2021 05:38:23 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/W+qyeFPqNdojrexRzVnuBGVmMU+XNSQLpYMplD4SY=;
        b=TkGZngR3KwkXHepTAVZrGWmFiofuH1PwlHpybLygL/cZIUacAepypB4aiwFQ2sUnLd+B+y
        ac59CnQfuy+t2r7xk1b38uKE625ey+v/gSZOVCVdhLTwDtSOwsvq0Rilo9KT+TU1XLW+jS
        d5aL1wsJ3elVXtJ6hzjOx3r96QEPtMNZFyYDDHHuj7gR1c2cV/YyKTDcdymXSNyFU7YH6d
        PZOIk/p7UOZCbH+ODipvDCGzEjNl0QqDw07Esvx5SZB6Kow9tds08YSkuFu2Bo3WNPLnLv
        5bwvUCG5d0EEmgJBGG5Eb4gxeEs3bMRoZ1/FapPF2LXYNmyVgdD8vLqGA9c89Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/W+qyeFPqNdojrexRzVnuBGVmMU+XNSQLpYMplD4SY=;
        b=3vLfaQVyNNmAGqZCvHjKcwRp5J5Q4YoVpzH/78jYr2qahmvwpvLO25TZjiSuKVP6MW96VY
        rBSlGuJSGOpaFTBw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock() like a trylock
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210316153119.13802-4-longman@redhat.com>
References: <20210316153119.13802-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b058f2e4d0a70c060e21ed122b264e9649cad57f
Gitweb:        https://git.kernel.org/tip/b058f2e4d0a70c060e21ed122b264e9649cad57f
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 16 Mar 2021 11:31:18 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 09:56:46 +01:00

locking/ww_mutex: Treat ww_mutex_lock() like a trylock

It was found that running the ww_mutex_lock-torture test produced the
following lockdep splat almost immediately:

[  103.892638] ======================================================
[  103.892639] WARNING: possible circular locking dependency detected
[  103.892641] 5.12.0-rc3-debug+ #2 Tainted: G S      W
[  103.892643] ------------------------------------------------------
[  103.892643] lock_torture_wr/3234 is trying to acquire lock:
[  103.892646] ffffffffc0b35b10 (torture_ww_mutex_2.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892660]
[  103.892660] but task is already holding lock:
[  103.892661] ffffffffc0b35cd0 (torture_ww_mutex_0.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x3e2/0x720 [locktorture]
[  103.892669]
[  103.892669] which lock already depends on the new lock.
[  103.892669]
[  103.892670]
[  103.892670] the existing dependency chain (in reverse order) is:
[  103.892671]
[  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
[  103.892675]        lock_acquire+0x1c5/0x830
[  103.892682]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892687]        ww_mutex_lock+0x4b/0x180
[  103.892690]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892694]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892698]        kthread+0x35f/0x430
[  103.892701]        ret_from_fork+0x1f/0x30
[  103.892706]
[  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
[  103.892709]        lock_acquire+0x1c5/0x830
[  103.892712]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892715]        ww_mutex_lock+0x4b/0x180
[  103.892717]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892721]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892725]        kthread+0x35f/0x430
[  103.892727]        ret_from_fork+0x1f/0x30
[  103.892730]
[  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:
[  103.892733]        check_prevs_add+0x3fd/0x2470
[  103.892736]        __lock_acquire+0x2602/0x3100
[  103.892738]        lock_acquire+0x1c5/0x830
[  103.892740]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892743]        ww_mutex_lock+0x4b/0x180
[  103.892746]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892749]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892753]        kthread+0x35f/0x430
[  103.892755]        ret_from_fork+0x1f/0x30
[  103.892757]
[  103.892757] other info that might help us debug this:
[  103.892757]
[  103.892758] Chain exists of:
[  103.892758]   torture_ww_mutex_2.base --> torture_ww_mutex_1.base --> torture_ww_mutex_0.base
[  103.892758]
[  103.892763]  Possible unsafe locking scenario:
[  103.892763]
[  103.892764]        CPU0                    CPU1
[  103.892765]        ----                    ----
[  103.892765]   lock(torture_ww_mutex_0.base);
[  103.892767] 				      lock(torture_ww_mutex_1.base);
[  103.892770] 				      lock(torture_ww_mutex_0.base);
[  103.892772]   lock(torture_ww_mutex_2.base);
[  103.892774]
[  103.892774]  *** DEADLOCK ***

Since ww_mutex is supposed to be deadlock-proof if used properly, such
deadlock scenario should not happen. To avoid this false positive splat,
treat ww_mutex_lock() like a trylock().

After applying this patch, the locktorture test can run for a long time
without triggering the circular locking dependency splat.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by Davidlohr Bueso <dbueso@suse.de>
Link: https://lore.kernel.org/r/20210316153119.13802-4-longman@redhat.com
---
 kernel/locking/mutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 622ebdf..bb89393 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -946,7 +946,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	preempt_disable();
-	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+	/*
+	 * Treat as trylock for ww_mutex.
+	 */
+	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);
 
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
