Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC833A24F5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFJHEn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 03:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJHEl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 03:04:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFCCC061574;
        Thu, 10 Jun 2021 00:02:45 -0700 (PDT)
Date:   Thu, 10 Jun 2021 07:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623308564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ztL1ruQ4arelm4nxjQPeHJQSeE2SCXM1lCANcI9FNM=;
        b=2ybo1S4ApbMHYPYDVdCBpNHU9Fu7ffczf4ToAUQNyGhniALQuYovioDiMLqT6m1y3j1kl5
        IXBWb/Onk0rl78hp822wRU/zwqZnZCrHsJHIXdJhvBQWG9/doYC03JpvnJPKEsggcY+okX
        egHbPCUJeidZ0I023lcVhxhaNG17YkFV+E/XwKFUtCPZnY4ruFg74F9K0DvQYSoIiK/O2K
        bYNu6J/7yWycemn3ZkQqq6d7o8LnDEHnCx8DWnx0udUF13D1MFnj9Jtf20Zg+gGkc2KsO4
        lcC07xYkXH4OJjmxEEgr2RHrSriTq8VmCOfVcdWpaJ1B5q1KD0HajELmj603Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623308564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ztL1ruQ4arelm4nxjQPeHJQSeE2SCXM1lCANcI9FNM=;
        b=ZLuDQ0PQ0/IWGgT5tgVALKvynBWt4Bw1fO1jVxUs9KxjNIBzW9K1YaPdADXeYSWT7TgpYX
        kXcqfLFVmQr0axDg==
From:   "tip-bot2 for Huilong Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Remove trailing semicolon in macros
Cc:     Huilong Deng <denghuilong@cdjrlc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210605045302.37154-1-denghuilong@cdjrlc.com>
References: <20210605045302.37154-1-denghuilong@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <162330856342.29796.8872573019245228294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     149876d96877eedce0ae3ffbd64edb56360b8926
Gitweb:        https://git.kernel.org/tip/149876d96877eedce0ae3ffbd64edb56360b8926
Author:        Huilong Deng <denghuilong@cdjrlc.com>
AuthorDate:    Sat, 05 Jun 2021 12:53:02 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Jun 2021 20:04:10 +02:00

seqlock: Remove trailing semicolon in macros

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210605045302.37154-1-denghuilong@cdjrlc.com
---
 include/linux/seqlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f61e34f..37ded6b 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -182,9 +182,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 
 #define seqcount_raw_spinlock_init(s, lock)	seqcount_LOCKNAME_init(s, lock, raw_spinlock)
 #define seqcount_spinlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, spinlock)
-#define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock);
-#define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex);
-#define seqcount_ww_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, ww_mutex);
+#define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock)
+#define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex)
+#define seqcount_ww_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, ww_mutex)
 
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
