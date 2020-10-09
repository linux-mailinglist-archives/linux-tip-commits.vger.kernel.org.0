Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A777288423
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbgJIH66 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D3C0613D9;
        Fri,  9 Oct 2020 00:58:50 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rWB5YrOO2kl998kyua404MYtKqnpYCKosWaE/rpe/OY=;
        b=U5QSaQIHxc/3hvFTrV2+tPBqp4NFPlzHVRjRZuj6542WtJgL2CpP7AnznsOET88obDSASL
        2jgy59GRXnLFFzuYIvtCBXyPs0SlNm8stntiUtlkrmB10aBzt2E6h/tZtUGOOHfWXjQLxv
        GJ1smi14kXw1QnMGqZ+MBmRplwtyQXSBpqRjdWiX3CSDEF+/pv+iFXRbvWRiIVc3Y+3JQh
        M3GChuGHItVdgMHFvDUrntvms6JFe4SV1Eci8gFqjWBuaDGoIm3vKQz9pE4s40uIDLFCnT
        ncRcLOMssTrJ3qD6DqXCrHi4AmWT/jslG0JZhs3bHye1D5URsPkWfI5/i9ZzIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rWB5YrOO2kl998kyua404MYtKqnpYCKosWaE/rpe/OY=;
        b=24kYPiJQNpfr4KxvooLxWfkJBWOdh4k1XlrNvMJmTkDiUPEzTU/0Oe9CgKX1y+Raa6Niam
        zo+K1VtbaXzgJkCg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Simplify constant string handling
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032784.7002.2950157235911661830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a4e74fa5f0d3e2a11f2d0deb522681d219a81426
Gitweb:        https://git.kernel.org/tip/a4e74fa5f0d3e2a11f2d0deb522681d219a81426
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 31 Jul 2020 10:17:20 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:10:22 -07:00

kcsan: Simplify constant string handling

Simplify checking prefixes and length calculation of constant strings.
For the former, the kernel provides str_has_prefix(), and the latter we
should just use strlen("..") because GCC and Clang have optimizations
that optimize these into constants.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 8 ++++----
 kernel/kcsan/report.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 3a9566a..116bdd8 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -300,16 +300,16 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		WRITE_ONCE(kcsan_enabled, true);
 	} else if (!strcmp(arg, "off")) {
 		WRITE_ONCE(kcsan_enabled, false);
-	} else if (!strncmp(arg, "microbench=", sizeof("microbench=") - 1)) {
+	} else if (str_has_prefix(arg, "microbench=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
-	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+	} else if (str_has_prefix(arg, "test=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("test=")], 0, &iters))
 			return -EINVAL;
 		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 3e83a69..bf1d594 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -279,8 +279,8 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 
 		cur = strnstr(buf, "kcsan_", len);
 		if (cur) {
-			cur += sizeof("kcsan_") - 1;
-			if (strncmp(cur, "test", sizeof("test") - 1))
+			cur += strlen("kcsan_");
+			if (!str_has_prefix(cur, "test"))
 				continue; /* KCSAN runtime function. */
 			/* KCSAN related test. */
 		}
