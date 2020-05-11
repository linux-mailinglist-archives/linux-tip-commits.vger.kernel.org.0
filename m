Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B11CE6FB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgEKU7V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 16:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730215AbgEKU7U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 16:59:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E3C061A0E;
        Mon, 11 May 2020 13:59:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWA-0005gR-NO; Mon, 11 May 2020 22:59:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5312C1C04CC;
        Mon, 11 May 2020 22:59:18 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:18 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Right-size TREE10 CPU consumption
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075827.390.6532991687416116899.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     df5916845dd6ee34ce40aaad5e7b61058720419c
Gitweb:        https://git.kernel.org/tip/df5916845dd6ee34ce40aaad5e7b61058720419c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 30 Mar 2020 10:42:30 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:28 -07:00

rcutorture: Right-size TREE10 CPU consumption

The number of CPUs is tuned to allow "4*CFLIST TREE10" on a large system,
up from "3*CFLIST TREE10" previously.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 2debe78..7311f84 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=100
+CONFIG_NR_CPUS=56
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
