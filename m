Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E7319EFE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhBLMpH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhBLMnP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9EEC06178C;
        Fri, 12 Feb 2021 04:42:34 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fz2YE1DfLpgVlLFRkb1DjVxrQOk5RLrlUP5ezOPJ+4M=;
        b=Wdkjnr2jpgRWTFYuZciQ2uFo45qtCzShyRXezT1HzUNL8faEZ4UOc5ZY3m1Rojm+yJnW2+
        /uDa32HdzxlJileSa453+TUBAXobT06rD4AtSlFaycGO/nG/vWPCKZAQbTV0tUdPRT6Srk
        jj8dRSANeRR+Q8q6k/ixRUPxjTtJNGD4LZ7tZWvAGwvDIiimKqnWbCT9QQbDdOAk7Ip7bj
        42vGOCXHuMV7ubwbvQBTVceOgh1UqZ4rZgSocudWstzNK4FzdhV/1TRXnMmm4ZnlPpilcK
        /cFujZQjgkpIJ4KDHXscWERmi3eS1U3uZhHQEiVfDoxbuGa0lJbWyLNuOP9CAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fz2YE1DfLpgVlLFRkb1DjVxrQOk5RLrlUP5ezOPJ+4M=;
        b=OsWRjDszY0dmUpLGeZ/5uWJqvkz8nKOL0MQ45gQfY3v6144NC5QalrViL66cmRKrquEK4l
        ejeQOWjZBt/NN2AA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh "Test Summary" date be end of test
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344740.23325.11772945097249998148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cb212767346ceba58c8b7bfdbbf45339b86e09c0
Gitweb:        https://git.kernel.org/tip/cb212767346ceba58c8b7bfdbbf45339b86e09c0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 19 Nov 2020 15:23:04 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:20 -08:00

torture: Make kvm.sh "Test Summary" date be end of test

Currently, the "date" command producing the output on the kvm.sh "Test
Summary" line is executed at the beginning of the test, which produces a
date that is less than helpful to someone wanting to know the duration
of the test.  This commit therefore defers this command's execution to
the end of the test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0a9211a..c8356d5 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -517,10 +517,12 @@ END {
 		dump(first, i, batchnum);
 }' >> $T/script
 
-cat << ___EOF___ >> $T/script
+cat << '___EOF___' >> $T/script
 echo
 echo
 echo " --- `date` Test summary:"
+___EOF___
+cat << ___EOF___ >> $T/script
 echo Results directory: $resdir/$ds
 kcsan-collapse.sh $resdir/$ds
 kvm-recheck.sh $resdir/$ds
