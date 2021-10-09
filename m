Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A64278AF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhJIKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhJIKJB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:01 -0400
Date:   Sat, 09 Oct 2021 10:07:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvtr4YeHrdtHP5wpZsRvUVwFMSwOI3b1lIn/oS9rJ9g=;
        b=vgSPAMkJv3VNQatIPz9d6ALEcIIQXNC4Rvk/N6q2Qu6RCKD9ZwjEeOO72NRcdwEqnfP5GA
        mIG+A8UpGLmJVixbya2ey+udSkIFBaW0B7Sti4wXr0Z9EnTRGqAGo49x4A1Pu/RpZZla3N
        QNauTMw1chzSZBVDkd/xiXHU/B5urSsED1VZcv4TInOvqHc4IduQd0eA2THSwm/VRn6Isj
        I+4EaOWf9bC2as+gF6YL0+eMl5FjQ2txm/NrQRsjdiUzMCjmq865ukjUZ4/8JKTye0+ls7
        bye/o0fHNDfCrk9kcjbJM7aPbDZs+MiXEX4kcIQPUuc2V00rp8NCx/40RfxULw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvtr4YeHrdtHP5wpZsRvUVwFMSwOI3b1lIn/oS9rJ9g=;
        b=9gGc+u0ZGm3X+K1f6Q/X1/zcbt6CDqyXbFshOik1A9RBB/5iLSKEyOBEUqJaqUs8869VJ5
        K4fKaklGp5g062Cg==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex,arm: Wire up sys_futex_waitv()
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-19-andrealmeid@collabora.com>
References: <20210923171111.300673-19-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402282.25758.8202119386022969663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ea7c45fde5aa3e761aaddb7902a31a95cb120e7b
Gitweb:        https://git.kernel.org/tip/ea7c45fde5aa3e761aaddb7902a31a95cb1=
20e7b
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:07 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:12 +02:00

futex,arm: Wire up sys_futex_waitv()

Wire up syscall entry point for ARM architectures, for both 32 and 64-bit.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-19-andrealmeid@collabor=
a.com
---
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index e842209..5431001 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -462,3 +462,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3cb206a..6bdb5f5 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
=20
-#define __NR_compat_syscalls		449
+#define __NR_compat_syscalls		450
 #endif
=20
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unist=
d32.h
index 844f6ae..41ea119 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -903,6 +903,8 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
+#define __NR_futex_waitv 449
+__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
=20
 /*
  * Please add new compat syscalls above this comment and update
