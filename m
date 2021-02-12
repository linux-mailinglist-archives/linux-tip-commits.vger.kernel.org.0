Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B46319EFD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBLMpF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhBLMnN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:13 -0500
Date:   Fri, 12 Feb 2021 12:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yZyzAc2UAgQNuAy1k4rN7s6xR2TeXFaO4yI6nbmfxBI=;
        b=We9CxcTExjYpgQhkHBHyHFjVxT3dElbkMJQsl/7f4LQ0vxqABVV2UEFXiAmHb0AbUe69m5
        Ps3uagf8KIv8QjY7xv1EokQRXa42WqgLZfSw5bbNFAY3/TXFebZDyBSUtMkZiLBQXXenvB
        HMfnIwERNApgPBsgFvaL2oGUaOTQiKzkL+Q1xv3/ts7yENJ6TnxYQ1ll6skgAyF4M6hBcd
        j5YzyS5XHk/VsI0ez+3VZJlubGoimsoZz5k0C47gFxNxPUGNHjKqHwvdn0Ued40PdKfndK
        kgVsgkMyFFQYi1PO9/k29CMSJGbFXRFWdZEOqEqh1rUCluQs5eXHYnVRV0vk3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yZyzAc2UAgQNuAy1k4rN7s6xR2TeXFaO4yI6nbmfxBI=;
        b=PHjA1F0P0gOGzrPhaX5xuxo2lUvbmTCgll9wGlfnLyuqsd26twV0/KgkyVyhjRrvt8WjjF
        q5TJ/mQMtfRZg6DQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh return failure upon build failure
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344671.23325.11260337432529418228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     23239fc075d60a942101227c42353b5ced804269
Gitweb:        https://git.kernel.org/tip/23239fc075d60a942101227c42353b5ced804269
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 23 Nov 2020 10:41:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:22 -08:00

torture: Make kvm.sh return failure upon build failure

The kvm.sh script uses kvm-find-errors.sh to evaluate whether or not
a build failed.  Unfortunately, kvm-find-errors.sh returns success if
there are no failed runs (including when there are no runs at all) even if
there are build failures.  This commit therefore makes kvm-find-errors.sh
return failure in response to build failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 8 ++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 6f50722..be26598 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -39,6 +39,7 @@ done
 if test -n "$files"
 then
 	$editor $files
+	editorret=1
 else
 	echo No build errors.
 fi
@@ -62,5 +63,10 @@ then
 	exit 1
 else
 	echo No errors in console logs.
-	exit 0
+	if test -n "$editorret"
+	then
+		exit $editorret
+	else
+		exit 0
+	fi
 fi
