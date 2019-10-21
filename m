Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC55DE488
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2019 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJUG05 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Oct 2019 02:26:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfJUG0z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Oct 2019 02:26:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9Q-000277-2S; Mon, 21 Oct 2019 08:26:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91FA31C0092;
        Mon, 21 Oct 2019 08:26:43 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:43 -0000
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Fix multiple memory and file
 descriptor leaks
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191014171047.GA30850@embeddedor>
References: <20191014171047.GA30850@embeddedor>
MIME-Version: 1.0
Message-ID: <157163920324.29376.662244450209670073.tip-bot2@tip-bot2>
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

Commit-ID:     f948eb45e3af9fb18a0487d0797a773897ef6929
Gitweb:        https://git.kernel.org/tip/f948eb45e3af9fb18a0487d0797a773897ef6929
Author:        Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate:    Mon, 14 Oct 2019 12:10:47 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 12:00:01 -03:00

perf annotate: Fix multiple memory and file descriptor leaks

Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
of returning in the middle of the function and leaking multiple
resources: prog_linfo, btf, s and bfdf.

Addresses-Coverity-ID: 1454832 ("Structurally dead code")
Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191014171047.GA30850@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f..e42bf57 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
