Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4F346269
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCWPJZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhCWPJF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:09:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E8C061764;
        Tue, 23 Mar 2021 08:09:04 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVbXEkiIHpyXN0C5ijWE4PRqcKypnI5p3HFpnBZ0Pgw=;
        b=My31Gb9xCbvgX60407o2PgiyfCXD9e8jxYjDmJi+BMqpXPMOsrOv1Fmi+scEWvQtmG7UJe
        j9zclEk1T8xLktkZw3GXesFqmO3zuF6aOxb7iZ15D4YUwAcUHMg38MUR4+cbQgz2z2Afts
        GuIj1l4FHXFOH+JJB7jOsQLHIU4O5Y4b6mLVR4BvP0rBPce7hg2d69wbls23aQ49gUq0Ze
        vxqU6TpPsw1OSP5pREILtIYInJwbsWSP3fIk+S/WkM9wmfaNuz3aKeHAnrimopKflkUG74
        9Et5CKsEGEBcJt8T1LcQSJLs+Awix148OTWDnq/9RcdPLh27rZ+e928hAuc5+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVbXEkiIHpyXN0C5ijWE4PRqcKypnI5p3HFpnBZ0Pgw=;
        b=RFWYTnQF7nXVCRCOmf3FmQ3HUBOLzSDcowGwEasVRde2/4TExwVeSlsiwh1kZ+HPqjYS/8
        sVGFY4L9iRZlRSBg==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize test_idle_cores() for !SMT
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210320221432.924-1-song.bao.hua@hisilicon.com>
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161651213699.398.5893410671090085517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c8987ae5af793a73e2c0d6ce804d8ff454ea377c
Gitweb:        https://git.kernel.org/tip/c8987ae5af793a73e2c0d6ce804d8ff454ea377c
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Sun, 21 Mar 2021 11:14:32 +13:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:01:59 +01:00

sched/fair: Optimize test_idle_cores() for !SMT

update_idle_core() is only done for the case of sched_smt_present.
but test_idle_cores() is done for all machines even those without
SMT.

This can contribute to up 8%+ hackbench performance loss on a
machine like kunpeng 920 which has no SMT. This patch removes the
redundant test_idle_cores() for !SMT machines.

Hackbench is ran with -g {2..14}, for each g it is ran 10 times to get
an average.

  $ numactl -N 0 hackbench -p -T -l 20000 -g $1

The below is the result of hackbench w/ and w/o this patch:

  g=    2      4     6       8      10     12      14
  w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
  w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
			    +4.1%  +8.3%  +7.3%   +6.3%

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210320221432.924-1-song.bao.hua@hisilicon.com
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6aad028..aaa0dfa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,9 +6038,11 @@ static inline bool test_idle_cores(int cpu, bool def)
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+	if (static_branch_likely(&sched_smt_present)) {
+		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+		if (sds)
+			return READ_ONCE(sds->has_idle_cores);
+	}
 
 	return def;
 }
