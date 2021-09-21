Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E39412F6B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhIUH3j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhIUH3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF55C06175F;
        Tue, 21 Sep 2021 00:28:07 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:28:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vdz8JvX95Haydup6tm5UyM1GKneejuwKMBUgHrfKAEI=;
        b=ecwFEEpJ2w4M0y9c+BVgpXHMV21S8QkLkHxM2Wn8PTEHjQXzazBWLtp2/40qTZdgYCHkIc
        WT+nisqvoEBaOodKzYtcGdg/heuIujmBkGFMYBy5f4fxk2dkXK/eOBaafzmEFz7UiQUa9L
        ewzLft1UgOzx3WeYudbw//0qNKVnoAUtKoKCHbBam1m20sJaRo1FvYGY12NlykMTg9n6Lb
        y4w6ME2W8QcF8pTOYlyhEBhyfM5fCZka3w8E/v1zv1Ugj4p9oCPI/TKEIOCo8W8ktJJNVq
        XaHTA4Hs7ZxP3QHLwZOXSsFFY4ta1Jt3he0y7x1Frs4OlB8rZ6GkbyACgyq59A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vdz8JvX95Haydup6tm5UyM1GKneejuwKMBUgHrfKAEI=;
        b=BLLRnICVenCtWRzsF8zwbSdbDx3uPsrzx0SK3L7ubQb491HBy8Bzlv+2+7YgIEWs5n7tRS
        dj8kCg3rxHnZTuDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Increase exception stack sizes
Cc:     Michael Wang <yun.wang@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YUIO9Ye98S5Eb68w@hirez.programming.kicks-ass.net>
References: <YUIO9Ye98S5Eb68w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163220928467.25758.1633612457264201514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7d490a1fe5678d5c4abc2652a7dcfbc0b261add8
Gitweb:        https://git.kernel.org/tip/7d490a1fe5678d5c4abc2652a7dcfbc0b261add8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 15 Sep 2021 16:19:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:33 +02:00

x86: Increase exception stack sizes

It turns out that a single page of stack is trivial to overflow with
all the tracing gunk enabled. Raise the exception stacks to 2 pages,
which is still half the interrupt stacks, which are at 4 pages.

Reported-by: Michael Wang <yun.wang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YUIO9Ye98S5Eb68w@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/page_64_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index a8d4ad8..e9e2c3b 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -15,7 +15,7 @@
 #define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
 #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
 
-#define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
+#define EXCEPTION_STACK_ORDER (1 + KASAN_STACK_ORDER)
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
 #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
