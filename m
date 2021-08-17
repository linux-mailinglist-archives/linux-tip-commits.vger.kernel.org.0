Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B403EF37B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhHQUPy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhHQUPT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37284C06121D;
        Tue, 17 Aug 2021 13:14:25 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg3zTSpRxNzjWx1iGANSTF9am2IIIQHwOSCJ5aU0BRE=;
        b=hkTJAA+EBo70tWxUAy/Jyy/07eBjdwGMpmzxhXI4ZYcutuaL0Ejv5xqnti9Ig/4pKu2Ox+
        djL62B81IRyZN995iwJKfUH7VuSe6X6+hnXuybOdI6++j5APrBexZXAUuj8vjxv5aBmn4Z
        BQCYBOS5w87qiY9x+cfIO8zIZrFiT/UZz8eXb+ybHIDLCKULSqvpADg1kz8E1qMHKAuVjr
        2n3LFMxeqeihlaxpFVR/yDNi7MXudCiy8n5xgTbbLyBwUJAS/x59A2KKiz9Sp9BvF13bfD
        NeX0RmDy9cbPOz9/L1HIjfyzTkKlfPU5CI4Zh3xUPTJGXYhNKy2dDCM/f/TnAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg3zTSpRxNzjWx1iGANSTF9am2IIIQHwOSCJ5aU0BRE=;
        b=4lbclTvkI2LBiAcKkCerOpyMtBbR0Se0Xahp/Dd/2HQZWZyHLw3jUTa6gS9GYQtqWbfojq
        dCVVr5vJOxXVeVDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Reduce header dependencies in
 <linux/debug_locks.h>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.484161136@linutronix.de>
References: <20210815211303.484161136@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126303.25758.12953615433442410363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cbcebf5bd3d056d7a0ae332118888d867ac346c0
Gitweb:        https://git.kernel.org/tip/cbcebf5bd3d056d7a0ae332118888d867ac346c0
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:29:10 +02:00

locking/lockdep: Reduce header dependencies in <linux/debug_locks.h>

The inclusion of printk.h leads to a circular dependency if spinlock_t is
based on rtmutexes on RT enabled kernels.

Include only atomic.h (xchg()) and cache.h (__read_mostly) which is all
what debug_locks.h requires.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.484161136@linutronix.de
---
 include/linux/debug_locks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index edb5c18..3f49e65 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -3,8 +3,7 @@
 #define __LINUX_DEBUG_LOCKING_H
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
-#include <linux/printk.h>
+#include <linux/cache.h>
 
 struct task_struct;
 
