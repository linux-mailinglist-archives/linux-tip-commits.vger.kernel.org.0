Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E33E1157
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhHEJep (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhHEJeo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE643C061765;
        Thu,  5 Aug 2021 02:34:30 -0700 (PDT)
Date:   Thu, 05 Aug 2021 09:34:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XbCgTl5w8QLCcz16XQmvLycNsbxxrobmRVN4aHmUjA=;
        b=N0Iq6/elG3pSK1lyelG96HNlvpG0/wbL4FKWzRgXNq26OBTNGdXgHjSDnmmD7Ebi69daN4
        5dXDi2Q1Yl5Gk3EAoG+HArvp666gUZ9la7Lo1JVLtkDpP6RgfEcYHu/DtRGWJsNmiY9Xk7
        LrqgamN7NLdFf3kSJj3t7jNOuOM3PcqGUEPllOSSSLsPgkM707H0MQuhK7sVzJAWr7pfG2
        g9iNL6WicU/nssF6EDfWyL/XBqgnTC5wSGt4Y0QuJgwCxnnDfOJfxlN1GgwnMvmO91r8mu
        drPL7gPOnUzJbXfpYPU/4C7x1uZYThmddHfK2wzClgwAIKB3lrfyB3JyF79cSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XbCgTl5w8QLCcz16XQmvLycNsbxxrobmRVN4aHmUjA=;
        b=bIv9O4jfmRqyb2JvFIMTR036icwNWxs4MjAGxltEvskj22YKX9nS/ar/c1Ksm4laDzls4j
        xmdkceQKutE76lDw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: remove unused assignment to pointer e
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210804115710.109608-1-colin.king@canonical.com>
References: <20210804115710.109608-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162815606779.395.10577182627193770345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     79551ec0782895af27d6aa9b3abb6d547b7260d3
Gitweb:        https://git.kernel.org/tip/79551ec0782895af27d6aa9b3abb6d547b7260d3
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 04 Aug 2021 12:57:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:39 +02:00

perf/x86: remove unused assignment to pointer e

The pointer e is being assigned a value that is never read, the assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210804115710.109608-1-colin.king@canonical.com
---
 arch/x86/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c0167d5..f4e5fa7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1085,10 +1085,8 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 * validate an event group (assign == NULL)
 	 */
 	if (!unsched && assign) {
-		for (i = 0; i < n; i++) {
-			e = cpuc->event_list[i];
+		for (i = 0; i < n; i++)
 			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
-		}
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
