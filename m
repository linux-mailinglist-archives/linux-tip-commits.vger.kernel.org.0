Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372C333F475
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhCQPtf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhCQPtB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:01 -0400
Date:   Wed, 17 Mar 2021 15:49:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1s4ENeHjnbdqX43k5NMmOi0g3JLcaBfYzezHDfXW/I=;
        b=x3E2gxEyRiUIolLOOxLIrK8LNhrE2Df3fr75oxWd+pRTUGYEfR7nU72ZIxFaFxBoLey6iX
        u+2Ib2+7yxLfRt66pzRm5/gZOZHnaQ9KpqST160XK1pq51UaNkYyzzpE0BEN37kp7Ck6Je
        oibdhhqXNhF22Caj/cQRDQn4o8VxPVpZPGQf0VaTWhnClB4MZENrJr/9zl8tJ47rdos+Za
        mv+UNljD5WtnEKWN4snoXHVlYGUi4uPcWBqMiMz9g98yHG/Jxlak9c++/Zr08K80ebmeHR
        Aif9NZg2z2O+y63Aeezb6OjwjZ4LcsRdYxfYETe0FtSYMKaNl+sk6Z2w0qJ0xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1s4ENeHjnbdqX43k5NMmOi0g3JLcaBfYzezHDfXW/I=;
        b=08WBkS6vAsB4JTZNL7bPA1OxHy7diM3ss6PXput7+t0nAnSDw6LA+77v/GGRP6bKV9EAeS
        wqU8KuuzCqX3vxBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Replace barrier() with cpu_relax() in
 tasklet_unlock_wait()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.249343366@linutronix.de>
References: <20210309084241.249343366@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599614013.398.5397350064896985635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d2da74d1278a1b51ef18beafa9da770f0db1c617
Gitweb:        https://git.kernel.org/tip/d2da74d1278a1b51ef18beafa9da770f0db1c617
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:51 +01:00

tasklets: Replace barrier() with cpu_relax() in tasklet_unlock_wait()

A barrier() in a tight loop which waits for something to happen on a remote
CPU is a pointless exercise. Replace it with cpu_relax() which allows HT
siblings to make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.249343366@linutronix.de

---
 include/linux/interrupt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2b98156..d689fd7 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -672,7 +672,8 @@ static inline void tasklet_unlock(struct tasklet_struct *t)
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &t->state))
+		cpu_relax();
 }
 #else
 #define tasklet_trylock(t) 1
