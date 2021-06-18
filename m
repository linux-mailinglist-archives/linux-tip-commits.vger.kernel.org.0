Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E083AC9C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhFRL0O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFRL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:13 -0400
Date:   Fri, 18 Jun 2021 11:24:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N06Q9lhWEMFmnl08UGhGh0i6zyshyigL958IvrkZQx0=;
        b=HubkvomUKcNW76/fD4Upemk/quDnb3J10ZZcvr3D3x/2v9mfpouKMp4lMpsWPRXIDIJemC
        EYg+uGBJkNmSfi1jHEsHo1ScdRIhABE6T0MefGBpx63JbWE9XuKeCRsOIgQXBIv3vWlXXB
        UVzCddU5laD+zXSfLbaqE6IkwyN51GuLoM2wqppoinz8A/9Rdk2hm2dLdI1jeA5sdqcZHS
        hAxGKMZCPXg5sLGkhGPFwYnUkZ+RSxSHro4eOeeLJbxj2IxnjqIZJXdt+v96GFpamj+dBL
        3p4IqmEeXtHimKfkGjTHPvPREpAHHdNK4fUH4cWCm683/ywBDH9520fYJ9sX3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N06Q9lhWEMFmnl08UGhGh0i6zyshyigL958IvrkZQx0=;
        b=5Xhzd3QiJ7NdB0qxcqmGGT71G9bBZnPJpJ8v/WF8GV7tvvucff/m3xYSPsQ9W9+Gouv6mJ
        B7lEq1Il06s3K2DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,timer: Use __set_current_state()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.409696194@infradead.org>
References: <20210611082838.409696194@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544278.19906.13862118615539886875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     600642ae9050a872055119ba09d0decc43f6c843
Gitweb:        https://git.kernel.org/tip/600642ae9050a872055119ba09d0decc43f6c843
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:08 +02:00

sched,timer: Use __set_current_state()

There's an existing helper for setting TASK_RUNNING; must've gotten
lost last time we did this cleanup.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210611082838.409696194@infradead.org
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf..467087d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1879,7 +1879,7 @@ signed long __sched schedule_timeout(signed long timeout)
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
 			dump_stack();
-			current->state = TASK_RUNNING;
+			__set_current_state(TASK_RUNNING);
 			goto out;
 		}
 	}
