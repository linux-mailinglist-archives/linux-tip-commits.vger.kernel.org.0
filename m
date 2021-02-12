Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D8319F03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBLMpZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhBLMnQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE4C061797;
        Fri, 12 Feb 2021 04:42:36 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2bxd8MdjChiH87wIV6KkFE3kirbgKgYs755vzmaPrXI=;
        b=Dl7B9AYBih9ZTIjJW2yPk0vNIDAa5meNt21TAXoCvCcGMISm+AQdsRPxtBzEdc1OYxRFYg
        J8aoTsB4BZ4ByityTAORhuDM35WZtLr4Te7qJUJN8CiATKUb02Dsxx//eS7ySWPe6olXWs
        uO5Pa94PFmuVeX0lXa/a1T2S77hmZeNke8BLjdT8K61gdmaWfIzG8wXwSwnTocj1QHEKoV
        jx1FsjdB21dzpypeHQSUT0iDyvQj10hObcvoCJ0FUbm9aJ+ragMAtbhF5VwoJ1Zl5Ieiap
        ALULAxaDymVuNmqg7fK6R/N92lTWbpf7FnI/xxLMCQ4YDdsLWMxdRC6w7eRtgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2bxd8MdjChiH87wIV6KkFE3kirbgKgYs755vzmaPrXI=;
        b=xE/IXeoDWHMezXXJQC2YYJiW8yjS4jE0kbDXDTDXlIgl2uNVwkQX3SsxIi+g1INDl7Ufu+
        JyhBhG6L2JRGe/Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow kvm.sh --datestamp to specify subdirectories
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344846.23325.5662520996330678799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bc4073587067f2128b422f260fedd9fe0a8f7c4e
Gitweb:        https://git.kernel.org/tip/bc4073587067f2128b422f260fedd9fe0a8f7c4e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Nov 2020 11:09:17 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:19 -08:00

torture: Allow kvm.sh --datestamp to specify subdirectories

Scripts like kvm-check-branches.sh group runs under a single directory
in resdir in order to allow easier retrospective analysis.  However, they
do this by letting kvm.sh create a directory as usual and then moving it
after the run.  This can be very confusing when looking at the results
while kvm-check-branches.sh is running.  This commit therefore enables
--datestamp to hand subdirectories to kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 55a18a9..0a9211a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -113,7 +113,7 @@ do
 		shift
 		;;
 	--datestamp)
-		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[^/]*$' '^--'
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._-/]*$' '^--'
 		ds=$2
 		shift
 		;;
@@ -375,7 +375,7 @@ if ! test -e $resdir
 then
 	mkdir -p "$resdir" || :
 fi
-mkdir $resdir/$ds
+mkdir -p $resdir/$ds
 TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
 TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
