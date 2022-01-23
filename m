Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9F497552
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jan 2022 20:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiAWTpB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 Jan 2022 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiAWTo5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06FC06173B;
        Sun, 23 Jan 2022 11:44:57 -0800 (PST)
Date:   Sun, 23 Jan 2022 19:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+D9Iat0tganiYDmp4iSST6BH7bgLz29lQ8VWI2zgfQ=;
        b=f1ym5oSpP9AgAAUWQQE7cnuFPqBxSQ49NBBvCS8nJl5h3bVpmg7xtcWCCPb8ZtoY4I90oo
        ZVqqU0nEBXvRHpOdZem9uaiDIPDf2dSGy8fn7ZNoziRp2vAbZtXgtk3hK+BbN8+5PglKX7
        bWB828MORPko5O/a0jZab6WFCxsbURCPv0O47qwLOgWu/JiK3Gu61ptpZhVAVC+eN+Yylh
        /35O/jKd/rbDYjRcK+d7n3wgucKVKDDCeTC6I+B5O0IKECEYnNMZYl++KPrdLbkEYnopbp
        HKWR7sVmMY8y11qClb61tzlOi68EbeaJwUc2zQdVbDI8uueMJdKsukYSg+Gk1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+D9Iat0tganiYDmp4iSST6BH7bgLz29lQ8VWI2zgfQ=;
        b=9LJZZyT2hHuQNonICMBjYW/EGYtgOW8Y1bFvgpwaLhr6BN4cPHKiYV8OzcdoLLa6kDtRfu
        0eR6CRvEibgyOxDA==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] perf/tests: Add AVX512-FP16 instructions to x86
 instruction decoder test
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-6-adrian.hunter@intel.com>
References: <20211202095029.2165714-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709412.16921.8251793737368272284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     cdb63ba98c5d03774bca9789e689fe62be4347b4
Gitweb:        https://git.kernel.org/tip/cdb63ba98c5d03774bca9789e689fe62be4347b4
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:37:57 +01:00

perf/tests: Add AVX512-FP16 instructions to x86 instruction decoder test

The x86 instruction decoder is used for both kernel instructions and
user space instructions (e.g. uprobes, perf tools Intel PT), so it is
good to update it with new instructions.

Add AVX512-FP16 instructions to x86 instruction decoder test.

A subsequent patch adds the instructions to the instruction decoder.

Reference:
Intel AVX512-FP16 Architecture Specification
June 2021
Revision 1.0
Document Number: 347407-001US

Example:

  $ perf test -v "x86 instruction decoder" |& grep vfcmaddcph | head -2
  Failed to decode: 62 f6 6f 48 56 cb     vfcmaddcph %zmm3,%zmm2,%zmm1
  Failed to decode: 62 f6 6f 48 56 8c c8 78 56 34 12      vfcmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-6-adrian.hunter@intel.com
---
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  910 +++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 1370 +++++++++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 1146 ++++++++++++++-
 3 files changed, 3426 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index 79e2050..ba429ca 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -2197,6 +2197,916 @@
 "3e f2 ff 25 78 56 34 12 \tnotrack bnd jmp *0x12345678",},
 {{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
 "3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 58 cb    \tvaddph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 58 cb    \tvaddph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 58 cb    \tvaddph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 58 cb    \tvaddsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 58 8c c8 78 56 34 12 \tvaddsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x48, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 48 c2 eb 12 \tvcmple_oqph %zmm3,%zmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x48, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 48 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%zmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x08, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 c2 eb 12 \tvcmple_oqph %xmm3,%xmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%xmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x28, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 28 c2 eb 12 \tvcmple_oqph %ymm3,%ymm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x28, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 28 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%ymm2,%k5",},
+{{0x62, 0xf3, 0x6e, 0x08, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6e 08 c2 eb 12 \tvcmple_oqsh %xmm3,%xmm2,%k5",},
+{{0x62, 0xf3, 0x6e, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6e 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqsh 0x12345678(%eax,%ecx,8),%xmm2,%k5",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2f, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 2f ca    \tvcomish %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 2f 8c c8 78 56 34 12 \tvcomish 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 5b ca    \tvcvtdq2ph %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 5b 8c c8 78 56 34 12 \tvcvtdq2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 5b ca    \tvcvtdq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 5b ca    \tvcvtdq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x48, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 48 5a ca    \tvcvtpd2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x08, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 08 5a ca    \tvcvtpd2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x28, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 28 5a ca    \tvcvtpd2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 5b ca    \tvcvtph2dq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 5b ca    \tvcvtph2dq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 5b ca    \tvcvtph2dq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 5a ca    \tvcvtph2pd %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 5a ca    \tvcvtph2pd %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 5a ca    \tvcvtph2pd %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x13, 0xca, }, 6, 0, "", "",
+"62 f2 7d 48 13 ca    \tvcvtph2ps %ymm2,%zmm1",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 79 13 ca       \tvcvtph2ps %xmm2,%xmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 7d 13 ca       \tvcvtph2ps %xmm2,%ymm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 79 13 ca       \tvcvtph2ps %xmm2,%xmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 7d 13 ca       \tvcvtph2ps %xmm2,%ymm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 13 ca    \tvcvtph2psx %ymm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 13 ca    \tvcvtph2psx %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 13 ca    \tvcvtph2psx %xmm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7b ca    \tvcvtph2qq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7b ca    \tvcvtph2qq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7b ca    \tvcvtph2qq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 79 ca    \tvcvtph2udq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 79 ca    \tvcvtph2udq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 79 ca    \tvcvtph2udq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 79 ca    \tvcvtph2uqq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 79 ca    \tvcvtph2uqq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 79 ca    \tvcvtph2uqq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 7d ca    \tvcvtph2uw %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 7d ca    \tvcvtph2uw %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 7d ca    \tvcvtph2uw %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7d ca    \tvcvtph2w %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7d ca    \tvcvtph2w %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7d ca    \tvcvtph2w %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7d 48 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%zmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf3, 0x7d, 0x48, 0x1d, 0xd1, 0x12, }, 7, 0, "", "",
+"62 f3 7d 48 1d d1 12 \tvcvtps2ph $0x12,%zmm2,%ymm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 7d 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm1,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 79 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm1,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 79 1d d1 12    \tvcvtps2ph $0x12,%xmm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 7d 1d d1 12    \tvcvtps2ph $0x12,%ymm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 7d 1d d1 12    \tvcvtps2ph $0x12,%ymm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 7d 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm2,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 79 1d d1 12    \tvcvtps2ph $0x12,%xmm2,%xmm1",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 79 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm2,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 1d ca    \tvcvtps2phx %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 1d 8c c8 78 56 34 12 \tvcvtps2phx 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 1d ca    \tvcvtps2phx %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 1d ca    \tvcvtps2phx %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 48 5b ca    \tvcvtqq2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 08 5b ca    \tvcvtqq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 28 5b ca    \tvcvtqq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xef, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 ef 08 5a 8c c8 78 56 34 12 \tvcvtsd2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5a 8c c8 78 56 34 12 \tvcvtsh2sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x2d, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 2d 84 c8 78 56 34 12 \tvcvtsh2si 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf6, 0x6c, 0x08, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6c 08 13 8c c8 78 56 34 12 \tvcvtsh2ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x79, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 79 c1    \tvcvtsh2usi %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x79, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 79 84 c8 78 56 34 12 \tvcvtsh2usi 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0xc8, }, 6, 0, "", "",
+"62 f5 6e 08 2a c8    \tvcvtsi2sh %eax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x1d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 1d cb    \tvcvtss2sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 1d 8c c8 78 56 34 12 \tvcvtss2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 48 5b ca    \tvcvttph2dq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 48 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 08 5b ca    \tvcvttph2dq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 28 5b ca    \tvcvttph2dq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 28 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7a ca    \tvcvttph2qq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7a ca    \tvcvttph2qq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7a ca    \tvcvttph2qq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 78 ca    \tvcvttph2udq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 78 ca    \tvcvttph2udq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 78 ca    \tvcvttph2udq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 78 ca    \tvcvttph2uqq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 78 ca    \tvcvttph2uqq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 78 ca    \tvcvttph2uqq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 7c ca    \tvcvttph2uw %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 7c ca    \tvcvttph2uw %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 7c ca    \tvcvttph2uw %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7c ca    \tvcvttph2w %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7c ca    \tvcvttph2w %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7c ca    \tvcvttph2w %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x2c, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 2c c1    \tvcvttsh2si %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x2c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 2c 84 c8 78 56 34 12 \tvcvttsh2si 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x78, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 78 c1    \tvcvttsh2usi %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x78, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 78 84 c8 78 56 34 12 \tvcvttsh2usi 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 48 7a ca    \tvcvtudq2ph %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 48 7a 8c c8 78 56 34 12 \tvcvtudq2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 08 7a ca    \tvcvtudq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 28 7a ca    \tvcvtudq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 48 7a ca    \tvcvtuqq2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 08 7a ca    \tvcvtuqq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 28 7a ca    \tvcvtuqq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0xc8, }, 6, 0, "", "",
+"62 f5 6e 08 7b c8    \tvcvtusi2sh %eax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 48 7d ca    \tvcvtuw2ph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 48 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 08 7d ca    \tvcvtuw2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 08 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 28 7d ca    \tvcvtuw2ph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 28 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 48 7d ca    \tvcvtw2ph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 48 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 08 7d ca    \tvcvtw2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 28 7d ca    \tvcvtw2ph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 28 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5e cb    \tvdivph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5e cb    \tvdivph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5e cb    \tvdivph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5e cb    \tvdivsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5e 8c c8 78 56 34 12 \tvdivsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 48 56 cb    \tvfcmaddcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 48 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 56 cb    \tvfcmaddcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 28 56 cb    \tvfcmaddcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 28 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x57, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 57 cb    \tvfcmaddcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 57 8c c8 78 56 34 12 \tvfcmaddcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 48 d6 cb    \tvfcmulcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 48 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 d6 cb    \tvfcmulcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 28 d6 cb    \tvfcmulcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 28 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd7, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 d7 cb    \tvfcmulcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 d7 8c c8 78 56 34 12 \tvfcmulcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 98 cb    \tvfmadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 98 cb    \tvfmadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 98 cb    \tvfmadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x99, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 99 cb    \tvfmadd132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x99, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 99 8c c8 78 56 34 12 \tvfmadd132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a8 cb    \tvfmadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a8 cb    \tvfmadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a8 cb    \tvfmadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa9, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a9 cb    \tvfmadd213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a9 8c c8 78 56 34 12 \tvfmadd213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b8 cb    \tvfmadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b8 cb    \tvfmadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b8 cb    \tvfmadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb9, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b9 cb    \tvfmadd231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b9 8c c8 78 56 34 12 \tvfmadd231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 48 56 cb    \tvfmaddcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 48 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 56 cb    \tvfmaddcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 28 56 cb    \tvfmaddcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 28 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x57, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 57 cb    \tvfmaddcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 57 8c c8 78 56 34 12 \tvfmaddcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 96 cb    \tvfmaddsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 96 cb    \tvfmaddsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 96 cb    \tvfmaddsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a6 cb    \tvfmaddsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a6 cb    \tvfmaddsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a6 cb    \tvfmaddsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b6 cb    \tvfmaddsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b6 cb    \tvfmaddsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b6 cb    \tvfmaddsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9a cb    \tvfmsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9a cb    \tvfmsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9a cb    \tvfmsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9b, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9b cb    \tvfmsub132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9b 8c c8 78 56 34 12 \tvfmsub132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 aa cb    \tvfmsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 aa cb    \tvfmsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 aa cb    \tvfmsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xab, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ab cb    \tvfmsub213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xab, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ab 8c c8 78 56 34 12 \tvfmsub213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ba cb    \tvfmsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ba cb    \tvfmsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ba cb    \tvfmsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbb, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bb cb    \tvfmsub231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbb, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bb 8c c8 78 56 34 12 \tvfmsub231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 97 cb    \tvfmsubadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 97 cb    \tvfmsubadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 97 cb    \tvfmsubadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a7 cb    \tvfmsubadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a7 cb    \tvfmsubadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a7 cb    \tvfmsubadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b7 cb    \tvfmsubadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b7 cb    \tvfmsubadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b7 cb    \tvfmsubadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 48 d6 cb    \tvfmulcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 48 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 d6 cb    \tvfmulcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 28 d6 cb    \tvfmulcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 28 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd7, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 d7 cb    \tvfmulcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 d7 8c c8 78 56 34 12 \tvfmulcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9c cb    \tvfnmadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9c cb    \tvfnmadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9c cb    \tvfnmadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9d cb    \tvfnmadd132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9d 8c c8 78 56 34 12 \tvfnmadd132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ac cb    \tvfnmadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ac cb    \tvfnmadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ac cb    \tvfnmadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xad, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ad cb    \tvfnmadd213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xad, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ad 8c c8 78 56 34 12 \tvfnmadd213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 bc cb    \tvfnmadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bc cb    \tvfnmadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 bc cb    \tvfnmadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbd, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bd cb    \tvfnmadd231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbd, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bd 8c c8 78 56 34 12 \tvfnmadd231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9e cb    \tvfnmsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9e cb    \tvfnmsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9e cb    \tvfnmsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9f, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9f cb    \tvfnmsub132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9f 8c c8 78 56 34 12 \tvfnmsub132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ae cb    \tvfnmsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ae cb    \tvfnmsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ae cb    \tvfnmsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaf, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 af cb    \tvfnmsub213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 af 8c c8 78 56 34 12 \tvfnmsub213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 be cb    \tvfnmsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 be cb    \tvfnmsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 be cb    \tvfnmsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbf, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bf cb    \tvfnmsub231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bf 8c c8 78 56 34 12 \tvfnmsub231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 66 e9 12 \tvfpclassph $0x12,%zmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 66 e9 12 \tvfpclassph $0x12,%xmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 66 e9 12 \tvfpclassph $0x12,%ymm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x67, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 67 e9 12 \tvfpclasssh $0x12,%xmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x67, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 67 ac c8 78 56 34 12 12 \tvfpclasssh $0x12,0x12345678(%eax,%ecx,8),%k5",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 42 ca    \tvgetexpph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 42 ca    \tvgetexpph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 42 ca    \tvgetexpph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x43, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 43 cb    \tvgetexpsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x43, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 43 8c c8 78 56 34 12 \tvgetexpsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 26 ca 12 \tvgetmantph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 26 ca 12 \tvgetmantph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 26 ca 12 \tvgetmantph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x27, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 27 cb 12 \tvgetmantsh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x27, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 27 8c c8 78 56 34 12 12 \tvgetmantsh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5f cb    \tvmaxph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5f cb    \tvmaxph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5f cb    \tvmaxph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5f cb    \tvmaxsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5f 8c c8 78 56 34 12 \tvmaxsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5d cb    \tvminph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5d cb    \tvminph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5d cb    \tvminph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5d cb    \tvminsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5d 8c c8 78 56 34 12 \tvminsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x11, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 11 8c c8 78 56 34 12 \tvmovsh %xmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x10, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 10 8c c8 78 56 34 12 \tvmovsh 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x10, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 10 cb    \tvmovsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7e, 0xc8, }, 6, 0, "", "",
+"62 f5 7d 08 7e c8    \tvmovw  %xmm1,%eax",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7e 8c c8 78 56 34 12 \tvmovw  %xmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x6e, 0xc8, }, 6, 0, "", "",
+"62 f5 7d 08 6e c8    \tvmovw  %eax,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x6e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 6e 8c c8 78 56 34 12 \tvmovw  0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 59 cb    \tvmulph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 59 cb    \tvmulph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 59 cb    \tvmulph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 59 cb    \tvmulsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 59 8c c8 78 56 34 12 \tvmulsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 4c ca    \tvrcpph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 4c ca    \tvrcpph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 4c ca    \tvrcpph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 4d cb    \tvrcpsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 4d 8c c8 78 56 34 12 \tvrcpsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 56 ca 12 \tvreduceph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 56 ca 12 \tvreduceph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 56 ca 12 \tvreduceph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x57, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 57 cb 12 \tvreducesh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 57 8c c8 78 56 34 12 12 \tvreducesh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 08 ca 12 \tvrndscaleph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 08 ca 12 \tvrndscaleph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 08 ca 12 \tvrndscaleph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x0a, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 0a cb 12 \tvrndscalesh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x0a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 0a 8c c8 78 56 34 12 12 \tvrndscalesh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 4e ca    \tvrsqrtph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 4e ca    \tvrsqrtph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 4e ca    \tvrsqrtph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4f, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 4f cb    \tvrsqrtsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 4f 8c c8 78 56 34 12 \tvrsqrtsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 2c cb    \tvscalefph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 2c cb    \tvscalefph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 2c cb    \tvscalefph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 2d cb    \tvscalefsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 2d 8c c8 78 56 34 12 \tvscalefsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 51 ca    \tvsqrtph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 51 ca    \tvsqrtph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 51 ca    \tvsqrtph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x51, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 51 cb    \tvsqrtsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 51 8c c8 78 56 34 12 \tvsqrtsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5c cb    \tvsubph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5c cb    \tvsubph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5c cb    \tvsubph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5c cb    \tvsubsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5c 8c c8 78 56 34 12 \tvsubsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2e, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 2e ca    \tvucomish %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 2e 8c c8 78 56 34 12 \tvucomish 0x12345678(%eax,%ecx,8),%xmm1",},
 {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
 "f3 0f 3a f0 c0 00    \threset $0x0",},
 {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index b2d0ba4..3a47e98 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -2507,6 +2507,1376 @@
 "f3 0f 01 ed          \ttestui ",},
 {{0xf3, 0x0f, 0x01, 0xec, }, 4, 0, "", "",
 "f3 0f 01 ec          \tuiret  ",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 58 cb    \tvaddph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 58 cb    \tvaddph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 58 cb    \tvaddph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 58 8c c8 78 56 34 12 \tvaddph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x58, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 58 cb    \tvaddsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 58 8c c8 78 56 34 12 \tvaddsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x58, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 58 8c c8 78 56 34 12 \tvaddsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x48, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 48 c2 eb 12 \tvcmple_oqph %zmm3,%zmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x48, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 48 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%rax,%rcx,8),%zmm2,%k5",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x48, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 48 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%zmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x08, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 c2 eb 12 \tvcmple_oqph %xmm3,%xmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%rax,%rcx,8),%xmm2,%k5",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%xmm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x28, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 28 c2 eb 12 \tvcmple_oqph %ymm3,%ymm2,%k5",},
+{{0x62, 0xf3, 0x6c, 0x28, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 28 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%rax,%rcx,8),%ymm2,%k5",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x28, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 28 c2 ac c8 78 56 34 12 12 \tvcmple_oqph 0x12345678(%eax,%ecx,8),%ymm2,%k5",},
+{{0x62, 0xf3, 0x6e, 0x08, 0xc2, 0xeb, 0x12, }, 7, 0, "", "",
+"62 f3 6e 08 c2 eb 12 \tvcmple_oqsh %xmm3,%xmm2,%k5",},
+{{0x62, 0xf3, 0x6e, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6e 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqsh 0x12345678(%rax,%rcx,8),%xmm2,%k5",},
+{{0x67, 0x62, 0xf3, 0x6e, 0x08, 0xc2, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6e 08 c2 ac c8 78 56 34 12 12 \tvcmple_oqsh 0x12345678(%eax,%ecx,8),%xmm2,%k5",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2f, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 2f ca    \tvcomish %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 2f 8c c8 78 56 34 12 \tvcomish 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x2f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 2f 8c c8 78 56 34 12 \tvcomish 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 5b ca    \tvcvtdq2ph %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 5b 8c c8 78 56 34 12 \tvcvtdq2ph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 5b 8c c8 78 56 34 12 \tvcvtdq2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 5b ca    \tvcvtdq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 5b ca    \tvcvtdq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x48, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 48 5a ca    \tvcvtpd2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x08, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 08 5a ca    \tvcvtpd2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xfd, 0x28, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 fd 28 5a ca    \tvcvtpd2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 5b ca    \tvcvtph2dq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 5b ca    \tvcvtph2dq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 5b ca    \tvcvtph2dq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 5b 8c c8 78 56 34 12 \tvcvtph2dq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 5a ca    \tvcvtph2pd %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 5a ca    \tvcvtph2pd %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5a, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 5a ca    \tvcvtph2pd %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 5a 8c c8 78 56 34 12 \tvcvtph2pd 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x13, 0xca, }, 6, 0, "", "",
+"62 f2 7d 48 13 ca    \tvcvtph2ps %ymm2,%zmm1",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf2, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7d 48 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 79 13 ca       \tvcvtph2ps %xmm2,%xmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 7d 13 ca       \tvcvtph2ps %xmm2,%ymm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 79 13 ca       \tvcvtph2ps %xmm2,%xmm1",},
+{{0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0xc4, 0xe2, 0x79, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 79 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0xca, }, 5, 0, "", "",
+"c4 e2 7d 13 ca       \tvcvtph2ps %xmm2,%ymm1",},
+{{0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0xc4, 0xe2, 0x7d, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 7d 13 8c c8 78 56 34 12 \tvcvtph2ps 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 13 ca    \tvcvtph2psx %ymm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x48, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 48 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 13 ca    \tvcvtph2psx %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x08, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 08 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x13, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 13 ca    \tvcvtph2psx %xmm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x28, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 28 13 8c c8 78 56 34 12 \tvcvtph2psx 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7b ca    \tvcvtph2qq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7b ca    \tvcvtph2qq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7b, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7b ca    \tvcvtph2qq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 7b 8c c8 78 56 34 12 \tvcvtph2qq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 79 ca    \tvcvtph2udq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 79 ca    \tvcvtph2udq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 79 ca    \tvcvtph2udq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 79 8c c8 78 56 34 12 \tvcvtph2udq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 79 ca    \tvcvtph2uqq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 79 ca    \tvcvtph2uqq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x79, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 79 ca    \tvcvtph2uqq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x79, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 79 8c c8 78 56 34 12 \tvcvtph2uqq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 7d ca    \tvcvtph2uw %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 7d ca    \tvcvtph2uw %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 7d ca    \tvcvtph2uw %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 7d 8c c8 78 56 34 12 \tvcvtph2uw 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7d ca    \tvcvtph2w %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7d ca    \tvcvtph2w %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7d ca    \tvcvtph2w %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 7d 8c c8 78 56 34 12 \tvcvtph2w 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7d 48 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%zmm1,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0x62, 0xf3, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7d 48 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%zmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf3, 0x7d, 0x48, 0x1d, 0xd1, 0x12, }, 7, 0, "", "",
+"62 f3 7d 48 1d d1 12 \tvcvtps2ph $0x12,%zmm2,%ymm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 7d 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm1,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0xc4, 0xe3, 0x7d, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"67 c4 e3 7d 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm1,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 79 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm1,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0xc4, 0xe3, 0x79, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"67 c4 e3 79 1d 8c c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm1,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 79 1d d1 12    \tvcvtps2ph $0x12,%xmm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 7d 1d d1 12    \tvcvtps2ph $0x12,%ymm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 7d 1d d1 12    \tvcvtps2ph $0x12,%ymm2,%xmm1",},
+{{0xc4, 0xe3, 0x7d, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 7d 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm2,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0xc4, 0xe3, 0x7d, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"67 c4 e3 7d 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%ymm2,0x12345678(%eax,%ecx,8)",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0xd1, 0x12, }, 6, 0, "", "",
+"c4 e3 79 1d d1 12    \tvcvtps2ph $0x12,%xmm2,%xmm1",},
+{{0xc4, 0xe3, 0x79, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 11, 0, "", "",
+"c4 e3 79 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm2,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0xc4, 0xe3, 0x79, 0x1d, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"67 c4 e3 79 1d 94 c8 78 56 34 12 12 \tvcvtps2ph $0x12,%xmm2,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 1d ca    \tvcvtps2phx %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 1d 8c c8 78 56 34 12 \tvcvtps2phx 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 1d 8c c8 78 56 34 12 \tvcvtps2phx 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 1d ca    \tvcvtps2phx %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x1d, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 1d ca    \tvcvtps2phx %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 48 5b ca    \tvcvtqq2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 08 5b ca    \tvcvtqq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xfc, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 fc 28 5b ca    \tvcvtqq2ph %ymm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0xef, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 ef 08 5a 8c c8 78 56 34 12 \tvcvtsd2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x5a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 5a 8c c8 78 56 34 12 \tvcvtsh2sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x2d, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 2d 84 c8 78 56 34 12 \tvcvtsh2si 0x12345678(%eax,%ecx,8),%eax",},
+{{0x67, 0x62, 0xf5, 0xfe, 0x08, 0x2d, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 fe 08 2d 84 c8 78 56 34 12 \tvcvtsh2si 0x12345678(%eax,%ecx,8),%rax",},
+{{0x67, 0x62, 0xf6, 0x6c, 0x08, 0x13, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6c 08 13 8c c8 78 56 34 12 \tvcvtsh2ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x79, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 79 c1    \tvcvtsh2usi %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x79, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 79 84 c8 78 56 34 12 \tvcvtsh2usi 0x12345678(%rax,%rcx,8),%eax",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x79, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 79 84 c8 78 56 34 12 \tvcvtsh2usi 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x79, 0xc1, }, 6, 0, "", "",
+"62 f5 fe 08 79 c1    \tvcvtsh2usi %xmm1,%rax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x79, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 fe 08 79 84 c8 78 56 34 12 \tvcvtsh2usi 0x12345678(%rax,%rcx,8),%rax",},
+{{0x67, 0x62, 0xf5, 0xfe, 0x08, 0x79, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 fe 08 79 84 c8 78 56 34 12 \tvcvtsh2usi 0x12345678(%eax,%ecx,8),%rax",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0xc8, }, 6, 0, "", "",
+"62 f5 6e 08 2a c8    \tvcvtsi2sh %eax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2shl 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2shl 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0xee, 0x08, 0x2a, 0xc8, }, 6, 0, "", "",
+"62 f5 ee 08 2a c8    \tvcvtsi2sh %rax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2shl 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x2a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 2a 8c c8 78 56 34 12 \tvcvtsi2shl 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x1d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 1d cb    \tvcvtss2sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 1d 8c c8 78 56 34 12 \tvcvtss2sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x1d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 1d 8c c8 78 56 34 12 \tvcvtss2sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 48 5b ca    \tvcvttph2dq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 48 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x48, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 48 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 08 5b ca    \tvcvttph2dq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x5b, 0xca, }, 6, 0, "", "",
+"62 f5 7e 28 5b ca    \tvcvttph2dq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 28 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x28, 0x5b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 28 5b 8c c8 78 56 34 12 \tvcvttph2dq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7a ca    \tvcvttph2qq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7a ca    \tvcvttph2qq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7a ca    \tvcvttph2qq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 7a 8c c8 78 56 34 12 \tvcvttph2qq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 78 ca    \tvcvttph2udq %ymm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 78 ca    \tvcvttph2udq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 78 ca    \tvcvttph2udq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 78 8c c8 78 56 34 12 \tvcvttph2udq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 78 ca    \tvcvttph2uqq %xmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 78 ca    \tvcvttph2uqq %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x78, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 78 ca    \tvcvttph2uqq %xmm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x78, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 78 8c c8 78 56 34 12 \tvcvttph2uqq 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 7c ca    \tvcvttph2uw %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 7c ca    \tvcvttph2uw %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 7c ca    \tvcvttph2uw %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 7c 8c c8 78 56 34 12 \tvcvttph2uw 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 48 7c ca    \tvcvttph2w %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 48 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x48, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 48 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 08 7c ca    \tvcvttph2w %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7c, 0xca, }, 6, 0, "", "",
+"62 f5 7d 28 7c ca    \tvcvttph2w %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7d, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 28 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x28, 0x7c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 28 7c 8c c8 78 56 34 12 \tvcvttph2w 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x2c, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 2c c1    \tvcvttsh2si %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x2c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 2c 84 c8 78 56 34 12 \tvcvttsh2si 0x12345678(%rax,%rcx,8),%eax",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x2c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 2c 84 c8 78 56 34 12 \tvcvttsh2si 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x2c, 0xc1, }, 6, 0, "", "",
+"62 f5 fe 08 2c c1    \tvcvttsh2si %xmm1,%rax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x2c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 fe 08 2c 84 c8 78 56 34 12 \tvcvttsh2si 0x12345678(%rax,%rcx,8),%rax",},
+{{0x67, 0x62, 0xf5, 0xfe, 0x08, 0x2c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 fe 08 2c 84 c8 78 56 34 12 \tvcvttsh2si 0x12345678(%eax,%ecx,8),%rax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x78, 0xc1, }, 6, 0, "", "",
+"62 f5 7e 08 78 c1    \tvcvttsh2usi %xmm1,%eax",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x78, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 78 84 c8 78 56 34 12 \tvcvttsh2usi 0x12345678(%rax,%rcx,8),%eax",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x78, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 78 84 c8 78 56 34 12 \tvcvttsh2usi 0x12345678(%eax,%ecx,8),%eax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x78, 0xc1, }, 6, 0, "", "",
+"62 f5 fe 08 78 c1    \tvcvttsh2usi %xmm1,%rax",},
+{{0x62, 0xf5, 0xfe, 0x08, 0x78, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 fe 08 78 84 c8 78 56 34 12 \tvcvttsh2usi 0x12345678(%rax,%rcx,8),%rax",},
+{{0x67, 0x62, 0xf5, 0xfe, 0x08, 0x78, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 fe 08 78 84 c8 78 56 34 12 \tvcvttsh2usi 0x12345678(%eax,%ecx,8),%rax",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 48 7a ca    \tvcvtudq2ph %zmm2,%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 48 7a 8c c8 78 56 34 12 \tvcvtudq2ph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7f, 0x48, 0x7a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7f 48 7a 8c c8 78 56 34 12 \tvcvtudq2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 08 7a ca    \tvcvtudq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 7f 28 7a ca    \tvcvtudq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x48, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 48 7a ca    \tvcvtuqq2ph %zmm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x08, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 08 7a ca    \tvcvtuqq2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0xff, 0x28, 0x7a, 0xca, }, 6, 0, "", "",
+"62 f5 ff 28 7a ca    \tvcvtuqq2ph %ymm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0xc8, }, 6, 0, "", "",
+"62 f5 6e 08 7b c8    \tvcvtusi2sh %eax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2shl 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2shl 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0xee, 0x08, 0x7b, 0xc8, }, 6, 0, "", "",
+"62 f5 ee 08 7b c8    \tvcvtusi2sh %rax,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2shl 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x7b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 7b 8c c8 78 56 34 12 \tvcvtusi2shl 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 48 7d ca    \tvcvtuw2ph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7f, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 48 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7f, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7f 48 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 08 7d ca    \tvcvtuw2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 08 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7f, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7f 08 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7f 28 7d ca    \tvcvtuw2ph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7f, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7f 28 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7f, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7f 28 7d 8c c8 78 56 34 12 \tvcvtuw2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 48 7d ca    \tvcvtw2ph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 48 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x48, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 48 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 08 7d ca    \tvcvtw2ph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x7d, 0xca, }, 6, 0, "", "",
+"62 f5 7e 28 7d ca    \tvcvtw2ph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7e, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 28 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x28, 0x7d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 28 7d 8c c8 78 56 34 12 \tvcvtw2ph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5e cb    \tvdivph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5e cb    \tvdivph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5e cb    \tvdivph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 5e 8c c8 78 56 34 12 \tvdivph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5e, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5e cb    \tvdivsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5e 8c c8 78 56 34 12 \tvdivsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x5e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 5e 8c c8 78 56 34 12 \tvdivsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 48 56 cb    \tvfcmaddcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 48 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 48 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 56 cb    \tvfcmaddcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 08 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 28 56 cb    \tvfcmaddcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 28 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 28 56 8c c8 78 56 34 12 \tvfcmaddcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x57, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 57 cb    \tvfcmaddcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 57 8c c8 78 56 34 12 \tvfcmaddcsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 08 57 8c c8 78 56 34 12 \tvfcmaddcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 48 d6 cb    \tvfcmulcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 48 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 48 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 d6 cb    \tvfcmulcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 08 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 28 d6 cb    \tvfcmulcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 28 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 28 d6 8c c8 78 56 34 12 \tvfcmulcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd7, 0xcb, }, 6, 0, "", "",
+"62 f6 6f 08 d7 cb    \tvfcmulcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6f, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6f 08 d7 8c c8 78 56 34 12 \tvfcmulcsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6f, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6f 08 d7 8c c8 78 56 34 12 \tvfcmulcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 98 cb    \tvfmadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 98 cb    \tvfmadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x98, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 98 cb    \tvfmadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x98, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 98 8c c8 78 56 34 12 \tvfmadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x99, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 99 cb    \tvfmadd132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x99, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 99 8c c8 78 56 34 12 \tvfmadd132sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x99, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 99 8c c8 78 56 34 12 \tvfmadd132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a8 cb    \tvfmadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a8 cb    \tvfmadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a8 cb    \tvfmadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xa8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 a8 8c c8 78 56 34 12 \tvfmadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa9, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a9 cb    \tvfmadd213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a9 8c c8 78 56 34 12 \tvfmadd213sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xa9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 a9 8c c8 78 56 34 12 \tvfmadd213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b8 cb    \tvfmadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b8 cb    \tvfmadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb8, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b8 cb    \tvfmadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xb8, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 b8 8c c8 78 56 34 12 \tvfmadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb9, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b9 cb    \tvfmadd231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b9 8c c8 78 56 34 12 \tvfmadd231sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xb9, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 b9 8c c8 78 56 34 12 \tvfmadd231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 48 56 cb    \tvfmaddcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 48 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 48 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 56 cb    \tvfmaddcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 08 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0x56, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 28 56 cb    \tvfmaddcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 28 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 28 56 8c c8 78 56 34 12 \tvfmaddcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x57, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 57 cb    \tvfmaddcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 57 8c c8 78 56 34 12 \tvfmaddcsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 08 57 8c c8 78 56 34 12 \tvfmaddcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 96 cb    \tvfmaddsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 96 cb    \tvfmaddsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x96, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 96 cb    \tvfmaddsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x96, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 96 8c c8 78 56 34 12 \tvfmaddsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a6 cb    \tvfmaddsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a6 cb    \tvfmaddsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a6 cb    \tvfmaddsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xa6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 a6 8c c8 78 56 34 12 \tvfmaddsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b6 cb    \tvfmaddsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b6 cb    \tvfmaddsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb6, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b6 cb    \tvfmaddsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xb6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 b6 8c c8 78 56 34 12 \tvfmaddsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9a cb    \tvfmsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9a cb    \tvfmsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9a, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9a cb    \tvfmsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x9a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 9a 8c c8 78 56 34 12 \tvfmsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9b, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9b cb    \tvfmsub132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9b 8c c8 78 56 34 12 \tvfmsub132sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9b, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9b 8c c8 78 56 34 12 \tvfmsub132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 aa cb    \tvfmsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 aa cb    \tvfmsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xaa, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 aa cb    \tvfmsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xaa, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 aa 8c c8 78 56 34 12 \tvfmsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xab, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ab cb    \tvfmsub213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xab, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ab 8c c8 78 56 34 12 \tvfmsub213sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xab, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 ab 8c c8 78 56 34 12 \tvfmsub213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ba cb    \tvfmsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ba cb    \tvfmsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xba, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ba cb    \tvfmsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xba, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 ba 8c c8 78 56 34 12 \tvfmsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbb, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bb cb    \tvfmsub231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbb, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bb 8c c8 78 56 34 12 \tvfmsub231sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xbb, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 bb 8c c8 78 56 34 12 \tvfmsub231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 97 cb    \tvfmsubadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 97 cb    \tvfmsubadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x97, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 97 cb    \tvfmsubadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x97, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 97 8c c8 78 56 34 12 \tvfmsubadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 a7 cb    \tvfmsubadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 a7 cb    \tvfmsubadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 a7 cb    \tvfmsubadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xa7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 a7 8c c8 78 56 34 12 \tvfmsubadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 b7 cb    \tvfmsubadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 b7 cb    \tvfmsubadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb7, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 b7 cb    \tvfmsubadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xb7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 b7 8c c8 78 56 34 12 \tvfmsubadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 48 d6 cb    \tvfmulcph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 48 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x48, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 48 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 d6 cb    \tvfmulcph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x08, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 08 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0xd6, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 28 d6 cb    \tvfmulcph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 28 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x28, 0xd6, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 28 d6 8c c8 78 56 34 12 \tvfmulcph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd7, 0xcb, }, 6, 0, "", "",
+"62 f6 6e 08 d7 cb    \tvfmulcsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6e, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6e 08 d7 8c c8 78 56 34 12 \tvfmulcsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6e, 0x08, 0xd7, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6e 08 d7 8c c8 78 56 34 12 \tvfmulcsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9c cb    \tvfnmadd132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9c cb    \tvfnmadd132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9c cb    \tvfnmadd132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x9c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 9c 8c c8 78 56 34 12 \tvfnmadd132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9d cb    \tvfnmadd132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9d 8c c8 78 56 34 12 \tvfnmadd132sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9d 8c c8 78 56 34 12 \tvfnmadd132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ac cb    \tvfnmadd213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ac cb    \tvfnmadd213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xac, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ac cb    \tvfnmadd213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xac, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 ac 8c c8 78 56 34 12 \tvfnmadd213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xad, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ad cb    \tvfnmadd213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xad, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ad 8c c8 78 56 34 12 \tvfnmadd213sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xad, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 ad 8c c8 78 56 34 12 \tvfnmadd213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 bc cb    \tvfnmadd231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bc cb    \tvfnmadd231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbc, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 bc cb    \tvfnmadd231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xbc, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 bc 8c c8 78 56 34 12 \tvfnmadd231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbd, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bd cb    \tvfnmadd231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbd, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bd 8c c8 78 56 34 12 \tvfnmadd231sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xbd, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 bd 8c c8 78 56 34 12 \tvfnmadd231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 9e cb    \tvfnmsub132ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9e cb    \tvfnmsub132ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9e, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 9e cb    \tvfnmsub132ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x9e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 9e 8c c8 78 56 34 12 \tvfnmsub132ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9f, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 9f cb    \tvfnmsub132sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x9f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 9f 8c c8 78 56 34 12 \tvfnmsub132sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x9f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 9f 8c c8 78 56 34 12 \tvfnmsub132sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 ae cb    \tvfnmsub213ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 ae cb    \tvfnmsub213ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xae, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 ae cb    \tvfnmsub213ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xae, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 ae 8c c8 78 56 34 12 \tvfnmsub213ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaf, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 af cb    \tvfnmsub213sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xaf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 af 8c c8 78 56 34 12 \tvfnmsub213sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xaf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 af 8c c8 78 56 34 12 \tvfnmsub213sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 be cb    \tvfnmsub231ph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 be cb    \tvfnmsub231ph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbe, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 be cb    \tvfnmsub231ph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0xbe, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 be 8c c8 78 56 34 12 \tvfnmsub231ph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbf, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 bf cb    \tvfnmsub231sh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0xbf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 bf 8c c8 78 56 34 12 \tvfnmsub231sh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0xbf, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 bf 8c c8 78 56 34 12 \tvfnmsub231sh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 66 e9 12 \tvfpclassph $0x12,%zmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 66 e9 12 \tvfpclassph $0x12,%xmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x66, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 66 e9 12 \tvfpclassph $0x12,%ymm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x67, 0xe9, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 67 e9 12 \tvfpclasssh $0x12,%xmm1,%k5",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x67, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 67 ac c8 78 56 34 12 12 \tvfpclasssh $0x12,0x12345678(%rax,%rcx,8),%k5",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x08, 0x67, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 08 67 ac c8 78 56 34 12 12 \tvfpclasssh $0x12,0x12345678(%eax,%ecx,8),%k5",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 42 ca    \tvgetexpph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x48, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 48 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 42 ca    \tvgetexpph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x08, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 08 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x42, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 42 ca    \tvgetexpph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x28, 0x42, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 28 42 8c c8 78 56 34 12 \tvgetexpph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x43, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 43 cb    \tvgetexpsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x43, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 43 8c c8 78 56 34 12 \tvgetexpsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x43, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 43 8c c8 78 56 34 12 \tvgetexpsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 26 ca 12 \tvgetmantph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x48, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 48 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 26 ca 12 \tvgetmantph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x08, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 08 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x26, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 26 ca 12 \tvgetmantph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x28, 0x26, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 28 26 8c c8 78 56 34 12 12 \tvgetmantph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x27, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 27 cb 12 \tvgetmantsh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x27, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 27 8c c8 78 56 34 12 12 \tvgetmantsh $0x12,0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x08, 0x27, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 08 27 8c c8 78 56 34 12 12 \tvgetmantsh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5f cb    \tvmaxph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5f cb    \tvmaxph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5f cb    \tvmaxph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 5f 8c c8 78 56 34 12 \tvmaxph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5f, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5f cb    \tvmaxsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5f 8c c8 78 56 34 12 \tvmaxsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x5f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 5f 8c c8 78 56 34 12 \tvmaxsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5d cb    \tvminph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5d cb    \tvminph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5d cb    \tvminph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 5d 8c c8 78 56 34 12 \tvminph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5d, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5d cb    \tvminsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5d 8c c8 78 56 34 12 \tvminsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x5d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 5d 8c c8 78 56 34 12 \tvminsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x11, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 11 8c c8 78 56 34 12 \tvmovsh %xmm1,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x11, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 11 8c c8 78 56 34 12 \tvmovsh %xmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7e, 0x08, 0x10, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7e 08 10 8c c8 78 56 34 12 \tvmovsh 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7e, 0x08, 0x10, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7e 08 10 8c c8 78 56 34 12 \tvmovsh 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x10, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 10 cb    \tvmovsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7e, 0xc8, }, 6, 0, "", "",
+"62 f5 7d 08 7e c8    \tvmovw  %xmm1,%eax",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x7e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 7e 8c c8 78 56 34 12 \tvmovw  %xmm1,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x7e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 7e 8c c8 78 56 34 12 \tvmovw  %xmm1,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x6e, 0xc8, }, 6, 0, "", "",
+"62 f5 7d 08 6e c8    \tvmovw  %eax,%xmm1",},
+{{0x62, 0xf5, 0x7d, 0x08, 0x6e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7d 08 6e 8c c8 78 56 34 12 \tvmovw  0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7d, 0x08, 0x6e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7d 08 6e 8c c8 78 56 34 12 \tvmovw  0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 59 cb    \tvmulph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 59 cb    \tvmulph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 59 cb    \tvmulph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 59 8c c8 78 56 34 12 \tvmulph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x59, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 59 cb    \tvmulsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 59 8c c8 78 56 34 12 \tvmulsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x59, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 59 8c c8 78 56 34 12 \tvmulsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 4c ca    \tvrcpph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x48, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 48 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 4c ca    \tvrcpph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x08, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 08 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4c, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 4c ca    \tvrcpph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x28, 0x4c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 28 4c 8c c8 78 56 34 12 \tvrcpph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 4d cb    \tvrcpsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 4d 8c c8 78 56 34 12 \tvrcpsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x4d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 4d 8c c8 78 56 34 12 \tvrcpsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 56 ca 12 \tvreduceph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x48, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 48 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 56 ca 12 \tvreduceph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x08, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 08 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x56, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 56 ca 12 \tvreduceph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x28, 0x56, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 28 56 8c c8 78 56 34 12 12 \tvreduceph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x57, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 57 cb 12 \tvreducesh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 57 8c c8 78 56 34 12 12 \tvreducesh $0x12,0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x08, 0x57, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 08 57 8c c8 78 56 34 12 12 \tvreducesh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 48 08 ca 12 \tvrndscaleph $0x12,%zmm2,%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x48, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 48 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x48, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 48 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 08 08 ca 12 \tvrndscaleph $0x12,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x08, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 08 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x08, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 08 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x08, 0xca, 0x12, }, 7, 0, "", "",
+"62 f3 7c 28 08 ca 12 \tvrndscaleph $0x12,%ymm2,%ymm1",},
+{{0x62, 0xf3, 0x7c, 0x28, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 7c 28 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf3, 0x7c, 0x28, 0x08, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 7c 28 08 8c c8 78 56 34 12 12 \tvrndscaleph $0x12,0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x0a, 0xcb, 0x12, }, 7, 0, "", "",
+"62 f3 6c 08 0a cb 12 \tvrndscalesh $0x12,%xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf3, 0x6c, 0x08, 0x0a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 12, 0, "", "",
+"62 f3 6c 08 0a 8c c8 78 56 34 12 12 \tvrndscalesh $0x12,0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf3, 0x6c, 0x08, 0x0a, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, 0x12, }, 13, 0, "", "",
+"67 62 f3 6c 08 0a 8c c8 78 56 34 12 12 \tvrndscalesh $0x12,0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 48 4e ca    \tvrsqrtph %zmm2,%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x48, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 48 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x48, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 48 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 08 4e ca    \tvrsqrtph %xmm2,%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x08, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 08 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x08, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 08 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4e, 0xca, }, 6, 0, "", "",
+"62 f6 7d 28 4e ca    \tvrsqrtph %ymm2,%ymm1",},
+{{0x62, 0xf6, 0x7d, 0x28, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 7d 28 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf6, 0x7d, 0x28, 0x4e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 7d 28 4e 8c c8 78 56 34 12 \tvrsqrtph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4f, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 4f cb    \tvrsqrtsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x4f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 4f 8c c8 78 56 34 12 \tvrsqrtsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x4f, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 4f 8c c8 78 56 34 12 \tvrsqrtsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 48 2c cb    \tvscalefph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x48, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 48 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x48, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 48 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 2c cb    \tvscalefph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x2c, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 28 2c cb    \tvscalefph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x28, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 28 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x28, 0x2c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 28 2c 8c c8 78 56 34 12 \tvscalefph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2d, 0xcb, }, 6, 0, "", "",
+"62 f6 6d 08 2d cb    \tvscalefsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf6, 0x6d, 0x08, 0x2d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f6 6d 08 2d 8c c8 78 56 34 12 \tvscalefsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf6, 0x6d, 0x08, 0x2d, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f6 6d 08 2d 8c c8 78 56 34 12 \tvscalefsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 48 51 ca    \tvsqrtph %zmm2,%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x48, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 48 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%rax,%rcx,8),%zmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x48, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 48 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%zmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 51 ca    \tvsqrtph %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x51, 0xca, }, 6, 0, "", "",
+"62 f5 7c 28 51 ca    \tvsqrtph %ymm2,%ymm1",},
+{{0x62, 0xf5, 0x7c, 0x28, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 28 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%rax,%rcx,8),%ymm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x28, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 28 51 8c c8 78 56 34 12 \tvsqrtph 0x12345678(%eax,%ecx,8),%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x51, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 51 cb    \tvsqrtsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 51 8c c8 78 56 34 12 \tvsqrtsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x51, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 51 8c c8 78 56 34 12 \tvsqrtsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 48 5c cb    \tvsubph %zmm3,%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x48, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 48 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%rax,%rcx,8),%zmm2,%zmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x48, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 48 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 08 5c cb    \tvsubph %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 08 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 08 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6c 28 5c cb    \tvsubph %ymm3,%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6c, 0x28, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6c 28 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%rax,%rcx,8),%ymm2,%ymm1",},
+{{0x67, 0x62, 0xf5, 0x6c, 0x28, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6c 28 5c 8c c8 78 56 34 12 \tvsubph 0x12345678(%eax,%ecx,8),%ymm2,%ymm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5c, 0xcb, }, 6, 0, "", "",
+"62 f5 6e 08 5c cb    \tvsubsh %xmm3,%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x6e, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 6e 08 5c 8c c8 78 56 34 12 \tvsubsh 0x12345678(%rax,%rcx,8),%xmm2,%xmm1",},
+{{0x67, 0x62, 0xf5, 0x6e, 0x08, 0x5c, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 6e 08 5c 8c c8 78 56 34 12 \tvsubsh 0x12345678(%eax,%ecx,8),%xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2e, 0xca, }, 6, 0, "", "",
+"62 f5 7c 08 2e ca    \tvucomish %xmm2,%xmm1",},
+{{0x62, 0xf5, 0x7c, 0x08, 0x2e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f5 7c 08 2e 8c c8 78 56 34 12 \tvucomish 0x12345678(%rax,%rcx,8),%xmm1",},
+{{0x67, 0x62, 0xf5, 0x7c, 0x08, 0x2e, 0x8c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f5 7c 08 2e 8c c8 78 56 34 12 \tvucomish 0x12345678(%eax,%ecx,8),%xmm1",},
 {{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
 "f3 0f 3a f0 c0 00    \threset $0x0",},
 {{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index 425db6a..a391464 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -1940,6 +1940,694 @@ int main(void)
 	asm volatile("testui");
 	asm volatile("uiret");
 
+	/* AVX512-FP16 */
+
+	asm volatile("vaddph %zmm3, %zmm2, %zmm1");
+	asm volatile("vaddph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vaddph %xmm3, %xmm2, %xmm1");
+	asm volatile("vaddph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vaddph %ymm3, %ymm2, %ymm1");
+	asm volatile("vaddph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vaddsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vaddsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vaddsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcmpph $0x12, %zmm3, %zmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%rax,%rcx,8), %zmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %zmm2, %k5");
+	asm volatile("vcmpph $0x12, %xmm3, %xmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%rax,%rcx,8), %xmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %k5");
+	asm volatile("vcmpph $0x12, %ymm3, %ymm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%rax,%rcx,8), %ymm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %ymm2, %k5");
+	asm volatile("vcmpsh $0x12, %xmm3, %xmm2, %k5");
+	asm volatile("vcmpsh $0x12, 0x12345678(%rax,%rcx,8), %xmm2, %k5");
+	asm volatile("vcmpsh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %k5");
+	asm volatile("vcomish %xmm2, %xmm1");
+	asm volatile("vcomish 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcomish 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtdq2ph %zmm2, %ymm1");
+	asm volatile("vcvtdq2ph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtdq2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtdq2ph %xmm2, %xmm1");
+	asm volatile("vcvtdq2ph %ymm2, %xmm1");
+	asm volatile("vcvtpd2ph %zmm2, %xmm1");
+	asm volatile("vcvtpd2ph %xmm2, %xmm1");
+	asm volatile("vcvtpd2ph %ymm2, %xmm1");
+	asm volatile("vcvtph2dq %ymm2, %zmm1");
+	asm volatile("vcvtph2dq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2dq %xmm2, %xmm1");
+	asm volatile("vcvtph2dq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2dq %xmm2, %ymm1");
+	asm volatile("vcvtph2dq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2pd %xmm2, %zmm1");
+	asm volatile("vcvtph2pd 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2pd %xmm2, %xmm1");
+	asm volatile("vcvtph2pd 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2pd %xmm2, %ymm1");
+	asm volatile("vcvtph2pd 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2ps %ymm2, %zmm1");
+	asm volatile("vcvtph2ps 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2ps %xmm2, %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2ps %xmm2, %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2ps %xmm2, %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2ps %xmm2, %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2psx %ymm2, %zmm1");
+	asm volatile("vcvtph2psx 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2psx %xmm2, %xmm1");
+	asm volatile("vcvtph2psx 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2psx %xmm2, %ymm1");
+	asm volatile("vcvtph2psx 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2qq %xmm2, %zmm1");
+	asm volatile("vcvtph2qq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2qq %xmm2, %xmm1");
+	asm volatile("vcvtph2qq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2qq %xmm2, %ymm1");
+	asm volatile("vcvtph2qq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2udq %ymm2, %zmm1");
+	asm volatile("vcvtph2udq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2udq %xmm2, %xmm1");
+	asm volatile("vcvtph2udq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2udq %xmm2, %ymm1");
+	asm volatile("vcvtph2udq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2uqq %xmm2, %zmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2uqq %xmm2, %xmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2uqq %xmm2, %ymm1");
+	asm volatile("vcvtph2uqq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2uw %zmm2, %zmm1");
+	asm volatile("vcvtph2uw 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2uw %xmm2, %xmm1");
+	asm volatile("vcvtph2uw 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2uw %ymm2, %ymm1");
+	asm volatile("vcvtph2uw 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2w %zmm2, %zmm1");
+	asm volatile("vcvtph2w 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2w %xmm2, %xmm1");
+	asm volatile("vcvtph2w 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2w %ymm2, %ymm1");
+	asm volatile("vcvtph2w 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtps2ph $0x12, %zmm1, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vcvtps2ph $0x12, %zmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %zmm2, %ymm1");
+	asm volatile("vcvtps2ph $0x12, %ymm1, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vcvtps2ph $0x12, %ymm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm1, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vcvtps2ph $0x12, %ymm2, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %xmm2, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm2, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2phx %zmm2, %ymm1");
+	asm volatile("vcvtps2phx 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtps2phx 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtps2phx %xmm2, %xmm1");
+	asm volatile("vcvtps2phx %ymm2, %xmm1");
+	asm volatile("vcvtqq2ph %zmm2, %xmm1");
+	asm volatile("vcvtqq2ph %xmm2, %xmm1");
+	asm volatile("vcvtqq2ph %ymm2, %xmm1");
+	asm volatile("vcvtsd2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2sd 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2si 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvtsh2si 0x12345678(%eax,%ecx,8), %rax");
+	asm volatile("vcvtsh2ss 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2usi %xmm1, %eax");
+	asm volatile("vcvtsh2usi 0x12345678(%rax,%rcx,8), %eax");
+	asm volatile("vcvtsh2usi 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvtsh2usi %xmm1, %rax");
+	asm volatile("vcvtsh2usi 0x12345678(%rax,%rcx,8), %rax");
+	asm volatile("vcvtsh2usi 0x12345678(%eax,%ecx,8), %rax");
+	asm volatile("vcvtsi2sh %eax, %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh %rax, %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtss2sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vcvtss2sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vcvtss2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvttph2dq %ymm2, %zmm1");
+	asm volatile("vcvttph2dq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2dq %xmm2, %xmm1");
+	asm volatile("vcvttph2dq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2dq %xmm2, %ymm1");
+	asm volatile("vcvttph2dq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2qq %xmm2, %zmm1");
+	asm volatile("vcvttph2qq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2qq %xmm2, %xmm1");
+	asm volatile("vcvttph2qq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2qq %xmm2, %ymm1");
+	asm volatile("vcvttph2qq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2udq %ymm2, %zmm1");
+	asm volatile("vcvttph2udq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2udq %xmm2, %xmm1");
+	asm volatile("vcvttph2udq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2udq %xmm2, %ymm1");
+	asm volatile("vcvttph2udq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2uqq %xmm2, %zmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2uqq %xmm2, %xmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2uqq %xmm2, %ymm1");
+	asm volatile("vcvttph2uqq 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2uw %zmm2, %zmm1");
+	asm volatile("vcvttph2uw 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2uw %xmm2, %xmm1");
+	asm volatile("vcvttph2uw 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2uw %ymm2, %ymm1");
+	asm volatile("vcvttph2uw 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2w %zmm2, %zmm1");
+	asm volatile("vcvttph2w 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2w %xmm2, %xmm1");
+	asm volatile("vcvttph2w 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2w %ymm2, %ymm1");
+	asm volatile("vcvttph2w 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttsh2si %xmm1, %eax");
+	asm volatile("vcvttsh2si 0x12345678(%rax,%rcx,8), %eax");
+	asm volatile("vcvttsh2si 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvttsh2si %xmm1, %rax");
+	asm volatile("vcvttsh2si 0x12345678(%rax,%rcx,8), %rax");
+	asm volatile("vcvttsh2si 0x12345678(%eax,%ecx,8), %rax");
+	asm volatile("vcvttsh2usi %xmm1, %eax");
+	asm volatile("vcvttsh2usi 0x12345678(%rax,%rcx,8), %eax");
+	asm volatile("vcvttsh2usi 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvttsh2usi %xmm1, %rax");
+	asm volatile("vcvttsh2usi 0x12345678(%rax,%rcx,8), %rax");
+	asm volatile("vcvttsh2usi 0x12345678(%eax,%ecx,8), %rax");
+	asm volatile("vcvtudq2ph %zmm2, %ymm1");
+	asm volatile("vcvtudq2ph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtudq2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtudq2ph %xmm2, %xmm1");
+	asm volatile("vcvtudq2ph %ymm2, %xmm1");
+	asm volatile("vcvtuqq2ph %zmm2, %xmm1");
+	asm volatile("vcvtuqq2ph %xmm2, %xmm1");
+	asm volatile("vcvtuqq2ph %ymm2, %xmm1");
+	asm volatile("vcvtusi2sh %eax, %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh %rax, %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtuw2ph %zmm2, %zmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtuw2ph %xmm2, %xmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtuw2ph %ymm2, %ymm1");
+	asm volatile("vcvtuw2ph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtw2ph %zmm2, %zmm1");
+	asm volatile("vcvtw2ph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtw2ph %xmm2, %xmm1");
+	asm volatile("vcvtw2ph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtw2ph %ymm2, %ymm1");
+	asm volatile("vcvtw2ph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vdivph %zmm3, %zmm2, %zmm1");
+	asm volatile("vdivph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vdivph %xmm3, %xmm2, %xmm1");
+	asm volatile("vdivph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vdivph %ymm3, %ymm2, %ymm1");
+	asm volatile("vdivph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vdivsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vdivsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vdivsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfcmaddcph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfcmaddcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmaddcph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfcmaddcph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfcmaddcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmaddcsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfcmulcph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfcmulcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmulcph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfcmulcph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfcmulcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmulcsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd132sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd213sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd231sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddcph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddcph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddcph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddcsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub132sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub213sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub231sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmulcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmulcph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmulcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmulcph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmulcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmulcph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmulcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmulcsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfmulcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd132sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd213sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd231sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub132ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub132sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub213ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub213sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub231ph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub231sh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfpclassph $0x12, %zmm1, %k5");
+	asm volatile("vfpclassph $0x12, %xmm1, %k5");
+	asm volatile("vfpclassph $0x12, %ymm1, %k5");
+	asm volatile("vfpclasssh $0x12, %xmm1, %k5");
+	asm volatile("vfpclasssh $0x12, 0x12345678(%rax,%rcx,8), %k5");
+	asm volatile("vfpclasssh $0x12, 0x12345678(%eax,%ecx,8), %k5");
+	asm volatile("vgetexpph %zmm2, %zmm1");
+	asm volatile("vgetexpph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vgetexpph %xmm2, %xmm1");
+	asm volatile("vgetexpph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vgetexpph %ymm2, %ymm1");
+	asm volatile("vgetexpph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vgetexpsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vgetexpsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vgetexpsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vgetmantph $0x12, %zmm2, %zmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vgetmantph $0x12, %xmm2, %xmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vgetmantph $0x12, %ymm2, %ymm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vgetmantsh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vgetmantsh $0x12, 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vgetmantsh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmaxph %zmm3, %zmm2, %zmm1");
+	asm volatile("vmaxph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vmaxph %xmm3, %xmm2, %xmm1");
+	asm volatile("vmaxph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmaxph %ymm3, %ymm2, %ymm1");
+	asm volatile("vmaxph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vmaxsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmaxsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vmaxsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vminph %zmm3, %zmm2, %zmm1");
+	asm volatile("vminph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vminph %xmm3, %xmm2, %xmm1");
+	asm volatile("vminph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vminph %ymm3, %ymm2, %ymm1");
+	asm volatile("vminph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vminsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vminsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vminsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmovsh %xmm1, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vmovsh %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vmovsh 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vmovsh 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vmovsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmovw %xmm1, %eax");
+	asm volatile("vmovw %xmm1, 0x12345678(%rax,%rcx,8)");
+	asm volatile("vmovw %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vmovw %eax, %xmm1");
+	asm volatile("vmovw 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vmovw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vmulph %zmm3, %zmm2, %zmm1");
+	asm volatile("vmulph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vmulph %xmm3, %xmm2, %xmm1");
+	asm volatile("vmulph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmulph %ymm3, %ymm2, %ymm1");
+	asm volatile("vmulph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vmulsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmulsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vmulsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrcpph %zmm2, %zmm1");
+	asm volatile("vrcpph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrcpph %xmm2, %xmm1");
+	asm volatile("vrcpph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrcpph %ymm2, %ymm1");
+	asm volatile("vrcpph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrcpsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vrcpsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vrcpsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vreduceph $0x12, %zmm2, %zmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vreduceph $0x12, %xmm2, %xmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vreduceph $0x12, %ymm2, %ymm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vreducesh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vreducesh $0x12, 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vreducesh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrndscaleph $0x12, %zmm2, %zmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrndscaleph $0x12, %xmm2, %xmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrndscaleph $0x12, %ymm2, %ymm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrndscalesh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vrndscalesh $0x12, 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vrndscalesh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrsqrtph %zmm2, %zmm1");
+	asm volatile("vrsqrtph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrsqrtph %xmm2, %xmm1");
+	asm volatile("vrsqrtph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrsqrtph %ymm2, %ymm1");
+	asm volatile("vrsqrtph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrsqrtsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vrsqrtsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vrsqrtsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vscalefph %zmm3, %zmm2, %zmm1");
+	asm volatile("vscalefph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vscalefph %xmm3, %xmm2, %xmm1");
+	asm volatile("vscalefph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vscalefph %ymm3, %ymm2, %ymm1");
+	asm volatile("vscalefph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vscalefsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vscalefsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vscalefsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsqrtph %zmm2, %zmm1");
+	asm volatile("vsqrtph 0x12345678(%rax,%rcx,8), %zmm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vsqrtph %xmm2, %xmm1");
+	asm volatile("vsqrtph 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vsqrtph %ymm2, %ymm1");
+	asm volatile("vsqrtph 0x12345678(%rax,%rcx,8), %ymm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vsqrtsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vsqrtsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vsqrtsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsubph %zmm3, %zmm2, %zmm1");
+	asm volatile("vsubph 0x12345678(%rax,%rcx,8), %zmm2, %zmm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vsubph %xmm3, %xmm2, %xmm1");
+	asm volatile("vsubph 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsubph %ymm3, %ymm2, %ymm1");
+	asm volatile("vsubph 0x12345678(%rax,%rcx,8), %ymm2, %ymm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vsubsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vsubsh 0x12345678(%rax,%rcx,8), %xmm2, %xmm1");
+	asm volatile("vsubsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vucomish %xmm2, %xmm1");
+	asm volatile("vucomish 0x12345678(%rax,%rcx,8), %xmm1");
+	asm volatile("vucomish 0x12345678(%eax,%ecx,8), %xmm1");
+
 #else  /* #ifdef __x86_64__ */
 
 	/* bound r32, mem (same op code as EVEX prefix) */
@@ -3700,6 +4388,464 @@ int main(void)
 	asm volatile("notrack bnd jmp *(0x12345678)");		/* Expecting: jmp indirect 0 */
 	asm volatile("notrack bnd jmp *0x12345678(%eax,%ecx,8)"); /* Expecting: jmp indirect 0 */
 
+	/* AVX512-FP16 */
+
+	asm volatile("vaddph %zmm3, %zmm2, %zmm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vaddph %xmm3, %xmm2, %xmm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vaddph %ymm3, %ymm2, %ymm1");
+	asm volatile("vaddph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vaddsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vaddsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcmpph $0x12, %zmm3, %zmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %zmm2, %k5");
+	asm volatile("vcmpph $0x12, %xmm3, %xmm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %k5");
+	asm volatile("vcmpph $0x12, %ymm3, %ymm2, %k5");
+	asm volatile("vcmpph $0x12, 0x12345678(%eax,%ecx,8), %ymm2, %k5");
+	asm volatile("vcmpsh $0x12, %xmm3, %xmm2, %k5");
+	asm volatile("vcmpsh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %k5");
+	asm volatile("vcomish %xmm2, %xmm1");
+	asm volatile("vcomish 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtdq2ph %zmm2, %ymm1");
+	asm volatile("vcvtdq2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtdq2ph %xmm2, %xmm1");
+	asm volatile("vcvtdq2ph %ymm2, %xmm1");
+	asm volatile("vcvtpd2ph %zmm2, %xmm1");
+	asm volatile("vcvtpd2ph %xmm2, %xmm1");
+	asm volatile("vcvtpd2ph %ymm2, %xmm1");
+	asm volatile("vcvtph2dq %ymm2, %zmm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2dq %xmm2, %xmm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2dq %xmm2, %ymm1");
+	asm volatile("vcvtph2dq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2pd %xmm2, %zmm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2pd %xmm2, %xmm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2pd %xmm2, %ymm1");
+	asm volatile("vcvtph2pd 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2ps %ymm2, %zmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2ps %xmm2, %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2ps %xmm2, %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2ps %xmm2, %xmm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2ps %xmm2, %ymm1");
+	asm volatile("vcvtph2ps 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2psx %ymm2, %zmm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2psx %xmm2, %xmm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2psx %xmm2, %ymm1");
+	asm volatile("vcvtph2psx 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2qq %xmm2, %zmm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2qq %xmm2, %xmm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2qq %xmm2, %ymm1");
+	asm volatile("vcvtph2qq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2udq %ymm2, %zmm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2udq %xmm2, %xmm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2udq %xmm2, %ymm1");
+	asm volatile("vcvtph2udq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2uqq %xmm2, %zmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2uqq %xmm2, %xmm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2uqq %xmm2, %ymm1");
+	asm volatile("vcvtph2uqq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2uw %zmm2, %zmm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2uw %xmm2, %xmm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2uw %ymm2, %ymm1");
+	asm volatile("vcvtph2uw 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtph2w %zmm2, %zmm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtph2w %xmm2, %xmm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtph2w %ymm2, %ymm1");
+	asm volatile("vcvtph2w 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtps2ph $0x12, %zmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %zmm2, %ymm1");
+	asm volatile("vcvtps2ph $0x12, %ymm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %ymm2, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2ph $0x12, %xmm2, %xmm1");
+	asm volatile("vcvtps2ph $0x12, %xmm2, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vcvtps2phx %zmm2, %ymm1");
+	asm volatile("vcvtps2phx 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtps2phx %xmm2, %xmm1");
+	asm volatile("vcvtps2phx %ymm2, %xmm1");
+	asm volatile("vcvtqq2ph %zmm2, %xmm1");
+	asm volatile("vcvtqq2ph %xmm2, %xmm1");
+	asm volatile("vcvtqq2ph %ymm2, %xmm1");
+	asm volatile("vcvtsd2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2sd 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2si 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvtsh2ss 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsh2usi %xmm1, %eax");
+	asm volatile("vcvtsh2usi 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvtsi2sh %eax, %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtsi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtss2sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vcvtss2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvttph2dq %ymm2, %zmm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2dq %xmm2, %xmm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2dq %xmm2, %ymm1");
+	asm volatile("vcvttph2dq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2qq %xmm2, %zmm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2qq %xmm2, %xmm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2qq %xmm2, %ymm1");
+	asm volatile("vcvttph2qq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2udq %ymm2, %zmm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2udq %xmm2, %xmm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2udq %xmm2, %ymm1");
+	asm volatile("vcvttph2udq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2uqq %xmm2, %zmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2uqq %xmm2, %xmm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2uqq %xmm2, %ymm1");
+	asm volatile("vcvttph2uqq 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2uw %zmm2, %zmm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2uw %xmm2, %xmm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2uw %ymm2, %ymm1");
+	asm volatile("vcvttph2uw 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttph2w %zmm2, %zmm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvttph2w %xmm2, %xmm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvttph2w %ymm2, %ymm1");
+	asm volatile("vcvttph2w 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvttsh2si %xmm1, %eax");
+	asm volatile("vcvttsh2si 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvttsh2usi %xmm1, %eax");
+	asm volatile("vcvttsh2usi 0x12345678(%eax,%ecx,8), %eax");
+	asm volatile("vcvtudq2ph %zmm2, %ymm1");
+	asm volatile("vcvtudq2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtudq2ph %xmm2, %xmm1");
+	asm volatile("vcvtudq2ph %ymm2, %xmm1");
+	asm volatile("vcvtuqq2ph %zmm2, %xmm1");
+	asm volatile("vcvtuqq2ph %xmm2, %xmm1");
+	asm volatile("vcvtuqq2ph %ymm2, %xmm1");
+	asm volatile("vcvtusi2sh %eax, %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtusi2sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vcvtuw2ph %zmm2, %zmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtuw2ph %xmm2, %xmm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtuw2ph %ymm2, %ymm1");
+	asm volatile("vcvtuw2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vcvtw2ph %zmm2, %zmm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vcvtw2ph %xmm2, %xmm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vcvtw2ph %ymm2, %ymm1");
+	asm volatile("vcvtw2ph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vdivph %zmm3, %zmm2, %zmm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vdivph %xmm3, %xmm2, %xmm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vdivph %ymm3, %ymm2, %ymm1");
+	asm volatile("vdivph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vdivsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vdivsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfcmaddcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmaddcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfcmaddcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfcmaddcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmaddcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfcmulcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfcmulcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfcmulcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfcmulcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfcmulcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmadd231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmadd231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmaddsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmaddsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmaddsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmaddsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsub231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsub231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmsubadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmsubadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmsubadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmsubadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmulcph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfmulcph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfmulcph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfmulcph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfmulcsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfmulcsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmadd231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmadd231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmadd231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmadd231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmadd231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub132ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub132ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub132ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub132sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub132sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub213ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub213ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub213ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub213sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub213sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph %zmm3, %zmm2, %zmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vfnmsub231ph %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfnmsub231ph %ymm3, %ymm2, %ymm1");
+	asm volatile("vfnmsub231ph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vfnmsub231sh %xmm3, %xmm2, %xmm1");
+	asm volatile("vfnmsub231sh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vfpclassph $0x12, %zmm1, %k5");
+	asm volatile("vfpclassph $0x12, %xmm1, %k5");
+	asm volatile("vfpclassph $0x12, %ymm1, %k5");
+	asm volatile("vfpclasssh $0x12, %xmm1, %k5");
+	asm volatile("vfpclasssh $0x12, 0x12345678(%eax,%ecx,8), %k5");
+	asm volatile("vgetexpph %zmm2, %zmm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vgetexpph %xmm2, %xmm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vgetexpph %ymm2, %ymm1");
+	asm volatile("vgetexpph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vgetexpsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vgetexpsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vgetmantph $0x12, %zmm2, %zmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vgetmantph $0x12, %xmm2, %xmm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vgetmantph $0x12, %ymm2, %ymm1");
+	asm volatile("vgetmantph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vgetmantsh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vgetmantsh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmaxph %zmm3, %zmm2, %zmm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vmaxph %xmm3, %xmm2, %xmm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmaxph %ymm3, %ymm2, %ymm1");
+	asm volatile("vmaxph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vmaxsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmaxsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vminph %zmm3, %zmm2, %zmm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vminph %xmm3, %xmm2, %xmm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vminph %ymm3, %ymm2, %ymm1");
+	asm volatile("vminph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vminsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vminsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmovsh %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vmovsh 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vmovsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmovw %xmm1, %eax");
+	asm volatile("vmovw %xmm1, 0x12345678(%eax,%ecx,8)");
+	asm volatile("vmovw %eax, %xmm1");
+	asm volatile("vmovw 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vmulph %zmm3, %zmm2, %zmm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vmulph %xmm3, %xmm2, %xmm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vmulph %ymm3, %ymm2, %ymm1");
+	asm volatile("vmulph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vmulsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vmulsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrcpph %zmm2, %zmm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrcpph %xmm2, %xmm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrcpph %ymm2, %ymm1");
+	asm volatile("vrcpph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrcpsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vrcpsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vreduceph $0x12, %zmm2, %zmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vreduceph $0x12, %xmm2, %xmm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vreduceph $0x12, %ymm2, %ymm1");
+	asm volatile("vreduceph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vreducesh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vreducesh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrndscaleph $0x12, %zmm2, %zmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrndscaleph $0x12, %xmm2, %xmm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrndscaleph $0x12, %ymm2, %ymm1");
+	asm volatile("vrndscaleph $0x12, 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrndscalesh $0x12, %xmm3, %xmm2, %xmm1");
+	asm volatile("vrndscalesh $0x12, 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vrsqrtph %zmm2, %zmm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vrsqrtph %xmm2, %xmm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vrsqrtph %ymm2, %ymm1");
+	asm volatile("vrsqrtph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vrsqrtsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vrsqrtsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vscalefph %zmm3, %zmm2, %zmm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vscalefph %xmm3, %xmm2, %xmm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vscalefph %ymm3, %ymm2, %ymm1");
+	asm volatile("vscalefph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vscalefsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vscalefsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsqrtph %zmm2, %zmm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %zmm1");
+	asm volatile("vsqrtph %xmm2, %xmm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %xmm1");
+	asm volatile("vsqrtph %ymm2, %ymm1");
+	asm volatile("vsqrtph 0x12345678(%eax,%ecx,8), %ymm1");
+	asm volatile("vsqrtsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vsqrtsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsubph %zmm3, %zmm2, %zmm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %zmm2, %zmm1");
+	asm volatile("vsubph %xmm3, %xmm2, %xmm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vsubph %ymm3, %ymm2, %ymm1");
+	asm volatile("vsubph 0x12345678(%eax,%ecx,8), %ymm2, %ymm1");
+	asm volatile("vsubsh %xmm3, %xmm2, %xmm1");
+	asm volatile("vsubsh 0x12345678(%eax,%ecx,8), %xmm2, %xmm1");
+	asm volatile("vucomish %xmm2, %xmm1");
+	asm volatile("vucomish 0x12345678(%eax,%ecx,8), %xmm1");
+
 #endif /* #ifndef __x86_64__ */
 
 	/* Prediction history reset */
