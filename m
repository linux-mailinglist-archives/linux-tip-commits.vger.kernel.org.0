Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D75319EF2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhBLMnr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhBLMmH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:42:07 -0500
Date:   Fri, 12 Feb 2021 12:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Ax3oof5dpSQbAOJ+jcIqJq5RJwbjuqj8AQNYLEEvBI=;
        b=ACQVGLgu4ZR1/mUhAqu9sw5KKck8+8prbO6JRziFuCJ2B9nkXjOJycsjXPvMnHSUi0lYSU
        Z2EvA+81nNlQ4aT6xqtHrGZk45Nd+YtqkoGQwl8ivsOhDumxVneZnDEe1yjuTabwynLXPf
        1zxsh9fF2J806h+fSwYmrkoASYlGXXlQNDb/nsEq4i1r2oX5I5vnMahHG0Swcq5M6C0sjC
        DEZju6sQmyBQShW3qeeMNoIX3US9Md6+HE8koITs4sj4Zd5p/nqoC9u0mHYnXTB3uuv9Tv
        aJbwErGJfmSjFeJ1A8+tGwEQ3pm1DDXeJA7HmOa97wIYj3KM1cgFsFLdqWEyiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Ax3oof5dpSQbAOJ+jcIqJq5RJwbjuqj8AQNYLEEvBI=;
        b=PcLpmq3c3/Hpg8cDpqCuO4UEIMvQBWY2K9E5HbDOm95rAfVbtunAnA61fd7NpI5tWmehBW
        pEGAZ2mnXTlkMTDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Simplify exit-code plumbing for
 kvm-recheck.sh and kvm-find-errors.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344521.23325.3827869966474352940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     365dc5cb62c8714e27554e44464f6e0e9c1fdbdf
Gitweb:        https://git.kernel.org/tip/365dc5cb62c8714e27554e44464f6e0e9c1fdbdf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 20 Dec 2020 16:52:29 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:24 -08:00

torture: Simplify exit-code plumbing for kvm-recheck.sh and kvm-find-errors.sh

This commit simplifies exit-code plumbing.  It makes kvm-recheck.sh return
the value 1 for a build error and 2 for a runtime error.  It also makes
kvm-find-errors.sh avoid checking runtime files for --build-only runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 1 +
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index be26598..0670841 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -46,6 +46,7 @@ fi
 if grep -q -e "--buildonly" < ${rundir}/log
 then
 	echo Build-only run, no console logs to check.
+	exit $editorret
 fi
 
 # Find console logs with errors
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 840a467..47cf4db 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -87,15 +87,16 @@ do
 	fi
 done
 EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
-ret=$?
 builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
 if test "$builderrors" -gt 0
 then
 	echo $builderrors runs with build errors.
+	ret=1
 fi
 runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
 if test "$runerrors" -gt 0
 then
 	echo $runerrors runs with runtime errors.
+	ret=2
 fi
 exit $ret
