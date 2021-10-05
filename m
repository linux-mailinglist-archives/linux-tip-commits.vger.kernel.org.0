Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAB422A51
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhJEONu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhJEONt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:49 -0400
Date:   Tue, 05 Oct 2021 14:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2p0ixJp8i5O+9SlOZa7ghg+UdHYvLq1JZera5LpoFBg=;
        b=Jy01cJwkVGx6HvENlyBFCv9uYO29mYDwo594Dqaur8ieRZn+bsrBM5/OsW9AZr46KgNuOz
        oxAyqqCH1EY4ghL0ngSf6R1hxx4pF0tEYIrCRU9D4fxEKSqeF5JFQavTT7PLrs8VLFFpHD
        KVgfnzX2sQOwVW/Q/LPP9D0XdiqJ+d4dU+clRyGJNIGypaXoS0LRxgTL+74DcH0e6B1+Ik
        SN/f+PIc0r9ruocO6R1klT+3jNLvvFDGM+7hHgoyw4Ec2xU72HnMbptxnXyWxailQkq+n2
        AOsl8NSlzsdiN37HpS4YX0g9rrFF59oEIsNhe/vyq8O75Azd6YVbx7zM1IQdRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2p0ixJp8i5O+9SlOZa7ghg+UdHYvLq1JZera5LpoFBg=;
        b=CStR4lBmvUodVO4LBpTK7n8n1cn0JY7mjFVPTm87mFW6Km0K615p6yLCAd+QK9w/yr1gTb
        b0R6V5sJNEqDrIAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Disable TTWU_QUEUE on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928122411.482262764@linutronix.de>
References: <20210928122411.482262764@linutronix.de>
MIME-Version: 1.0
Message-ID: <163344311716.25758.10362833133961492425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     539fbb5be0da56ffa1434b4f56521a0522bd1d61
Gitweb:        https://git.kernel.org/tip/539fbb5be0da56ffa1434b4f56521a0522bd1d61
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:12 +02:00

sched: Disable TTWU_QUEUE on RT

The queued remote wakeup mechanism has turned out to be suboptimal for RT
enabled kernels. The maximum latencies go up by a factor of > 5x in certain
scenarious.

This is caused by either long wake lists or by a large number of TTWU IPIs
which are processed back to back.

Disable it for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928122411.482262764@linutronix.de
---
 kernel/sched/features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7f8dace..1cf435b 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -46,11 +46,16 @@ SCHED_FEAT(DOUBLE_TICK, false)
  */
 SCHED_FEAT(NONTASK_CAPACITY, true)
 
+#ifdef CONFIG_PREEMPT_RT
+SCHED_FEAT(TTWU_QUEUE, false)
+#else
+
 /*
  * Queue remote wakeups on the target CPU and process them
  * using the scheduler IPI. Reduces rq->lock contention/bounces.
  */
 SCHED_FEAT(TTWU_QUEUE, true)
+#endif
 
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
