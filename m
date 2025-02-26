Return-Path: <linux-tip-commits+bounces-3673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB944A45EC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4551189A749
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C62206AF;
	Wed, 26 Feb 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJO+R+h5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSTQDtdi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF821D3E2;
	Wed, 26 Feb 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572109; cv=none; b=pElQUokpFJLXvFu7EqWIFxV9ZXSc7o4WZpyjlbjPVICHuG1Z7OYq6HZAtMVRo8sHXiusWgZgqO5U0G+V149MRn2adqBXy/T4vfhTpr2jMHL06voaJDq26M+0mfct2lYdRe+G6CVILYokL6kEyh+pwM+RlGWIKiCo0HsK+Y5GVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572109; c=relaxed/simple;
	bh=Rt897XLMZPrPPsSuPtIMayBbHhYplVmM1AfxLPAJcw8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sNwxbgklZpmmLTIkboPhXXGZsaLijfvRc1HU1eApcARuPt46DsPALcYLHrfhtkeweWqqOSKnPOCG+RnTDsePRmzrph15yJF7E9rB0gv5U8Cd3Q1CVA2eZUOthkVRD3j33hcchT4P3ulFAvn7rI2w4U7sOfb6NprxBGyn8D0RUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJO+R+h5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kSTQDtdi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2gj0Seds5FDrw0P3SFOSnYVNisZfm6nwaSY5Pt2tD4=;
	b=lJO+R+h5j76JrGqumbZMZty9bj0Wf+yKJWVJ4r+Hsb1juWVpcwh29ObPwWbHa8emloayKa
	JLcSuooy7wnB8MNNgzFmgIrCYZ3DtQT3EPCgN74J8VBOc09OCmZWNuzQL1rqfqr6o7tTXN
	wessjcXfY5Xvmh4B5i0tbTDFSXmKeIrEmmozrgewqiCpCkkip/wf9V6f7SQtz0ON5xzcH7
	ipEbAnd+zqLAHNKTe4Vjk5FrgpnlTkHxmBXTDJDmhmL1BXFSGKvtU7cMbyAV7hLLHErKLX
	dYzgIEC527xjWIgd4oWCEWQj/idQBd7dZHoIhtuQAiyGrSFPMXIvJuI252Q/LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2gj0Seds5FDrw0P3SFOSnYVNisZfm6nwaSY5Pt2tD4=;
	b=kSTQDtdixkDB5N3qWdIzgugA68MmdQm2Gtbobpb8TYURxaNcSC6806DQDQs8ACiJ8AbGHv
	VEB2gclpSPDG2JDw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/xstate: Introduce signal ABI test
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-7-chang.seok.bae@intel.com>
References: <20250226010731.2456-7-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210535.10177.10652890663366192077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e075d9fa16b3681b8a375cb47f4b5a1901e93530
Gitweb:        https://git.kernel.org/tip/e075d9fa16b3681b8a375cb47f4b5a1901e93530
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:26 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:29 +01:00

selftests/x86/xstate: Introduce signal ABI test

With the refactored test cases, another xstate exposure to userspace is
through signal delivery. While amx.c includes signal-related scenarios,
its primary focus is on xstate permission management, which is largely
specific to dynamic states.

The remaining gap is testing xstate preservation and restoration across
signal delivery. The kernel defines an ABI for presenting xstate in the
signal frame, closely resembling the hardware XSAVE format, where xstate
modification is also possible.

Introduce a new test case to verify xstate preservation across signal
delivery and return, that is ensuring ABI compatibility by:

 - Loading xstate before raising a signal.

 - Verifying correct exposure in the signal frame

 - Modifying xstate in the signal frame before returning.

 - Checking the state restoration upon signal return.

Integrate this test into the AMX test suite as an initial usage site.

  Expected output:
  $ amx_64
  ...
  [RUN]   AMX Tile data: load xstate and raise SIGUSR1
  [OK]    'magic1' is valid
  [OK]    'xfeatures' in SW reserved area is valid
  [OK]    'xfeatures' in XSAVE header is valid
  [OK]    xstate delivery was successful
  [OK]    'magic2' is valid
  [RUN]   AMX Tile data: load new xstate from sighandler and check it after sigreturn
  [OK]    xstate was restored correctly

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-7-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c    |   2 +-
 tools/testing/selftests/x86/xstate.c | 108 ++++++++++++++++++++++++++-
 tools/testing/selftests/x86/xstate.h |   1 +-
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 4bafbb7..9cb691d 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -510,6 +510,8 @@ int main(void)
 
 	test_ptrace(XFEATURE_XTILEDATA);
 
+	test_signal(XFEATURE_XTILEDATA);
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index d318b35..b5600f4 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -21,6 +21,11 @@ static inline uint64_t xgetbv(uint32_t index)
 	return eax + ((uint64_t)edx << 32);
 }
 
+static inline uint64_t get_xstatebv(struct xsave_buffer *xbuf)
+{
+	return *(uint64_t *)(&xbuf->header);
+}
+
 static struct xstate_info xstate;
 
 struct futex_info {
@@ -325,3 +330,106 @@ void test_ptrace(uint32_t feature_num)
 	if (!WIFEXITED(status) || WEXITSTATUS(status))
 		ksft_exit_fail_msg("ptracee exit error\n");
 }
+
+/*
+ * Test signal delivery for the ABI compatibility.
+ * See the ABI format: arch/x86/include/uapi/asm/sigcontext.h
+ */
+
+/*
+ * Avoid using printf() in signal handlers as it is not
+ * async-signal-safe.
+ */
+#define SIGNAL_BUF_LEN 1000
+static char signal_message_buffer[SIGNAL_BUF_LEN];
+static void sig_print(char *msg)
+{
+	int left = SIGNAL_BUF_LEN - strlen(signal_message_buffer) - 1;
+
+	strncat(signal_message_buffer, msg, left);
+}
+
+static struct xsave_buffer *stashed_xbuf;
+
+static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	void *xbuf = ctx->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes;
+	uint32_t magic2;
+
+	/* Reset the signal message buffer: */
+	signal_message_buffer[0] = '\0';
+
+	sw_bytes = get_fpx_sw_bytes(xbuf);
+	if (sw_bytes->magic1 == FP_XSTATE_MAGIC1)
+		sig_print("[OK]\t'magic1' is valid\n");
+	else
+		sig_print("[FAIL]\t'magic1' is not valid\n");
+
+	if (get_fpx_sw_bytes_features(xbuf) & xstate.mask)
+		sig_print("[OK]\t'xfeatures' in SW reserved area is valid\n");
+	else
+		sig_print("[FAIL]\t'xfeatures' in SW reserved area is not valid\n");
+
+	if (get_xstatebv(xbuf) & xstate.mask)
+		sig_print("[OK]\t'xfeatures' in XSAVE header is valid\n");
+	else
+		sig_print("[FAIL]\t'xfeatures' in XSAVE hader is not valid\n");
+
+	if (validate_xstate_same(stashed_xbuf, xbuf))
+		sig_print("[OK]\txstate delivery was successful\n");
+	else
+		sig_print("[FAIL]\txstate delivery was not successful\n");
+
+	magic2 = *(uint32_t *)(xbuf + sw_bytes->xstate_size);
+	if (magic2 == FP_XSTATE_MAGIC2)
+		sig_print("[OK]\t'magic2' is valid\n");
+	else
+		sig_print("[FAIL]\t'magic2' is not valid\n");
+
+	set_rand_data(&xstate, xbuf);
+	copy_xstate(stashed_xbuf, xbuf);
+}
+
+void test_signal(uint32_t feature_num)
+{
+	bool valid_xstate;
+
+	xstate = get_xstate_info(feature_num);
+
+	/*
+	 * The signal handler will access this to verify xstate context
+	 * preservation.
+	 */
+
+	stashed_xbuf = alloc_xbuf();
+	if (!stashed_xbuf)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	printf("[RUN]\t%s: load xstate and raise SIGUSR1\n", xstate.name);
+
+	sethandler(SIGUSR1, validate_sigfpstate, 0);
+
+	load_rand_xstate(&xstate, stashed_xbuf);
+
+	raise(SIGUSR1);
+
+	/*
+	 * Immediately record the test result, deferring printf() to
+	 * prevent unintended state contamination by that.
+	 */
+	valid_xstate = validate_xregs_same(stashed_xbuf);
+	printf("%s", signal_message_buffer);
+
+	printf("[RUN]\t%s: load new xstate from sighandler and check it after sigreturn\n",
+	       xstate.name);
+
+	if (valid_xstate)
+		printf("[OK]\txstate was restored correctly\n");
+	else
+		printf("[FAIL]\txstate restoration failed\n");
+
+	clearhandler(SIGUSR1);
+	free(stashed_xbuf);
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 2bf11d3..4d0ffe9 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -191,5 +191,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 
 void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
 void test_ptrace(uint32_t feature_num);
+void test_signal(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */

