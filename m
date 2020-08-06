Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0923DDCE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Aug 2020 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgHFRO0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 13:14:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbgHFRJ5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 13:09:57 -0400
Date:   Thu, 06 Aug 2020 17:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ne3J/fritjC3f6XwQ45a/x/lwXUJ47nxfGJP34wwHIw=;
        b=p1EXG7mEDsdLD6amjmi/a+8S6VFVZTVYI8G1ZZhXGx9Q6szc3oFejR649hTPdhZEBoZrWg
        ZipOln43CG2Dcgke9+h0eo+956Lmt/TXpq/z959ZEVv1I/d0icGWkF/NaC1gc5HILQIUXK
        AdGXIz0cGl+BxCwjWmpGngsjkyh2fvYcqYhOoLjbKlDYaxL605c/OyvkN63sfofOOJ2pM4
        q4bMPjTSMEhz6r0cNybMUvVuMBc5bSO6P/no6kyTt6Kz3xwQgGWMsqnt8HULt1aHit6KDG
        43c1wJUE4l3tqfySnD8n6lOzkNNkY2++AN3oMq/9SdgKBuIPZrTAbihS7oBahQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ne3J/fritjC3f6XwQ45a/x/lwXUJ47nxfGJP34wwHIw=;
        b=vJISJ2hTeugf7tQahU8Kclny3CxFvTHsy00neQSA7jY9JUo2kJ95bvfJHokt0CW94NGLbS
        wZp2AGt/lPtOuFAQ==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix use of count for nr_running tracepoint
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200805203138.1411-1-pauld@redhat.com>
References: <20200805203138.1411-1-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <159673379532.3192.11425814365139825757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a1bd06853ee478d37fae9435c5521e301de94c67
Gitweb:        https://git.kernel.org/tip/a1bd06853ee478d37fae9435c5521e301de94c67
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Wed, 05 Aug 2020 16:31:38 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 09:36:59 +02:00

sched: Fix use of count for nr_running tracepoint

The count field is meant to tell if an update to nr_running
is an add or a subtract. Make it do so by adding the missing
minus sign.

Fixes: 9d246053a691 ("sched: Add a tracepoint to track rq->nr_running")
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200805203138.1411-1-pauld@redhat.com
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3fd2838..28709f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1999,7 +1999,7 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
 	if (trace_sched_update_nr_running_tp_enabled()) {
-		call_trace_sched_update_nr_running(rq, count);
+		call_trace_sched_update_nr_running(rq, -count);
 	}
 
 	/* Check if we still need preemption */
