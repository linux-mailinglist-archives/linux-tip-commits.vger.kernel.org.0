Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8928827A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgJIGhX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbgJIGfg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:36 -0400
Date:   Fri, 09 Oct 2020 06:35:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vlqniB9P8mnJmdkAZprpDa0ytPMd1k/rCCjE/mSx+wc=;
        b=zVQibXHKj88daXbUx62rVr1DENgdA+RWUXX4EzQruQgEB4evILWYVYnXR79nfr0ETR91RI
        Laupjiqe1IImlB8rhkOHGFVgJtVeKDuKeESkqGlWdZRManr60v0YAdB+fM3bimR/rpSqsQ
        zZAtpKaUGjldBBB1zigA1hHtmV0jRF2tsBiVx+rGsKzShTmdquuMXhSCq1Xz6tITP+L3Q9
        JLCZx9pzRNIBfKSXlbcnciMc0XUgNUGMfzEFyz1ermHGo3MeBLcn+yBFs91MOmsQ40JUGu
        7kvU3mgQTkhV8q9WBf3Wgq/oU8BrM2NISAqoKTtguQjRATdnxGTFurw0a77EPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vlqniB9P8mnJmdkAZprpDa0ytPMd1k/rCCjE/mSx+wc=;
        b=v8OgTd8N1pnCXSngNBmrfTXO9fd+JIYPDBye3X4ZGNOgTgxIAuuS0GCQcK21oqb0aMejEC
        GGxhVHUQRTD7yIAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add scftorture to the rcutorture scripting
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533253.7002.16684720028511939729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     80c9476e683ec37ba45fd8e6a5c5081bea207e1a
Gitweb:        https://git.kernel.org/tip/80c9476e683ec37ba45fd8e6a5c5081bea207e1a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 24 Jun 2020 17:57:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:32 -07:00

torture: Add scftorture to the rcutorture scripting

This commit updates the rcutorture scripting to include the new scftorture
torture-test module.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh       | 38 ++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh                   |  2 +-
 tools/testing/selftests/rcutorture/configs/scf/CFLIST           |  2 ++
 tools/testing/selftests/rcutorture/configs/scf/CFcommon         |  2 ++
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT        |  9 +++++++++
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot   |  1 +
 tools/testing/selftests/rcutorture/configs/scf/PREEMPT          |  9 +++++++++
 tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh | 30 ++++++++++++++++++++++++++++++
 8 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
new file mode 100755
index 0000000..671bfee
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for rcutorture progress.
+#
+# Usage: kvm-recheck-rcu.sh resdir
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+i="$1"
+if test -d "$i" -a -r "$i"
+then
+	:
+else
+	echo Unreadable results directory: $i
+	exit 1
+fi
+. functions.sh
+
+configfile=`echo $i | sed -e 's/^.*\///'`
+nscfs="`grep 'scf_invoked_count ver:' $i/console.log 2> /dev/null | tail -1 | sed -e 's/^.* scf_invoked_count ver: //' -e 's/ .*$//' | tr -d '\015'`"
+if test -z "$nscfs"
+then
+	echo "$configfile ------- "
+else
+	dur="`sed -e 's/^.* scftorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`"
+	if test -z "$dur"
+	then
+		rate=""
+	else
+		nscfss=`awk -v nscfs=$nscfs -v dur=$dur '
+			BEGIN { print nscfs / dur }' < /dev/null`
+		rate=" ($nscfss/s)"
+	fi
+	echo "${configfile} ------- ${nscfs} SCF handler invocations$rate"
+fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e655983..44dfdd9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -184,7 +184,7 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
 		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
diff --git a/tools/testing/selftests/rcutorture/configs/scf/CFLIST b/tools/testing/selftests/rcutorture/configs/scf/CFLIST
new file mode 100644
index 0000000..4d62eb4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/CFLIST
@@ -0,0 +1,2 @@
+NOPREEMPT
+PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/scf/CFcommon b/tools/testing/selftests/rcutorture/configs/scf/CFcommon
new file mode 100644
index 0000000..c11ab91
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_SCF_TORTURE_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
new file mode 100644
index 0000000..b8429d6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -0,0 +1,9 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=n
+CONFIG_NO_HZ_FULL=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
new file mode 100644
index 0000000..d6a7fa0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
@@ -0,0 +1 @@
+nohz_full=1
diff --git a/tools/testing/selftests/rcutorture/configs/scf/PREEMPT b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
new file mode 100644
index 0000000..ae4992b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
@@ -0,0 +1,9 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
diff --git a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
new file mode 100644
index 0000000..d3d9e35
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Torture-suite-dependent shell functions for the rest of the scripts.
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+# scftorture_param_onoff bootparam-string config-file
+#
+# Adds onoff scftorture module parameters to kernels having it.
+scftorture_param_onoff () {
+	if ! bootparam_hotplug_cpu "$1" && configfrag_hotplug_cpu "$2"
+	then
+		echo CPU-hotplug kernel, adding scftorture onoff. 1>&2
+		echo scftorture.onoff_interval=1000 scftorture.onoff_holdoff=30
+	fi
+}
+
+# per_version_boot_params bootparam-string config-file seconds
+#
+# Adds per-version torture-module parameters to kernels supporting them.
+per_version_boot_params () {
+	echo $1 `scftorture_param_onoff "$1" "$2"` \
+		scftorture.stat_interval=15 \
+		scftorture.shutdown_secs=$3 \
+		scftorture.verbose=1 \
+		scf
+}
