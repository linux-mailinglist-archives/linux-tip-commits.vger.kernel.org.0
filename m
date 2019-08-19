Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA25920CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Aug 2019 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHSJzW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Aug 2019 05:55:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSJzV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Aug 2019 05:55:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7J9t5mp4087236
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 02:55:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7J9t5mp4087236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566208506;
        bh=jDUEcHl/SB4R5gGTZ6xt6tZtK32ud0sFvT52HciYr4c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lLatb51zPKBpAPjyh1yXHz4paUfQPYgi6mmSlqaNIl6xOB08pPhViNBG+zThbvFd1
         bVPODrt2j2RSR/Y79NDQ1ULWoUJfU1NrO99bbe6wIzj+ejClUrGox5zO0fR5/3GQa3
         sJMh9z982sfU/j+UqyV1NHabEhemqjXc3e3O98vwvUzEWF4TITAc67tlPxQmzoEjBC
         tlQqcOX5GR308OXfxzJEflYECj1JdYpFeWWbzFx8Rfsr88Ev7Uv9XU/NJAuywY+ANy
         BXwckmgNXgaZ1g31Eb+jqakr9G1QRG9Gk1Qq1/6WJdoIQuvofT4citCKhlOHm7VyAG
         9W1Mln+noFo7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7J9t5pb4087233;
        Mon, 19 Aug 2019 02:55:05 -0700
Date:   Mon, 19 Aug 2019 02:55:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Su Yanjun <tipbot@zytor.com>
Message-ID: <tip-77d760328ee015cf89460c52bfd5a6b0a09b7472@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, suyj.fnst@cn.fujitsu.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: suyj.fnst@cn.fujitsu.com, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <1565945001-4413-1-git-send-email-suyj.fnst@cn.fujitsu.com>
References: <1565945001-4413-1-git-send-email-suyj.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86: Fix typo in comment
Git-Commit-ID: 77d760328ee015cf89460c52bfd5a6b0a09b7472
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  77d760328ee015cf89460c52bfd5a6b0a09b7472
Gitweb:     https://git.kernel.org/tip/77d760328ee015cf89460c52bfd5a6b0a09b7472
Author:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
AuthorDate: Fri, 16 Aug 2019 16:43:21 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 19 Aug 2019 11:50:24 +0200

perf/x86: Fix typo in comment

No functional change.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1565945001-4413-1-git-send-email-suyj.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81b005e4c7d9..325959d19d9a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1236,7 +1236,7 @@ void x86_pmu_enable_event(struct perf_event *event)
  * Add a single event to the PMU.
  *
  * The event is added to the group of enabled events
- * but only if it can be scehduled with existing events.
+ * but only if it can be scheduled with existing events.
  */
 static int x86_pmu_add(struct perf_event *event, int flags)
 {
