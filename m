Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF78347258
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhCXHWr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhCXHWb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:31 -0400
Date:   Wed, 24 Mar 2021 07:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vStxBNJscWg4xPXWDBlqQ0OTqEtjF7fFzH/e/Vifzik=;
        b=UeK9bTwsuwqrk/Je6KaNGPJ1d22ak54Lyjh6zfRt3GE52P8T4MT75cXxbsNCA4oFm2xxP+
        IiIweCYOPcOpy0a2J0QJb9cuynJRvWWdwELedF8gd+s+D4/4nyiUi5rXVVnLscKjAutZoL
        UNAPrJwdy1PqZVk14o7AZ1Md1UEW3oS9C3QUnJsSCts4jEMCUjl09rORSUT0W9R5F2HnvW
        39+vhk8S5WdrgrNbCN5aco26nYR8zPPUOrmKCSPZlsWBHkVsMDfAiCC9uIWHxYyuzKE2RT
        8Z7s5hGSHgJfufuUHNz2o0xFaGkq4p7wMRVF2laZIjPiGlRniAcYOPNUR51dtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vStxBNJscWg4xPXWDBlqQ0OTqEtjF7fFzH/e/Vifzik=;
        b=ztLwqbmSES4LEUyUxuD0xJfxS1T0kqpbaHMR/yQLX8qBUkRZjR1tZRVGJeBE2JJhojVCv+
        00L0TZ4yyCSRgrAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Inline chainwalk depth check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.195031688@linutronix.de>
References: <20210323213708.195031688@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054918.398.7755503240934818483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     31120afb21f5892aa981af635b425a074e978cab
Gitweb:        https://git.kernel.org/tip/31120afb21f5892aa981af635b425a074e978cab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:07 +01:00

locking/rtmutex: Inline chainwalk depth check

There is no point for this wrapper at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.195031688@linutronix.de
---
 kernel/locking/rtmutex.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index a18ee0c..0eac57c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -343,14 +343,9 @@ static void rt_mutex_adjust_prio(struct task_struct *p)
 static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 					  enum rtmutex_chainwalk chwalk)
 {
-	/*
-	 * This is just a wrapper function for the following call,
-	 * because debug_rt_mutex_detect_deadlock() smells like a magic
-	 * debug feature and I wanted to keep the cond function in the
-	 * main source file along with the comments instead of having
-	 * two of the same in the headers.
-	 */
-	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
+		return waiter != NULL;
+	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
 /*
