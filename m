Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB23319EA4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBLMjg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBLMiP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:15 -0500
Date:   Fri, 12 Feb 2021 12:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZgfyXo2MHosBGjdx9i+KVNfUdsnQEBhMOi7tivy8/7k=;
        b=emVamKJSfqp9n6HtY1dSdsufpVh8DpkTyu6KFYhJNB0dRGEC8dYMVzQ4OmnlPyGLkrnPpJ
        ZkUegjhWOuSQJFEgWNm5ylLh+x8qNFT70ma5iOY9XwS8XsU0Ku2ZuJzV+fzKoBsPbdYSBL
        74vXtesaDpY7ZwjUoJl0CmHq6+OOFkBHxDxJ1t99uv4Qs+0hg5w+E2GLheduz/RtxufTVn
        P7KJyekcdPEB+xPb6EFH4He/gwg9/vSf6MOoc5CLa/XvSf4YRLET7sSfX/+PKI8d8SzA1C
        PoBeDjZY/iyLjjCoFSG60qHNVf6Ry/84fXc22Ka1bXsjcyh1deS0BBBthWsldA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZgfyXo2MHosBGjdx9i+KVNfUdsnQEBhMOi7tivy8/7k=;
        b=dz2DXBD1jZ/5Bv61H8qm4n5mRbYGZhr4zKeuFH2seK62wmbNKDYo/5V66lIUhg1Ygp26j6
        +hDbdOA1wnG/JIBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Auto-size SCF and scaling runs based on
 number of CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343403.23325.18052330917575439477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     69d2b33e3f2077c57c20a3b718931746cb3a6094
Gitweb:        https://git.kernel.org/tip/69d2b33e3f2077c57c20a3b718931746cb3a6094
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 12:42:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:41 -08:00

torture: Auto-size SCF and scaling runs based on number of CPUs

This commit improves torture.sh flexibility by autoscaling the number
of CPUs to be used in variable-CPUs torture tests, including scftorture,
refscale, rcuscale, and kvfree.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 19 ++++++++------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 57f2f31..e13dacf 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -19,6 +19,11 @@ PATH=${KVM}/bin:$PATH; export PATH
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 MAKE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS*2))
+HALF_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS/2))
+if test "$HALF_ALLOTED_CPUS" -lt 1
+then
+	HALF_ALLOTED_CPUS=1
+fi
 
 # Default duration and apportionment.
 duration_base=10
@@ -291,8 +296,8 @@ fi
 
 if test "$do_scftorture" = "yes"
 then
-	torture_bootargs="scftorture.nthreads=224 torture.disable_onoff_at_boot"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 if test "$do_refscale" = yes
@@ -303,8 +308,8 @@ else
 fi
 for prim in $primlist
 do
-	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
@@ -315,14 +320,14 @@ else
 fi
 for prim in $primlist
 do
-	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 done
 
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 echo " --- " $scriptname $args
