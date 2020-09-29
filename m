Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7027BE94
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgI2H5T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgI2H4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D0C061755;
        Tue, 29 Sep 2020 00:56:54 -0700 (PDT)
Date:   Tue, 29 Sep 2020 07:56:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzSk0mih3ZnhDaBPWS7n7R6JzM1rIKi0erUcYb+Vuuw=;
        b=HgJ/+1PzggrTwnThrcdbbdZIP5S3OaEwORv27AAosbR0Emzy/uOJE9DPARSgRiWJkJi0u7
        DosAaiwG2VhQue1N+i0qJzSb/+4BX327Llh6lgC9AFzDqd4RLDhFfvR00sCCs5R7wEtEuN
        lmEVwKk9soEjFbtTiv17pHuFcx3OvmJLNd5D5wR10JPv1EmbwY+t1Q6Nrfd+0WMiR2rgvF
        ctvJlnr8sa0drI0ggZe4MeCsXTIJvFN+R76zN1EIxWzV0BMqbjVQoSrElz2o0SHnAeEm1W
        h3LOi6xmyYvTMnobr/yh3QJ6jatWXObzk9jZw1KhwWBLxv1kgqdXgPT0u7v3Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzSk0mih3ZnhDaBPWS7n7R6JzM1rIKi0erUcYb+Vuuw=;
        b=sPYC9AtYVJOkI/0f8lmCoUPB1/klbMYk/daoidjQG/xHiNcB4lK411phOy3mYWrgKwrISj
        AwrG+JQTj6ELZuCQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unused inline function
 uclamp_bucket_base_value()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200922132410.48440-1-yuehaibing@huawei.com>
References: <20200922132410.48440-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160136621160.7002.405479490400563598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     51bd5121c4eb25b911f6bc1ab4de5fe865fe0dcb
Gitweb:        https://git.kernel.org/tip/51bd5121c4eb25b911f6bc1ab4de5fe865fe0dcb
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 22 Sep 2020 21:24:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:25 +02:00

sched: Remove unused inline function uclamp_bucket_base_value()

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20200922132410.48440-1-yuehaibing@huawei.com
---
 kernel/sched/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c36dc1a..dd32d85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -940,11 +940,6 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 	return clamp_value / UCLAMP_BUCKET_DELTA;
 }
 
-static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
-{
-	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
-}
-
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
