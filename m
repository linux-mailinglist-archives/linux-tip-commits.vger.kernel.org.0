Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C293319F02
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBLMpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhBLMnP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:15 -0500
Date:   Fri, 12 Feb 2021 12:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jD9t7zzUWzwdEW085G3lUKMgKZPtdv1OS+ADV5st9t0=;
        b=pAvOou4OoY936MeuncO7P5ZcszymTADxpUzwWI1truIhxkwScaFPxfWpB+nKQ0nkaRRyue
        r7aSAs+oN6CfmbUPtXDEOFQcAIq9z2zJNQgrYyvIR2EAAnxIrAPn6QxCo97T9b4lAHl0rY
        i3FeGnlm3Ry5bh9EiSWLqbfMTaPp7wwfc6KkioJ2ioUn/TVDi1sZkksqga+iCmIOO3vAWp
        eorQ/nhUZnI60Vev53IU/vcXTxMRh/gid72dfglQJCKzk4CKKVXHzgf7miPyUZY4EKAOnx
        rp33ACjIW86T2LE1qYIgUKbZei2YlJ1vm+U6VlJPRwEUPx8l4CYnEJXFjktpmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jD9t7zzUWzwdEW085G3lUKMgKZPtdv1OS+ADV5st9t0=;
        b=ZVWysIbHupK3loe+Gno0Bm8cvehEo6UxQZKWs0y+1BbIp2fwdyKOBdW0mZbQtsoxud3b/t
        +tLiaMwz2IL3GXCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh arguments accumulate
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344715.23325.14924811106429496411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     452613719eeea36de8ab13388a704fccb9d572dd
Gitweb:        https://git.kernel.org/tip/452613719eeea36de8ab13388a704fccb9d572dd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 20 Nov 2020 20:09:55 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:21 -08:00

torture: Make kvm.sh arguments accumulate

Given that kvm.sh in invoked from scripts, it is only natural for
different levels of scripting to provide their own Kconfig option values,
for example.  Unfortunately, right now, the last such argument on the
command line wins.

This commit therefore makes the --bootargs, --configs, --kconfigs,
--kmake-args, and --qemu-args argument values accumulate.  For example,
where "--configs TREE01 --configs TREE02" would previously have run only
scenario TREE02, now it will run both scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c8356d5..6fd7ef7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -85,7 +85,7 @@ do
 		;;
 	--bootargs|--bootarg)
 		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
-		TORTURE_BOOTARGS="$2"
+		TORTURE_BOOTARGS="$TORTURE_BOOTARGS $2"
 		shift
 		;;
 	--bootimage)
@@ -97,8 +97,8 @@ do
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
-		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]*$' '^--'
-		configs="$2"
+		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs="$configs $2"
 		shift
 		;;
 	--cpus)
@@ -162,7 +162,7 @@ do
 		;;
 	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
-		TORTURE_KCONFIG_ARG="$2"
+		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--kasan)
@@ -173,7 +173,7 @@ do
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-		TORTURE_KMAKE_ARG="$2"
+		TORTURE_KMAKE_ARG="`echo "$TORTURE_KMAKE_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--mac)
@@ -191,7 +191,7 @@ do
 		;;
 	--qemu-args|--qemu-arg)
 		checkarg --qemu-args "(qemu arguments)" $# "$2" '^-' '^error'
-		TORTURE_QEMU_ARG="$2"
+		TORTURE_QEMU_ARG="`echo "$TORTURE_QEMU_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--qemu-cmd)
