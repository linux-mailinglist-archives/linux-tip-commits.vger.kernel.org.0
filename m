Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32E22C0B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGXIdr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgGXIdq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C61C0619D3;
        Fri, 24 Jul 2020 01:33:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PigvJTJ1IXMtfAX4SR4/VMXZsEI5VpZH2UY2zxTsh50=;
        b=GADU9VxDtUnguvca6eRPy43cXL8i8AvbcyBlPRYcZ0vJsDPZg0hnIz10LsjF6ywVrIRgBj
        nWLS5Ty6CIsc1mY513JmOVAxi578oWvC11tg4Qixg7u/FwkI6+V36Hf9uwUjguXcDC5Ail
        Ck42H73Se6MAWj6ZlOqA0nJNbXj3fY+852MKpKZ6QuyZjhcQg6F4zTMIlCkv0hjDoEPWzM
        VoIOGJOPk2sy/h2oZ/hVWlfMt2zijmm7K2xG8axWsyJCbzSl6mIv4wahJxK6FRkLhkKIo3
        Vvw06w+lhELTR3g/5/f/aERRpW1jxGVn48u5PGWcI3tsgIaeBhglMoBbG37J/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PigvJTJ1IXMtfAX4SR4/VMXZsEI5VpZH2UY2zxTsh50=;
        b=AtlPilg8zAVIRW0jJxh1nHhzxR6MtyoqmyLPQZodKhsUzoba5vq22BRgomv8Pza7WJpLNy
        gmW24UXZHUdzzECA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,ion: Convert to sched_set_normal()
Cc:     john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962457.4006.12981963462257250028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     9309de08f14f49a29f6cc8a20653731235692b1f
Gitweb:        https://git.kernel.org/tip/9309de08f14f49a29f6cc8a20653731235692b1f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:23 +02:00

sched,ion: Convert to sched_set_normal()

In an attempt to take away sched_setscheduler() from modules, change
this into sched_set_normal(.nice = 19).

Cc: john.stultz@linaro.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/staging/android/ion/ion_heap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 0755b11..563b84c 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *data)
 
 int ion_heap_init_deferred_free(struct ion_heap *heap)
 {
-	struct sched_param param = { .sched_priority = 0 };
-
 	INIT_LIST_HEAD(&heap->free_list);
 	init_waitqueue_head(&heap->waitqueue);
 	heap->task = kthread_run(ion_heap_deferred_free, heap,
@@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct ion_heap *heap)
 		       __func__);
 		return PTR_ERR_OR_ZERO(heap->task);
 	}
-	sched_setscheduler(heap->task, SCHED_IDLE, &param);
+	sched_set_normal(heap->task, 19);
 
 	return 0;
 }
