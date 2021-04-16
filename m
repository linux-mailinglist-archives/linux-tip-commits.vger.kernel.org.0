Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA5362358
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbhDPPCV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbhDPPCR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48DC061760;
        Fri, 16 Apr 2021 08:01:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dN02knF80B8Q5ThVImZNLeKLw0QWas3On367Qt6nCq4=;
        b=dIenI8Jrp7hvZzY7+C2S51ewa3rLE+mOl9rxTcLH1Cdf80FWNEAsPmOTDM8mh5ahnj1OZC
        UcG2P5gPTiKFimjnBRhGVR7ABllAa+/bolVSDVnILBh2rb9jrOhFo4E0MYnoOx9cE/e9e6
        y/OpXZAnNCNSJe/WtqTXd5A876vtvNCMEMT9Lr53PmyXWgFaUphjAciXkTL5bl6mHSYUhc
        1umFPyzKyTvUoWCUygV/1qpdMzYvu5k3VtSAhjUAsps4AUCITo5rVu2AhIia5LSZ7hmY8o
        T0ow8nmIfIGiiI4P8NdBRGZYY6cZepxonc9462LNuvI4ef/UOcrzmTW7fNmqOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dN02knF80B8Q5ThVImZNLeKLw0QWas3On367Qt6nCq4=;
        b=G5cRfuAEoHClni8liCVYoGgqIcYPoGf6PGx0xW9s4owym7AmkefwTxWXHcvpUZbAvu0ZEP
        9hCNE9rmiw/EECCg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] signal: Introduce TRAP_PERF si_code and si_perf to siginfo
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210408103605.1676875-6-elver@google.com>
References: <20210408103605.1676875-6-elver@google.com>
MIME-Version: 1.0
Message-ID: <161858531033.29796.1442507652274621227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fb6cc127e0b6e629252cdd0f77d5a1f49db95b92
Gitweb:        https://git.kernel.org/tip/fb6cc127e0b6e629252cdd0f77d5a1f49db95b92
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 08 Apr 2021 12:36:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:41 +02:00

signal: Introduce TRAP_PERF si_code and si_perf to siginfo

Introduces the TRAP_PERF si_code, and associated siginfo_t field
si_perf. These will be used by the perf event subsystem to send signals
(if requested) to the task where an event occurred.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
Link: https://lkml.kernel.org/r/20210408103605.1676875-6-elver@google.com
---
 arch/m68k/kernel/signal.c          |  3 +++
 arch/x86/kernel/signal_compat.c    |  5 ++++-
 fs/signalfd.c                      |  4 ++++
 include/linux/compat.h             |  2 ++
 include/linux/signal.h             |  1 +
 include/uapi/asm-generic/siginfo.h |  6 +++++-
 include/uapi/linux/signalfd.h      |  4 +++-
 kernel/signal.c                    | 11 +++++++++++
 8 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 349570f..a4b7ee1 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -622,6 +622,9 @@ static inline void siginfo_build_tests(void)
 	/* _sigfault._addr_pkey */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
 
+	/* _sigfault._perf */
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x10);
+
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x10);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a5330ff..0e5d0a7 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -29,7 +29,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGFPE  != 15);
 	BUILD_BUG_ON(NSIGSEGV != 9);
 	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 5);
+	BUILD_BUG_ON(NSIGTRAP != 6);
 	BUILD_BUG_ON(NSIGCHLD != 6);
 	BUILD_BUG_ON(NSIGSYS  != 2);
 
@@ -138,6 +138,9 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
 
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
+
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
 	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 456046e..040a114 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,6 +134,10 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 #endif
 		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
+	case SIL_PERF_EVENT:
+		new.ssi_addr = (long) kinfo->si_addr;
+		new.ssi_perf = kinfo->si_perf;
+		break;
 	case SIL_CHLD:
 		new.ssi_pid    = kinfo->si_pid;
 		new.ssi_uid    = kinfo->si_uid;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be7..c8821d9 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -236,6 +236,8 @@ typedef struct compat_siginfo {
 					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
+				/* used when si_code=TRAP_PERF */
+				compat_u64 _perf;
 			};
 		} _sigfault;
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c..1e98548 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -43,6 +43,7 @@ enum siginfo_layout {
 	SIL_FAULT_MCEERR,
 	SIL_FAULT_BNDERR,
 	SIL_FAULT_PKUERR,
+	SIL_PERF_EVENT,
 	SIL_CHLD,
 	SIL_RT,
 	SIL_SYS,
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d259700..d0bb912 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -91,6 +91,8 @@ union __sifields {
 				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 				__u32 _pkey;
 			} _addr_pkey;
+			/* used when si_code=TRAP_PERF */
+			__u64 _perf;
 		};
 	} _sigfault;
 
@@ -155,6 +157,7 @@ typedef struct siginfo {
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
+#define si_perf		_sifields._sigfault._perf
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
@@ -253,7 +256,8 @@ typedef struct siginfo {
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
 #define TRAP_UNK	5	/* undiagnosed trap */
-#define NSIGTRAP	5
+#define TRAP_PERF	6	/* perf event with sigtrap=1 */
+#define NSIGTRAP	6
 
 /*
  * There is an additional set of SIGTRAP si_codes used by ptrace
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 83429a0..7e33304 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -39,6 +39,8 @@ struct signalfd_siginfo {
 	__s32 ssi_syscall;
 	__u64 ssi_call_addr;
 	__u32 ssi_arch;
+	__u32 __pad3;
+	__u64 ssi_perf;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -49,7 +51,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[28];
+	__u8 __pad[16];
 };
 
 
diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef..f683518 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1199,6 +1199,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
+	case SIL_PERF_EVENT:
 	case SIL_SYS:
 		ret = false;
 		break;
@@ -2531,6 +2532,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
+	case SIL_PERF_EVENT:
 		ksig->info.si_addr = arch_untagged_si_addr(
 			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
 		break;
@@ -3333,6 +3335,10 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 #endif
 		to->si_pkey = from->si_pkey;
 		break;
+	case SIL_PERF_EVENT:
+		to->si_addr = ptr_to_compat(from->si_addr);
+		to->si_perf = from->si_perf;
+		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
 		to->si_uid = from->si_uid;
@@ -3413,6 +3419,10 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 #endif
 		to->si_pkey = from->si_pkey;
 		break;
+	case SIL_PERF_EVENT:
+		to->si_addr = compat_ptr(from->si_addr);
+		to->si_perf = from->si_perf;
+		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
 		to->si_uid    = from->si_uid;
@@ -4593,6 +4603,7 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_lower);
 	CHECK_OFFSET(si_upper);
 	CHECK_OFFSET(si_pkey);
+	CHECK_OFFSET(si_perf);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
