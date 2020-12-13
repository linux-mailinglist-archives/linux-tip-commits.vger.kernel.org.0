Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489682D9005
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgLMTVO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbgLMTC3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F594C061257;
        Sun, 13 Dec 2020 11:01:06 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qOfOdK3L+SQFJnDXb6wCZq5Vtt00bKDsFSkweJTLLLY=;
        b=GEa/NygCpSVfXogtFvWQkCtfKRNJ0M1/FTsiX44czVjUQ1zFksJ0ac8lNUPlVzkrqUhj7E
        EO5NOq8CKeDFgMTe4EZVOEdu76+amUm7kVRst7A04ph2VpDfgLxlC0gXBmEDQIXeWr0wYi
        KN9PMwZfWPk6UwM/NBn8ZVHvRqJLCt2xXWaL0xcQZ2uqh2G390LyOjmOIabZ6lLuGmNctd
        26YtfCxh0OCrH1YaQLXgDfGIeHyQ/qFifPnk2ZKk3dF5oPyB9XQ4lZ2fOd/EhHD5oCWqRM
        QwEWoJrDtEygnEQ/aZW7xLnDrxi9FGBmsiHMDryzC8TCPHGhbQAlS7n++s95xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qOfOdK3L+SQFJnDXb6wCZq5Vtt00bKDsFSkweJTLLLY=;
        b=A+LUcSV07/HAAiN8gXKV46Iap21i116BjzyBnfgDEebdH1FWOJ2uuCx4CFotfLCLBIKiTD
        OtEbDQES1OPCbTAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Add types to litmus tests
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606463.3364.17138726900606745313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1947bfcf81a905e84a58b423063e81034a90efed
Gitweb:        https://git.kernel.org/tip/1947bfcf81a905e84a58b423063e81034a90efed
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Nov 2020 13:20:56 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:25:16 -08:00

tools/memory-model: Add types to litmus tests

This commit adds type information for global variables in the litmus
tests in order to allow easier use with klitmus7.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                                | 4 +++-
 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                                | 4 +++-
 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                                | 4 +++-
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                     | 4 +++-
 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      | 5 ++++-
 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                           | 5 ++++-
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 | 7 ++++++-
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                    | 6 +++++-
 tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus   | 6 +++++-
 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     | 5 ++++-
 tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                      | 5 ++++-
 tools/memory-model/litmus-tests/LB+poonceonces.litmus                                      | 5 ++++-
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                | 5 ++++-
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                             | 5 +++--
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus                     | 2 ++
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus                       | 2 ++
 tools/memory-model/litmus-tests/MP+polocks.litmus                                          | 6 +++++-
 tools/memory-model/litmus-tests/MP+poonceonces.litmus                                      | 5 ++++-
 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                      | 5 ++++-
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                                       | 6 +++++-
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus                                  | 5 ++++-
 tools/memory-model/litmus-tests/R+poonceonces.litmus                                       | 5 ++++-
 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    | 5 ++++-
 tools/memory-model/litmus-tests/S+poonceonces.litmus                                       | 5 ++++-
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus                                 | 5 ++++-
 tools/memory-model/litmus-tests/SB+poonceonces.litmus                                      | 5 ++++-
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus                          | 5 ++++-
 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                                | 5 ++++-
 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             | 5 ++++-
 tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus                 | 7 ++++++-
 tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus                 | 7 ++++++-
 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus | 6 +++++-
 32 files changed, 130 insertions(+), 31 deletions(-)

diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 967f9f2..772544f 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoRR+poonceonce+Once
  * reads from the same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index 4635739..5faae98 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoRW+poonceonce+Once
  * a given variable and a later write to that same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index bb068c9..77c9cc9 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoWR+poonceonce+Once
  * given variable and a later read from that same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 0d9f0a9..85ef746 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -7,7 +7,9 @@ C CoWW+poonceonce
  * writes to the same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index e729d27..87aa900 100644
--- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -10,7 +10,10 @@ C IRIW+fencembonceonces+OnceOnce
  * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index 4b54dd6..f84022d 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -10,7 +10,10 @@ C IRIW+poonceonces+OnceOnce
  * different process?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 094d58d..398f624 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -7,7 +7,12 @@ C ISA2+pooncelock+pooncelock+pombonce
  * (in P0() and P1()) is visible to external process P2().
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index b321aa6..212a432 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -9,7 +9,11 @@ C ISA2+poonceonces
  * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 025b046..7afd856 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -11,7 +11,11 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
  * (AKA non-rf) link, so release-acquire is all that is needed.
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index 4727f5a..c8a93c7 100644
--- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -11,7 +11,10 @@ C LB+fencembonceonce+ctrlonceonce
  * another control dependency and order would still be maintained.)
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 07b9904..2fa0295 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -8,7 +8,10 @@ C LB+poacquireonce+pooncerelease
  * to the other?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index 74c49cb..2107306 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -7,7 +7,10 @@ C LB+poonceonces
  * be prevented even with no explicit ordering?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index a273da9..e04b71b 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -8,7 +8,10 @@ C MP+fencewmbonceonce+fencermbonceonce
  * is usually better to use smp_store_release() and smp_load_acquire().
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 97731b4..18df682 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,8 +10,9 @@ C MP+onceassign+derefonce
  *)
 
 {
-y=z;
-z=0;
+	int x;
+	int *y=z;
+	int z=0;
 }
 
 P0(int *x, int **y)
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index 50f4d62..b1b1266 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -11,6 +11,8 @@ C MP+polockmbonce+poacquiresilsil
  *)
 
 {
+	spinlock_t lo;
+	int x;
 }
 
 P0(spinlock_t *lo, int *x)
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index abf81e7..867c75d 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -11,6 +11,8 @@ C MP+polockonce+poacquiresilsil
  *)
 
 {
+	spinlock_t lo;
+	int x;
 }
 
 P0(spinlock_t *lo, int *x)
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 712a4fc..63e0f67 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -11,7 +11,11 @@ C MP+polocks
  * to see all prior accesses by those other CPUs.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 172f014..68180a4 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -7,7 +7,10 @@ C MP+poonceonces
  * no ordering at all?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index d52c684..19f3e68 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -8,7 +8,10 @@ C MP+pooncerelease+poacquireonce
  * pattern.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 72c9276..4ac189a 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -11,7 +11,11 @@ C MP+porevlocks
  * see all prior accesses by those other CPUs.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index 222a0b8..af9463b 100644
--- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -9,7 +9,10 @@ C R+fencembonceonces
  * cause the resulting test to be allowed.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index 5386f12..bcd5574 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -8,7 +8,10 @@ C R+poonceonces
  * store propagation delays.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index 1847982..c36341d 100644
--- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -7,7 +7,10 @@ C S+fencewmbonceonce+poacquireonce
  * store against a subsequent store?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index 8c9c2f8..7775c23 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -9,7 +9,10 @@ C S+poonceonces
  * READ_ONCE(), is ordering preserved?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index ed5fff1..833cdfe 100644
--- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -9,7 +9,10 @@ C SB+fencembonceonces
  * suffice, but not much else.)
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index 10d5507..c92211e 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -8,7 +8,10 @@ C SB+poonceonces
  * variable that the preceding process reads.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
index 04a1660..84344b4 100644
--- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -6,7 +6,10 @@ C SB+rfionceonce-poonceonces
  * This litmus test demonstrates that LKMM is not fully multicopy atomic.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index 6a2bc12..4314947 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -8,7 +8,10 @@ C WRC+poonceonces+Once
  * test has no ordering at all.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index e994725..554999c 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -10,7 +10,10 @@ C WRC+pooncerelease+fencermbonceonce+Once
  * is A-cumulative in LKMM.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 415248f..265a95f 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -9,7 +9,12 @@ C Z6.0+pooncelock+poonceLock+pombonce
  * by CPUs not holding that lock.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index 10a2aa0..0c9aea8 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -8,7 +8,12 @@ C Z6.0+pooncelock+pooncelock+pombonce
  * seen as ordered by a third process not holding that lock.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index 88e70b8..661f9aa 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -14,7 +14,11 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
  * involving locking.)
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
