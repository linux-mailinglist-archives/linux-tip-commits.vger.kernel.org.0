Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468E42D8FF9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLMTUW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbgLMTCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF6C0611CD;
        Sun, 13 Dec 2020 11:01:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gLfNGSf+Jq0ugP7ZpAIPH82xJZnlCDZp13juylGORx8=;
        b=Ki2klPN5aufyx0GjxPnHjGs4z7hGHwX+8GmkBkZluSEoeo331U2oLlXfIIf9+UrG1/A1FB
        aox6wSrkJyjFLYzeG+hbCtLUQQh6EcBfOi990gug6ppaAMmjWOo1uacXHK90Se7WvMjP6D
        vR/Z33E0suDF8B8btPPEofzvTcUBv/XrlWY75CGxr1dXhXtxlW5h63VlvnKn0+sB0hJAxr
        0VyXxv3/ebGyXrKp2nv8oOThKcPNu57pK3sEFfwf/ogYPvlxRwBF6d+iggOTaeHZeM36bc
        n5KYlc0x2CqnaSoij+eDI9P2+MgAJi9KygUgvcOa7R6I251+NsO6Ic/O6cwUFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gLfNGSf+Jq0ugP7ZpAIPH82xJZnlCDZp13juylGORx8=;
        b=mvif0Jl9Mm5of4Qp3BMbVSoCGWt/uyLCdr3stM3jeVXT+1WYuiMwqh1PPpRtPsx2+PYBu4
        MFT8d9tuYJNWPxAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm-check-branches.sh use --allcpus
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606692.3364.15241784450900157813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5be7d80deb80ceef50a6bd86d83c8fd62264778a
Gitweb:        https://git.kernel.org/tip/5be7d80deb80ceef50a6bd86d83c8fd62264778a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 15 Oct 2020 11:42:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:58 -08:00

torture: Make kvm-check-branches.sh use --allcpus

Currently the kvm-check-branches.sh script calculates the number of CPUs
and passes this to the kvm.sh --cpus command-line argument.  This works,
but this commit saves a line by instead using the new kvm.sh --allcpus
command-line argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index 6e65c13..370406b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -52,8 +52,7 @@ echo Results directory: $resdir/$ds
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
-cpus="`identify_qemu_vcpus`"
-echo Using up to $cpus CPUs.
+echo Using all `identify_qemu_vcpus` CPUs.
 
 # Each pass through this loop does one command-line argument.
 for gitbr in $@
@@ -74,7 +73,7 @@ do
 		# Test the specified commit.
 		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
 		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --cpus $cpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		kvm.sh --allcpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
 		ret=$?
 		echo kvm.sh return code $ret for commit $i from branch $gitbr
 
