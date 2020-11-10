Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D992AD6BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgKJMqv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgKJMpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA8C0613CF;
        Tue, 10 Nov 2020 04:45:20 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlhQewQtTXEPhYiIf7CuYtR9qEyliWZVMPK5jIbCPWM=;
        b=PkMrUHu7zMIyIganLWpTeZoZ5VfnuSH6FsJ/Byz5CZI04q5fmTuDw7we8QUzVC2waHBHZY
        c7btkuNfjYJCo3Qg6J9d5+3ZmR68tvVNnTG5ITQyvpSHCBWnGpB10hGr6fAI5Bfj0iRz1Z
        VTi2pDcafoL2lbcYXWWQY1yyOBLNRqsW7J925clXF2lVC9L2hRAZZXEd7QL6JytJULoIvl
        9Y1XMXzmeZcErbVRCrN6T7vHhAWeSV8XZkhmfabBX3C6XVNg20HGEhpuyETxdOS4VcpzXN
        IYnVsVlcZfJvXHVdpxuHjCupgadKeshGZw3RiRwy1rr9ehXVgEq28+2Tu/E5rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlhQewQtTXEPhYiIf7CuYtR9qEyliWZVMPK5jIbCPWM=;
        b=5QG2cObk50ucHSBpXnp3eTkjlZ5AnDQM1KDNU1+dsjIn2zuNr7bLFRAeyh7Pggic2yDXrV
        8eLGseypP1xhhLDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix event multiplexing for exclusive groups
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029162902.038667689@infradead.org>
References: <20201029162902.038667689@infradead.org>
MIME-Version: 1.0
Message-ID: <160501231817.11244.16475577084391904219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2714c3962f304d031d5016c963c4b459337b0749
Gitweb:        https://git.kernel.org/tip/2714c3962f304d031d5016c963c4b459337b0749
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Oct 2020 16:29:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:36 +01:00

perf: Fix event multiplexing for exclusive groups

Commit 9e6302056f80 ("perf: Use hrtimers for event multiplexing")
placed the hrtimer (re)start call in the wrong place.  Instead of
capturing all scheduling failures, it only considered the PMU failure.

The result is that groups using perf_event_attr::exclusive are no
longer rotated.

Fixes: 9e6302056f80 ("perf: Use hrtimers for event multiplexing")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201029162902.038667689@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0e5268..00be48a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2612,7 +2612,6 @@ group_error:
 
 error:
 	pmu->cancel_txn(pmu);
-	perf_mux_hrtimer_restart(cpuctx);
 	return -EAGAIN;
 }
 
@@ -3672,6 +3671,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
+		perf_mux_hrtimer_restart(cpuctx);
 	}
 
 	return 0;
