Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050B319EAB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBLMkE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhBLMid (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4278C061794;
        Fri, 12 Feb 2021 04:37:10 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=urmQRgyyjq2DfPzMSGF2CLgXVgFwC4cz6ctagHDNTbI=;
        b=WawQjOKpwdGWUfqOMDRNhMLS5Bql7cqqC3BJ2vFppoLpxLEHqpd4MJ/qOr6v+DT/GE5zTc
        OxunjJPjVJ/sutuVYiqLyGKQ26djsbouC57YGCIIRrpaDMk3zcMz2eddxgzvLm3Dngbrdg
        +Gwr1rSVyOEP3rWni256AUnnt0zNGx7v+2AyA5jliBNlAKKuEOt4rZde40fE3UvAlQW8bG
        Syk3oJQpCWCE4JEFkKN2wphPO6qxrjV+lT1ikJ4nRI66/dq/T1PbTLfuKfuu4S1MmZvzeZ
        aMJ9AIGhmhnt7IZvgG1ZwgEZFL0hThMzMRYJdxHbNKyRHtrlg5OHNE/Z35cjkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=urmQRgyyjq2DfPzMSGF2CLgXVgFwC4cz6ctagHDNTbI=;
        b=yKm+5evHZQsX6AlbTLTVNsXxgroN4t+kKIuuFUR5N89YY9xoyGgP0dJ6k2KbbU1l+nSozD
        fBXAHrq9hM3wIwCA==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Make dup2() rely on dup3() when available
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342682.23325.2871472805056866547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     79f220e56dc85739aa5462fa8a1abd4a44f002e0
Gitweb:        https://git.kernel.org/tip/79f220e56dc85739aa5462fa8a1abd4a44f002e0
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:24 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:44 -08:00

tools/nolibc: Make dup2() rely on dup3() when available

A recent boot failure on 5.4-rc3 on arm64 revealed that sys_dup2()
is not available and that only sys_dup3() is implemented.  This commit
detects this and falls back to sys_dup3() when available.  This is a
port of nolibc's upstream commit fd5272ec2c66 to the Linux kernel.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3115c64..5fda4d8 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1502,10 +1502,22 @@ int sys_dup(int fd)
 	return my_syscall1(__NR_dup, fd);
 }
 
+#ifdef __NR_dup3
+static __attribute__((unused))
+int sys_dup3(int old, int new, int flags)
+{
+	return my_syscall3(__NR_dup3, old, new, flags);
+}
+#endif
+
 static __attribute__((unused))
 int sys_dup2(int old, int new)
 {
+#ifdef __NR_dup3
+	return my_syscall3(__NR_dup3, old, new, 0);
+#else
 	return my_syscall2(__NR_dup2, old, new);
+#endif
 }
 
 static __attribute__((unused))
@@ -1876,6 +1888,20 @@ int dup2(int old, int new)
 	return ret;
 }
 
+#ifdef __NR_dup3
+static __attribute__((unused))
+int dup3(int old, int new, int flags)
+{
+	int ret = sys_dup3(old, new, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+#endif
+
 static __attribute__((unused))
 int execve(const char *filename, char *const argv[], char *const envp[])
 {
