Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5528E27E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJNOvV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 10:51:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgJNOvV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 10:51:21 -0400
Date:   Wed, 14 Oct 2020 14:51:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602687078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJueDQP+10Qkf1xAvIeG0VodEvFc4SmsIuyoYx387E4=;
        b=ClZCULtIDI506eohnvNCASz9ZcekmrAYND/1yYkQS2qRq12NLS+PPhQGQSlqe4qSjChlhO
        COTmOY+PxAg/WPJdox66o52PQ4JqQP/3iCWyvmQEn3DP0v5EAergaO8k1DIGtbrxFP6vnZ
        +U1fTlAsz0EOp6WBQkG9e20enNQnXBoE90837Fc5s2KjK7hoG1AsproDXsm0W/tm8rSL6R
        sngeYu9yR/8JrqyuxBuOgUBxbSMBQu5WtF0IRNjSHG0N3xvplqoHMdCWdro+XymS47dThj
        /ywPz9StJDub4wp0dxjHF+2zBKccbUKR4Eez/lnyK5/LSuVGNQKijHmzGmAtxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602687078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJueDQP+10Qkf1xAvIeG0VodEvFc4SmsIuyoYx387E4=;
        b=4ancqJ7kv2d2nS2ocAiBV6gJ8W+I5K7lK1Vq6I/A6nHs1M27JprhkcJKXH/69DQn6tVtWt
        V3JIhutmRRUf4gBA==
From:   "tip-bot2 for zhuguangqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Replace zero-length array with flexible-array
Cc:     zhuguangqing <zhuguangqing@xiaomi.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014140220.11384-1-zhuguangqing83@gmail.com>
References: <20201014140220.11384-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Message-ID: <160268707762.7002.14992849323463105279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a3f1d195119ffe62c2c558c6f0dced070c2cf004
Gitweb:        https://git.kernel.org/tip/a3f1d195119ffe62c2c558c6f0dced070c2cf004
Author:        zhuguangqing <zhuguangqing@xiaomi.com>
AuthorDate:    Wed, 14 Oct 2020 22:02:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 16:48:48 +02:00

sched: Replace zero-length array with flexible-array

In the following commit:

  04f5c362ec6d: ("sched/fair: Replace zero-length array with flexible-array")

a zero-length array cpumask[0] has been replaced with cpumask[].
But there is still a cpumask[0] in 'struct sched_group_capacity'
which was missed.

The point of using [] instead of [0] is that with [] the compiler will
generate a build warning if it isn't the last member of a struct.

[ mingo: Rewrote the changelog. ]

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20201014140220.11384-1-zhuguangqing83@gmail.com
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8d1ca65..df80bfc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1471,7 +1471,7 @@ struct sched_group_capacity {
 	int			id;
 #endif
 
-	unsigned long		cpumask[0];		/* Balance mask */
+	unsigned long		cpumask[];		/* Balance mask */
 };
 
 struct sched_group {
