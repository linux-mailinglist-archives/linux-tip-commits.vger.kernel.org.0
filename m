Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655A40FF79
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhIQSiZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 14:38:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhIQSiZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 14:38:25 -0400
Date:   Fri, 17 Sep 2021 18:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631903821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOE455zCgHMRV2KtcMLJJjrjMSeHfZJ2aD7gAmLLL9E=;
        b=RZh0FWMxxRIt+RezQeTESlmA/21VmeiFQk3m2W3dykj02a/wl1jjN3fJtgNJbbcprBjrwV
        FnqR8vzFnYA0jdmd9A0Q81py8pAIUBWgFUAH6o1QnjvCsgVxETs/KBtd7MNjo5xTo+dD90
        AHcsE9wVyjsZ3bxtYnIm0ZYlEpaPOffCRsrSCc7vMk9j2yiEpf+Dpb+LVGLEgPsaRE+hN8
        SeHZUULyJ8XIAAHijbuJJVfB7vW3M4cYhSg3XxfeT1W+cBAIqca9nMtyD53WTJCFNC2ToF
        F+HFP+g+TB9bxW802GXi4y8jEEYBo8eNSxxyjicaii4El0WEQ2BtsQy52OQ8bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631903821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOE455zCgHMRV2KtcMLJJjrjMSeHfZJ2aD7gAmLLL9E=;
        b=KzbMJYo8gNsrByNQCYUCyHUJdrhyiVgFpJec+UBKYYJj3lK+9eQC6qA6tnHWTTmptwIUK5
        Q6OVY9KTVQtXbTCQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unused inline function __rq_clock_broken()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210914095244.52780-1-yuehaibing@huawei.com>
References: <20210914095244.52780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <163190382071.25758.6548863054688812006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e23bc1e6d52e9b9ecca895b408a4eca742caed16
Gitweb:        https://git.kernel.org/tip/e23bc1e6d52e9b9ecca895b408a4eca742caed16
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 14 Sep 2021 17:52:44 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 20:32:26 +02:00

sched: Remove unused inline function __rq_clock_broken()

These is no caller in tree since commit
523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210914095244.52780-1-yuehaibing@huawei.com
---
 kernel/sched/sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 094ea86..148d5d3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1426,11 +1426,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 
 extern void update_rq_clock(struct rq *rq);
 
-static inline u64 __rq_clock_broken(struct rq *rq)
-{
-	return READ_ONCE(rq->clock);
-}
-
 /*
  * rq::clock_update_flags bits
  *
