Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64101437A35
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhJVPoV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhJVPoV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 11:44:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B17C061764;
        Fri, 22 Oct 2021 08:42:03 -0700 (PDT)
Date:   Fri, 22 Oct 2021 15:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634917320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6v+eI27ai0ENftfCr+6DCRj3eKVY4o8rF9LTxcX3Rw=;
        b=uvtlwUFqPLcOac+IxCTG/Gjj6SMl1ijoSHHKx+6uCl8zjSt5wW5okH5HVVEkPCuXr/VGBW
        JTuEMV3P8ibX1FlSIRA1wX/fwaWfb/etlVGIqQL4c6N4LZSYG/tnJhYHECrOrspfIac47u
        ljXteyx8zY9Duez8vc2xxTQvVE5C86xbUJFLRkZfEA6xzc4mV0kdctsUCY0TX/iKNVdd6N
        lHucBUmw6h0YrZGV61C62kUdTEcfc09m/7/bejfH/aADKonRNqAwJrtttQYgZorKjoyX2i
        w9s1gb581eRTM0L7+qyUc2yiPJIgwSbOaN1FLdi38tOHJWQmQqfWsgQOheqjEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634917321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6v+eI27ai0ENftfCr+6DCRj3eKVY4o8rF9LTxcX3Rw=;
        b=2pF1iCXI8JsNYTC5mrIq7mxIsiz6Lbp7Twc5uMt+TKxxa2nC6wtRa6+LrytvtRrUFfzp6F
        /aNhPMma197Fb1Aw==
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove rq_relock()
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C449948fdf9be4764b3929c52572917dd25eef758=2E16346?=
 =?utf-8?q?11953=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3C449948fdf9be4764b3929c52572917dd25eef758=2E163461?=
 =?utf-8?q?1953=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163491731964.626.5567261652275466917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eaed27d0d01a89a510736d87f10cea02042b4756
Gitweb:        https://git.kernel.org/tip/eaed27d0d01a89a510736d87f10cea02042b4756
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Tue, 19 Oct 2021 10:58:39 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Oct 2021 15:32:46 +02:00

sched/core: Remove rq_relock()

After the removal of migrate_tasks(), there is no user of
rq_relock() left, so remove it.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/449948fdf9be4764b3929c52572917dd25eef758.1634611953.git.rocking@linux.alibaba.com
---
 kernel/sched/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a00fc70..f0b249e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1616,14 +1616,6 @@ rq_lock(struct rq *rq, struct rq_flags *rf)
 }
 
 static inline void
-rq_relock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_rq_lock(rq);
-	rq_repin_lock(rq, rf);
-}
-
-static inline void
 rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
