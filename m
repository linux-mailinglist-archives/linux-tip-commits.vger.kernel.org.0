Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1131BB9D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBOO5T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FBC0617AB;
        Mon, 15 Feb 2021 06:55:48 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SvZatWUFOlAE1MhuIj0oIwsUbxBX74zM4vcDThQQZFw=;
        b=c4rFW36uQxPk26VlRX7klQOk3wzx2rQ2HB7DztteIt16q5dL0ERnM1UGm9yYkVovdHVQLp
        y40jH166k2JMEFBFzKfkmfjpcewUO5E32AUEW5T1xz7421mJQroiO/zlXBJY/LTsaRmOQ9
        SoElWj0CHPEUruwdvRz8WXMn1cs9nt7tccArRiZUpN+DJbbHnBNVwXF2wstvUp3JzLQz+M
        zLT01vDzmg8JJfibqm2p5LEalygcFJTVc27WLtguOclgOX2ARTkG8YkFnwtjyC3amAcixn
        NUlDt+QEumhfrLsyLsI6Nwm8Rdg5LNMgy3vyKM0dal1AfhMn1KvS2yOBCi1w2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SvZatWUFOlAE1MhuIj0oIwsUbxBX74zM4vcDThQQZFw=;
        b=pI3Kwel8+nsHQpw1llXRLm4LFne0Ac5U5zcb9RAvIqQfncHQU2h0XUAC2vikgP6EzpWzaU
        6uB90CRRuBQEJpBw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Eliminate the __kvfree_rcu() macro
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094671.20312.5615708638923293514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5ea5d1ed572cb5ac173674fe770252253d2d9e27
Gitweb:        https://git.kernel.org/tip/5ea5d1ed572cb5ac173674fe770252253d2d9e27
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Fri, 20 Nov 2020 12:49:17 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:42:04 -08:00

rcu: Eliminate the __kvfree_rcu() macro

This commit open-codes the __kvfree_rcu() macro, thus saving a
few lines of code and improving readability.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b95373e..f1576cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -840,15 +840,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 #define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
-/*
- * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
- */
-#define __kvfree_rcu(head, offset) \
-	do { \
-		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
-		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
-	} while (0)
-
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr: pointer to kfree for both single- and double-argument invocations.
@@ -866,7 +857,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kvfree_rcu(). If this error is triggered, you can
+ * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -912,8 +903,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+	if (___p) {									\
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
+		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
+			(offsetof(typeof(*(ptr)), rhf)));				\
+	}										\
 } while (0)
 
 #define kvfree_rcu_arg_1(ptr)					\
