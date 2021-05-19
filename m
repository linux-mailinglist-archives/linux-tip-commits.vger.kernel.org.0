Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2A388919
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhESIK3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbhESIK1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB8C06175F;
        Wed, 19 May 2021 01:09:08 -0700 (PDT)
Date:   Wed, 19 May 2021 08:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s9R9ky02lpZU2YNwYCcWjLjQiK5LDQNbF3EQqUjTKE=;
        b=kx90sFkYEKjM6IbM2cJLnH/3ZEMmHXgJzesG7xMAapbcKu7lHnQBhxWq/qKtbkyc4LbXDh
        iDnw39UbkOWm1Uzm/L0LUTLi/bCui85QCqzAAVF9MD478p5MEmsuJOUX44QjxZpVLqlPdb
        pfhp/wt040VgnJ56YcdndZ2DD/OWj4hY5S2Q96aM+6t32g4aWdt/QmOtBEi/cv13PMXqNb
        BcPf5ZhRKWq8uD6AzUMkk1wIMFvj7GQ+KJEjM0hwku9usZou5h9vgmPXrUDQs5M4+P2doU
        TegKswJFzkrYS2PZcyAbeeKnka5aGcOCyJvzV+4gsL+uS0al+v8y0GkkBnIogQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s9R9ky02lpZU2YNwYCcWjLjQiK5LDQNbF3EQqUjTKE=;
        b=Ei6mA6RdmGNw0IlqxMhTCPBDBJE/fwTNLBOV7xvdtstYGMJnQxenhRF0qrDfdkE9IwIQxm
        zXry6WkF4YSvNTCA==
From:   "tip-bot2 for Yejune Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] lib/smp_processor_id: Use is_percpu_thread()
 instead of nr_cpus_allowed
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Yejune Deng <yejune.deng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510151024.2448573-3-valentin.schneider@arm.com>
References: <20210510151024.2448573-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162141174613.29796.12436906474538112691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0019699518cc026b5bd912425be8e424843d5b33
Gitweb:        https://git.kernel.org/tip/0019699518cc026b5bd912425be8e424843d5b33
Author:        Yejune Deng <yejune.deng@gmail.com>
AuthorDate:    Mon, 10 May 2021 16:10:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:54 +02:00

lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed

is_percpu_thread() more elegantly handles SMP vs UP, and further checks the
presence of PF_NO_SETAFFINITY. This lets us catch cases where
check_preemption_disabled() can race with a concurrent sched_setaffinity().

[Amended changelog]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
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
