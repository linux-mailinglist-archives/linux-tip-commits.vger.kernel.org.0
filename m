Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A902D8FE0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgLMTQv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392438AbgLMTDI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423DC0611E4;
        Sun, 13 Dec 2020 11:01:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=51x+MREM8dNzugf/lifkteXE3BiuRzwXrH4XUHKMe0s=;
        b=25ENoFGjTf7Kh/3noLdqX4fhXPXhfPCQ7IcdKccPSBEXWFAD+BFdL5qhDVVkr0DfSz5+A4
        27rMoh00OJpBs7AWW0q2+vN3oYYWVnEknieae4ZZ+PcMo+utQPx38TSNL8sNGaiKv+kdN5
        EgoZMgT8uDIUYle+nkNELYmuDklLw4aS0Cxizr6mxEp7Z2YseT4c38Bl4lmT6ulbcNBkQf
        ohR6/FkJjiR+ynPD37sMOZ2j9OZFrum005fLalTD8xfEF8vBpovc717XOEAYXkLuQO5UxF
        o9U8h2agjZ2jCrU/vrQyq1s8OKPHXA5DlIPKt0xeFtEmWiMjBRR+riDUnX2ndw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=51x+MREM8dNzugf/lifkteXE3BiuRzwXrH4XUHKMe0s=;
        b=OyKoiTd7aEZcsPm6BZl2qI+UBwDXoDXEKN2upsI1FTiwqgLwJsUERnkbyMYE0F1iNOKdP9
        ohFxmFvSE8EKEsDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Accept time units on kvm.sh --duration argument
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606808.3364.14022211682176943547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7de1ca35269ee20e40c35666c810cbaea528c719
Gitweb:        https://git.kernel.org/tip/7de1ca35269ee20e40c35666c810cbaea528c719
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 22 Sep 2020 17:20:11 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:55 -08:00

torture: Accept time units on kvm.sh --duration argument

The "--duration <minutes>" has worked well for a very long time, but
it can be inconvenient to compute the minutes for (say) a 28-hour run.
It can also be annoying to have to let a simple boot test run for a full
minute.  This commit therefore permits an "s" suffix to specify seconds,
"m" to specify minutes (which remains the default), "h" suffix to specify
hours, and "d" to specify days.

With this change, "--duration 5" still specifies that each scenario
run for five minutes, but "--duration 30s" runs for only 30 seconds,
"--duration 8h" runs for eight hours, and "--duration 2d" runs for
two days.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 5ad3882..c348d96 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -58,7 +58,7 @@ usage () {
 	echo "       --datestamp string"
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
-	echo "       --duration minutes"
+	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
 	echo "       --interactive"
@@ -128,8 +128,20 @@ do
 		shift
 		;;
 	--duration)
-		checkarg --duration "(minutes)" $# "$2" '^[0-9]*$' '^error'
-		dur=$(($2*60))
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		dur=$(($ts*mult))
 		shift
 		;;
 	--gdb)
