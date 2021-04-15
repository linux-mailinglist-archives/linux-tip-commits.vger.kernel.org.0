Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3F436046F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhDOIiF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 04:38:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhDOIiB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 04:38:01 -0400
Date:   Thu, 15 Apr 2021 08:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618475857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjHL55bEeskbBs9mz12HAqyHio2hK+S7n0fTvWlroWk=;
        b=ReIBjoUFvBGsnaybcFC5+VLad5ss8mNn30CP6QvgY9WC5VqhxN7hE1e5xDUVndqAuJIW6/
        0EVjzN3czBs4KR9L9Y4eILw/8Sb5+RAw4osyi/f8BdCRv+r+8M8jITkkAWiBbrGAhoJUMo
        pBU5KPiipMQboU/gvqgwXrEC062Dsum05THj9QSpyh8DcUHaGBg5qIYtBpu8dqN7roMfjo
        nGBfbJ/1esEa35ocfZur6SAKGar2h7sH90ERtL1k87ELSioA0Nt4g6zfxIjinNmeFs5uM1
        VhMGhqrQdaH479iK1Jlo3uoCAvulnrz3ZjIQ3pBCye1jkrbeO0mLMV3Th4HkFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618475857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjHL55bEeskbBs9mz12HAqyHio2hK+S7n0fTvWlroWk=;
        b=nPpAbx+3FLXE2OsTFfu3Ehq2EqnZj8AiljnX8FVujEVyKk1e0RMrETZylzxAhH5QyhGP63
        xHO4j17eePGi1OAQ==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Optimize rseq_update_cpu_id()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210413203352.71350-2-eric.dumazet@gmail.com>
References: <20210413203352.71350-2-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <161847585497.29796.198913334536672796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     60af388d23889636011488c42763876bcdda3eab
Gitweb:        https://git.kernel.org/tip/60af388d23889636011488c42763876bcdda3eab
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 13 Apr 2021 13:33:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Apr 2021 18:04:09 +02:00

rseq: Optimize rseq_update_cpu_id()

Two put_user() in rseq_update_cpu_id() are replaced
by a pair of unsafe_put_user() with appropriate surroundings.

This removes one stac/clac pair on x86 in fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20210413203352.71350-2-eric.dumazet@gmail.com
---
 kernel/rseq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9..f020f18 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,13 +84,20 @@
 static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
+	struct rseq __user *rseq = t->rseq;
 
-	if (put_user(cpu_id, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
+	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+		goto efault;
+	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
+	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
+
+efault_end:
+	user_write_access_end();
+efault:
+	return -EFAULT;
 }
 
 static int rseq_reset_rseq_cpu_id(struct task_struct *t)
