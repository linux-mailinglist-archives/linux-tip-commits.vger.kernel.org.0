Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2863EF3AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhHQURR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhHQUPy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A2C061140;
        Tue, 17 Aug 2021 13:14:35 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSin4TQhjJRpT5ySI1MsfAhOhbYKOQo6LjNuPorAZOA=;
        b=cqmq1zPyYpbPt5LGBMc2MS4BN7LWDsXEOLyj+gDqdVHYiWgm+xLZuXdz3tCjjRrM/HskbU
        rI4Yo0bHB82mxL5yMebeQv+/YEtIHQg+Q3LTDJY/uspC4Q5+okrEDPCfY0kotgnXdQje8X
        wIn3cUW3vh+kqKShxbx5XVH8cmtykrH6eBvOF6PmrWiYB9Q06BFfBfLMudL1rugf24QCl1
        Xb9DIfjjeHUHKzSja6ys24KMkJh+AEsLI/WWO7jqN4fKfNvHuky5zqjafe65c2M75AFeJ7
        ta666T+sDvbM8WVjjM/uusOemW3hYnZ6NxfN40Wyl/gfFrMBZfday8mrVfehBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSin4TQhjJRpT5ySI1MsfAhOhbYKOQo6LjNuPorAZOA=;
        b=uEMpGHo1u0WVrEljh5AcHtyjv92aORWFl8Gg1Qut07EYntRFrkaQWp9c2WLrukgq/nDN+z
        PgMxcfjmMZE50FAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.429918071@linutronix.de>
References: <20210815211302.429918071@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127341.25758.11465218501365954785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2c8bb85151d4bad825f8962792e9f53d22db81db
Gitweb:        https://git.kernel.org/tip/2c8bb85151d4bad825f8962792e9f53d22db81db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:57:55 +02:00

sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER()

The RT specific spin/rwlock implementation requires special handling of the
to be woken waiters. Provide a WAKE_Q_HEAD_INITIALIZER(), which can be used by
the rtmutex code to implement an RT aware wake_q derivative.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.429918071@linutronix.de
---
 include/linux/sched/wake_q.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 26a2013..06cd8fb 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -42,8 +42,11 @@ struct wake_q_head {
 
 #define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
 
-#define DEFINE_WAKE_Q(name)				\
-	struct wake_q_head name = { WAKE_Q_TAIL, &name.first }
+#define WAKE_Q_HEAD_INITIALIZER(name)				\
+	{ WAKE_Q_TAIL, &name.first }
+
+#define DEFINE_WAKE_Q(name)					\
+	struct wake_q_head name = WAKE_Q_HEAD_INITIALIZER(name)
 
 static inline void wake_q_init(struct wake_q_head *head)
 {
