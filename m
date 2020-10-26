Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C805A298A84
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770070AbgJZKkX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 06:40:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770065AbgJZKkV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 06:40:21 -0400
Date:   Mon, 26 Oct 2020 10:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603708819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqDYvcGlxY85LWEFlnZLGZ0FhgrCevZLmKjdDpAVdS0=;
        b=Xs8ehwcvjTqL9Xev5WNA2ftCOvX7W+e3XZOzqWZLxMS0oucwTpcHTJ3eVmUUeut0M/V+fm
        T1F1Kt+NCdJkAmR3qfRjTLRKYd8PZ4fJWPM35D2Zc9gcGCd/vQYJVkxnkmatBw7k+vuNpK
        Ik2xkcpyhQhyLwyRNjrqSm9rKDa/150MBANv0AsZ0J46sQ0WCM+V9nQenRC9bWEK0Mb9er
        kfyhDLfYWo4RtxyVrkMZWVTnhlCYxb0DK1oasdZClRb52qbLGm60UZQb7wbltD8D8ZCcER
        5MVyixAiNOsOaT8L1zceuvZTm7qAt4bg37ejHgsXLVVM81rcpFwIG8L4fw+ecw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603708819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqDYvcGlxY85LWEFlnZLGZ0FhgrCevZLmKjdDpAVdS0=;
        b=qMams7cibLB+XDrzQ3dwNRNnxk3LvYxgwBguDjQ8BFvox3qLLcBYurUcMZWM0Zqw2S53if
        QgNiwvXrDx7k4lDw==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Remove unused inline function
 debug_hrtimer_free()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200909134850.21940-1-yuehaibing@huawei.com>
References: <20200909134850.21940-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160370881871.397.13731090502650786961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5254cb87c0423f73c8036235795788a132e8956e
Gitweb:        https://git.kernel.org/tip/5254cb87c0423f73c8036235795788a132e8956e
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 09 Sep 2020 21:48:50 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 11:39:21 +01:00

hrtimer: Remove unused inline function debug_hrtimer_free()

There is no caller in tree, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200909134850.21940-1-yuehaibing@huawei.com

---
 kernel/time/hrtimer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3624b9b..387b4be 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -425,11 +425,6 @@ static inline void debug_hrtimer_deactivate(struct hrtimer *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
 
-static inline void debug_hrtimer_free(struct hrtimer *timer)
-{
-	debug_object_free(timer, &hrtimer_debug_descr);
-}
-
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode);
 
