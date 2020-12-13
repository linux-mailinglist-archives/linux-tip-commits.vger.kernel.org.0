Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6742D8FA6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392701AbgLMTDM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392433AbgLMTDI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9525C0611D0;
        Sun, 13 Dec 2020 11:01:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XAhY19PAJrwuXA0hTJgPEZ4cUIrKScXzJIZYlkgN0xc=;
        b=BVZwfigS8SVHBhomAS4v52Y/OUK7OcoBwBu+Du4bhrfAIMQC+Qy7bA1kgr/bPOaz5dRwMw
        WwtAazpjDGeCSEGmyIFdJFf6EDzf3iTyA0MeBgcRYOpibLBg1MOUG/i0YmVaTBY2PHrKV2
        ahhBjcwbfw72g+gJbCsdlIP8hO2vA/PlQ+QaValjUQ3upeTY5OhEfrfVQP9QKjirTl2D0j
        94+/yCBoXsUcBBPk4kgxfdVxOdIE4IynjCRHrSAa6dipH5edFRvMDNc3Nt556xExs42qBv
        MZl+su1lZdnnBEQG2+B9uSYOvY71U0vixoh61ZwBiQ3ISBYxpNRx2tYFthjAHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XAhY19PAJrwuXA0hTJgPEZ4cUIrKScXzJIZYlkgN0xc=;
        b=nkzFnbIiK0gmG69nqwUbMalyex/Q81bIThAug6ZYckDJCsKqHB5BV5cos1N5SLWoNLwDZg
        NOqwzT/GT6fmewCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow alternative forms of kvm.sh
 command-line arguments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606771.3364.14917703470958671269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a5136f4ffb44f8c1a80406c5bfd4d233433398e6
Gitweb:        https://git.kernel.org/tip/a5136f4ffb44f8c1a80406c5bfd4d233433398e6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 24 Sep 2020 08:52:33 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:55 -08:00

torture: Allow alternative forms of kvm.sh command-line arguments

This commit allows --build-only as a synonym for --buildonly, --kconfigs
for --kconfig, and --kmake-args for --kmake-arg.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c348d96..45d07b7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -93,7 +93,7 @@ do
 		TORTURE_BOOT_IMAGE="$2"
 		shift
 		;;
-	--buildonly)
+	--buildonly|--build-only)
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
@@ -160,7 +160,7 @@ do
 		jitter="$2"
 		shift
 		;;
-	--kconfig)
+	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="$2"
 		shift
@@ -171,7 +171,7 @@ do
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
-	--kmake-arg)
+	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		TORTURE_KMAKE_ARG="$2"
 		shift
