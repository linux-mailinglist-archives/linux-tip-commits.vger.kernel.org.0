Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03642EE03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhJOJr0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbhJOJrR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7016C06176C;
        Fri, 15 Oct 2021 02:45:05 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:45:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eWTfEm6pOYWWks4mqBjS+LRov6DGfx63gzGW+rAQKI=;
        b=AZu1h2yrJuEIEbQCK8YRsUG6eJ5szAF/uiJj6bKuTszIrbAtb88G8+m5UoSJ4LpuSSne7p
        TtLW6OhIj5ckZozZBcp/yJbY7FkotdYV2W3/fl+gP96YRtJt8HQ5aALOeeVyHuQ1hkJgpL
        Shn2/LVzD3IpDBZYUAuzYCbLLG8YNm+1kkoETMnYA+y0z7ryZbTj8S7j6MYrr0d9ljGMTi
        eesKuEnx3x9Jq3dpuyibeWOxTY3sVUsSXmjahWMfT/8iUHksvfw4EnTsfmt7Xi+j4RXoP5
        CaHSkc8MXdoqYYvFGqrOwx2l8kMP/ICbCnDFPpKUO+P+ssYNSKzNUO5vd/FmlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eWTfEm6pOYWWks4mqBjS+LRov6DGfx63gzGW+rAQKI=;
        b=7bABRwj4535f+foBSWhe9btYSk25fkO9d6MY1FYf4kxi0wRbFYdcstm3UAN1p2Ui17x7y0
        PF4Nry+tKRoFRqDw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] proc: Use task_is_running() for wchan in /proc/$pid/stat
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211008111626.211281780@infradead.org>
References: <20211008111626.211281780@infradead.org>
MIME-Version: 1.0
Message-ID: <163429110349.25758.11671964116161224606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4e046156792c26bef8a4e30be711777fc8578257
Gitweb:        https://git.kernel.org/tip/4e046156792c26bef8a4e30be711777fc8578257
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 29 Sep 2021 15:02:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:13 +02:00

proc: Use task_is_running() for wchan in /proc/$pid/stat

The implementations of get_wchan() can be expensive. The only information
imparted here is whether or not a process is currently blocked in the
scheduler (and even this doesn't need to be exact). Avoid doing the
heavy lifting of stack walking and just report that information by using
task_is_running().

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008111626.211281780@infradead.org
---
 fs/proc/array.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8..77cf418 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -541,7 +541,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	}
 
 	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
+		wchan = !task_is_running(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -606,10 +606,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
