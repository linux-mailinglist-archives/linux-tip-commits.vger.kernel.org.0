Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD2319EAC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBLMkH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhBLMid (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA17C061797;
        Fri, 12 Feb 2021 04:37:10 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uxyrjjTtzb3HDBMsgQo3W1WjPnT24y71jbOQXob22eo=;
        b=pCqc+AUth97Q+Z5TvfVNTLGPcFd4dtSCynoL1f+F84IcWoo5hjHQNexQXuik1cwctKrJX1
        CPXH+Zx4tX+UFpLto8/siXFFUxQ9NRPs2eZjfiLLl/Unl4Ys4/u0/962ZNFBYcCxzerz1k
        O9k2t3uF3BKzHobS50bfN/Pe2N2HeHVURu1jjyaotMv9XzE1ImEXUsJ7+4ixJkGZEWAN/J
        y9QDi5krbDbTxMa0mbeBsBcodpHxdE3PkuKyTiZHpqCB/0iZ7Kz6Mpo3u4wvT6sz+Pz+CY
        kMrlrq3Qd8aPGjvzvi9B8mSETr1FW3m/6jxtnaVEUcmVoOOe6zTd1EaFdKXhJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uxyrjjTtzb3HDBMsgQo3W1WjPnT24y71jbOQXob22eo=;
        b=yJWRoEZwL35dXa7D4Ong0bih/xyYllGOpjuBcyqUqwqKK9fczUFNQb696WCf7ydY+LgQTE
        tBbrfLUQ0BcMoNBw==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Make getpgrp() fall back to getpgid(0)
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342657.23325.16799302339651184115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c0c7c103756fee25aadfd5c36f7b86e318f9abb4
Gitweb:        https://git.kernel.org/tip/c0c7c103756fee25aadfd5c36f7b86e318f9abb4
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:25 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:44 -08:00

tools/nolibc: Make getpgrp() fall back to getpgid(0)

The getpgrp() syscall is not implemented on arm64, so this commit instead
uses getpgid(0) when getpgrp() is not available.  This is a port of
nolibc's upstream commit 2379f25073f9 to the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 5fda4d8..9209da8 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1545,9 +1545,15 @@ int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
 }
 
 static __attribute__((unused))
+pid_t sys_getpgid(pid_t pid)
+{
+	return my_syscall1(__NR_getpgid, pid);
+}
+
+static __attribute__((unused))
 pid_t sys_getpgrp(void)
 {
-	return my_syscall0(__NR_getpgrp);
+	return sys_getpgid(0);
 }
 
 static __attribute__((unused))
@@ -1951,6 +1957,18 @@ int getdents64(int fd, struct linux_dirent64 *dirp, int count)
 }
 
 static __attribute__((unused))
+pid_t getpgid(pid_t pid)
+{
+	pid_t ret = sys_getpgid(pid);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+static __attribute__((unused))
 pid_t getpgrp(void)
 {
 	pid_t ret = sys_getpgrp();
