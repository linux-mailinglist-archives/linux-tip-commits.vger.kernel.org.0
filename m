Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB752D72F2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437434AbgLKJf3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405657AbgLKJfU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E1C0613D3;
        Fri, 11 Dec 2020 01:34:40 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqG/RiyorwCXnP6CASf5E2OkGRGE96QcN3juhk/aOEY=;
        b=r3Cwqg9SjWu8Yy7QgQZILCNntTV1oyqjLBieO2tAapSj3MpQs8GbTf9wiRo1gp40lJq+DS
        TiVbihG94NBYowU8iid8ZwG/tSj5Ulpc+IZCd9emuu/aprjFx0HPmM17XQ3VPYhUNgWCCJ
        6vhgsF1FBODJ8Gqxgw+E7O6+Cyllsle0hwXfeMkKz19Ztav978vMoJdwGb3uuBC+9Fmc83
        0ymRSzR/A1xC9X/OCq29tImDZcDHF48DsGAN8LRdgD72nrDJUAxapikZzy+Dl907+daVvT
        p2L7jA+uLlIq01AycFbHVPHquitKy0d5/IuL0XVqFoMF4cpjcPHs2oGXxu7zZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqG/RiyorwCXnP6CASf5E2OkGRGE96QcN3juhk/aOEY=;
        b=JFV3XEWs3E1PQ+fRJSzu0h/M1hhAx8tocfLiyXGExrgeh6nS4y7kjcZq2D7KyNGQmIE1ZH
        wvAkYOoWQZ1SHCDA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clear SMT siblings after determining
 the core is not idle
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130144020.GS3371@techsingularity.net>
References: <20201130144020.GS3371@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160767927797.3364.8571066133105790079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     13d5a5e9f9b8515da3c04305ae1bb03ab91be7a7
Gitweb:        https://git.kernel.org/tip/13d5a5e9f9b8515da3c04305ae1bb03ab91be7a7
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 30 Nov 2020 14:40:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Dec 2020 10:30:38 +01:00

sched/fair: Clear SMT siblings after determining the core is not idle

The clearing of SMT siblings from the SIS mask before checking for an idle
core is a small but unnecessary cost. Defer the clearing of the siblings
until the scan moves to the next potential target. The cost of this was
not measured as it is borderline noise but it should be self-evident.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201130144020.GS3371@techsingularity.net
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5dceda..efac224 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6086,10 +6086,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
 	/*
