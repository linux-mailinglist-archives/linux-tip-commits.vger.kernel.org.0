Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C43168FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhBJOTg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhBJOTX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:19:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2BB264E77;
        Wed, 10 Feb 2021 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612966721;
        bh=/H/VpuE4ftmMd1Jm1lW1k1psNWGjYaTa1sG7utPCWP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxmz6XzlQ/YtWrL9W/YfZfx/AwJJNqC/ad908KSGQTVb+PdyYIVbHQBTS4j3byBFt
         z+VwvbpFI7rJKzT4g5Zt+EbLq1gmgNNvfd9gyFgP5DCNlL91sjwkvsgt3UW164ia4b
         j53OdRdFpcjiUbfuexjbLGQn4iG3y4pwd23K4OItiuyWSbZxQOuGovZVthbp9sSh4J
         /pkJLQsAJ8uCthRIGqYwwyJPp4B7zxdFGNPmioNxtIe0lEVn0nq50MjLIWLZgsXO+o
         HBEJIsUjxIBjVPPYxedLDl57bfEfUPs5e+k8PNvxUhKgrfP9rm7Thnt9yGqxlbz7QA
         ni+ATs9hAdQ4g==
Date:   Wed, 10 Feb 2021 15:18:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched,x86: Allow !PREEMPT_DYNAMIC
Message-ID: <20210210141838.GA53130@lothringen>
References: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
 <161296521143.23325.3662179234825253723.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161296521143.23325.3662179234825253723.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Feb 10, 2021 at 01:53:31PM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     82891be90f3c42dc964fd61b8b2a89de12940c9f
> Gitweb:        https://git.kernel.org/tip/82891be90f3c42dc964fd61b8b2a89de12940c9f
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 09 Feb 2021 22:02:33 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 10 Feb 2021 14:44:51 +01:00
> 
> sched,x86: Allow !PREEMPT_DYNAMIC
> 
> Allow building x86 with PREEMPT_DYNAMIC=n, this is needed for
> PREEMPT_RT as it makes no sense to not have full preemption on
> PREEMPT_RT.
> 
> Fixes: 8c98e8cf723c ("preempt/dynamic: Provide preempt_schedule[_notrace]() static calls")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mike Galbraith <efault@gmx.de>
> Link: https://lkml.kernel.org/r/YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net

Also should we add something like this?

From 4e1de6d9d8804ea7edc6f8767abea37f5103799a Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 10 Feb 2021 15:11:39 +0100
Subject: [PATCH] preempt/dynamic: Make PREEMPT_DYNAMIC optional

In order not to make the small trampoline overhead mandatory for archs
that support HAVE_STATIC_CALL but not HAVE_STATIC_CALL_INLINE, make
PREEMPT_DYNAMIC optional.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/Kconfig.preempt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 416017301660..1fe759677907 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -40,7 +40,6 @@ config PREEMPT
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -83,11 +82,13 @@ config PREEMPTION
        select PREEMPT_COUNT
 
 config PREEMPT_DYNAMIC
-	bool
+	bool "Override preemption flavour at boot time"
+	depends on HAVE_PREEMPT_DYNAMIC && PREEMPT
+	default HAVE_STATIC_CALL_INLINE
 	help
 	  This option allows to define the preemption model on the kernel
-	  command line parameter and thus override the default preemption
-	  model defined during compile time.
+	  command line parameter "preempt=" and thus override the default
+	  preemption model defined during compile time.
 
 	  The feature is primarily interesting for Linux distributions which
 	  provide a pre-built kernel binary to reduce the number of kernel
@@ -99,3 +100,5 @@ config PREEMPT_DYNAMIC
 
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
+
+	  Say Y if you have CONFIG_HAVE_STATIC_CALL_INLINE.
-- 
2.25.1

