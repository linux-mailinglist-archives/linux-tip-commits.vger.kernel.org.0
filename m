Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764641ED08
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354321AbhJAMM2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354313AbhJAMM0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:26 -0400
Date:   Fri, 01 Oct 2021 12:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/hcSLxRzI9WUoD9EAQsZjkCbl3dFDyyezc02ScufeU=;
        b=v7BCs06cGTOJdbWoUjsQqSpkN+hdn9n9n2j7LcOqIDqKrrxKc+vUUpjh51NRlvztaiRGHB
        Fx/quyjcLEib0U783Oj67z17b+BqjgwDRGFfrN/M95rP+nWY5t77vtC2Vud4HoAbOL8hZv
        c96zfsGo3Ra01VElNgcdpXusI0hbcpiJxF0dUn/H2DBZ3C9CbWKWL+6AuGNHanfsI0rODm
        lK53XEzodIDiD8b1fSAk5iMQfxlyYErdVzJwiq7MNNxbL9kAj2IFAKcmIB32mVu82I0CcE
        c9wehA3pSnZnefCVl/Dp4OOSeoD0AyB8M8YTkC9eqV/YS8gbBSU4G+px7f2nag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/hcSLxRzI9WUoD9EAQsZjkCbl3dFDyyezc02ScufeU=;
        b=LOM8sb0l3heTrhuGeIc6VAUjHYR8vRNYN4pvqSD9Zntc3i1tEbLSOHX+zzibD0Rmg4UFwy
        1BEi7JXtXNAab+CA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Null terminate buffer when updating
 tunable_scaling
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210927114635.GH3959@techsingularity.net>
References: <20210927114635.GH3959@techsingularity.net>
MIME-Version: 1.0
Message-ID: <163309024087.25758.3346697651927545623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     703066188f63d66cc6b9d678e5b5ef1213c5938e
Gitweb:        https://git.kernel.org/tip/703066188f63d66cc6b9d678e5b5ef1213c5938e
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 27 Sep 2021 12:46:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:57 +02:00

sched/fair: Null terminate buffer when updating tunable_scaling

This patch null-terminates the temporary buffer in sched_scaling_write()
so kstrtouint() does not return failure and checks the value is valid.

Before:
  $ cat /sys/kernel/debug/sched/tunable_scaling
  1
  $ echo 0 > /sys/kernel/debug/sched/tunable_scaling
  -bash: echo: write error: Invalid argument
  $ cat /sys/kernel/debug/sched/tunable_scaling
  1

After:
  $ cat /sys/kernel/debug/sched/tunable_scaling
  1
  $ echo 0 > /sys/kernel/debug/sched/tunable_scaling
  $ cat /sys/kernel/debug/sched/tunable_scaling
  0
  $ echo 3 > /sys/kernel/debug/sched/tunable_scaling
  -bash: echo: write error: Invalid argument

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210927114635.GH3959@techsingularity.net
---
 kernel/sched/debug.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4971622..17a653b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -173,16 +173,22 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
 {
 	char buf[16];
+	unsigned int scaling;
 
 	if (cnt > 15)
 		cnt = 15;
 
 	if (copy_from_user(&buf, ubuf, cnt))
 		return -EFAULT;
+	buf[cnt] = '\0';
 
-	if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
+	if (kstrtouint(buf, 10, &scaling))
 		return -EINVAL;
 
+	if (scaling >= SCHED_TUNABLESCALING_END)
+		return -EINVAL;
+
+	sysctl_sched_tunable_scaling = scaling;
 	if (sched_update_scaling())
 		return -EINVAL;
 
