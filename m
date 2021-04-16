Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A41362491
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhDPPyP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhDPPyK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:10 -0400
Date:   Fri, 16 Apr 2021 15:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m8JcsqPOETyostPRA8rjjubVp4yO1xghB7n3RmVvmo=;
        b=0qEIc09//iUkJiL/R5sftXVaZxeIvb99ZDIh0KxSKtdtmfM0dD7XULlfBSYKagxCotQdGa
        L1wkapWtwfJ/rGd+2uJ0MWZweNQ1CFa0n14+vDluwjViEguvAN37anADn+/vgg9RGuHxvf
        +p9iNTQtUcmxYZQMJWcClCYI3pJXgX3UFSy6raFYvN4v/kzPT/umpZ2Qtyd6R/qQCeXj5F
        cGV+mxE4J/e+FbVxVWBK1EYNaHbvObLGY8yu8TMn4maiLTV16ZJ+WF9Z2VTXMEl4fI5YAs
        e8YVHkTR08qY2g6k1cQK2gLTr4r0aQP6K0ioXCylntfRdfpy0XDfl/tIs68mLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m8JcsqPOETyostPRA8rjjubVp4yO1xghB7n3RmVvmo=;
        b=fxuUkWNGwQEuKDVi71G/6uEab9dGFvNpkCauPEwqKxOKV++bFvmv6+G3GWKJmY7ZQ02mC3
        Ri37+1bdudxXmuCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove sched_schedstats sysctl out from
 under SCHED_DEBUG
Cc:     Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.161151631@infradead.org>
References: <20210412102001.161151631@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842361.29796.9540204811870244295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1d1c2509de4488cc58c924d0a6117c62de1d4f9c
Gitweb:        https://git.kernel.org/tip/1d1c2509de4488cc58c924d0a6117c62de1d4f9c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Mar 2021 19:47:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:33 +02:00

sched: Remove sched_schedstats sysctl out from under SCHED_DEBUG

CONFIG_SCHEDSTATS does not depend on SCHED_DEBUG, it is inconsistent
to have the sysctl depend on it.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.161151631@infradead.org
---
 kernel/sysctl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8042098..17f1cc9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1711,17 +1711,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_SCHEDSTATS
-	{
-		.procname	= "sched_schedstats",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_schedstats,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SCHEDSTATS */
 #endif /* CONFIG_SMP */
 #ifdef CONFIG_NUMA_BALANCING
 	{
@@ -1755,6 +1744,17 @@ static struct ctl_table kern_table[] = {
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
+#ifdef CONFIG_SCHEDSTATS
+	{
+		.procname	= "sched_schedstats",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_schedstats,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SCHEDSTATS */
 #ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
