Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF3388A16
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhESJEp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbhESJEV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 05:04:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89FEC06175F;
        Wed, 19 May 2021 02:02:36 -0700 (PDT)
Date:   Wed, 19 May 2021 09:02:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621414955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8EvIfgzEDqBQYp6s74DAT1Dgj8PKiLIMCqm3l3Mqp0=;
        b=tDFgB50cBM7n5kYAPGlF+1/5O6RJWL023Fn5WpjPLLs74tX/8r3m7la7slj2Q9g2TIgbpz
        mEkELVp+rSVQuLoAwNCAmpEfl9za22FZfANdHHglRzMX/zAATyfGW6AHn+jNQdnETuNw2O
        jma5Vtn+qBmNF4aRFWWRxcd4BfOLiShcyR2JtMp7jGK1QbJDOqZkdzzOMhWSZxK+84fEW8
        sDzEXAc8vbrWxCY7EFFrVK5CAKcXH1q+lBNXHjghwVMulyWkJcHPaOQcXNTSSk7zTPmHZi
        O0f3A10fL+keNhqsA74dkgr3PsX5QFjNCMq2zOPgIN3k7WfbzHKTxwGCkgev6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621414955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8EvIfgzEDqBQYp6s74DAT1Dgj8PKiLIMCqm3l3Mqp0=;
        b=LOmqzKrkFKzEVRLxPz+MFuc3fjrHXBsRLArtne3CAYNKCUWYOkgJA96EBo+MpZPsnj2g2d
        bz2p5sYV0MPgiTBQ==
From:   "tip-bot2 for Yejune Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] lib/smp_processor_id: Use is_percpu_thread()
 instead of nr_cpus_allowed
Cc:     Yejune Deng <yejune.deng@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510151024.2448573-3-valentin.schneider@arm.com>
References: <20210510151024.2448573-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162141495460.29796.4438792168641232595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     570a752b7a9bd03b50ad6420cd7f10092cc11bd3
Gitweb:        https://git.kernel.org/tip/570a752b7a9bd03b50ad6420cd7f10092cc11bd3
Author:        Yejune Deng <yejune.deng@gmail.com>
AuthorDate:    Mon, 10 May 2021 16:10:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 19 May 2021 10:51:40 +02:00

lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed

is_percpu_thread() more elegantly handles SMP vs UP, and further checks the
presence of PF_NO_SETAFFINITY. This lets us catch cases where
check_preemption_disabled() can race with a concurrent sched_setaffinity().

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
[Amended changelog]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210510151024.2448573-3-valentin.schneider@arm.com
---
 lib/smp_processor_id.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 1c1dbd3..046ac62 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (irqs_disabled())
 		goto out;
 
-	/*
-	 * Kernel threads bound to a single CPU can safely use
-	 * smp_processor_id():
-	 */
-	if (current->nr_cpus_allowed == 1)
+	if (is_percpu_thread())
 		goto out;
 
 #ifdef CONFIG_SMP
