Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB47362495
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhDPPyT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhDPPyL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E523C061574;
        Fri, 16 Apr 2021 08:53:46 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NG2ae6qWkx7VLt4SEQZgI98U9N8e1QuSJT29lV0Mpc=;
        b=v3be3G1hj7j2BX+LsrgU0hh7ujtp5oWz6HPZu1GewRbF5D91UNMTCxMm4o+NjAOmX3Fkcp
        u0fDqMDcg8Kbr3PBnAkzzrIgAVqACuP8svkLg4Khlw3gMoXjibI2mUaDuHgbOk5DwsVH5+
        Zes4klj9L+VpnB1aXhEeXoJdtGAt4PYP8qqjHQpUOr4JXz9D4cOlYzZI1pY2Z0ATRgkQhP
        CMVlTqJ+BKkeHua89cSkesXoCdoFXzYMPUF5tYs9Oa6wuaLqVrHftLVRPRMOWBnQY9qrkq
        lub+HaNQR1V2W0GDVC3aa2pXNtnmBu3abfQFnUnT4PBgl0ZW+uTFHN8vTafXcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NG2ae6qWkx7VLt4SEQZgI98U9N8e1QuSJT29lV0Mpc=;
        b=qkSRqKPPQry/H6Z/tEmqHKLRBvR1e8yQHlLUepG14//VgN+3yTbvU9Qc739HdvJuqxyIE3
        lKW973dwv7UNcaCQ==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Allow runtime enabling/disabling of
 NUMA balance without SCHED_DEBUG
Cc:     Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210324133916.GQ15768@suse.de>
References: <20210324133916.GQ15768@suse.de>
MIME-Version: 1.0
Message-ID: <161858842405.29796.3492604972677273238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b7cc6ec744b307db59568c654a8904a5928aa855
Gitweb:        https://git.kernel.org/tip/b7cc6ec744b307db59568c654a8904a5928aa855
Author:        Mel Gorman <mgorman@suse.de>
AuthorDate:    Wed, 24 Mar 2021 13:39:16 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:33 +02:00

sched/numa: Allow runtime enabling/disabling of NUMA balance without SCHED_DEBUG

The ability to enable/disable NUMA balancing is not a debugging feature
and should not depend on CONFIG_SCHED_DEBUG.  For example, machines within
a HPC cluster may disable NUMA balancing temporarily for some jobs and
re-enable it for other jobs without needing to reboot.

This patch removes the dependency on CONFIG_SCHED_DEBUG for
kernel.numa_balancing sysctl. The other numa balancing related sysctls
are left as-is because if they need to be tuned then it is more likely
that NUMA balancing needs to be fixed instead.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210324133916.GQ15768@suse.de
---
 kernel/sysctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09..8042098 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1753,6 +1753,9 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_SCHED_DEBUG */
+#ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
 		.data		= NULL, /* filled in by handler */
@@ -1763,7 +1766,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
 		.data		= &sysctl_sched_rt_period,
