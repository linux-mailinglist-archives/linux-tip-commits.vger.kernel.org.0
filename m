Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A500B2D8F9D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbgLMTCb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389226AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D1C061285;
        Sun, 13 Dec 2020 11:01:06 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zR80Psi9+dk3trXcieVnZ9atAyP5/MXYjAlf50qgcZU=;
        b=jY3jSo0GieO1dM/wZYqVzCnJAfhyCO/Z4RF6Q93OBZnPCgPCzaFOdKUmVDnxIHXHACUrOO
        gynecL2e0TtH5ifxzlNFikzPjHPjwJFO6qo1KLc7ekkOwMz0zeW1bsxSGFEBSb76IbyysA
        gY0cLf8YnLExrzfBtAg0SpHxzINrcy8nqpBdxDGwUtgCQ+6z2m9ikIBgEZscSjt/1WKn8f
        X/tUxfSmNMm9UnIqR6BnG7t2RZCL0+oEVsP/luxp6O4DGsbQQBpjDll77L9RzhbLLg5pGi
        UMg9fWOZ2P0BpJvd+thZa4+ZN5pfTZQT7f4MZY0pMHbNPDjqrF8qyLgXy1EdQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zR80Psi9+dk3trXcieVnZ9atAyP5/MXYjAlf50qgcZU=;
        b=shOq4GpR4M4foX6ENSGJH8wf6V69d7IC0kyYC36CHAN14fvQCi3ALix8VxHZwtTPQLVY12
        l5BF38zsOwb+cGAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Label MP tests' producers and consumers
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606400.3364.7268549375683971734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b6ff30849ca723b78306514246b98ca5645d92f5
Gitweb:        https://git.kernel.org/tip/b6ff30849ca723b78306514246b98ca5645d92f5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Nov 2020 13:39:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:25:17 -08:00

tools/memory-model: Label MP tests' producers and consumers

This commit adds comments that label the MP tests' producer and consumer
processes, and also that label the "exists" clause as the bad outcome.

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus | 6 +++---
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus              | 6 +++---
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus      | 6 +++---
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus        | 6 +++---
 tools/memory-model/litmus-tests/MP+polocks.litmus                           | 6 +++---
 tools/memory-model/litmus-tests/MP+poonceonces.litmus                       | 6 +++---
 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus       | 6 +++---
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                        | 6 +++---
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index f15e501..c5c168d 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -13,14 +13,14 @@ C MP+fencewmbonceonce+fencermbonceonce
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	smp_wmb();
 	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -30,4 +30,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index ed8ee9b..20ff626 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -15,13 +15,13 @@ C MP+onceassign+derefonce
 	int y=0;
 }
 
-P0(int *x, int **p)
+P0(int *x, int **p) // Producer
 {
 	WRITE_ONCE(*x, 1);
 	rcu_assign_pointer(*p, x);
 }
 
-P1(int *x, int **p)
+P1(int *x, int **p) // Consumer
 {
 	int *r0;
 	int r1;
@@ -32,4 +32,4 @@ P1(int *x, int **p)
 	rcu_read_unlock();
 }
 
-exists (1:r0=x /\ 1:r1=0)
+exists (1:r0=x /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index b1b1266..153917a 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -15,7 +15,7 @@ C MP+polockmbonce+poacquiresilsil
 	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	smp_mb__after_spinlock();
@@ -23,7 +23,7 @@ P0(spinlock_t *lo, int *x)
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -34,4 +34,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index 867c75d..aad6439 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -15,14 +15,14 @@ C MP+polockonce+poacquiresilsil
 	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	WRITE_ONCE(*x, 1);
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -33,4 +33,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 4b0c2ed..21cbca6 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -17,7 +17,7 @@ C MP+polocks
 	int flag;
 }
 
-P0(int *buf, int *flag, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	spin_lock(mylock);
@@ -25,7 +25,7 @@ P0(int *buf, int *flag, spinlock_t *mylock)
 	spin_unlock(mylock);
 }
 
-P1(int *buf, int *flag, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
@@ -36,4 +36,4 @@ P1(int *buf, int *flag, spinlock_t *mylock)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 3010bba..9f9769d 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -12,13 +12,13 @@ C MP+poonceonces
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -27,4 +27,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index 21e825d..cbe28e7 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -13,13 +13,13 @@ C MP+pooncerelease+poacquireonce
 	int flag;
 }
 
-P0(int *buf, int *flag)
+P0(int *buf, int *flag) // Producer
 {
 	WRITE_ONCE(*buf, 1);
 	smp_store_release(flag, 1);
 }
 
-P1(int *buf, int *flag)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
@@ -28,4 +28,4 @@ P1(int *buf, int *flag)
 	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 9691d55..012041b 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -17,7 +17,7 @@ C MP+porevlocks
 	int flag;
 }
 
-P0(int *buf, int *flag, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
@@ -28,7 +28,7 @@ P0(int *buf, int *flag, spinlock_t *mylock)
 	spin_unlock(mylock);
 }
 
-P1(int *buf, int *flag, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
 	spin_lock(mylock);
 	WRITE_ONCE(*buf, 1);
@@ -36,4 +36,4 @@ P1(int *buf, int *flag, spinlock_t *mylock)
 	WRITE_ONCE(*flag, 1);
 }
 
-exists (0:r0=1 /\ 0:r1=0)
+exists (0:r0=1 /\ 0:r1=0) (* Bad outcome. *)
