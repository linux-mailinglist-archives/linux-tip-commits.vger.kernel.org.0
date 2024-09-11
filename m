Return-Path: <linux-tip-commits+bounces-2300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5C974F3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5251C21B8E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B317B51B;
	Wed, 11 Sep 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECguBTxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQFRGP7r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD713A884;
	Wed, 11 Sep 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049181; cv=none; b=sJksjgtq87kUdnNLfF076NTE718lOUtwJWMRZJQGj8gKRSCvZRMl5EE+Fl018l8Va+LEjE5ZjnAWGQk+53wBV2SW/9NcDrCcG2tIoVemld13IEtovi5TtFyNL46IycikCgkaw/PhAJ3DrlappeITHp2J6lNWQ39QquFQ6KKTrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049181; c=relaxed/simple;
	bh=nFXFNYSYZ8RWMu53wCfEwEYMCYmdLxIZFBF71sHex0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FKkznKsM/y+EVg7gXFPvtHgfWydSxS3X0LsQXJM/URLHj7ndGiTMPon45j7n3Ugyag0vW5IjJFp8X6Mn5iM6mjSWOS/tAil0yV+D9Nll3HK0DvVSwrxJ80c4AUnB5RyVmOiDm+1yU58Hy08+0LbgtbSLGpszmYWTiqujWei23qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECguBTxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQFRGP7r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 10:06:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726049177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89fFTMjF07mIIdQIxSuCjEAL2qbIX0n67g5ZVggMHRo=;
	b=ECguBTxhZY0l9LbdQMVfzlRInCRme3XtYHjzXfg8gPBS32bIk9wQlLRYPhXp7Z/vfpHeoJ
	2tgKqnHl4sqVQunLeBzQlkMrar2aZccD8Hb4Y1WB5hkh+VekXlIqhUH/E8Fb20oxcJfqMs
	9fwMQtey1J6F3AgNh51Me+6KZX4NGV0rUjeUhTLa0QABS/YFjBCUFZ1B0UqumMI4vkm547
	huMbb8Cv2NLBwxROCUssnt2Cr24pbF5OaSKikfRl69SEcoq8412U86XonxQ0RTiOjYQqfM
	C+7SnGTLDH6qBIAbh/kCOoGnjO280Al61dmnJwEjSprjEQMEXabmRkPaUfUuSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726049177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89fFTMjF07mIIdQIxSuCjEAL2qbIX0n67g5ZVggMHRo=;
	b=CQFRGP7rUZOFLAem3/o/IulvQbj5Ja12vQ8TPTyauPpB74NNst2ZPh53q+oCZrBohxbm6C
	tZn2V0t+HlAt8bBA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Move is_rwsem_reader_owned() and
 rwsem_owner() under CONFIG_DEBUG_RWSEMS
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240909182905.161156-1-longman@redhat.com>
References: <20240909182905.161156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604917670.2215.16033363773535605001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d00b83d416e73bc3fa4d21b14bec920e88b70ce6
Gitweb:        https://git.kernel.org/tip/d00b83d416e73bc3fa4d21b14bec920e88b70ce6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 09 Sep 2024 14:29:05 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 12:02:33 +02:00

locking/rwsem: Move is_rwsem_reader_owned() and rwsem_owner() under CONFIG_DEBUG_RWSEMS

Both is_rwsem_reader_owned() and rwsem_owner() are currently only used when
CONFIG_DEBUG_RWSEMS is defined. This causes a compilation error with clang
when `make W=1` and CONFIG_WERROR=y:

kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
  187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
      |                    ^~~~~~~~~~~~~~~~~~~~~
kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
  271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
      |                                   ^~~~~~~~~~~

Fix this by moving these two functions under the CONFIG_DEBUG_RWSEMS define.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240909182905.161156-1-longman@redhat.com
---
 kernel/locking/rwsem.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 33cac79..4b041e9 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -181,12 +181,21 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 	__rwsem_set_reader_owned(sem, current);
 }
 
+#ifdef CONFIG_DEBUG_RWSEMS
+/*
+ * Return just the real task structure pointer of the owner
+ */
+static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
+{
+	return (struct task_struct *)
+		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
+}
+
 /*
  * Return true if the rwsem is owned by a reader.
  */
 static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 {
-#ifdef CONFIG_DEBUG_RWSEMS
 	/*
 	 * Check the count to see if it is write-locked.
 	 */
@@ -194,11 +203,9 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 
 	if (count & RWSEM_WRITER_MASK)
 		return false;
-#endif
 	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
 }
 
-#ifdef CONFIG_DEBUG_RWSEMS
 /*
  * With CONFIG_DEBUG_RWSEMS configured, it will make sure that if there
  * is a task pointer in owner of a reader-owned rwsem, it will be the
@@ -266,15 +273,6 @@ static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
 }
 
 /*
- * Return just the real task structure pointer of the owner
- */
-static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
-{
-	return (struct task_struct *)
-		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
-}
-
-/*
  * Return the real task structure pointer of the owner and the embedded
  * flags in the owner. pflags must be non-NULL.
  */

