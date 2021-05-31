Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA8395915
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEaKmf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhEaKm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:42:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF52C06174A;
        Mon, 31 May 2021 03:40:46 -0700 (PDT)
Date:   Mon, 31 May 2021 10:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622457644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiFeCfRaHeCsjUxcDpC7TOeQPjyxerYrXoe6w0WQmVU=;
        b=AgA7gda3kk1Yd95FpR1LlEJl//oR6FDuYo87AokG5P+OjfvKVKyCArQgt+1bhQMTeky+EW
        7MGVqd59P5k2pmYW2UQIOIoyth7BsdSwB/P5qvVFVjA75IpWv09ZuGZb08SayfteDMLVQn
        UdylEErAO8SFlIA+uarISBpDtrN3UI8N4InOoCH9ChR8+YkWkoPJm1nsABs5DucIPEO3QU
        eLPkyN81zSTjssHFJRRcHw8NpCeOZgNrujW/y2t5HDK7rz+fAkJb3h8duwI7DH9atowr+j
        p6osC3L9iAqleJlCumxK6jDeXzjFgfSi43JHoP6iBHSmJQnlMNnzVRbdctkLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622457644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiFeCfRaHeCsjUxcDpC7TOeQPjyxerYrXoe6w0WQmVU=;
        b=ldqqVCUy4UDxpNjKPz0TIYFQomx1j4LtYfKSmr3097Id4W2o92lEgXwbDtEHroJfiJW09S
        zX/iDqqu2+MIESBw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix data race between pin_count increment/decrement
Cc:     syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527104711.2671610-1-elver@google.com>
References: <20210527104711.2671610-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <162245764385.29796.9800747748903959917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6c605f8371159432ec61cbb1488dcf7ad24ad19a
Gitweb:        https://git.kernel.org/tip/6c605f8371159432ec61cbb1488dcf7ad24ad19a
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 27 May 2021 12:47:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 31 May 2021 10:14:51 +02:00

perf: Fix data race between pin_count increment/decrement

KCSAN reports a data race between increment and decrement of pin_count:

  write to 0xffff888237c2d4e0 of 4 bytes by task 15740 on cpu 1:
   find_get_context		kernel/events/core.c:4617
   __do_sys_perf_event_open	kernel/events/core.c:12097 [inline]
   __se_sys_perf_event_open	kernel/events/core.c:11933
   ...
  read to 0xffff888237c2d4e0 of 4 bytes by task 15743 on cpu 0:
   perf_unpin_context		kernel/events/core.c:1525 [inline]
   __do_sys_perf_event_open	kernel/events/core.c:12328 [inline]
   __se_sys_perf_event_open	kernel/events/core.c:11933
   ...

Because neither read-modify-write here is atomic, this can lead to one
of the operations being lost, resulting in an inconsistent pin_count.
Fix it by adding the missing locking in the CPU-event case.

Fixes: fe4b04fa31a6 ("perf: Cure task_oncpu_function_call() races")
Reported-by: syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210527104711.2671610-1-elver@google.com
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..fe88d6e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4609,7 +4609,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		ctx = &cpuctx->ctx;
 		get_ctx(ctx);
+		raw_spin_lock_irqsave(&ctx->lock, flags);
 		++ctx->pin_count;
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		return ctx;
 	}
