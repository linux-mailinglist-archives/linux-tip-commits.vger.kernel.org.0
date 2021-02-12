Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD9319F04
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBLMp3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhBLMnR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DCC0617A7;
        Fri, 12 Feb 2021 04:42:37 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VuSlqGiLqOYJUXClVLOO2u35K7fNBzAv8eRJl9mNdFs=;
        b=dvCXJ7YcmOmmUogh5Qgwfpzb94uN0MPdWw99cqkLtrpsQljF/9CqWQqSAOX7AgkvNrhZOh
        FSVAWXNF8lUSpi7TLNaHIEzE/FgUpZCWeYql8w/CP/UoVL0N6mXdE9Hd+a55S2rtsMziB1
        TOOaqshzacGNzI/IZA7WlXkuCltEeXBX3+jXfsOQ8dkDS+qH7bW4FDwRIaFNonrtuJELHQ
        vziLXcJy9rqg0JYYftPSP7wJwMeSONx/HBxDfnMzfp4eWDWvxRfN9e1UjkdCS+8LTLLdHI
        hZwsuTIQ9rxEeGSEmgAD/xVRghjrJVfSKynSPRu8TlIYjMBt1lbfSwpIPs8KIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VuSlqGiLqOYJUXClVLOO2u35K7fNBzAv8eRJl9mNdFs=;
        b=zltBEoRmv4FuBchGN0f7Ey2Hx1OF6qcPIX897wXnYG6PfHNAIsuI5sVfN2v83r3tuQnAJ6
        uD9/t+4TBibFQGDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh "--dryrun sched" summarize
 number of builds
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344873.23325.13236245957669798292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     eca0501a7a2036d3e63aae80cf7f2594408374ff
Gitweb:        https://git.kernel.org/tip/eca0501a7a2036d3e63aae80cf7f2594408374ff
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 08 Nov 2020 15:52:30 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:18 -08:00

torture: Make kvm.sh "--dryrun sched" summarize number of builds

Knowing the number of builds that kvm.sh will split a run into allows
estimation of the duration of a test, give or take build duration.
This commit therefore adds a line of output to "--dryrun sched" that
gives the number of builds that will be run.  This excludes "builds"
for repeated scenarios that reuse an earlier build.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1078be1..55a18a9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -536,6 +536,10 @@ then
 	egrep 'Start batch|Starting build\.' $T/script |
 		grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
+	nbuilds="`grep 'Starting build\.' $T/script |
+		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
+		  awk '{ print $1 }' | grep -v '\.' | wc -l`"
+	echo Total number of builds: $nbuilds
 	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
 	echo Total number of batches: $nbatches
 	exit 0
