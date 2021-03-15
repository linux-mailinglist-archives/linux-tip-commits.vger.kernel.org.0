Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3608533C056
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhCOPsS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhCOPrz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A5C06174A;
        Mon, 15 Mar 2021 08:47:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tZw40VQSYN6blGwJxKQu1bS1F9kzXZB06aBwKVZocw=;
        b=AaBTv+0x1z7NOTrnnX/phOnwuM9OluX8hZ4tkuaDx5oCV+uqGpr0ycOgvkvfZ8CjTLqa2/
        d/+Jk5m5IlKi7Ggq0eBayHlmhP09cq3m12D7IY/OFKPPo1eWszT+wvHBynIhVffLxAuefr
        mHOwa3N95yI5CGJ4AXg9WJkxyAagNUas3p5/KRgaSg2R5ovX+Ht9ZyjFRLkNHS13dnP6zK
        0Sy3cBbz3CvYZdu4WZrrzmRNd+miT5yrYXK4rXy8lcBOUGaRnAKnXLLKaqzyV/Eq/Myg3C
        zDb+ChuU6IonchT5s8UwQTUwQ79z/PiQ8xumfweZ0G59RPbuTqQecnSb1Raj6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tZw40VQSYN6blGwJxKQu1bS1F9kzXZB06aBwKVZocw=;
        b=SKJbYP/5zyw50Xwvm4RXJIUKaDCLxeBrmcf8Dw3t7+B6i+noWR4fBdGVHaz/SnlPkanP7Q
        M6bqSOmAJ/jJrhAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] tools/perf: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-20-bp@alien8.de>
References: <20210304174237.31945-20-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326443.398.670225451830163620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     62660b0fd238253aff951479a2adf1f06a231422
Gitweb:        https://git.kernel.org/tip/62660b0fd238253aff951479a2adf1f06a231422
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 23 Nov 2020 23:00:16 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:41:26 +01:00

tools/perf: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lkml.kernel.org/r/20210304174237.31945-20-bp@alien8.de
---
 tools/perf/arch/x86/tests/insn-x86.c                     |  9 +---
 tools/perf/arch/x86/util/archinsn.c                      |  9 ++--
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 17 ++++---
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 4f75ae9..0262b0d 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -96,13 +96,12 @@ static int get_branch(const char *branch_str)
 static int test_data_item(struct test_data *dat, int x86_64)
 {
 	struct intel_pt_insn intel_pt_insn;
+	int op, branch, ret;
 	struct insn insn;
-	int op, branch;
 
-	insn_init(&insn, dat->data, MAX_INSN_SIZE, x86_64);
-	insn_get_length(&insn);
-
-	if (!insn_complete(&insn)) {
+	ret = insn_decode(&insn, dat->data, MAX_INSN_SIZE,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0) {
 		pr_debug("Failed to decode: %s\n", dat->asm_rep);
 		return -1;
 	}
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 34d600c..546feda 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -11,7 +11,7 @@ void arch_fetch_insn(struct perf_sample *sample,
 		     struct machine *machine)
 {
 	struct insn insn;
-	int len;
+	int len, ret;
 	bool is64bit = false;
 
 	if (!sample->ip)
@@ -19,8 +19,9 @@ void arch_fetch_insn(struct perf_sample *sample,
 	len = thread__memcpy(thread, machine, sample->insn, sample->ip, sizeof(sample->insn), &is64bit);
 	if (len <= 0)
 		return;
-	insn_init(&insn, sample->insn, len, is64bit);
-	insn_get_length(&insn);
-	if (insn_complete(&insn) && insn.length <= len)
+
+	ret = insn_decode(&insn, sample->insn, len,
+			  is64bit ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret >= 0 && insn.length <= len)
 		sample->insn_len = insn.length;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 2f6cc7e..593f20e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -169,11 +169,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 		      struct intel_pt_insn *intel_pt_insn)
 {
 	struct insn insn;
+	int ret;
 
-	insn_init(&insn, buf, len, x86_64);
-	insn_get_length(&insn);
-	if (!insn_complete(&insn) || insn.length > len)
+	ret = insn_decode(&insn, buf, len,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0 || insn.length > len)
 		return -1;
+
 	intel_pt_insn_decoder(&insn, intel_pt_insn);
 	if (insn.length < INTEL_PT_INSN_BUF_SZ)
 		memcpy(intel_pt_insn->buf, buf, insn.length);
@@ -194,12 +196,13 @@ const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		      u8 *inbuf, int inlen, int *lenp)
 {
 	struct insn insn;
-	int n, i;
+	int n, i, ret;
 	int left;
 
-	insn_init(&insn, inbuf, inlen, x->is64bit);
-	insn_get_length(&insn);
-	if (!insn_complete(&insn) || insn.length > inlen)
+	ret = insn_decode(&insn, inbuf, inlen,
+			  x->is64bit ? INSN_MODE_64 : INSN_MODE_32);
+
+	if (ret < 0 || insn.length > inlen)
 		return "<bad>";
 	if (lenp)
 		*lenp = insn.length;
