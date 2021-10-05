Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA78422A65
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhJEOOJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhJEON6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB7C061749;
        Tue,  5 Oct 2021 07:12:07 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/ddAYHU5SAlvf+h1v5SfBA4lLMMmyacvaU9NR8O8IE=;
        b=tusA1uj59nyn4/9dtcZR6lJ96fN2pdAKPY3rdnGOaXeKJm61nHd8ZGyQ7h8dkRB9YzLz+t
        hFdPcurfFDglMAGglLvYloQazf5vuWOhpJm+uz6WGH8C4Puy02wdi37kPnd1ABOL3HOpqQ
        8w1kthgaWOkgjxeww76BwL3x3VkCW6KqoPc7GOlRywiYkvPzA4fJn5gt6HS6a7VFdu0J3u
        Nhmpajjon/cHn2hdx+QcrKJxP1K3rVn/yA9sEOnQK+ieJEXCC8lil1Cbg3fTwf8I16W9ZX
        dAg0pgZKpDj+7K0wSQA9z+CGxNlzR/Jw6hCQkt6jMeRcwP3qwwQj2uWnlUAi6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/ddAYHU5SAlvf+h1v5SfBA4lLMMmyacvaU9NR8O8IE=;
        b=g48juJ51UH8GZzgeiIHuxX9G7S9NPfT7GGHjqqxZ13U8CDLOlZ/5e8/xnVZkkJHcf2o/3z
        GmK+g14ryvTA3fDw==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unused inline function __rq_clock_broken()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210914095244.52780-1-yuehaibing@huawei.com>
References: <20210914095244.52780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <163344312520.25758.13885264891205156672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     32ed980c3020b7a19e26dc488c10817807ba2a41
Gitweb:        https://git.kernel.org/tip/32ed980c3020b7a19e26dc488c10817807ba2a41
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 14 Sep 2021 17:52:44 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:55 +02:00

sched: Remove unused inline function __rq_clock_broken()

These is no caller in tree since commit
523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210914095244.52780-1-yuehaibing@huawei.com
---
 kernel/sched/sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8712fc4..198058b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1426,11 +1426,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 
 extern void update_rq_clock(struct rq *rq);
 
-static inline u64 __rq_clock_broken(struct rq *rq)
-{
-	return READ_ONCE(rq->clock);
-}
-
 /*
  * rq::clock_update_flags bits
  *
