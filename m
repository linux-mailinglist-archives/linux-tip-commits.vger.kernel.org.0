Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F423D3131D4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhBHMJT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhBHMHR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:07:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4ECC06178A;
        Mon,  8 Feb 2021 04:06:36 -0800 (PST)
Date:   Mon, 08 Feb 2021 12:06:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkcgDtiq9H22ESNjGl4kiZJBKyWKACV97G6szrgnwR0=;
        b=H2o3R20RwagCtBgHh1IBA5s2BJzLR+cxtS6+yYIMp1ZTADj+SYdq73KXnmAIg361L1ZX2U
        3LkT9rKiiVvRuaIz7yZ8aUYQ8DlfU2aBwbpVaaXQl4/lfQOgpSL2E5rbfmyph+MmtPm/JY
        0D3G0s3/zRE0OUJVEGLk/zqXJMvL79ey+U670iqo72wo8W58ywzL4ZSgGvoJJNeNuBmPEp
        yCn2ATUmgU6Kayr8jjy8APktMLfLkmakWe8MXXJhEMsPdlixmOM6aOJpwIL1QeZsO97bS0
        g4nAa4JOiaqaJJWaSybHceTTfOmMeVqP4W31FRBVrCp3ql7FBACjJA34ApUoVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkcgDtiq9H22ESNjGl4kiZJBKyWKACV97G6szrgnwR0=;
        b=h/Bnftcz+PI9rybm51aR8OhYjjfDPcdphnRuqv6cKTOCLwjtz9jawKCVKGcpKsvE0MLzs8
        VWlexhBgO2FO7hBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Avoid unmatched unlock
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YBfkuyIfB1+VRxXP@hirez.programming.kicks-ass.net>
References: <YBfkuyIfB1+VRxXP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161278599436.23325.6481139637302751711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7f82e631d236cafd28518b998c6d4d8dc2ef68f6
Gitweb:        https://git.kernel.org/tip/7f82e631d236cafd28518b998c6d4d8dc2ef68f6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Feb 2021 11:55:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:20:15 +01:00

locking/lockdep: Avoid unmatched unlock

Commit f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI"
inversions") overlooked that print_usage_bug() releases the graph_lock
and called it without the graph lock held.

Fixes: f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/YBfkuyIfB1+VRxXP@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ad9afd8..5104db0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3773,7 +3773,7 @@ static void
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
 	pr_warn("\n");
@@ -3814,6 +3814,7 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
 	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
+		graph_unlock();
 		print_usage_bug(curr, this, bad_bit, new_bit);
 		return 0;
 	}
