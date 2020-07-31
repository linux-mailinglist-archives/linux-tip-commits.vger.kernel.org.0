Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFE23430D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgGaJXC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbgGaJXC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:02 -0400
Date:   Fri, 31 Jul 2020 09:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b5WJ0mvOdCZdtKkOsooSfaGTJNRJMDtkglvtIPqRY0E=;
        b=mld1EZw6w8P34EWhNnhk4AZwuKXmqZSl0zL0pRilyvu07J5PcZI5r+qjFXnR2mbS9iwvQc
        FR3IBwRE0aRbKSRvlt2rHYXxDqP8oQfk2f81N6t6KRdiiqeD51M1fDj22qsvDeWpInzxF6
        eqWr45A+n4iHqKLLdA1ZXFd4/898TNk0Pllt0pvKgZU5cy5oaWZ6pGKteXXolHKYkhvlLr
        yv+DS2IcEgEwwaVWN5vzdOjUFTqvDk3ufV1sVuRAuOyZwYc7XMzl5+KdTF4ZId53wyk0/S
        P/TfAixNs7FPGTrHTrS+Vra+Ou+nhWKFAxRrcfDu7mDnHD9sZnYOAiV6UY76xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b5WJ0mvOdCZdtKkOsooSfaGTJNRJMDtkglvtIPqRY0E=;
        b=IcqQMp3etqvo+Dg7Hd9x3oVqGV6WRouAayepioRX01R5+FejjfBeaXushscnoBoMpXTBZa
        vIYB85EuACxgEMAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Label experiment-number column "Runs"
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737986.4006.5105626828965823787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6efb06340846c788336f402e3a472a24fabb431e
Gitweb:        https://git.kernel.org/tip/6efb06340846c788336f402e3a472a24fabb431e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 14:26:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Label experiment-number column "Runs"

The experiment-number column is currently labeled "Threads", which is
misleading at best.  This commit therefore relabels it as "Runs", and
adjusts the scripts accordingly.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c                                          | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 445190b..2d2d227 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -415,7 +415,7 @@ static int main_func(void *arg)
 
 	buf[0] = 0;
 	strcat(buf, "\n");
-	strcat(buf, "Threads\tTime(ns)\n");
+	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
 		if (errexit)
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
index 6fc06cd..0660f3f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -24,7 +24,7 @@ configfile=`echo $i | sed -e 's/^.*\///'`
 
 sed -e 's/^\[[^]]*]//' < $i/console.log | tr -d '\015' |
 awk -v configfile="$configfile" '
-/^[ 	]*Threads	Time\(ns\) *$/ {
+/^[ 	]*Runs	Time\(ns\) *$/ {
 	if (dataphase + 0 == 0) {
 		dataphase = 1;
 		# print configfile, $0;
