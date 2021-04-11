Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607AE35B51C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhDKNpM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbhDKNo1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:27 -0400
Date:   Sun, 11 Apr 2021 13:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9eDNbk3H2QTyqCLqkl/NQyaNsCi0ZcamzDzlAGlJwAU=;
        b=stTyGSN5Ch6v99BU80q7OMZWfpkngR+1xoeIQXXsNfYawCl2M42C++iqrJwDtbLhqpgzwE
        g8n0Z6Jl1UjFlN1rH4URUsEFVSWBYN6nV3iB/8E5pUnhgRNSAFFkRbyRCpqMIRNYCP90Ic
        lQ1LFRl36UAOgG8nig04FbSEDqmjn4kvmHZ2Z2iUwUCtZC+ChmVNlRLzK0DMnkoRL9Q7l0
        jT4m7KyB0Bs/GW64EAGF4EqnG6XiIcDStbTSkXo98zf+RRw+sf8rmvwZIbfQr2qXSGHtC9
        2MjbcezkbO+memqoZ5KBim9yvqc/WqkejX2Rs49/7HiR+iYEl95waqixI46N5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9eDNbk3H2QTyqCLqkl/NQyaNsCi0ZcamzDzlAGlJwAU=;
        b=Vz/25/FrEiJDRGjwbwr9DKI26v41NqS6jubPl9Er9A3++T+IriXsMJOzk/40HHYSVpZeyp
        2giIo+PoTJsDxxBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Use "all" and "N" in "nohz_full" and "rcu_nocbs"
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862353.29796.11793516362582086662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c71c39b344f7eec9d4492913f22126b03bb7b746
Gitweb:        https://git.kernel.org/tip/c71c39b344f7eec9d4492913f22126b03bb7b746
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 21 Jan 2021 15:56:53 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

rcutorture: Use "all" and "N" in "nohz_full" and "rcu_nocbs"

This commit uses the shiny new "all" and "N" cpumask options to decouple
the "nohz_full" and "rcu_nocbs" kernel boot parameters in the TREE04.boot
and TREE08.boot files from the CONFIG_NR_CPUS options in the TREE04 and
TREE08 files.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index 5adc675..a8d94ca 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutree.rcu_fanout_leaf=4 nohz_full=1-7
+rcutree.rcu_fanout_leaf=4 nohz_full=1-N
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 22478fd..94d3844 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,3 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
-rcu_nocbs=0-7
+rcu_nocbs=all
