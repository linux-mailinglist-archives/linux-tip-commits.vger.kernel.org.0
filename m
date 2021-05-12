Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB837B86E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhELItD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhELIs7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 04:48:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC16C061760;
        Wed, 12 May 2021 01:47:51 -0700 (PDT)
Date:   Wed, 12 May 2021 08:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620809270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHOHowTuaqG6fAqphFm6F8HCmnXnEYLwnGR3WdQvKe4=;
        b=ywYg5bIl/5JaNTi0zJhxjvPaXSPVBtDu/CzG7liL1DOafFaGTOvM+f7AA9tt3jojtVxuyz
        1kUfEpQxPgL8FKIt0wAequBXT0pcc461iusLjj7QLTzhGXtApPRnTauSdQU3Y/8fJuquLg
        XA5jpnbhVAXBRyV/ADO6I/9eaE6ziLhBwiWvTz4V13U/AgweciXWzaXNhYPwvcZyypoLOv
        TIHcLHp5u6Fc+AoiL/90I0AevYXX8rwErTfOl5SJ8fU/a46TsdJ4kjybI+skwZl5R3lF4M
        AcRiB2AhtJQ2A17Ys20fRJYKMA1EWJjebpvYsKzzcNbjRs+R1DFqExQFasE9eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620809270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHOHowTuaqG6fAqphFm6F8HCmnXnEYLwnGR3WdQvKe4=;
        b=iP2Rx1ycPGYJvACeopEvT4fbhLLVECRi3xa8jkuBK250ls34d5C27z1e8FzINWmgwAvNte
        c1nIL3JQVEcc3ODA==
From:   "tip-bot2 for Gautham R. Shenoy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix clearing of has_idle_cores flag
 in select_idle_cpu()
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <162080926950.29796.5635598249768970052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     02dbb7246c5bbbbe1607ebdc546ba5c454a664b1
Gitweb:        https://git.kernel.org/tip/02dbb7246c5bbbbe1607ebdc546ba5c454a664b1
Author:        Gautham R. Shenoy <ego@linux.vnet.ibm.com>
AuthorDate:    Tue, 11 May 2021 20:46:09 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:41:28 +02:00

sched/fair: Fix clearing of has_idle_cores flag in select_idle_cpu()

In commit:

  9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")

in select_idle_cpu(), we check if an idle core is present in the LLC
of the target CPU via the flag "has_idle_cores". We look for the idle
core in select_idle_cores(). If select_idle_cores() isn't able to find
an idle core/CPU, we need to unset the has_idle_cores flag in the LLC
of the target to prevent other CPUs from going down this route.

However, the current code is unsetting it in the LLC of the current
CPU instead of the target CPU. This patch fixes this issue.

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20aa234..3248e24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6217,7 +6217,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 	}
 
 	if (has_idle_core)
-		set_idle_cores(this, false);
+		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
