Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E552AD6A7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgKJMpv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgKJMpX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817BC0613D1;
        Tue, 10 Nov 2020 04:45:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pa6e/wNUqPVwhFqh696W3M9Lqsr9mpsxZ1wvix/+rtg=;
        b=qI4sr/uRoEM+5KGWjL7D2SqhpIelUaPEIb1TMzNWEr3gH+LDADe0lK80DwOtZJrAhd0Z5a
        VbdYMD1w4T00cQLWlSjLyHwb7Q0ebzsCQPQd7jz1owFZLx7S7syeluxbr2iruDcgmyIj+k
        xmLz4AmlG8OZlR4cUr9qVUzSbmGyNaUIU3h1X8ERrpz5Ye3vS6oqgyKWJd/Dm+0St8CWOd
        xsV0W1nN6biWBUnbDBMAjTK8bADmJIsf5IaTCrf7sEG3E0yFZRxI5UERe5V6xyppxha5PW
        7NgBHNeS2h7Wr+0lCTgocdPxFDQ2AifAsPKVUykLtKnes191G7mUlVkf++/geA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pa6e/wNUqPVwhFqh696W3M9Lqsr9mpsxZ1wvix/+rtg=;
        b=SNuqAvixUSAUKahqIJXDuMw735CR/HHrT5jWaHARevUHYA1BHN7+t4HNmiqAYJKOe6FOMl
        yVxoZl2Ryzth4WAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Optimize get_recursion_context()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151955.187580298@infradead.org>
References: <20201030151955.187580298@infradead.org>
MIME-Version: 1.0
Message-ID: <160501232116.11244.12564524766827620851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     09da9c81253dd8e43e0d2d7cea02de6f9f19499d
Gitweb:        https://git.kernel.org/tip/09da9c81253dd8e43e0d2d7cea02de6f9f19499d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 13:43:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:34 +01:00

perf: Optimize get_recursion_context()

  "Look ma, no branches!"

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Link: https://lkml.kernel.org/r/20201030151955.187580298@infradead.org
---
 kernel/events/internal.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 402054e..228801e 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -205,16 +205,12 @@ DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
 static inline int get_recursion_context(int *recursion)
 {
-	int rctx;
-
-	if (unlikely(in_nmi()))
-		rctx = 3;
-	else if (in_irq())
-		rctx = 2;
-	else if (in_serving_softirq())
-		rctx = 1;
-	else
-		rctx = 0;
+	unsigned int pc = preempt_count();
+	unsigned char rctx = 0;
+
+	rctx += !!(pc & (NMI_MASK));
+	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
 
 	if (recursion[rctx])
 		return -1;
