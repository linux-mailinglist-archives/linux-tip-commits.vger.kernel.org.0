Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D832B3A6C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKOWvH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgKOWvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B18C0613CF;
        Sun, 15 Nov 2020 14:51:06 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHqj28Plm58wxpmVLQLDW33Z3qv8qXqTgDO5fun+I9M=;
        b=lWtBXGgb/4AIXZjJFLLxb2gBJgeeWVIQeqfAjsqgBUOk7tnMM1oiQpACo3sPHaGXYBmUBK
        Cy0JkTW+OUMpbwfeTMPM+VZ6VS6kakxbwuEN7qny4a/vQEFJkQMwdLrh35a8UoHgLjV4sC
        30o9sIYk/nFxJGrDoxrscL5JMZgxg4MV1ZEmC2M1FPiguwroBfweXP3AvI4mhiLwytP3Eh
        nptfTAjYRiHTwX67zmfHhRf0benjI5dQSMGKSx2CJ7EurUCTyvVPyjYPTBU7RP9Aom2qwV
        HXi3TH+/daG7bz0v8pzZIJ1aZ3MPQlQDfZgydXqSnJW0w34RhXzXTKKv8k5taQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHqj28Plm58wxpmVLQLDW33Z3qv8qXqTgDO5fun+I9M=;
        b=8mOruafEkUloSlTmw0O3KRm1d24Fa4BjRYFm3gmwkNSjU4J2dSZMBmbCTRccSvVlXGWzo8
        CG8T1bxdLAj4ZjDw==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add missing parameter docs for
 pvclock_gtod_[un]register_notifier()
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066443.11244.2312343456989921633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f27f7c3f100e74a7f451a63a15788f50c52f7cce
Gitweb:        https://git.kernel.org/tip/f27f7c3f100e74a7f451a63a15788f50c52f7cce
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:24 +01:00

timekeeping: Add missing parameter docs for pvclock_gtod_[un]register_notifier()

The kernel-doc parser complains about:
 kernel/time/timekeeping.c:651: warning: Function parameter or member
 'nb' not described in 'pvclock_gtod_register_notifier'
 kernel/time/timekeeping.c:670: warning: Function parameter or member
 'nb' not described in 'pvclock_gtod_unregister_notifier'

Add the missing parameter explanations.

[ tglx: Massaged changelog ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-3-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timekeeping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ab4b831..9c93923 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -663,6 +663,7 @@ static void update_pvclock_gtod(struct timekeeper *tk, bool was_set)
 
 /**
  * pvclock_gtod_register_notifier - register a pvclock timedata update listener
+ * @nb: Pointer to the notifier block to register
  */
 int pvclock_gtod_register_notifier(struct notifier_block *nb)
 {
@@ -682,6 +683,7 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_register_notifier);
 /**
  * pvclock_gtod_unregister_notifier - unregister a pvclock
  * timedata update listener
+ * @nb: Pointer to the notifier block to unregister
  */
 int pvclock_gtod_unregister_notifier(struct notifier_block *nb)
 {
