Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3754319EB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBLMkP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhBLMig (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:36 -0500
Date:   Fri, 12 Feb 2021 12:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N/0Yfbpw1zHkTFuW2JQBoHQ7ddD5mbQa0bWXgfEjvqg=;
        b=Gw7GgntTopehqy3U8AeZOa9GNI3CRCRRW45ZJMkloqG0HDu2kNBd1KwbyfYEw180yQOnXD
        OAQ2ekLnCNUa3Jy671LkoEupQCB+vync1Lh4Lh9jHHa/F/MrtDTCVTJA/s4oJV5eeuwm9N
        2LI9o3tpG1xzrEFaVxJX82K1WdHjPi7j1Uef4pjeMfnr8nO1RglzWKhgOBvbK+0blCjrXf
        o1ylLwX2e2IcftZglhKfjbTVBnQQsGXEFdBBPKgd3k0fZkANqT2OmEbICZVibNrNiycbNA
        oKHdpcOleBhnq9rtWI/Rz4xk70bPfIRerQmRUggPh6qjzH4uhC344tXF7zmdfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N/0Yfbpw1zHkTFuW2JQBoHQ7ddD5mbQa0bWXgfEjvqg=;
        b=xEFfcN5baxQR6sHo/VUc6rfgHHWAnXFBAFfgx06c8tmdngPVldzFrC7e9JzctNB+kHuBAp
        A2gsf/1sDdw+PjDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh use common time-duration
 bash functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343482.23325.159300005773488089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1adb5d6b52251105f77630432b36e340cdcb3390
Gitweb:        https://git.kernel.org/tip/1adb5d6b52251105f77630432b36e340cdcb3390
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Nov 2020 16:49:15 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:37 -08:00

torture: Make torture.sh use common time-duration bash functions

This commit makes torture.sh use the new bash functions get_starttime()
and get_starttime_duration() created for kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 20 ++++----------
 1 file changed, 7 insertions(+), 13 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/torture.sh

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
old mode 100644
new mode 100755
index 7f21aab..1657404
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -13,6 +13,10 @@
 scriptname=$0
 args="$*"
 
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -172,7 +176,7 @@ touch $T/successes
 
 ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
 startdate="`date`"
-starttime="`awk 'BEGIN { print systime() }' < /dev/null`"
+starttime="`get_starttime`"
 
 # tortureme flavor command
 # Note that "flavor" is an arbitrary string.  Supply --torture if needed.
@@ -274,17 +278,7 @@ then
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	ret=2
 fi
-duration="`awk -v starttime=$starttime '
-BEGIN {
-	s = systime() - starttime;
-	h = s / 3600;
-	d = h /24;
-	if (d < 1)
-		print h " hours";
-	else
-		print d " days (" h " hours)";
-}' < /dev/null`"
-echo Started at $startdate, ended at `date`, duration $duration. | tee -a $T/log
+echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
 if test -n "$tdir"
@@ -293,9 +287,9 @@ then
 fi
 exit $ret
 
+# @@@
 # RCU CPU stall warnings?
 # scftorture warnings?
 # Need a way for the invoker to specify clang.
 # Work out --configs based on number of available CPUs?
-# Need a way to specify --configs.  --configs--rcutorture?
 # Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
