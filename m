Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EACE35B4E0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhDKNoU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qpv/7hmeJe1rkdMsempkZEFnL2JQXIrePCoufgiLEwE=;
        b=DLxgIwew9qR2QMvIrJ0PFN9JDM4UxMTLuNaQL38dyTKBUVc5132HKV57nYYJZSIjsKfkiX
        ZTF0L6LPEnBG+ZZqulMkt8eg0e/Xu0SUPz1q/3x/to7j65LoyNQmGJARp1ncBIaX/MY6Nx
        guYKV5SEt4wIVHmh+OTM1M1XHAKXiSj4f06BF63sCWgARFs4OdmlP5ywCVj8T+i4zKtX/l
        7/ehqcItxY69bJYaN+Z2lAdeqcOZqY9XVZVen5VwUCab2wSa5rtAoDUVrTJp5CkoOYYhYd
        3i3iyLSkKA+/8gy7vUEX4U8B3veOwGbXLe3HgpYLX3VErYr87K5EwpOMU/XHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qpv/7hmeJe1rkdMsempkZEFnL2JQXIrePCoufgiLEwE=;
        b=lUEamtgeLOj66QymMiftcck/J0CIPr97n6w9v9zDRzh5pJmVwZsCUeL+051QHHfoUD0tgX
        cCaxmJg1GVVqwyBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Improve readability of the testid.txt file
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861144.29796.9245104369962922661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f9d2f1e2c426ad6c4d7661cc7d90be4de2c4f7a4
Gitweb:        https://git.kernel.org/tip/f9d2f1e2c426ad6c4d7661cc7d90be4de2c4f7a4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Feb 2021 17:20:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Improve readability of the testid.txt file

The testid.txt file was intended for occasional in extremis use, but
now that the new "bare-metal" file references it, it might see more use.
This commit therefore labels sections of output and adds spacing to make
it easier to see what needs to be done to make a bare-metal build tree
match an rcutorture build tree.

Of course, you can avoid this whole issue by building your bare-metal
kernel in the same directory in which you ran rcutorture, but that might
not always be an option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 35a2132..1de198d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -404,11 +404,16 @@ echo $scriptname $args
 touch $resdir/$ds/log
 echo $scriptname $args >> $resdir/$ds/log
 echo ${TORTURE_SUITE} > $resdir/$ds/TORTURE_SUITE
-pwd > $resdir/$ds/testid.txt
+echo Build directory: `pwd` > $resdir/$ds/testid.txt
 if test -d .git
 then
+	echo Current commit: `git rev-parse HEAD` >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo ' ---' Output of "'"git status"'": >> $resdir/$ds/testid.txt
 	git status >> $resdir/$ds/testid.txt
-	git rev-parse HEAD >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo ' ---' Output of "'"git diff HEAD"'": >> $resdir/$ds/testid.txt
 	git diff HEAD >> $resdir/$ds/testid.txt
 fi
 ___EOF___
