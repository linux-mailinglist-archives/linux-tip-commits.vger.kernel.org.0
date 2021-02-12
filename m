Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57163319E99
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBLMi4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBLMhz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:55 -0500
Date:   Fri, 12 Feb 2021 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=moW0f5K46Gf7gX3aCXxtwPelP2KXbb3oFxNVQIAfDEE=;
        b=j5G1zvrpyz8wst0Sm07gRzj5uQXldJgBa/uOw7QfGWTvCFJiZ0vR3zwHkcZBCAp2tya0y0
        Ovdi1cYgalV9yh1FUGu6pEdnE+27nK6jklEt311Mw9KwZaN2Ex1q+uTKxFt5oxgy7k5Saw
        vpKiqtKUTOEjk+HZZpJrg4trYdvkUTbYHAWezdfPh17ocbHU+p+F5PtydOoXjsNlUzFufz
        ijwz1oB8DWkocm/3zGL7Bm+j6c8m9d1vOEVFvcHE+CWg0eZMApsyelXStT+9qukrJ65nN4
        EHjTTpfmtVssxXZBptK9paPSXCPfd5p6xQO8wsakMGGsjpwaWXgK0ALYv7cihA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=moW0f5K46Gf7gX3aCXxtwPelP2KXbb3oFxNVQIAfDEE=;
        b=iEVZMlinFiIrnp8UjCU4xbrdaMwfAg08QSOT68a+T26a157YsRDjPSim/r2OYSCnFrbF1d
        oIBsJtu5fSIYesBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow scenarios to be specified to torture.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343182.23325.8042404972059642303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8847bd4988321cbc66c94e9dfb05b401c50378a3
Gitweb:        https://git.kernel.org/tip/8847bd4988321cbc66c94e9dfb05b401c50378a3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 27 Nov 2020 08:31:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:45 -08:00

torture: Allow scenarios to be specified to torture.sh

This commit adds --configs-rcutorture, --configs-locktorture, and
--configs-scftorture arguments to torture.sh, allowing the desired
set of scenarios to be passed to each.  The default for each has been
changed from a large-system-appropriate set to just CFLIST for each.
Users are encouraged to create scripts that provide appropriate settings
for their specific systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 46 +++++++++++++-
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index cf74123..f614011 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -30,6 +30,11 @@ then
 	VERBOSE_BATCH_CPUS=0
 fi
 
+# Configurations/scenarios.
+configs_rcutorture=
+configs_locktorture=
+configs_scftorture=
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -59,6 +64,9 @@ function doyesno () {
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
+	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
+	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
 	echo "       --doall"
 	echo "       --doallmodconfig / --do-no-allmodconfig"
 	echo "       --do-kasan / --do-no-kasan"
@@ -77,6 +85,21 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--config-rcutorture|--configs-rcutorture)
+		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_rcutorture="$configs_rcutorture $2"
+		shift
+		;;
+	--config-locktorture|--configs-locktorture)
+		checkarg --configs-locktorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_locktorture="$configs_locktorture $2"
+		shift
+		;;
+	--config-scftorture|--configs-scftorture)
+		checkarg --configs-scftorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_scftorture="$configs_scftorture $2"
+		shift
+		;;
 	--doall)
 		do_allmodconfig=yes
 		do_rcutorture=yes
@@ -155,18 +178,35 @@ T=/tmp/torture.sh.$$
 trap 'rm -rf $T' 0 2
 mkdir $T
 
+# Calculate rcutorture defaults and apportion time
+if test -z "$configs_rcutorture"
+then
+	configs_rcutorture=CFLIST
+fi
 duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
 if test "$duration_rcutorture" -eq 0
 then
 	echo " --- Zero time for rcutorture, disabling" | tee -a $T/log
 	do_rcutorture=no
 fi
+
+# Calculate locktorture defaults and apportion time
+if test -z "$configs_locktorture"
+then
+	configs_locktorture=CFLIST
+fi
 duration_locktorture=$((duration_base*duration_locktorture_frac/10))
 if test "$duration_locktorture" -eq 0
 then
 	echo " --- Zero time for locktorture, disabling" | tee -a $T/log
 	do_locktorture=no
 fi
+
+# Calculate scftorture defaults and apportion time
+if test -z "$configs_scftorture"
+then
+	configs_scftorture=CFLIST
+fi
 duration_scftorture=$((duration_base*duration_scftorture_frac/10))
 if test "$duration_scftorture" -eq 0
 then
@@ -268,19 +308,19 @@ fi
 if test "$do_rcutorture" = "yes"
 then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
-	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE10 4*CFLIST" --trust-make
+	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
 then
 	torture_bootargs="torture.disable_onoff_at_boot"
-	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "14*CFLIST" --trust-make
+	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "$configs_locktorture" --trust-make
 fi
 
 if test "$do_scftorture" = "yes"
 then
 	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 if test "$do_refscale" = yes
