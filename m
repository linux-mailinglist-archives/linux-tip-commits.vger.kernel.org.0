Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8E40D929
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhIPMAp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbhIPMAo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0E4C061764;
        Thu, 16 Sep 2021 04:59:22 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:59:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/W3cyHifpwKlK7kYcof3zIww/kpcaq54cqWjNPx6i0=;
        b=2lIF4mbwJIGy6fUVUQ5bgZQMe2WBm+NMCzGMqYtupqyxy5x+YUrCNHURG7vm81mDHYFdTL
        3He7Uh41/6w49mZV5AzzfJ0vfLQNDEQnyMbOWL0+nJCuahKXqkgem4qpFaguksCu6d6zYS
        euNSXotT8xa+zjZ38CqUJSL55KFORIu2+9iRpahDKzp7LhFqojXHwmMIJux69jB4LswX5+
        pBggpWFaaBL0UOVyvRSDAUP7iBkjUzth6ySeyl0AqYeECuKjxA9YaQiH+eoONLr4gunY/O
        TRd5hXG1hceZOONMeUiivNrrjjI8h4XqSHXcWJx83VbgOe2VCTQl0dMqJdk5kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/W3cyHifpwKlK7kYcof3zIww/kpcaq54cqWjNPx6i0=;
        b=YhERpRROh7rSd9jmZpiduJv2YzjMZrJjytuuFj/oXy7a9pwtCiEWOInm6NQeSnSYWwefCC
        ucMBqclg7zJ59pAQ==
From:   "tip-bot2 for Baptiste Lepers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] events: Reuse value read using READ_ONCE instead
 of re-reading it
Cc:     Baptiste Lepers <baptiste.lepers@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210906015310.12802-1-baptiste.lepers@gmail.com>
References: <20210906015310.12802-1-baptiste.lepers@gmail.com>
MIME-Version: 1.0
Message-ID: <163179356028.25758.1740508579736783885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b89a05b21f46150ac10a962aa50109250b56b03b
Gitweb:        https://git.kernel.org/tip/b89a05b21f46150ac10a962aa50109250b56b03b
Author:        Baptiste Lepers <baptiste.lepers@gmail.com>
AuthorDate:    Mon, 06 Sep 2021 11:53:10 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:06 +02:00

events: Reuse value read using READ_ONCE instead of re-reading it

In perf_event_addr_filters_apply, the task associated with
the event (event->ctx->task) is read using READ_ONCE at the beginning
of the function, checked, and then re-read from event->ctx->task,
voiding all guarantees of the checks. Reuse the value that was read by
READ_ONCE to ensure the consistency of the task struct throughout the
function.

Fixes: 375637bc52495 ("perf/core: Introduce address range filtering")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210906015310.12802-1-baptiste.lepers@gmail.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e872..0c000cb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10193,7 +10193,7 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 		return;
 
 	if (ifh->nr_file_filters) {
-		mm = get_task_mm(event->ctx->task);
+		mm = get_task_mm(task);
 		if (!mm)
 			goto restart;
 
