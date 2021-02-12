Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F583319E9A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBLMi6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhBLMhz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:55 -0500
Date:   Fri, 12 Feb 2021 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pPvF2ym1DpnhfzQlWEVdr1hew5dBg/JezY1TUrWraF8=;
        b=OBPwyNENubW3EdTVumpEkhmJaL+a/acjhPrephX1KSzQCmJGCBGZ7W5le7e0mPYXaw+UwY
        heCXB1V4Gk7zL8n+wSh3TaASA8EKHpx3yrgEzrSwawCMb0y6Kyo6uOkn7vGNQ/PbPRfkPg
        z/r93B93e53cZzW53oSq82iRIiOHAd/9HWt1EH+eYOkwOswhiZ6zk0tyScF6PkSt4hrPA6
        kUZE20n2cr6SJEw5uQS/2E04uVVXoUX4HQ8ZjVLUUqo6Hy6rD8qAg2rcHCnHXShh+I08B0
        xWqNFsSPUCdd3YWE+tc+WzEsv9hA09DmD2v0ZR/Mc0u6imxAC4VYu2yUF+mvWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pPvF2ym1DpnhfzQlWEVdr1hew5dBg/JezY1TUrWraF8=;
        b=gXtp+Yki5tmlaPZ1a7irwsiUmZT/tbUhgAMOHYsFfPPK8jquZ9d9wVWx/CD48TK2prfd0U
        zNE6O1HtMqV5z9BQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh refuse to do zero-length runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343231.23325.2309835893681538774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c679d90b21b76319b4a6c719442b6a1ff124b88d
Gitweb:        https://git.kernel.org/tip/c679d90b21b76319b4a6c719442b6a1ff124b88d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 26 Nov 2020 13:29:24 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:44 -08:00

torture: Make torture.sh refuse to do zero-length runs

This commit causes torture.sh to check for zero-length runs and to take
the cowardly option of refusing to run them, logging its cowardice for
later inspection.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 25 ++++++++++----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index f2f9140..43ef2c0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -151,16 +151,29 @@ do
 	shift
 done
 
-duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
-# Need to sum remaining weights, and if duration weights to zero,
-# set do_no_rcutorture. @@@
-duration_locktorture=$((duration_base*duration_locktorture_frac/10))
-duration_scftorture=$((duration_base*duration_scftorture_frac/10))
-
 T=/tmp/torture.sh.$$
 trap 'rm -rf $T' 0 2
 mkdir $T
 
+duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
+if test "$duration_rcutorture" -eq 0
+then
+	echo " --- Zero time for rcutorture, disabling" | tee -a $T/log
+	do_rcutorture=no
+fi
+duration_locktorture=$((duration_base*duration_locktorture_frac/10))
+if test "$duration_locktorture" -eq 0
+then
+	echo " --- Zero time for locktorture, disabling" | tee -a $T/log
+	do_locktorture=no
+fi
+duration_scftorture=$((duration_base*duration_scftorture_frac/10))
+if test "$duration_scftorture" -eq 0
+then
+	echo " --- Zero time for scftorture, disabling" | tee -a $T/log
+	do_scftorture=no
+fi
+
 touch $T/failures
 touch $T/successes
 
