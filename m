Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13BE10D157
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2019 07:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfK2GD4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Nov 2019 01:03:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48048 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfK2GDE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMg-0008Hd-B8; Fri, 29 Nov 2019 07:02:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED98C1C1D25;
        Fri, 29 Nov 2019 07:02:49 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Fix invalid LBR/binary mismatch error
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191127095631.15663-1-adrian.hunter@intel.com>
References: <20191127095631.15663-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157500736974.21853.16749925622988390147.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5172672da02e483d9b3c4d814c3482d0c8ffb1a6
Gitweb:        https://git.kernel.org/tip/5172672da02e483d9b3c4d814c3482d0c8ffb1a6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 27 Nov 2019 11:56:31 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 28 Nov 2019 08:08:38 -03:00

perf script: Fix invalid LBR/binary mismatch error

The 'len' returned by grab_bb() includes an extra MAXINSN bytes to allow
for the last instruction, so the the final 'offs' will not be 'len'.
Fix the error condition logic accordingly.

Before:

  $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
  [ perf record: Woken up 19 times to write data ]
  [ perf record: Captured and wrote 2.274 MB perf.data ]
  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
            grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
        bmexec+2485:
        00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
        00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
        00005641d5806bd6                        add %rdi, %rax
        00005641d5806bd9                        movzxb  -0x1(%rax), %edx
        00005641d5806bdd                        cmp %rax, %r14
        00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
        mismatch of LBR data and executable
        00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi

After:

  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
            grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
        bmexec+2485:
        00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
        00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
        00005641d5806bd6                        add %rdi, %rax
        00005641d5806bd9                        movzxb  -0x1(%rax), %edx
        00005641d5806bdd                        cmp %rax, %r14
        00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
        00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi
        00005641d58069c6                        add %rax, %rdi

Fixes: e98df280bc2a ("perf script brstackinsn: Fix recovery from LBR/binary mismatch")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191127095631.15663-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e8db26b..e2406b2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1126,7 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
-		if (off != (unsigned)len)
+		if (off != end - start)
 			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
