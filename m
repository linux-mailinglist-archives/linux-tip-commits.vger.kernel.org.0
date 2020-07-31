Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00C234275
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgGaJXA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbgGaJW7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:59 -0400
Date:   Fri, 31 Jul 2020 09:22:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FzxS+fEegb83AG4bqFpLRRBshGDZX82PElp8btP3H3k=;
        b=N/ESqh/151SF6m9tjDc4+t+vCfbyikOtLeHDQpsJQ3j91js6+BgdX/d1/FwDJza6qe6rpk
        7VP+xiyOosJ5q8VWGKejq7asSGhLw1TieG3OjFHG8ZOICDe9il9vlPZiOMnM4hvNGalmz8
        aWH6s0afRqsDgA09ppkzWOjzcat5TI60w+o1ix5rHAKU6EAdgc/DdrT+fKDrgTX0jeVfrK
        yupUqHxmjBdRPeSUN05K1cqXfmZ2hdXxhBGFTVxdCDSRdaR9jflrPdpsh8o0By5k1kROB6
        VMg2+GgoDG3dqcW8v1xZmSq1xytccw3TWrxs3zVsHRgyutJambMqvV5M/uqKPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FzxS+fEegb83AG4bqFpLRRBshGDZX82PElp8btP3H3k=;
        b=P2xfv/FdXCxFmeyqHuesbXwJo+79bdrXGbGCixOVe+V+S7PDX8lFFd6MFQrPlB6g/r2KQS
        EYM7eN197eaCIRAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Adjust refperf.loop default value
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737725.4006.2622764186928228387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4dd72a338a07486823037a6b45334d05192c913a
Gitweb:        https://git.kernel.org/tip/4dd72a338a07486823037a6b45334d05192c913a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 29 May 2020 13:11:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Adjust refperf.loop default value

With the various measurement optimizations, 10,000 loops normally
suffices.  This commit therefore reduces the refperf.loops default value
from 10,000,000 to 10,000.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 57a750b..063eeb0 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -61,7 +61,7 @@ torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
-torture_param(long, loops, 10000000, "Number of loops per experiment.");
+torture_param(long, loops, 10000, "Number of loops per experiment.");
 // Number of readers, with -1 defaulting to about 75% of the CPUs.
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
