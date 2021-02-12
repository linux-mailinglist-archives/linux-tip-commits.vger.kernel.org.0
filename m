Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7B319E87
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhBLMiT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhBLMhu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:50 -0500
Date:   Fri, 12 Feb 2021 12:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BabadaKVsMRogXIuDo1+NwHKfEGx1tEgVepBW6m1PtI=;
        b=wmqBaU1cJidT7pc8JKd5ZRU4XbfJ1HCrnd/U/mXx+tFvEuh7jWTpU3+N/NBgY9r6JBF7/Q
        8/HgHIgVSEoiwbvekncgASG++ORu2/JSWKdOjON+B10C+/frroH2l7iVkvANG/Lub9kAAf
        fVTXOnolVrfV9wuUmAePpTpz6mg/RV9+mn3RFB30n7gy8/LChWWC0bMqAkyXAJD3ykOKDS
        +bRP8B6SBqmbCM1o6uO/muuhguv6b+A4K9+M0Lmwaim9V3QzZ36O0NXqMnVvfbKCLg+ljX
        zgpUygfLzyGvSCDzGwN6IbPF2h5Mu9p//wwpLu/vH91oq3MO4LGC24P/8rKcjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BabadaKVsMRogXIuDo1+NwHKfEGx1tEgVepBW6m1PtI=;
        b=l1wUEpURSwnaCnz5P4pVG0oTnoK502UPesG6Mf9LPaxLr6t2nOAw5FXa+Lt8yr58TYvgpr
        5kmyEFmSS62bQQAQ==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Implement poll() based on ppoll()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342605.23325.10307309906235202220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5b1c827ca3b349801e2faff4185118cfa74f94c6
Gitweb:        https://git.kernel.org/tip/5b1c827ca3b349801e2faff4185118cfa74f94c6
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:27 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:44 -08:00

tools/nolibc: Implement poll() based on ppoll()

Some architectures like arm64 do not implement poll() and have to use
ppoll() instead. This commit therefore makes poll() use ppoll() when
available. This is a port of nolibc's upstream commit 800f75c13ede to
the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index fdd5524..833693f 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1652,7 +1652,17 @@ int sys_pivot_root(const char *new, const char *old)
 static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
+#if defined(__NR_ppoll)
+	struct timespec t;
+
+	if (timeout >= 0) {
+		t.tv_sec  = timeout / 1000;
+		t.tv_nsec = (timeout % 1000) * 1000000;
+	}
+	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
+#else
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
+#endif
 }
 
 static __attribute__((unused))
