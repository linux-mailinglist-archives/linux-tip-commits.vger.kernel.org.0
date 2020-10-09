Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAB288252
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgJIGgP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732095AbgJIGfr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4AC0613DA;
        Thu,  8 Oct 2020 23:35:47 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o+2nKPALB09+ENj0/ROj95qVVzLNDAUp4gLCwOHdCoA=;
        b=njyZumDw5au2+t07vuNcgAkMtU2e6YC/QHKSzXRpCHjEyEbsax2SfMjiYrydpgj+a9+Lnw
        Uj0+C7ol3nu+e+baH2O/eZpYdIAlzehbWExSoD56/bzMzq0uc2A8BKWEhuBUZkAUDg5d9+
        oFpDncO+RS3asknccqI1oL+NyIbOhI+64P330uAh9lmYEcj4QWYImt1uFjhc+vQ4j7MC+F
        otyiEoa/kI7C5JwUqCUKGtYhXvTO2E39w3jRWJ9dQFP+z0aWIxLL0ty0E87G+ABGJryDAC
        +oU6zC0aUOAwDg30owg5QZ9R47BeCrR4gKhQKaj1Kax0bLXWLxuRmR0iqtB8rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o+2nKPALB09+ENj0/ROj95qVVzLNDAUp4gLCwOHdCoA=;
        b=iXlVwR4lu3XjSzwiSBs/HNBZXSOwqAmTybCewH8S4uoqEAmgg+JeR08Jt4zff+FnbEn/nB
        Rdm2WSSLMeP9RwCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove KCSAN stubs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534504.7002.9408001842038253829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ebc3505d507cf0aafdc31e4b2359c9b22b3927c8
Gitweb:        https://git.kernel.org/tip/ebc3505d507cf0aafdc31e4b2359c9b22b3927c8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Jun 2020 13:25:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:02 -07:00

rcu: Remove KCSAN stubs

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..eb36779 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -70,19 +70,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcutree."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 /* Data structures. */
 
 /*
