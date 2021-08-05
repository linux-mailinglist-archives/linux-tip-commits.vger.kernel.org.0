Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5BA3E1161
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhHEJey (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbhHEJev (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:51 -0400
Date:   Thu, 05 Aug 2021 09:34:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AUopnDqr/PD/iAu9lmgj937YVmkwHQacFFOGHmAdPU=;
        b=q31CjDT8IQWEBRx8am7akVPWfwfZHm/oDGjG3BJ1ZevZp0z+VBIOLQYieC/lBxwGemjNCL
        z8ezEkYAROaQWVgBnqlAISEjz1LJq5CpXxjVCKBYTURwOYZDF0nWGOEyGe8RUWR7plvcmh
        aW3cwPm1T27+SYcUM+Z1O7D8rI1drE3iH7Nco1ycCsHmBTBhlZliBJXuXKP4PPza+Poxgl
        sVUKrpOYec4e067JM0vQnJweB63Oi6IlOAq6ONXcUlJW82bvhOQYrdTDMR7EmiM4xMo7xp
        lHZRMTJMGjExa9hO9H6Wuvn+iy7meaLaw4ajqSTX/ApjeX7RUeCN06s9oJgBmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AUopnDqr/PD/iAu9lmgj937YVmkwHQacFFOGHmAdPU=;
        b=7x81VlcN2aF6PPrLLtyxtKBSJcDrtIHnyw9lPSOIdjllJQfEzYeYMPuAhNWX+fZuou5hzJ
        9o0OFKtoU1PTz+CA==
From:   "tip-bot2 for Wang Hui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: remove redundant on_rq status change
Cc:     Wang Hui <john.wanghui@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210721091109.1406043-1-john.wanghui@huawei.com>
References: <20210721091109.1406043-1-john.wanghui@huawei.com>
MIME-Version: 1.0
Message-ID: <162815607635.395.12214105489940284165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f912d051619d11411867f642d2004928eb0b41b1
Gitweb:        https://git.kernel.org/tip/f912d051619d11411867f642d2004928eb0b41b1
Author:        Wang Hui <john.wanghui@huawei.com>
AuthorDate:    Wed, 21 Jul 2021 17:11:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:43 +02:00

sched: remove redundant on_rq status change

activate_task/deactivate_task will change on_rq status,
no need to do it again.

Signed-off-by: Wang Hui <john.wanghui@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210721091109.1406043-1-john.wanghui@huawei.com
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd0..6c562ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5659,11 +5659,9 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
-		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
-		p->on_rq = TASK_ON_RQ_QUEUED;
 
 		resched_curr(dst);
 
