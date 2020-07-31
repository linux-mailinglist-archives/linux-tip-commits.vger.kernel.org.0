Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9923426C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgGaJWu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:22:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgGaJWs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:48 -0400
Date:   Fri, 31 Jul 2020 09:22:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jBoOhsEWZoLYOhA8Q7IrkGTmWoGwlT/jzq9cCnTUnDQ=;
        b=WoSq6Ify/ORF/ebLcYT8pwSU4jh2aX7esytsLYTYnFTn2KZibnOuEfXfBJoR1xm3XxTZ8L
        VRonMjFEf2ATyzIOUF7QfoOCVIoQeUrb9yVZKbSnDFhj/s+Pa2141eFBHqu3WNVMVoG/Vk
        e2m66iuWT0u6Agc1JDlL4GzM5VZevaOZxm9/UWb1757s+3dwPhgaQR5gqhFVzGEW+IeF47
        J+jIyd6EUkSWhYCcjBm5yDOiKVwFeK7dlGa67DGg5uw7BPHEtu78f0hYzkIgvh6ME+N6pd
        x6dpSz/qrgJdoFswQt6/GxsQM6qafpa/My3CfJe+xPJCwlR5HHrOHYMmHOb3Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jBoOhsEWZoLYOhA8Q7IrkGTmWoGwlT/jzq9cCnTUnDQ=;
        b=S5AsXXPgf4bGvq3zab1A8dVTEoOPqSbEfI/BPm/6qzzgOL2YfgyUEWkj4u3lqnYVZpcCWB
        2SKyAIOt6a7Uj7Cg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Set configfile variable to current scenario
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736668.4006.10295126204104607934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     61251d6899803594a108c3165aeb072c73e09cc8
Gitweb:        https://git.kernel.org/tip/61251d6899803594a108c3165aeb072c73e09cc8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 26 Apr 2020 16:48:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Set configfile variable to current scenario

The torture-test recheck logic fails to set the configfile variable to
the current scenario, so this commit properly initializes this variable.
This change isn't critical given that all errors for a given scenario
follow that scenario's heading, but it is easier on the eyes to repeat it.
And this repetition also prevents confusion as to whether a given message
goes with the previous heading or the next one.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 736f047..2261aa6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -31,6 +31,7 @@ do
 			head -1 $resdir/log
 		fi
 		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
