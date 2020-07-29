Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30392320A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgG2Oep (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 10:34:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgG2Odg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:36 -0400
Date:   Wed, 29 Jul 2020 14:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arwDHYVzH4hDk3sycXAG27A00V8wNWc0J/NYoHhIKnU=;
        b=Ee5QTsy7QsttltBXBqDaWgemmOxajzS16zmmo4tTWt3TWN04azMgh9GWzSFPLdfITcQET/
        /BwA5A5jSNINJa58KTYKi29TPymoNOHX9erM7IuOVjeqODwdPLGSE4tTPeSGX9T3laMzA4
        RmpSmjAzymXohyY6bHcG5v6s4gtLiT1g9i3uliOMArOPl2KsD5nxtKu2xl5ZXorc8op3pc
        a5/OjKlMdckGZgvlZA8xBJ+fPu+Ex0Cum4xseMK8mwyzN4lstRW0AiULXpmsYCN3S4FK0v
        wvPPgb+ZlzNS+LEiX+grwGgPTzdpTHhb6MnMuhVF+aCZ7RbeVC7tjJ8R3bntXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arwDHYVzH4hDk3sycXAG27A00V8wNWc0J/NYoHhIKnU=;
        b=LKtx5pyR3hwGoJ1pKrX2o+7wzdu+19tiGtsOXjIpPS7np6T1zatROUesWXB8rpm5Kau7Qr
        qUEiBCk5uNM+SPAQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] netfilter: conntrack: Use sequence counter with
 associated spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-15-a.darwish@linutronix.de>
References: <20200720155530.1173732-15-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321381.4006.16378241640368257725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8201d923f492703a7d6c980cff3034759a452b86
Gitweb:        https://git.kernel.org/tip/8201d923f492703a7d6c980cff3034759a452b86
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:26 +02:00

netfilter: conntrack: Use sequence counter with associated spinlock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-15-a.darwish@linutronix.de
---
 include/net/netfilter/nf_conntrack.h | 2 +-
 net/netfilter/nf_conntrack_core.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 90690e3..ea4e201 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -286,7 +286,7 @@ int nf_conntrack_hash_resize(unsigned int hashsize);
 
 extern struct hlist_nulls_head *nf_conntrack_hash;
 extern unsigned int nf_conntrack_htable_size;
-extern seqcount_t nf_conntrack_generation;
+extern seqcount_spinlock_t nf_conntrack_generation;
 extern unsigned int nf_conntrack_max;
 
 /* must be called with rcu read lock held */
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index f33d72c..b597b5b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);
 
 unsigned int nf_conntrack_max __read_mostly;
 EXPORT_SYMBOL_GPL(nf_conntrack_max);
-seqcount_t nf_conntrack_generation __read_mostly;
+seqcount_spinlock_t nf_conntrack_generation __read_mostly;
 static unsigned int nf_conntrack_hash_rnd __read_mostly;
 
 static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
@@ -2600,7 +2600,8 @@ int nf_conntrack_init_start(void)
 	/* struct nf_ct_ext uses u8 to store offsets/size */
 	BUILD_BUG_ON(total_extension_size() > 255u);
 
-	seqcount_init(&nf_conntrack_generation);
+	seqcount_spinlock_init(&nf_conntrack_generation,
+			       &nf_conntrack_locks_all_lock);
 
 	for (i = 0; i < CONNTRACK_LOCKS; i++)
 		spin_lock_init(&nf_conntrack_locks[i]);
