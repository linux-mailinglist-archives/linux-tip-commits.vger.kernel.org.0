Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1196413374
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 14:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhIUMmp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhIUMmm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 08:42:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B8C061575;
        Tue, 21 Sep 2021 05:41:14 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:41:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632228070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDNaOAyLhe9F+PINkX4Wt383OyDkPDiSbUSXnaD34JY=;
        b=QTNjf8VrFllbtkJBB7QvWBvE1bafB/CzTJ+zTsC+sj1cDFP+lLMY53hblDtisOWm3UAxkO
        hvBgp8VY+pHG+0cUnDBUKQhuMNXwLaQLgqhgWXqITdpHSYENsms0WbE9czdC69O5QI23Yi
        e2e959K8dlmDaOm8g7o/NcZ1QB/kPy9un5wvFgHq+BCYx811yHGAKFZBCKvikbw6uIpw2Z
        rQYyGIJyhTg5T2QMmQIir+iW758qopdkdfjRoxrnq3n2Eguo4fHfeJOHibQ1tdeOerueBX
        msvXlueRERIF/0GC5J8dFO4/d6Znghq7YpNevFfs5n2vawNxMFyrVOlSI2vvbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632228070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDNaOAyLhe9F+PINkX4Wt383OyDkPDiSbUSXnaD34JY=;
        b=/CH9REiwrCLt8Yy/U7MJ+UJgeYx8D9diuYsMcUlQJ8gQuCg3DRQjL4aeGMQvd8Hq6hpa6f
        5YdUhUveJsw6W8CQ==
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
Message-ID: <163222806918.25758.2617878698069891903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7fae4c24a2b84a66c7be399727aca11e7a888462
Gitweb:        https://git.kernel.org/tip/7fae4c24a2b84a66c7be399727aca11e7a888462
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 15 Sep 2021 16:19:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Sep 2021 13:57:43 +02:00

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
