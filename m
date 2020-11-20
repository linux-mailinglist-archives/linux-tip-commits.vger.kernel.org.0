Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA332BAA5B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKTMov (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:44:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTMov (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:44:51 -0500
Date:   Fri, 20 Nov 2020 12:44:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605876289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Po6hMNLYVS0Z3NJUrq9IN25TwJsdGVJZiUmrzvotxso=;
        b=qFopZQCx0YDNuhL9eUU4R8HuAyJxw0ZIWCg66LvyqVoSQjNZOttTVPGYU3Td5Z/C2DO/li
        Lz6xTHrgHX78pp9OVXNVBZ4vIy6CULNfd3vNEObAyOa4HgzO98fs3Sf2FeEpcaSnXOGzut
        T53xHdqWzX8Aj+/eN4MfxoqR+01/kBJOxpV9Q7G1reqOc61VTCExqaKOhs5pvKpyG7MY+f
        L840BI/jKOzEZ3oWidQLPADCgCj2FoLOLUh9T6wzWL9gezrCIlmXHyF9BM1ieaRrv8pq6I
        ItRkz4sBgmO0ZxKXYy0JDqa2UoD8aTpMW+tE7+jiRvR/dyBDpFQNuwAki6qOmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605876289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Po6hMNLYVS0Z3NJUrq9IN25TwJsdGVJZiUmrzvotxso=;
        b=ITYPfUSxDmGUaKIb5zO2s3Aj0qpwgXNLesefF5xWNdZJXroTNBtElUQfJoGvvqDNJjbJBO
        oOF8E4w4HCyMfvAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117151637.259084-6-frederic@kernel.org>
References: <20201117151637.259084-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160587628844.11244.216988947383639442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     d1f250e2205eca9f1264f8e2d3a41fcf38f92d91
Gitweb:        https://git.kernel.org/tip/d1f250e2205eca9f1264f8e2d3a41fcf38f92d91
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:16:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:42 +01:00

x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK

A lot of ground work has been performed on x86 entry code. Fragile path
between user_enter() and user_exit() have IRQs disabled. Uses of RCU and
intrumentation in these fragile areas have been explicitly annotated
and protected.

This architecture doesn't need exception_enter()/exception_exit()
anymore and has therefore earned CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117151637.259084-6-frederic@kernel.org
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b8..d793361 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -162,6 +162,7 @@ config X86
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
+	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
