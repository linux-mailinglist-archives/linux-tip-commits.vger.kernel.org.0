Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464E35B4F2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhDKNo1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhDKNoH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:07 -0400
Date:   Sun, 11 Apr 2021 13:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gYjMVYtwu/ILfMH4BR0WTCWHbGcFdo13jy157ARNEMs=;
        b=JuIKFCjcodp2EJSDmWx/FH7ILdhFSHzYU69N09QcZpXoFxQwU/ga0OxxZG2vvIbTH/MIzz
        GKLmS5IkyEyVQhFQASpAaBXj/8jHVN+GxIInz84y/o55jeA0XFeiNNG947oVqQad3Uvlpd
        FIvzM6zg5BnA+6oUwZfyMi5r25Jytas/q1rMoYlM9UgLwcyp+tv7OPEp05749WJ4nK+5Cw
        NHEST9RPzkbf2UZ7IMDGUkv/bJMH1cnrSdu8Xb12/5F3V1+lMPn5lj75K8WvDAT7ff0nPv
        JUbBNI//a9NeBHL3zRDa2M2OxeVZasIVxbumb9bGOYd80jj30+yvY240dOQfSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gYjMVYtwu/ILfMH4BR0WTCWHbGcFdo13jy157ARNEMs=;
        b=pRuTtdZTudav7O5sHbNnm7eqdEev3v+JsaMi8a9gGjruzvuOgA4tQP/1Ecyh8tX0HDhG1I
        H/5HB+SH6o3SDdAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make jitter.sh handle large systems
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861450.29796.11179417291697971339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8126c57f00cea3502a017b7c76df1fac58f89e88
Gitweb:        https://git.kernel.org/tip/8126c57f00cea3502a017b7c76df1fac58f89e88
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 10 Feb 2021 13:25:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:21:41 -08:00

torture: Make jitter.sh handle large systems

The current jitter.sh script expects cpumask bits to fit into whatever
the awk interpreter uses for an integer, which clearly does not hold for
even medium-sized systems these days.  This means that on a large system,
only the first 32 or 64 CPUs (depending) are subjected to jitter.sh
CPU-time perturbations.  This commit therefore computes a given CPU's
cpumask using text manipulation rather than arithmetic shifts.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 188b864..3a856ec 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -67,10 +67,10 @@ do
 		srand(n + me + systime());
 		ncpus = split(cpus, ca);
 		curcpu = ca[int(rand() * ncpus + 1)];
-		mask = lshift(1, curcpu);
-		if (mask + 0 <= 0)
-			mask = 1;
-		printf("%#x\n", mask);
+		z = "";
+		for (i = 1; 4 * i <= curcpu; i++)
+			z = z "0";
+		print "0x" 2 ^ (curcpu % 4) z;
 	}' < /dev/null`
 	n=$(($n+1))
 	if ! taskset -p $cpumask $$ > /dev/null 2>&1
