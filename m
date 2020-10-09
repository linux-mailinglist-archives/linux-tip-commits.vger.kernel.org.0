Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167562882BB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgJIGjZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgJIGfR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:17 -0400
Date:   Fri, 09 Oct 2020 06:35:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R58zf8cu5RWB/O1rGzEuV4XAv1olz1WwFvYq/YjYdKw=;
        b=kg2ntqIn4Zyy2k++ufzcf4LJ8+rPFuWWFxWIAb2E0NePtjsjQ8NubNZs8mPTLpDF7ORnN9
        ivuXUGqlqL+A52Bc9zQpjfhtZPXJN8QgfAdc4CCmASCSK/2bAwZdLRXpdae0EjoDxwwPI5
        M3RNMfnnv+lmimuPnrP1MEdzjzENKtDTZ9xcZRhdUl7asxb8WQ3ylJ1z8f1brI4uUduGv0
        7tj2hdkk+ojjGGVRWdjomi0KXx/8qd2tKM31vAVKsDUZX5UeATG0ZuBCAURctPqKkajHpE
        5TxJnu2oVbe5d5qh610uXk7qfOhjyBvM3ajfDMJx5Ql5fxuLjpRj3vI2A6KtvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R58zf8cu5RWB/O1rGzEuV4XAv1olz1WwFvYq/YjYdKw=;
        b=d26b0lsramNnAlSi9F6ss1MTseUPQhzG/MqZYqp+rlL+AaiRGAGJYBLy9epM4cxvqbb1af
        S8aqBTC0M3+OajAg==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Make function torture_percpu_rwsem_init() static
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531538.7002.1792524817885556080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d49bed9abc3454bd123cbe974ecbeae119701b92
Gitweb:        https://git.kernel.org/tip/d49bed9abc3454bd123cbe974ecbeae119701b92
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Fri, 03 Jul 2020 13:05:27 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:32 -07:00

locktorture: Make function torture_percpu_rwsem_init() static

The sparse tool complains as follows:

kernel/locking/locktorture.c:569:6: warning:
 symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?

And this function is not used outside of locktorture.c,
so this commit marks it static.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9cfa5e8..62d215b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -566,7 +566,7 @@ static struct lock_torture_ops rwsem_lock_ops = {
 #include <linux/percpu-rwsem.h>
 static struct percpu_rw_semaphore pcpu_rwsem;
 
-void torture_percpu_rwsem_init(void)
+static void torture_percpu_rwsem_init(void)
 {
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
