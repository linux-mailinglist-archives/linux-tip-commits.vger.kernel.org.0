Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022582882BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgJIGja (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbgJIGfQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:16 -0400
Date:   Fri, 09 Oct 2020 06:35:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=asd0KrTKSDxwIQMdHeW7AX76ynTzDaiSLlENDd72vJA=;
        b=1hCy6PX52sWzHfWpJ6UREfcGu4Euw8CV/NIv3pfvvtPAqNVprq1N1qrlCkSPnS9zsVQFVw
        AZqeGwjcgMmcHykRI6yE0tkhcO6SnUIvLYWnSsXjbiEqbLsbM56jeIZxt3jvv+kRefM5Ub
        wpEDpWn9weO5+TV/8J2UvKiNNSlBia+pHH/m8yxBakhuAEItHQHkZ6+pHDRTkieG/bQfF7
        miM2g52xaYoEScOoTmbnA9GSIyIpkP5MiqoVxotW15LXF8ZpgP3Atds+wnPz8FjPQULoPx
        jcFaslPR/RD/gH9476ixvOMY21SQmMAczob0a/NW/K1+kTtuHRPFSZ/cf7M8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=asd0KrTKSDxwIQMdHeW7AX76ynTzDaiSLlENDd72vJA=;
        b=W0F5+hqT0L0MoV/A4cU1ikKrf8gcuw0IiiVjjfEj6A5PbBkD3UYL48qi2jcqvJQ/NEb29O
        mM2lK4yk6Ck+SFDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add kvm.sh --help and update help message
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531341.7002.18057789555792205484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5461808889405de254ab3370aa7f07ac0b6cb938
Gitweb:        https://git.kernel.org/tip/5461808889405de254ab3370aa7f07ac0b6cb938
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 19 Jul 2020 12:17:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:34 -07:00

torture: Add kvm.sh --help and update help message

This commit adds a --help argument (along with its synonym -h) to display
the help text.  While in the area, this commit also updates the help text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0a08463..fc15b52 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -56,17 +56,18 @@ usage () {
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
 	echo "       --duration minutes"
+	echo "       --help"
 	echo "       --interactive"
 	echo "       --jitter N [ maxsleep (us) [ maxspin (us) ] ]"
 	echo "       --kconfig Kconfig-options"
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
-	echo "       --memory megabytes | nnnG"
+	echo "       --memory megabytes|nnnG"
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --results absolute-pathname"
-	echo "       --torture rcu"
+	echo "       --torture lock|rcu|rcuperf|refscale|scf"
 	echo "       --trust-make"
 	exit 1
 }
@@ -127,6 +128,9 @@ do
 		dur=$(($2*60))
 		shift
 		;;
+	--help|-h)
+		usage
+		;;
 	--interactive)
 		TORTURE_QEMU_INTERACTIVE=1; export TORTURE_QEMU_INTERACTIVE
 		;;
