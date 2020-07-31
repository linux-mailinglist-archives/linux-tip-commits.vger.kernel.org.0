Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF6234341
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgGaJ3P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:29:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbgGaJWm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:42 -0400
Date:   Fri, 31 Jul 2020 09:22:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fu66TyA1dYXuLUOCo/8m0OO2+QQ9CFKDHM/TlCFA4ek=;
        b=B3KBwR+Vn85pssKblKC7UZO97O25EgN2OORjrygmYEHzohAjuPVuVeG72tNcQbku2b4Lmu
        5YG8qPUtZVeQXuVyaYx8NyS2yG9RCHyrk82KK9t6zAijvAVQSEGWfj+oIDR8gSdEqPHwaE
        0jL3Mll2XNgKzYtmoaVfwZQJ1gvBGOQSDV+ThwRip33YDdIf6FZHZogI3fHfnIVg//e4Xx
        Q0Iij9IMeJYWuBHOOMYn4UM09EUtCPWWD5bbWB7xMzTHo9yNhyyZ81RxdIrbw6k5VgeYoD
        C9YVbz7fUOEfQzA6GX1Yy9t7qrhMtrFkg7nvRLJSJL7BsnNiGb5h0Q5KaflGUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fu66TyA1dYXuLUOCo/8m0OO2+QQ9CFKDHM/TlCFA4ek=;
        b=iKWLMfXntdBXq9u+50cmvG/ndPTxxzNSuHql0vREczZsvpfpxCRYpYwBhOOp+QBTwr0iaD
        mAdGhyyA0ge2IPCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Improve diagnostic for KCSAN-incapable compilers
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735883.4006.6144823697055482816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     61b77be09e29e6dc152b1984691e5b1708e8a6ac
Gitweb:        https://git.kernel.org/tip/61b77be09e29e6dc152b1984691e5b1708e8a6ac
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 10:38:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Improve diagnostic for KCSAN-incapable compilers

Using --kcsan when the compiler does not support KCSAN results in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16

This is a bit obtuse, so this commit adds checks resulting in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Compiler or architecture does not support KCSAN!
Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 357899c..840a467 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -44,7 +44,8 @@ do
 			then
 				echo QEMU killed
 			fi
-			configcheck.sh $i/.config $i/ConfigFragment
+			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
+			cat $T
 			if test -r $i/Make.oldconfig.err
 			then
 				cat $i/Make.oldconfig.err
@@ -73,7 +74,11 @@ do
 	done
 	if test -f "$rd/kcsan.sum"
 	then
-		if test -s "$rd/kcsan.sum"
+		if grep -q CONFIG_KCSAN=y $T
+		then
+			echo "Compiler or architecture does not support KCSAN!"
+			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
+		elif test -s "$rd/kcsan.sum"
 		then
 			echo KCSAN summary in $rd/kcsan.sum
 		else
