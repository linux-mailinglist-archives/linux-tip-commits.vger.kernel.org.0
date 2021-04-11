Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17C735B4EC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhDKNoZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bsOwYiV646Fao1c+2WGQZY6xwN2A5IKy7VkLpIBWvvI=;
        b=J9etGcDblLZjsGPcDq6DSIZQccK0gtIr77aJo0GS5YdzW3c6vWQVDinI3ISXqpKsdnuxV9
        Xo4ZzWC/puhy9Ibti4RBv7T5LFdGsEVnjYgsjebE5MiI0vawKl2CYrlnhLQouSG3+1SMIV
        hOYWeH2AeNa1kzkLo/TIrYhJ0A4JGT8rPQS6vAmpBiaJo+40O6WPaPe1D/eCaWujSEXBGF
        uZYKADnxVZabsfNKmrLwJI+7Rh8efKXtb2LFXpnFH1LYUuS+f+hyv1d06kFe912Km1IIYF
        /UTN/o3QZr5HNPSjbGD/NZV+jv67L+UiciqnMUU93H9xWg7xzLjufDqa2jnxgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bsOwYiV646Fao1c+2WGQZY6xwN2A5IKy7VkLpIBWvvI=;
        b=12OElGvQo0jttuhSOJFoCV0KzZiHfYwbW5c2lXlCazJQnTI4y4xRC8eMS8JISDwWVXBfHF
        9og1HYrUWxCA4/DA==
From:   "tip-bot2 for Stephen Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Replace rcu_torture_stall string with %s
Cc:     Stephen Zhang <stephenzhangzsd@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861291.29796.7062188151210309046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0a27fff30a5e561dc77e9cb1bf9cf462e1735179
Gitweb:        https://git.kernel.org/tip/0a27fff30a5e561dc77e9cb1bf9cf462e1735179
Author:        Stephen Zhang <stephenzhangzsd@gmail.com>
AuthorDate:    Sat, 23 Jan 2021 17:54:17 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:22:28 -08:00

rcutorture: Replace rcu_torture_stall string with %s

This commit replaces a hard-coded "rcu_torture_stall" string in a
pr_alert() format with "%s" and __func__.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..271726e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1971,8 +1971,8 @@ static int rcu_torture_stall(void *args)
 			local_irq_disable();
 		else if (!stall_cpu_block)
 			preempt_disable();
-		pr_alert("rcu_torture_stall start on CPU %d.\n",
-			 raw_smp_processor_id());
+		pr_alert("%s start on CPU %d.\n",
+			  __func__, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
 			if (stall_cpu_block)
@@ -1983,7 +1983,7 @@ static int rcu_torture_stall(void *args)
 			preempt_enable();
 		cur_ops->readunlock(idx);
 	}
-	pr_alert("rcu_torture_stall end.\n");
+	pr_alert("%s end.\n", __func__);
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
