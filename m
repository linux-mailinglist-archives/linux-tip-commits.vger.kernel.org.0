Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307CA36046E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 10:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhDOIiD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 04:38:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58260 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhDOIiA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 04:38:00 -0400
Date:   Thu, 15 Apr 2021 08:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618475856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDNHrP3ALhoIbXqgfExa+stJYy5WU7PGMrYDWNv0eEw=;
        b=xdAWeXha2qmG2Wdu1XYCHJw1+7m/uNu5kdtKBIb6uoZryHH7HIwCF9jTcnHQxCo0VlpJuN
        hNqTqFNg+8etOQ021rZeqHCjLU9RJY/wQQi+aKPa4dyxwvWuoHf7M2JIvvHcCFtNAOD9Zk
        q46fxwgtl2srettMEwIztPaHKWMpVWuxHPndssBS0KUv7+gAonHe9MAuOwfNRLeAEtXLHL
        8AzQRXNm70J/icAhEVwdxL0N3FnD3cOEsWy9fF+liQmdwdWpTjVjqHAE7YcdwnstFtkJSk
        bYu20Zl2J6NXXax7fPw82R5kn59duhdmt1KHuYsifsgFsUpMU4Tms2e6XPA3QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618475856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDNHrP3ALhoIbXqgfExa+stJYy5WU7PGMrYDWNv0eEw=;
        b=n73TUQAnjI4B9ZJax6mKSjb4wqlmHKYc+LIeORI5xh+M4rC0/Swf7YQNwrgzNGI7LEwdTd
        dPDZHovQdJu/ctAw==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Optimise rseq_get_rseq_cs() and clear_rseq_cs()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210413203352.71350-4-eric.dumazet@gmail.com>
References: <20210413203352.71350-4-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <161847585417.29796.13325097988570422172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e0ccd4a3b01c5a71732a13186ca110a138516ea
Gitweb:        https://git.kernel.org/tip/5e0ccd4a3b01c5a71732a13186ca110a138516ea
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 13 Apr 2021 13:33:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Apr 2021 18:04:09 +02:00

rseq: Optimise rseq_get_rseq_cs() and clear_rseq_cs()

Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
update includes") added regressions for our servers.

Using copy_from_user() and clear_user() for 64bit values
is suboptimal.

We can use faster put_user() and get_user() on 64bit arches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20210413203352.71350-4-eric.dumazet@gmail.com
---
 kernel/rseq.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index cfe01ab..35f7bd0 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -127,8 +127,13 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
+#ifdef CONFIG_64BIT
+	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
+		return -EFAULT;
+#else
 	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
 		return -EFAULT;
+#endif
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
@@ -211,9 +216,13 @@ static int clear_rseq_cs(struct task_struct *t)
 	 *
 	 * Set rseq_cs to NULL.
 	 */
+#ifdef CONFIG_64BIT
+	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
+#else
 	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
 		return -EFAULT;
 	return 0;
+#endif
 }
 
 /*
