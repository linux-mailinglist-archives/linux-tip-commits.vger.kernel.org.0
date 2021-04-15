Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8636046D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhDOIiC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 04:38:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDOIiA (ORCPT
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
        bh=ROeQ1OxMvB8BnBA7qu8XZTUAQ0r3ZQxY22kR4mz0S3k=;
        b=UYdbYNsvaDHs6Xg78AcrwG8MkOqGCwKAAmjyIPYKC8NOTbt5LDa0chex1BR6Ze2w5RoHe+
        T3DEITbFHzac8Pq7gEnHM/9her2CAd8A8iTAbu7nrC8c1n7/mShjrUSwEpiHm6TX3dzpnB
        tIm92Mjw5OuXKBHaSnBjb2GFxOggYSfJZwx8zzPjgN1EyhXC39PXDfCgaUJCTKyxEmCKjb
        NlGm8Q5NVp6hQ0oavk/K7zxdg1mNP3pwMZ7tdoRIo5r160MKFNg+qeHZg59yCZ4MxzgUmv
        6nYPdCl2Z7fc0WJwUbhlQOYxMlOXYb4ECVXqzLeMSfkqTKFpnLosVUvHagc+vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618475856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROeQ1OxMvB8BnBA7qu8XZTUAQ0r3ZQxY22kR4mz0S3k=;
        b=Z3Lti0Hq2WeuD33FZTm0F9dDHK5ykwp60HurmiesYhhpIH/ske2veqp8+dE5LPN509+Rv9
        IBaAo1FM/SXuhmAw==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Remove redundant access_ok()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210413203352.71350-3-eric.dumazet@gmail.com>
References: <20210413203352.71350-3-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <161847585462.29796.5252744835551804567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ed96051531ecc6965f6456d25b19b9b6bdb5c28
Gitweb:        https://git.kernel.org/tip/0ed96051531ecc6965f6456d25b19b9b6bdb5c28
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 13 Apr 2021 13:33:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Apr 2021 18:04:09 +02:00

rseq: Remove redundant access_ok()

After commit 8f2817701492 ("rseq: Use get_user/put_user rather
than __get_user/__put_user") we no longer need
an access_ok() call from __rseq_handle_notify_resume()

Mathieu pointed out the same cleanup can be done
in rseq_syscall().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20210413203352.71350-3-eric.dumazet@gmail.com
---
 kernel/rseq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index f020f18..cfe01ab 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -273,8 +273,6 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
-		goto error;
 	ret = rseq_ip_fixup(regs);
 	if (unlikely(ret < 0))
 		goto error;
@@ -301,8 +299,7 @@ void rseq_syscall(struct pt_regs *regs)
 
 	if (!t->rseq)
 		return;
-	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
-	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
 		force_sig(SIGSEGV);
 }
 
