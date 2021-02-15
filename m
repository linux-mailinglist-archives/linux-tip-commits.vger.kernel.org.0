Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2531BBA8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBOO5t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhBOO5R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A34C061226;
        Mon, 15 Feb 2021 06:55:56 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=09iQPBwzlLLR9xeEuR/9HMWcPUX84d2SdcHCgy8GgoU=;
        b=CZyfBKECnDGVsADapokXWcdisKj/haC5slv/qP60Z8xhxNO6GNOZ98DoN/c75rTGvXIvPW
        g/vRIvxCN9hjVjCP43f2b0HyzX0BF6LO0XGQLpftMg7RNodlMiGqpcRTe1ZCg2oZA6u+pw
        SK3oV0HkyFviU/5Meh7SYgbst/yRdIfI2iI8Z28Vh3n3z+e0O1/26JPmb+OGv5kVE2lX8i
        BxUpsWAGKzpckH6GNJgkObWxpD3xGXQB9/7sso0UsPK1itPohQARe4NXheV6/gkd7shNo4
        NqPd5cuiet/YQVi2Zg0zoUNevCbb4n/XSNSBlz4zbaUB1P3RCLvzobPvHDiV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=09iQPBwzlLLR9xeEuR/9HMWcPUX84d2SdcHCgy8GgoU=;
        b=tzozV6YfxztG+dt4RXw68eEPQkYqniLootI0+0PTDu1MpKFBH0ggtfjp2ztSV0YuslYV4q
        9GeX/iZwySJ2KNBA==
From:   "tip-bot2 for Akira Yokosawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Remove redundant
 initialization in litmus tests
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340095504.20312.4764775522085337042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5c587f9b9c35850f9da3c425f98dc53ab1cde9f3
Gitweb:        https://git.kernel.org/tip/5c587f9b9c35850f9da3c425f98dc53ab1cde9f3
Author:        Akira Yokosawa <akiyks@gmail.com>
AuthorDate:    Sat, 28 Nov 2020 08:43:45 +09:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:40:49 -08:00

tools/memory-model: Remove redundant initialization in litmus tests

This is a revert of commit 1947bfcf81a9 ("tools/memory-model: Add types
to litmus tests") with conflict resolutions.

klitmus7 [1] is aware of default types of "int" and "int*".
It accepts litmus tests for herd7 without extra type info unless
non-"int" variables are referenced by an "exists", "locations",
or "filter" directive.

[1]: Tested with klitmus7 versions 7.49 or later.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                                | 4 +---
 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                                | 4 +---
 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                                | 4 +---
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                     | 4 +---
 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      | 5 +----
 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                           | 5 +----
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 | 7 +------
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                    | 6 +-----
 tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus   | 6 +-----
 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     | 5 +----
 tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                      | 5 +----
 tools/memory-model/litmus-tests/LB+poonceonces.litmus                                      | 5 +----
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                | 5 +----
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                             | 4 +---
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus                     | 5 +----
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus                       | 5 +----
 tools/memory-model/litmus-tests/MP+polocks.litmus                                          | 6 +-----
 tools/memory-model/litmus-tests/MP+poonceonces.litmus                                      | 5 +----
 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                      | 5 +----
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                                       | 6 +-----
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus                                  | 5 +----
 tools/memory-model/litmus-tests/R+poonceonces.litmus                                       | 5 +----
 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    | 5 +----
 tools/memory-model/litmus-tests/S+poonceonces.litmus                                       | 5 +----
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus                                 | 5 +----
 tools/memory-model/litmus-tests/SB+poonceonces.litmus                                      | 5 +----
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus                          | 5 +----
 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                                | 5 +----
 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             | 5 +----
 tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus                 | 7 +------
 tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus                 | 7 +------
 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus | 6 +-----
 32 files changed, 32 insertions(+), 134 deletions(-)

diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 772544f..967f9f2 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRR+poonceonce+Once
  * reads from the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index 5faae98..4635739 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRW+poonceonce+Once
  * a given variable and a later write to that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index 77c9cc9..bb068c9 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoWR+poonceonce+Once
  * given variable and a later read from that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 85ef746..0d9f0a9 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -7,9 +7,7 @@ C CoWW+poonceonce
  * writes to the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index 87aa900..e729d27 100644
--- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+fencembonceonces+OnceOnce
  * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index f84022d..4b54dd6 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+poonceonces+OnceOnce
  * different process?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 398f624..094d58d 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -7,12 +7,7 @@ C ISA2+pooncelock+pooncelock+pombonce
  * (in P0() and P1()) is visible to external process P2().
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index 212a432..b321aa6 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -9,11 +9,7 @@ C ISA2+poonceonces
  * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 7afd856..025b046 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -11,11 +11,7 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
  * (AKA non-rf) link, so release-acquire is all that is needed.
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index c8a93c7..4727f5a 100644
--- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -11,10 +11,7 @@ C LB+fencembonceonce+ctrlonceonce
  * another control dependency and order would still be maintained.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 2fa0295..07b9904 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -8,10 +8,7 @@ C LB+poacquireonce+pooncerelease
  * to the other?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index 2107306..74c49cb 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -7,10 +7,7 @@ C LB+poonceonces
  * be prevented even with no explicit ordering?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index c5c168d..f8ca122 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -8,10 +8,7 @@ C MP+fencewmbonceonce+fencermbonceonce
  * is usually better to use smp_store_release() and smp_load_acquire().
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 20ff626..d84160b 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,9 +10,7 @@ C MP+onceassign+derefonce
  *)
 
 {
-	int *p=y;
-	int x;
-	int y=0;
+p=y;
 }
 
 P0(int *x, int **p) // Producer
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index 153917a..ba91cc6 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockmbonce+poacquiresilsil
  * executed before the lock was acquired (loosely speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index aad6439..a5ea3ed 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockonce+poacquiresilsil
  * speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 21cbca6..e6af05f 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -11,11 +11,7 @@ C MP+polocks
  * to see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 9f9769d..ba9c99c 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -7,10 +7,7 @@ C MP+poonceonces
  * no ordering at all?
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index cbe28e7..f174bfe 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -8,10 +8,7 @@ C MP+pooncerelease+poacquireonce
  * pattern.
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 012041b..b959914 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -11,11 +11,7 @@ C MP+porevlocks
  * see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index af9463b..222a0b8 100644
--- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C R+fencembonceonces
  * cause the resulting test to be allowed.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index bcd5574..5386f12 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -8,10 +8,7 @@ C R+poonceonces
  * store propagation delays.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index c36341d..1847982 100644
--- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -7,10 +7,7 @@ C S+fencewmbonceonce+poacquireonce
  * store against a subsequent store?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index 7775c23..8c9c2f8 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -9,10 +9,7 @@ C S+poonceonces
  * READ_ONCE(), is ordering preserved?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index 833cdfe..ed5fff1 100644
--- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C SB+fencembonceonces
  * suffice, but not much else.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index c92211e..10d5507 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -8,10 +8,7 @@ C SB+poonceonces
  * variable that the preceding process reads.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
index 84344b4..04a1660 100644
--- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -6,10 +6,7 @@ C SB+rfionceonce-poonceonces
  * This litmus test demonstrates that LKMM is not fully multicopy atomic.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index 4314947..6a2bc12 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -8,10 +8,7 @@ C WRC+poonceonces+Once
  * test has no ordering at all.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index 554999c..e994725 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -10,10 +10,7 @@ C WRC+pooncerelease+fencermbonceonce+Once
  * is A-cumulative in LKMM.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 265a95f..415248f 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -9,12 +9,7 @@ C Z6.0+pooncelock+poonceLock+pombonce
  * by CPUs not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index 0c9aea8..10a2aa0 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -8,12 +8,7 @@ C Z6.0+pooncelock+pooncelock+pombonce
  * seen as ordered by a third process not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index 661f9aa..88e70b8 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -14,11 +14,7 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
  * involving locking.)
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
