Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31B2D8FF5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgLMTCi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389306AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B64C061248;
        Sun, 13 Dec 2020 11:01:06 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SSgOtCsFqpdejyn9bl0aNytKW34T2msHnnHTDF52Rkg=;
        b=gy6K408bsve8W9kUXNEugCckuTHfyHyb0w0qhajqqoOG14CK/7Gv0XFbMUDyYndppa4dNK
        MwP3bLTmyTwTHV/FzXWrrtACCgAcDgFgC23O16Efo8O6B6LLcNrU0ZgqvwX3SdxALOBk2C
        58HMOcKfPzdd/CCCvwcrlGqQJlOsJHU9N/K5FN2djxoXmoxbbcPh9Gf2mWBzf+elC/+6jc
        3k3s6Mc6ZX8na9vp7Nv4Hp/BM2TR9Oe8mH2B5l62RqXZ/UbegwWKwdfjyr4XJxAg8JQ9hK
        b+oOD+P5KWEGzyAqiouhyY2oPkQm3QBOOKvv6amNsXkOzpiPThGx+IlRpvzKDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SSgOtCsFqpdejyn9bl0aNytKW34T2msHnnHTDF52Rkg=;
        b=YxhMC4fOf11sYUPTxrrj7nsLdeo9k76Z2DEKgNjEDbYdPI2rqY5fH+yGMgoFEnaif+kzrX
        JeSdrKmzXj6nxUCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Use "buf" and "flag" for
 message-passing tests
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606435.3364.14056121916857447067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     acc4bdc55dcb7d7fe0be736999572a55e121873f
Gitweb:        https://git.kernel.org/tip/acc4bdc55dcb7d7fe0be736999572a55e121873f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Nov 2020 13:30:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:25:16 -08:00

tools/memory-model: Use "buf" and "flag" for message-passing tests

The use of "x" and "y" for message-passing tests is fine for people
familiar with memory models and litmus-test nomenclature, but is a bit
obtuse for others.  This commit therefore substitutes "buf" for "x" and
"flag" for "y" for the MP tests.  There are a few special-case MP tests
that use locks and these are unchanged.  There is another MP test that
uses pointers, and this is changed to name the pointer "p".

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus              | 12 ++++++------
 tools/memory-model/litmus-tests/MP+polocks.litmus                           | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+poonceonces.litmus                       | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus       | 16 ++++++++--------
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                        | 16 ++++++++--------
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index e04b71b..f15e501 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -9,25 +9,25 @@ C MP+fencewmbonceonce+fencermbonceonce
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	smp_wmb();
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	smp_rmb();
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 18df682..ed8ee9b 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,24 +10,24 @@ C MP+onceassign+derefonce
  *)
 
 {
+	int *p=y;
 	int x;
-	int *y=z;
-	int z=0;
+	int y=0;
 }
 
-P0(int *x, int **y)
+P0(int *x, int **p)
 {
 	WRITE_ONCE(*x, 1);
-	rcu_assign_pointer(*y, x);
+	rcu_assign_pointer(*p, x);
 }
 
-P1(int *x, int **y)
+P1(int *x, int **p)
 {
 	int *r0;
 	int r1;
 
 	rcu_read_lock();
-	r0 = rcu_dereference(*y);
+	r0 = rcu_dereference(*p);
 	r1 = READ_ONCE(*r0);
 	rcu_read_unlock();
 }
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 63e0f67..4b0c2ed 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -13,27 +13,27 @@ C MP+polocks
 
 {
 	spinlock_t mylock;
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock)
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_lock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock)
 {
 	int r0;
 	int r1;
 
 	spin_lock(mylock);
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_unlock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 68180a4..3010bba 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -8,23 +8,23 @@ C MP+poonceonces
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*buf, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
-	r1 = READ_ONCE(*x);
+	r0 = READ_ONCE(*flag);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index 19f3e68..21e825d 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -9,23 +9,23 @@ C MP+pooncerelease+poacquireonce
  *)
 
 {
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y)
+P0(int *buf, int *flag)
 {
-	WRITE_ONCE(*x, 1);
-	smp_store_release(y, 1);
+	WRITE_ONCE(*buf, 1);
+	smp_store_release(flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag)
 {
 	int r0;
 	int r1;
 
-	r0 = smp_load_acquire(y);
-	r1 = READ_ONCE(*x);
+	r0 = smp_load_acquire(flag);
+	r1 = READ_ONCE(*buf);
 }
 
 exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 4ac189a..9691d55 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -13,27 +13,27 @@ C MP+porevlocks
 
 {
 	spinlock_t mylock;
-	int x;
-	int y;
+	int buf;
+	int flag;
 }
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock)
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_lock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock)
 {
 	spin_lock(mylock);
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_unlock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
 exists (0:r0=1 /\ 0:r1=0)
