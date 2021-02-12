Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF7319E84
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBLMiI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhBLMht (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:49 -0500
Date:   Fri, 12 Feb 2021 12:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6J8eay/5p+XqL085XE4wmgxiCX3RHC3tQxDMQrgY6Xg=;
        b=dsrVSgPL5w+dlyrhZ/99tGFqHt52TcsHU+Ha68UZHz2FrbH0FjpKp3t4qaiihrcCP8EEb4
        eF8CdLG9/ADPkmVgsKQaiJk3ZMWakgKKBUoCrasLda8CbfDHhlZE6OYUm+z4juwyqT/I/P
        pNBQ1pnMd65noVSQYo2GxkEH1joTUp6hEyCyYkZKQwp+jkk2y0peHAUdwOgZpJGWd2tgne
        X2OE7w+hX664I40zc5qD59yKMwONBNiRwJJzTrlGseiO7ezeLPp3sR5YLOaUMxuLMltIVI
        0cRBPfNbLFFu4+G9coBCu5gT5zaMe0nIq0DNLr1F2W7rkTnwm1wO0qE1Uh09LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6J8eay/5p+XqL085XE4wmgxiCX3RHC3tQxDMQrgY6Xg=;
        b=0zCtiF16yiUXXq+AasMwdhMqAltS2dOiD0ip9COiNgAxGTmDHJ8VDK5+PfLBSGncOq1Ydm
        fc8QbFBRDKBxobBw==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/rcutorture: Fix position of -lgcc in mkinitrd.sh
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342449.23325.7310449319645523121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     26cec81415b1b2a2e8e36ef0b24cf5f26467aa61
Gitweb:        https://git.kernel.org/tip/26cec81415b1b2a2e8e36ef0b24cf5f26467aa61
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:48:08 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:45 -08:00

tools/rcutorture: Fix position of -lgcc in mkinitrd.sh

The -lgcc command-line argument is placed poorly in the build options,
which can result in build failures, for exapmle, on ARM when uidiv()
is required.  This commit therefore places the -lgcc argument after the
source files.

Fixes: b94ec36896da ("rcutorture: Make use of nolibc when available")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 38e424d..70d62fd 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -70,7 +70,7 @@ if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
 	# architecture supported by nolibc
         ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
 		-nostdlib -include ../../../../include/nolibc/nolibc.h \
-		-lgcc -s -static -Os -o init init.c
+		-s -static -Os -o init init.c -lgcc
 else
 	${CROSS_COMPILE}gcc -s -static -Os -o init init.c
 fi
