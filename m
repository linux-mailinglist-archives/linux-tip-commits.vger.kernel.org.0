Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C237B904
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELJYc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELJYc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82D0C061574;
        Wed, 12 May 2021 02:23:22 -0700 (PDT)
Date:   Wed, 12 May 2021 09:23:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQsNHpB1pKh6oyleRzxkH90AapZQevgK/yIKUZxb/5g=;
        b=3JkTgsGqVdOX9IGV8O+bxexK7aD+P/Tx/n8kOgAofiyClZlVSIugAPOSNwrG0NyND9Pngu
        lL2ducWCQL7lpTxiqwZinVqUL2B1nYF+0pcMD7QZImIvmPvrect278tcFRCxGiPC78b0Sv
        XPD+X8CprLk/CXbJllvSExLj2kz642kIUXkArYwDGol5z0ke61Mi1oKiB+Gqujmz7/Kdkp
        eBVDsgqXAajzKNyGuY1Q6/x7+Ja2xosJK5/JDFt436KL8Ha5MbZHgRFiJ8hFya2LTzLKcG
        rbGNgmhnw8+5m8VmwMmmjdMG27ez7ReMbagiX6BDrPeTGy1hpDgoWSL8JyCChw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQsNHpB1pKh6oyleRzxkH90AapZQevgK/yIKUZxb/5g=;
        b=yzpqnB/JfOZmydg4ufsp3oJ4HjAutTtt2R/zzqW0ndptik8SfuAcE1bo0Aoe4F1BEQaxM4
        yNxF+xCxzLLXj2DA==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove the pointless BUG_ON(!task) from
 wake_up_q()
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210510161522.GA32644@redhat.com>
References: <20210510161522.GA32644@redhat.com>
MIME-Version: 1.0
Message-ID: <162081140064.29796.9820212664923113539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2b8ca1a907d5fffc85fb648bbace28ddf3420825
Gitweb:        https://git.kernel.org/tip/2b8ca1a907d5fffc85fb648bbace28ddf3420825
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Mon, 10 May 2021 18:15:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 11:03:54 +02:00

sched/core: Remove the pointless BUG_ON(!task) from wake_up_q()

container_of() can never return NULL - so don't check for it pointlessly.

[ mingo: Twiddled the changelog. ]

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510161522.GA32644@redhat.com
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc2..61d1d85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -585,7 +585,6 @@ void wake_up_q(struct wake_q_head *head)
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-		BUG_ON(!task);
 		/* Task can safely be re-inserted now: */
 		node = node->next;
 		task->wake_q.next = NULL;
