Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C280E45A0CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 12:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhKWLFI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 06:05:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhKWLFH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 06:05:07 -0500
Date:   Tue, 23 Nov 2021 11:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637665317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FG3ETERgCBzhsutvLg6J4Yv+Z5Slq68+gPgin1tcCEs=;
        b=TOtc7XGceyNSPLapXD9UIafYoZl5rX6aK7IOQfBLqsp4zsqNvJ9B63dn3R5GEnbIF8StPj
        Whkao0O0i+iB/nKax7/UslkUNNWZtuxvWy9qxf+vWL7jT9XsFVRa2qrcRlvBoSHY0obVRw
        MKGe+sxIjmoazWGg6hnNSI+YELbn9NZPOi3qgJ8KWKgAn8xFCdvEAlWFnSq/YTO+DCcZ7S
        r+hOEayJvEd/dwB58pCvZZhjFklYodvucyMAf/bi1AdD5D5SchhOVv8DBlDbHOz1GiBca9
        kogb13hRVIuMDYsDLRC+SN36fPxafc5EZITG8sWF5QNtAZ6sx8XvzuxflmSuBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637665317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FG3ETERgCBzhsutvLg6J4Yv+Z5Slq68+gPgin1tcCEs=;
        b=59YC4PJPDaRDm6/+Z2szCNi7mOLdxZTAVECjo3njcCWBzMjuLogo4jrIWAj7pmnuwCvDDk
        dDx91Gz9bMg5GjDg==
From:   "tip-bot2 for Andrey Ryabinin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuacct: Convert BUG_ON() to WARN_ON_ONCE()
Cc:     Andrey Ryabinin <arbn@yandex-team.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115164607.23784-2-arbn@yandex-team.com>
References: <20211115164607.23784-2-arbn@yandex-team.com>
MIME-Version: 1.0
Message-ID: <163766531684.11128.7984508732175783489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c7ccbf4b6174e32c130892570db06d0f496cfef0
Gitweb:        https://git.kernel.org/tip/c7ccbf4b6174e32c130892570db06d0f496cfef0
Author:        Andrey Ryabinin <arbn@yandex-team.com>
AuthorDate:    Mon, 15 Nov 2021 19:46:05 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:55:22 +01:00

cpuacct: Convert BUG_ON() to WARN_ON_ONCE()

Replace fatal BUG_ON() with more safe WARN_ON_ONCE() in cpuacct_cpuusage_read().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20211115164607.23784-2-arbn@yandex-team.com
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 893eece..f347cf9 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -106,7 +106,8 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	 * We allow index == CPUACCT_STAT_NSTATS here to read
 	 * the sum of usages.
 	 */
-	BUG_ON(index > CPUACCT_STAT_NSTATS);
+	if (WARN_ON_ONCE(index > CPUACCT_STAT_NSTATS))
+		return 0;
 
 #ifndef CONFIG_64BIT
 	/*
