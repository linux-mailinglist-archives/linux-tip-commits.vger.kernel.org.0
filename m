Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F940C8C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbhIOPu6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41602 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhIOPur (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:47 -0400
Date:   Wed, 15 Sep 2021 15:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNvQnmLRcVPFVS+v9zpGVWAuxfKpT7Ro1TH29S1Dwpo=;
        b=bMiMVAgysumQaD2+uPgJc1S7sohbzrYgbhg17jg0BOU+6TEglpamAtCaoKM+PJZt0JoLSn
        SpHZRbXVMmWhPaY7r40aOWUjsP6a0UCamEwcz3Hhd1i2xq8BKNDEiy6aEXNNSYN1cM2ocq
        51dvAfuou4ZiCoUSwT/wmkuI3EPd11CbIC3eFHCdJKm8sWkq/u8XsZo6Zbnr5nBveE14j1
        VtcSWrkbZblavlXQ72MnUHe8SsuE2RV+1bChbo4c1AA8KhNOIU96syn/SP2NaOO2cgcalH
        WwRmbANIgkmlrEfxicXld1rp44s2plGxAboX6tDwMvnSUWjSUvXhblUc/4IKnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNvQnmLRcVPFVS+v9zpGVWAuxfKpT7Ro1TH29S1Dwpo=;
        b=xHT4OiC+bhjL1mFzUDOAw8KFaotp56+UMHjCxTpVN/N+2+S6W+h2QzMpst5ZFdm1oJxgFG
        ai8N+dTznzOVGXBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] locking/lockdep: Avoid RCU-induced noinstr fail
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.311980536@infradead.org>
References: <20210624095148.311980536@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096674.25758.986050044326739617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ce0b9c805dd66d5e49fd53ec5415ae398f4c56e6
Gitweb:        https://git.kernel.org/tip/ce0b9c805dd66d5e49fd53ec5415ae398f4c56e6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:47 +02:00

locking/lockdep: Avoid RCU-induced noinstr fail

vmlinux.o: warning: objtool: look_up_lock_class()+0xc7: call to rcu_read_lock_any_held() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.311980536@infradead.org
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c..8a50967 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -888,7 +888,7 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu_notrace(class, hash_head, hash_entry) {
 		if (class->key == key) {
 			/*
 			 * Huh! same key, different name? Did someone trample
