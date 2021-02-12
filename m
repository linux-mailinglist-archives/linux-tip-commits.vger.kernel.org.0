Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23A319EBB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBLMkc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhBLMjB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:01 -0500
Date:   Fri, 12 Feb 2021 12:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=es7YbVHh4UtMqrMQrj9l6FT2NCYGRYFN/+hhZCk/xLU=;
        b=nTS3qkgD0HzWtBrdTgTS31uudx6CELSMrggVd+RdVvaoO7VrnIEFbByeGvEGppVBVveJTI
        IOWT3J6q9K916cSW2QgT6ZdQleDEhKxZNhgdhYyfjetcS3qDtfOJ9zQUaQOKPBb1kKNOxI
        mpPsDq3mkqQb+DW2AADIdFD5kOn3wX8LUeES+t27V3f0OLI4Rc03F1N12YcmvtGzzPAihI
        Hj71RawFVx52s39JJqUYAAnj1ju1vy+8GTqQGTIQQQ3u/T1btFJVt9he1eVJMjAPGEWOsF
        cEO2gewYNXg02YDZJBhs96NWyzoJo3S8QIkTEI1XscBfo6yDnIpTRinHYeVOEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=es7YbVHh4UtMqrMQrj9l6FT2NCYGRYFN/+hhZCk/xLU=;
        b=Go/klFEiyBvlx7dlH9I5wZ1ukSevlI8QfsC9JGxDR4Ro+lHHczfJnS6/5pdOth+Q0HFPsm
        WKkL+Z6jJ1WkpyBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/rcutorture: Support nocb toggle in TREE01
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343662.23325.12090314384518642598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     70e8088b97211177225acf499247b3741cc8a229
Gitweb:        https://git.kernel.org/tip/70e8088b97211177225acf499247b3741cc8a229
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:29 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

tools/rcutorture: Support nocb toggle in TREE01

This commit adds periodic toggling of 7 of 8 CPUs every second to TREE01
in order to test NOCB toggle code.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index d6da9a6..40af3df 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -2,5 +2,7 @@ maxcpus=8 nr_cpus=43
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
-rcu_nocbs=0
+rcu_nocbs=0-1,3-7
+rcutorture.nocbs_nthreads=8
+rcutorture.nocbs_toggle=1000
 rcutorture.fwd_progress=0
