Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22E31BBA1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBOO5e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBOO5I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B83C06121D;
        Mon, 15 Feb 2021 06:55:49 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MxKvaSUApfwKbW8/5xPx1DyewACqSMC6MYWumJd9TUU=;
        b=I18zItnSf+kHkPzxKRvlQ2bv00iZ2cDWU267c/leCCeiBRvhB877/i8jA8GhWSHM343Afn
        xxg+W9todvPRPQheXTNr0B+ZX0dOwz4fGUa22xBqGLEsyHWQePeyI7uUMmXhT8GkjbF49F
        aE2rmAYcSBS7EMWUzibDdg8nKChIwluzV/9eVSbWAOE9wvrIJWZPwKOMePnBeh8HCCU4MI
        Hzi210xjllD9irqn7Cq+pPX2XNNmkrTPOvDTGXGrj+zSvNVzxXGDRK1wVmqKjqoRETjxa1
        lU47kIGB9GQhyhNUCROHQXr/L2qFCIZnFEFMYcblq9tNe4jKlwNIH46rS161ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MxKvaSUApfwKbW8/5xPx1DyewACqSMC6MYWumJd9TUU=;
        b=LIykZ9kQ6UNC7fdWArC1k1JYohNqHHL+4pC3bEYiDyfgn+Lkhhi0o93RfaH6iZiHlpvlGe
        NduAj0Xqpj8UK/DQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay
 boot parameter
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094740.20312.2053972766807992089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2252ec1464730ce718dc8087c13a419b9aa58758
Gitweb:        https://git.kernel.org/tip/2252ec1464730ce718dc8087c13a419b9aa58758
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 10 Dec 2020 09:53:50 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:35:15 -08:00

doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter

This commit removes documentation for the rcutree.rcu_idle_lazy_gp_delay
kernel boot parameter given that this parameter no longer exists.

Fixes: 77a40f97030b ("rcu: Remove kfree_rcu() special casing and lazy-callback handling")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..b5baa8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4179,12 +4179,6 @@
 			Set wakeup interval for idle CPUs that have
 			RCU callbacks (RCU_FAST_NO_HZ=y).
 
-	rcutree.rcu_idle_lazy_gp_delay= [KNL]
-			Set wakeup interval for idle CPUs that have
-			only "lazy" RCU callbacks (RCU_FAST_NO_HZ=y).
-			Lazy RCU callbacks are those which RCU can
-			prove do nothing more than free memory.
-
 	rcutree.rcu_kick_kthreads= [KNL]
 			Cause the grace-period kthread to get an extra
 			wake_up() if it sleeps three times longer than
