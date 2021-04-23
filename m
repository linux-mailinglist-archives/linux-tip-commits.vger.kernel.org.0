Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65B368DAC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Apr 2021 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhDWHLD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Apr 2021 03:11:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbhDWHLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Apr 2021 03:11:03 -0400
Date:   Fri, 23 Apr 2021 07:10:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619161826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI1Pd5v0WAfXx+BahMGzaQK3b5hSGu2vsXJZGgN8dmQ=;
        b=ezKLFQsjK/NGSmi3kSobotOWbfRGqkY7S4gFT9T6pE8n0qZIar0kG79wtaYuRFfIEXEY12
        BmIHBYbqOC+SFKop6G43gIouBASUalh02OtZ+g98CE9/4CRRgmttXCS3UCsp2UYMyNAM/C
        Jq4sv6Pty4Xmcl6ZMWY8vzreFkAfewBlSgabGNYqqaEclxrbqt8OOyOkaykiWNNKHM85Id
        Cx8DFBaRuKJDm+p0QDWb9HEE1lz46Q13HCNNVvmD/AZj1kYHo6DUAR9BevdvfaTemWjIXj
        j6N0fnEMEI+ZekNnQyQBwfo+iz0/NxDSxpLLgQOErTlE+VAfzLQG+i0gtzP0vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619161826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI1Pd5v0WAfXx+BahMGzaQK3b5hSGu2vsXJZGgN8dmQ=;
        b=xxPoY886fGoALeoeRXMyQywDj9pAFYSHzAjYRbP5RqGzHijd1Wco0UHOM/4yEwiy0yK2wD
        6SSy8ixZ/5v0UmDw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422191823.79012-1-elver@google.com>
References: <20210422191823.79012-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <161916182563.29796.7643401185171422433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3ddb3fd8cdb0a6c11b7c8d91ba42d84c4ea3cc43
Gitweb:        https://git.kernel.org/tip/3ddb3fd8cdb0a6c11b7c8d91ba42d84c4ea3cc43
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 22 Apr 2021 21:18:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Apr 2021 09:03:16 +02:00

signal, perf: Fix siginfo_t by avoiding u64 on 32-bit architectures

The alignment of a structure is that of its largest member. On
architectures like 32-bit Arm (but not e.g. 32-bit x86) 64-bit integers
will require 64-bit alignment and not its natural word size.

This means that there is no portable way to add 64-bit integers to
siginfo_t on 32-bit architectures without breaking the ABI, because
siginfo_t does not yet (and therefore likely never will) contain 64-bit
fields on 32-bit architectures. Adding a 64-bit integer could change the
alignment of the union after the 3 initial int si_signo, si_errno,
si_code, thus introducing 4 bytes of padding shifting the entire union,
which would break the ABI.

One alternative would be to use the __packed attribute, however, it is
non-standard C. Given siginfo_t has definitions outside the Linux kernel
in various standard libraries that can be compiled with any number of
different compilers (not just those we rely on), using non-standard
attributes on siginfo_t should be avoided to ensure portability.

In the case of the si_perf field, word size is sufficient since there is
no exact requirement on size, given the data it contains is user-defined
via perf_event_attr::sig_data. On 32-bit architectures, any excess bits
of perf_event_attr::sig_data will therefore be truncated when copying
into si_perf.

Since si_perf is intended to disambiguate events (e.g. encoding relevant
information if there are more events of the same type), 32 bits should
provide enough entropy to do so on 32-bit architectures.

For 64-bit architectures, no change is intended.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lkml.kernel.org/r/20210422191823.79012-1-elver@google.com
---
 include/linux/compat.h                                | 2 +-
 include/uapi/asm-generic/siginfo.h                    | 2 +-
 tools/testing/selftests/perf_events/sigtrap_threads.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index c8821d9..f0d2dd3 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -237,7 +237,7 @@ typedef struct compat_siginfo {
 					u32 _pkey;
 				} _addr_pkey;
 				/* used when si_code=TRAP_PERF */
-				compat_u64 _perf;
+				compat_ulong_t _perf;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d0bb912..03d6f6d 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -92,7 +92,7 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			__u64 _perf;
+			unsigned long _perf;
 		};
 	} _sigfault;
 
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 9c0fd44..78ddf5e 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -44,7 +44,7 @@ static struct {
 } ctx;
 
 /* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
-#define TEST_SIG_DATA(addr) (~(uint64_t)(addr))
+#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
 
 static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
 {
