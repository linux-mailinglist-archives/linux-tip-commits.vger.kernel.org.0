Return-Path: <linux-tip-commits+bounces-2528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23019AB915
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC9E1C23336
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E721BD03C;
	Tue, 22 Oct 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BOGQctZZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tesPYQKZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6768126C05;
	Tue, 22 Oct 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634035; cv=none; b=f80YYI1SUTnaINis0XSsOf16jhYoCUCD5F5bMJzCK/JCIiz3D6JmzePd8p2mKYKIozyjdLvnqkGgtVu79GGqHa2+xnQsJ2rcMdWnmwvuZr+RtYxvT7MTIpeAHy43M40qB6AnUv4C8BUCrV7HJ2gkIZR9g+t6+LzD0+Y1KrVMdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634035; c=relaxed/simple;
	bh=DJvL8HeiOYexBx7wV2xbAvsI50tZyPd9r5a4zUwmKOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MgV+c0Tkqp4lzuZtPKVtP7t4ksVaIgYgSn/8fwoIluWkClOn/i9nQ8fNq7mwpNAIDr1w+l3BLgI3kMwuY5W0IrRnMxCQ71s0+yRpO6tFdl63z1uzOyzNZ0NcHX1FnWV7k3Hog7rooUYlons3Dm8ngz6p0eXFj2kOiz6gZZi9IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BOGQctZZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tesPYQKZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcx7RD87seTRTpWz27Rc8tqqa8qLWZ41iLUDgfx9hDI=;
	b=BOGQctZZ9GLn2pIENp4Nz6wSK3ugg/BB2bK/SGQh5/qYzQAuQoEITvZ6LBVxOz19Mntnhc
	cWFo+3qQJfuiMv124TW27xFGzXz8sqeBtqvOQPvCDT3A4luz29s/g0iP8WOJE2+chWgX8i
	AdqgkIKtj3j1Il0J4H9hLyQcAKK3cvHSkOZdXKKe7zGVeS2+qkCJ+3InRNHbK6o3eim72u
	d0eqQ6WJrQfa7jmjvhdAYex+L7RWc773ecFuIaXX1qpDLW2coV436yU8ba6310zKBwGegl
	v6xFDv60Q5b3rOe+CJOW0cFtmVs0b//GOmi5PmDN+DAA/3HOwStar4/2QSOJTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcx7RD87seTRTpWz27Rc8tqqa8qLWZ41iLUDgfx9hDI=;
	b=tesPYQKZqoJ893P4KZ92u4vbEWUydmC2molbFr81zxC2lIUQ6G/rpp7ELysHFTFd6phZ3V
	hOB0FZIqAzDZWuDw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Use info level for lockdep initial info messages
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007065457.20128-1-jirislaby@kernel.org>
References: <20241007065457.20128-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963403159.1442.11454534618321395967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e48bf7ca6056297664eb260fa88cae8e50d9b698
Gitweb:        https://git.kernel.org/tip/e48bf7ca6056297664eb260fa88cae8e50d9b698
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Mon, 07 Oct 2024 08:54:57 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 21:21:16 -07:00

lockdep: Use info level for lockdep initial info messages

All those:
 Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
 ... MAX_LOCKDEP_SUBCLASSES:  8
 ... MAX_LOCK_DEPTH:          48
 ... MAX_LOCKDEP_KEYS:        8192
and so on are dumped with the KERN_WARNING level. It is due to missing
KERN_* annotation.

Use pr_info() instead of bare printk() to dump the info with the info
level.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241007065457.20128-1-jirislaby@kernel.org
---
 kernel/locking/lockdep.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6fd4af2..2d8ec03 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6600,17 +6600,17 @@ EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
 void __init lockdep_init(void)
 {
-	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
+	pr_info("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
-	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
-	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
-	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
-	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
-	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
-	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
-	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
+	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
+	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
+	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
+	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
+	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
-	printk(" memory used by lock dependency info: %zu kB\n",
+	pr_info(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(lock_classes) +
 		sizeof(lock_classes_in_use) +
 		sizeof(classhash_table) +
@@ -6628,12 +6628,12 @@ void __init lockdep_init(void)
 		);
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
-	printk(" memory used for stack traces: %zu kB\n",
+	pr_info(" memory used for stack traces: %zu kB\n",
 	       (sizeof(stack_trace) + sizeof(stack_trace_hash)) / 1024
 	       );
 #endif
 
-	printk(" per task-struct memory footprint: %zu bytes\n",
+	pr_info(" per task-struct memory footprint: %zu bytes\n",
 	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
 

