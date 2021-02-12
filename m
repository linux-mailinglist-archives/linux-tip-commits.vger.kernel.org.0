Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258FF319E83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhBLMh5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhBLMht (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C294C06178A;
        Fri, 12 Feb 2021 04:37:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uyw0NwtQHiqGNw07WJMyPhTgN7b3TRmo64Co3oU7Z6E=;
        b=G4eqktpO9mo3fySpI2ZRA8JY1ct7G9ppy8v69+OSUCnn+J4CyidtYxueWndIb1DEVXYwVj
        wGW1m5eAr00nF/NbLoMrp5y7IU060AT+19+GWzRM0g8XfCHAQGAWT0RrKazTaxMXkRfq1m
        zoJrBsR5bP2sYyRPnSF0gG8uWHleOTPTYnpQsgbspsm0l3FJU2PcvTQZ2JJEcjC7gtXohT
        Kp18lDldyRQtXCbHqCjNr6VgZp8a8DpJmzmUYFlQR+PbhoQ2lY9TXdcGESuIuiKwDMdNl2
        32FB/xz2BPQ2Ybz7FLc8/+90cI6bSffrcMmkgxdbzThqgsazUpTK4T/tAhLRyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uyw0NwtQHiqGNw07WJMyPhTgN7b3TRmo64Co3oU7Z6E=;
        b=eKZ6oLkpLnAk+VX2kDAJcsWgdDzblw7R9lDv85Hw3aVdpphU/c6dh4+2r2N3rU6vVrS03p
        xSVT8SSe5zMJV/Bg==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Fix position of -lgcc in the documented example
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342475.23325.2973395003549310012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3c6ce7a5363723a05bfe3ee03a8d4a9b66841ae4
Gitweb:        https://git.kernel.org/tip/3c6ce7a5363723a05bfe3ee03a8d4a9b66841ae4
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:31 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:45 -08:00

tools/nolibc: Fix position of -lgcc in the documented example

The documentation header in the nolibc.h file provides an example command
line, but it places the -lgcc argument before the source files, which
can fail with libgcc.a (e.g. on ARM when uidiv is needed). This commit
therefore moves the -lgcc to the end of the command line, hopefully
before this example leaks into makefiles.  This is a port of nolibc's
upstream commit b5e282089223 to the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 618acad..8b7a983 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -71,7 +71,7 @@
  *
  * A simple static executable may be built this way :
  *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
- *            -static -include nolibc.h -lgcc -o hello hello.c
+ *            -static -include nolibc.h -o hello hello.c -lgcc
  *
  * A very useful calling convention table may be found here :
  *      http://man7.org/linux/man-pages/man2/syscall.2.html
