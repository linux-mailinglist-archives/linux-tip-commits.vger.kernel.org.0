Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C32319E8A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBLMiW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhBLMhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:51 -0500
Date:   Fri, 12 Feb 2021 12:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2WaDoHHKmM0pCeDccu4x6VJnqvweuwKEfinkIKT6gX4=;
        b=aLvqaGCGw7+27JErbBbvagki19LUPKi1wh1ZL0j4nvvGius7MSE8Dag/lX/3VDU0MbBWry
        veVnv+I3yDRkLWsD6dlQMdDgQpfXIRUCG7NrqRhdO4N6GXb+pBQDAbeWfZO0lONmUGGd+m
        l6YkfmdrN5lBxF+5YKNw1/3hezBjoNqhpC1sLcdvpHoN1SYAMaxDiGQD5auaCGXX9GR3TN
        ACCn3D1brYdrPJYvN9ogkbNqRQ5XCu9B8cDj2ilipSSDiQohZWIZnO/T3mPPnyDjZIo3MB
        IheWT1QYjANexg/Cnw4IG1nwK/DITYKERO7wu4/wJmQ9TW0XgCqW3zHUGX2XNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2WaDoHHKmM0pCeDccu4x6VJnqvweuwKEfinkIKT6gX4=;
        b=E+GAbM8IB24IAO/wjGUbH/P+8LM2QWV3FeQAzb2ux3/Luo5fffAFsbBk2gYYG/NMLwJIW2
        dnw+CbfIlmaqkJDw==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Add the definition for dup()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342710.23325.15512886496672918580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c261145abd2461f921ac44ad70c28778dda710f4
Gitweb:        https://git.kernel.org/tip/c261145abd2461f921ac44ad70c28778dda710f4
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:23 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:44 -08:00

tools/nolibc: Add the definition for dup()

This commit adds the dup() function, which was omitted when sys_dup()
was defined.  This is a port of nolibc's upstream commit 47cc42a79c92
to the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index e61d36c..3115c64 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1853,6 +1853,18 @@ int close(int fd)
 }
 
 static __attribute__((unused))
+int dup(int fd)
+{
+	int ret = sys_dup(fd);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+static __attribute__((unused))
 int dup2(int old, int new)
 {
 	int ret = sys_dup2(old, new);
