Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923792A245F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Nov 2020 06:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgKBFiA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Nov 2020 00:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBFiA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Nov 2020 00:38:00 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE35C0617A6;
        Sun,  1 Nov 2020 21:38:00 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id a20so11848057ilk.13;
        Sun, 01 Nov 2020 21:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmtyWXXFCEjzWmQYxQpJxHrT5LT5SmaadSNhDN5r2mI=;
        b=SMe2WPsXWxRPeMHazpborPwlpILG3FkT8obRAsJM+ZUm17kfQqQaPOSob0Jc6yYugj
         ZqBPdYKwg3bc0qSbCZWXbHaQWgNQzwlRk42k8eXus8j7Yeb/5zlb4SJbqmWWBLln4Q7X
         inmI2wuYD14UH9usZ3Nk4/CkUpiNvboME/4Qqd8ccqry3TKpqNx4DjDbdOKyyGQ/6ktG
         VcEMGRSGAptEDcWhlx6OI6A6UxlF3qlWYGTTQQNlgn/OEAts52wdVurh83MOC9H6Z3lG
         pXuNvyZHo6IYXhBHbpLMquaYXmKssDrw8a2EARGY4OniciLCiHcA3KaeAggHLdQasTZO
         z3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmtyWXXFCEjzWmQYxQpJxHrT5LT5SmaadSNhDN5r2mI=;
        b=Qw+IqKvzolbLLJvZ7xWjZnQXL9g+EEWkdM4h06Rr2fj6r3a/YhfuqBIieuzx/IVZXE
         Y9eHV0zxD8i3fHIj3qpchRTj7nsnqgmq32GwcyqskZMCYouUbqlTd7TsWbM4l1jZ6ohN
         +eVAgFWSKZJqD8eJS5PVDCe3ANzMvymCpujk1TkHmVTgbBHi24D0YUMkFQZZoMwdD27Y
         KtyAYd5HbWmptwavIH7uGxwzfLW4GJmo5tNyTxdIGhzBnsqXJGgm5KY6IaGw92FwKy1j
         GCgb7sB9c/I4/KwLM72h2KW2dzaBMZL5+ISTASloE1LDhu3clz80p+vcfCwkETU5L/oc
         eIbA==
X-Gm-Message-State: AOAM532WS+2Yq6mBRuB9Af+NqzBR1LWaShXhPlzbH/0T3VJCGTgdf38r
        5zZVQeRsLXUFN4zEnUdywEWZMZj3ceQ=
X-Google-Smtp-Source: ABdhPJyIp/AtxHQmHCSEmY8oCG4MZHinb72/M4jmjLADKWL2YG0K30CPyr1MBsktCB1AUmGcXp/jLw==
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr2987641ilq.161.1604295479696;
        Sun, 01 Nov 2020 21:37:59 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w81sm10489656ilk.38.2020.11.01.21.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:37:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id BAB5827C0054;
        Mon,  2 Nov 2020 00:37:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 02 Nov 2020 00:37:57 -0500
X-ME-Sender: <xms:NZufX1mq9UgIp5_b2H1KcvCWgXeiUnVPpJjdObIr3cku2vDpUypWqw>
    <xme:NZufXw2ap0cSNdAhPj4Hdc8yWfJk7pbPcnQ8EhTjjRV8NW470tX61OIztoiRmoS1z
    sKhx4hEEGAmbGvRSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddttddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedutddurdekiedrgedurdegjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpeepfh
    higihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NZufX7qdIFhxWs8fAEShzy4zOLgT7WkXnQiyQAZzWMoLb-eDp_Oi0g>
    <xmx:NZufX1mw88tWul5KOKJWWE0Njj9e-VF3wZWr6PR9-9jOB63EL_xTQQ>
    <xmx:NZufXz3QgcPA_-gJ298S96J_UDJ49_7MD7y4SXoJgPfQH6Ijyu2UxA>
    <xmx:NZufXz-C_A27gLlNQrJqSgBU5RI_vsqRAXwwbSc9AGVvD0nyURU35w>
Received: from localhost (unknown [101.86.41.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E5043280063;
        Mon,  2 Nov 2020 00:37:56 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Qian Cai <cai@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] lockdep: Avoid to modify chain keys in validate_chain()
Date:   Mon,  2 Nov 2020 13:37:41 +0800
Message-Id: <20201102053743.450459-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
References: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Chris Wilson reported a problem spotted by check_chain_key(): a chain
key got changed in validate_chain() because we modify the ->read in
validate_chain() to skip checks for dependency adding, and ->read is
taken into calculation for chain key since commit f611e8cf98ec
("lockdep: Take read/write status in consideration when generate
chainkey").

Fix this by avoiding to modify ->read in validate_chain() based on two
facts: a) since we now support recursive read lock detection, there is
no need to skip checks for dependency adding for recursive readers, b)
since we have a), there is only one case left (nest_lock) where we want
to skip checks in validate_chain(), we simply remove the modification
for ->read and rely on the return value of check_deadlock() to skip the
dependency adding.

Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
Peter,

I managed to get a reproducer for the problem Chris reported, please see
patch #2. With this patch, that problem gets fixed.

This small patchset is based on your locking/core, patch #2 actually
relies on your "s/raw_spin/spin" changes, thanks for taking care of that
;-)

Regards,
Boqun

 kernel/locking/lockdep.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..a294326fd998 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2765,7 +2765,9 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns: 0 on deadlock detected, 1 on OK, 2 if another lock with the same
+ * lock class is held but nest_lock is also held, i.e. we rely on the
+ * nest_lock to avoid the deadlock.
  */
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
@@ -2788,7 +2790,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
 		if ((next->read == 2) && prev->read)
-			return 2;
+			continue;
 
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
@@ -3592,16 +3594,13 @@ static int validate_chain(struct task_struct *curr,
 
 		if (!ret)
 			return 0;
-		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
 		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if the new lock introduces no more
+		 * lock dependency (because we already hold a lock with the
+		 * same lock class) nor deadlock (because the nest_lock
+		 * serializes nesting locks), see the comments for
+		 * check_deadlock().
 		 */
 		if (!chain_head && ret != 2) {
 			if (!check_prevs_add(curr, hlock))
-- 
2.28.0

