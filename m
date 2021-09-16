Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70340D931
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhIPMAt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbhIPMAs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:48 -0400
Date:   Thu, 16 Sep 2021 11:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIsADEUqwNmNzW5LJZz5jVYVRaL7RS44v/2kCMycPB0=;
        b=0ECp56J2GxOKbKAlN/HHOY9QJWCWXsefS1fKwOyu64AFFkZ7hhCyXMfy5oeXux84f0TqI7
        J6YS+qs+w9N2FVpQdUHkCOeIbI5IirFzwkggl4A9CVBvS2U/KhV0w+SxiDJW1mES6BiIO6
        82/K0TTxeZWqJTqOfVUD2l22H7YEKb+ZXaz5cJESqtACUGqiBugcuhcu+Ey+Lpkw+jM4Ae
        yWBA2V7ioOxCXlnoX+cFS+AK/WLESpVWsVu+OBphkPaH8iGOmd0bjgOxwcpVv2BECjw+hR
        CfqDlus00yHK68ekpAmPIPwZ7UsArOcJR0kCr3jcPT5a0cr16aue/OV/kHMdxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIsADEUqwNmNzW5LJZz5jVYVRaL7RS44v/2kCMycPB0=;
        b=7kGwfbsi+BHRT+PCFNWV+eiTIHVF8GONp0LA8bPJxlvTQ4eNGL79El6X6pSaJbEblGD+LR
        IOM1sw27CVLoEkBw==
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
Message-ID: <163179356588.25758.7661405207431410606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33effaafbaf9c0070eac69a362120f4d1c26b5cf
Gitweb:        https://git.kernel.org/tip/33effaafbaf9c0070eac69a362120f4d1c26b5cf
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 14 Sep 2021 17:52:44 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:01 +02:00

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
index 1d8bc76..eacc15d 100644
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
