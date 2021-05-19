Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D1388CB4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbhESLZM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350325AbhESLZL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 07:25:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB05C06175F;
        Wed, 19 May 2021 04:23:52 -0700 (PDT)
Date:   Wed, 19 May 2021 11:23:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621423430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oC8q0rOmcDKtolwME7rSjazhCjKJV5JaDUa4U5xRKmc=;
        b=tXglUprhFWQOUvmiKHzmTabnInng5QjGnAR7sZnZ670fvLFFY4vuwld0McGOyRnChyZECw
        zNmK7NfJF5640P3NIlqPwAYPsKj436bujhjpVCY4nd/6J1hIs86xihDr2Hbf6oSsM0njQG
        SziADYphCbAoEsi5cg6pJ/XoYrBWck2MYzSM1fqe2IpytX4Pk2QIV32quZ2/8xYG2/063R
        4j/ABbVR0QWwYQWkz1Vwu+tpQpFO7psvU5NE98agnmBW1GTCCpAjE575gbyPUyFQrgW3RP
        cxu+jZQ+atJqedtqMjdYmBx3RhYB6gjy5DTrQdMV/oKzRp+WdxkhvKFrK0XthA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621423430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oC8q0rOmcDKtolwME7rSjazhCjKJV5JaDUa4U5xRKmc=;
        b=VOpDbjQnyP+Uy2Giw6AQmAI2kFodm8nQCPJejmxi3rKIeCTlOM0LIS5eWE6L1jRrJF0Jo9
        V/guX7H35IXF+7CQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix a stale comment in pick_next_task()
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519063709.323162-1-masahiroy@kernel.org>
References: <20210519063709.323162-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162142342925.29796.10155000709823402519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1699949d3314e5d1956fb082e4cd4798bf6149fc
Gitweb:        https://git.kernel.org/tip/1699949d3314e5d1956fb082e4cd4798bf6149fc
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 19 May 2021 15:37:09 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 May 2021 13:03:21 +02:00

sched: Fix a stale comment in pick_next_task()

fair_sched_class->next no longer exists since commit:

  a87e749e8fa1 ("sched: Remove struct sched_class::next field").

Now the sched_class order is specified by the linker script.

Rewrite the comment in a more generic way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210519063709.323162-1-masahiroy@kernel.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ec420c..3d25272 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5318,7 +5318,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (unlikely(p == RETRY_TASK))
 			goto restart;
 
-		/* Assumes fair_sched_class->next == idle_sched_class */
+		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
 			put_prev_task(rq, prev);
 			p = pick_next_task_idle(rq);
