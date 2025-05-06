Return-Path: <linux-tip-commits+bounces-5323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C81AACC86
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA62B1C04D5B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BFF286413;
	Tue,  6 May 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mvh2BHX+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkvLNqVg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176432853E9;
	Tue,  6 May 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553925; cv=none; b=dD8gJlgYLR5VYX9y9qWeRQUpxk5y0Z7fQab7UCgE1h0sH1vXF5aAJwues76Tt8cSvRlmJR4hw5CMRPWsi1gUy7bnhMaP/l6YA0xvOmXzqHIIWre+rfe0QyUbGhIzP89UWd5BLCVGJwQ1zvL1zWRvAVqZf0Y3/2G/uf0RDgk0Nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553925; c=relaxed/simple;
	bh=p3w/St0kW8fKa76Db7E8rYhh3MsgIDsElDGzAXP9C8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sI828eUw8kw6RQmNeF3IoReoHXUOJXZWrFL+HqD5FiiCNLEm9uKEHroGJJF1ctyrwplzpoM2USfZ//QqGLsgcJ5c8v3BEQ61nqEmCogVUwaW2VzBLI599CHn2RN7m/FwhizUUYp7VlOIsRU1/LkgsiH6a86ISUd2v+sEND76900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mvh2BHX+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkvLNqVg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 17:52:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746553922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hp2iDlvZc776exwlwCKdQCJZrhOKa0RLDTpLaBIuAs=;
	b=Mvh2BHX+OWGB6ERtP1WY0BFwGF50Ju/KV9tk1/KYd2fyOVWv0qQWiXkeFusJ/HnTHQ7nMQ
	Gc+NyoD/kknF6Y0wdHidcBr8+5rksd//wp5MaYgn9lfbuTV8Wt5dzKfcm1f0QOhet7GdC8
	Y9hrHZqGz0Jw9AoZllZZ0xXlBta5LzzhkLeTQrRVe9/Up2RnS6scA3/gwQFiwxWNafEdoO
	+VxRcTKAk2XBnnCG1hlxgDWeBZJm7dodwqfpPFdkg9/3QZy5zOjfNcxJt1ExsKOtK56y9m
	VPokfxf8YxQkO+7MyY6UifPvm3uVQSDm5veb834NWjdMHGSeJSdzjEzoD/m4XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746553922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hp2iDlvZc776exwlwCKdQCJZrhOKa0RLDTpLaBIuAs=;
	b=pkvLNqVg5bOusrc/LcyBM6jZYnIYJNBK16qNOg/6vX00/Px53TjlwePyBBpmwyk+LkL/Of
	FnrvT+BTYsz3aODA==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Move hlock_equal() to the
 respective #ifdeffery
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506042049.50060-2-boqun.feng@gmail.com>
References: <20250506042049.50060-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174655392101.406.10520586528110757948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     96ca1830e1219eda431702eb9a74225e8fe3ccc0
Gitweb:        https://git.kernel.org/tip/96ca1830e1219eda431702eb9a74225e8fe3ccc0
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 05 May 2025 21:20:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 18:34:31 +02:00

locking/lockdep: Move hlock_equal() to the respective #ifdeffery

When hlock_equal() is unused, it prevents kernel builds with clang,
`make W=1` and CONFIG_WERROR=y, CONFIG_LOCKDEP=y and
CONFIG_LOCKDEP_SMALL=n:

  lockdep.c:2005:20: error: unused function 'hlock_equal' [-Werror,-Wunused-function]

Fix this by moving the function to the respective existing ifdeffery
for its the only user.

See also:

  6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")

Fixes: 68e305678583 ("lockdep: Adjust check_redundant() for recursive read change")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20250506042049.50060-2-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58d78a3..546e928 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1977,41 +1977,6 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 }
 
 /*
- * We are about to add A -> B into the dependency graph, and in __bfs() a
- * strong dependency path A -> .. -> B is found: hlock_class equals
- * entry->class.
- *
- * If A -> .. -> B can replace A -> B in any __bfs() search (means the former
- * is _stronger_ than or equal to the latter), we consider A -> B as redundant.
- * For example if A -> .. -> B is -(EN)-> (i.e. A -(E*)-> .. -(*N)-> B), and A
- * -> B is -(ER)-> or -(EN)->, then we don't need to add A -> B into the
- * dependency graph, as any strong path ..-> A -> B ->.. we can get with
- * having dependency A -> B, we could already get a equivalent path ..-> A ->
- * .. -> B -> .. with A -> .. -> B. Therefore A -> B is redundant.
- *
- * We need to make sure both the start and the end of A -> .. -> B is not
- * weaker than A -> B. For the start part, please see the comment in
- * check_redundant(). For the end part, we need:
- *
- * Either
- *
- *     a) A -> B is -(*R)-> (everything is not weaker than that)
- *
- * or
- *
- *     b) A -> .. -> B is -(*N)-> (nothing is stronger than this)
- *
- */
-static inline bool hlock_equal(struct lock_list *entry, void *data)
-{
-	struct held_lock *hlock = (struct held_lock *)data;
-
-	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
-	       (hlock->read == 2 ||  /* A -> B is -(*R)-> */
-		!entry->only_xr); /* A -> .. -> B is -(*N)-> */
-}
-
-/*
  * We are about to add B -> A into the dependency graph, and in __bfs() a
  * strong dependency path A -> .. -> B is found: hlock_class equals
  * entry->class.
@@ -2916,6 +2881,41 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
 
 #ifdef CONFIG_LOCKDEP_SMALL
 /*
+ * We are about to add A -> B into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * If A -> .. -> B can replace A -> B in any __bfs() search (means the former
+ * is _stronger_ than or equal to the latter), we consider A -> B as redundant.
+ * For example if A -> .. -> B is -(EN)-> (i.e. A -(E*)-> .. -(*N)-> B), and A
+ * -> B is -(ER)-> or -(EN)->, then we don't need to add A -> B into the
+ * dependency graph, as any strong path ..-> A -> B ->.. we can get with
+ * having dependency A -> B, we could already get a equivalent path ..-> A ->
+ * .. -> B -> .. with A -> .. -> B. Therefore A -> B is redundant.
+ *
+ * We need to make sure both the start and the end of A -> .. -> B is not
+ * weaker than A -> B. For the start part, please see the comment in
+ * check_redundant(). For the end part, we need:
+ *
+ * Either
+ *
+ *     a) A -> B is -(*R)-> (everything is not weaker than that)
+ *
+ * or
+ *
+ *     b) A -> .. -> B is -(*N)-> (nothing is stronger than this)
+ *
+ */
+static inline bool hlock_equal(struct lock_list *entry, void *data)
+{
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read == 2 ||  /* A -> B is -(*R)-> */
+		!entry->only_xr); /* A -> .. -> B is -(*N)-> */
+}
+
+/*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. If it can, <src> -> <target> dependency is already
  * in the graph.

