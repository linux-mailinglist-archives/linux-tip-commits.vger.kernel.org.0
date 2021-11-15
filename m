Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF76451D30
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbhKPAZ5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350709AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0rmQJ7M6t1sqfovORuRSSCA8dmagNN4fau5KgnkFYI=;
        b=LH2PwFXweoXUJMSaI4LeXnVYPMmXKDeJivcsy2NDQt7HtbnMaCc9+PH4peemkpzupb2qS7
        p2YS7fjhtqjV1QwBIgrnh34KV98waKQeviQeViZD5TUzhXDauf5iOJ0YTcrGKOROoL2QpZ
        Zac3w9b7G+o5PMoiJn5CcmINKXrGDXvN0kygjUi2K+t24z9ym0L2hV6JNOS5rX16PmZsoh
        gpKPocuwPg8UvC8dzcyszSgrGa9VE5QTzgn9EqULSI6Htuut5PiZ/pYbQM96FiICXjnKJ4
        gptOrMnJBbTfc6HrU75NXGCfmnVsBMavDd86bMFEY/9p0StamVbwhI+4MyK/Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0rmQJ7M6t1sqfovORuRSSCA8dmagNN4fau5KgnkFYI=;
        b=ObyKdsbgPLLTAmhmTARCny1plp4S6v9qVT1u6EzTYNfntnwXpN28i7JgsO5+/Xps7ZNqOg
        d9m64xXBip1StRBQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Enable multiple thread support
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca49dc0d85401db788a0a3f0d795e848abf3b1f44=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ca49dc0d85401db788a0a3f0d795e848abf3b1f44=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774032.414.13423600725318852745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     26e688f1263a3c226f3bb5e3441c310ae11e8001
Gitweb:        https://git.kernel.org/tip/26e688f1263a3c226f3bb5e3441c310ae11e8001
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 15 Nov 2021 10:35:25 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:14 -08:00

selftests/sgx: Enable multiple thread support

Each thread executing in an enclave is associated with a Thread Control
Structure (TCS). The test enclave contains two hardcoded TCS. Each TCS
contains meta-data used by the hardware to save and restore thread specific
information when entering/exiting the enclave.

The two TCS structures within the test enclave share their SSA (State Save
Area) resulting in the threads clobbering each other's data. Fix this by
providing each TCS their own SSA area.

Additionally, there is an 8K stack space and its address is
computed from the enclave entry point which is correctly done for
TCS #1 that starts on the first address inside the enclave but
results in out of bounds memory when entering as TCS #2. Split 8K
stack space into two separate pages with offset symbol between to ensure
the current enclave entry calculation can continue to be used for both
threads.

While using the enclave with multiple threads requires these fixes the
impact is not apparent because every test up to this point enters the
enclave from the first TCS.

More detail about the stack fix:
-------------------------------
Before this change the test enclave (test_encl) looks as follows:

.tcs (2 pages):
(page 1) TCS #1
(page 2) TCS #2

.text (1 page)
One page of code

.data (5 pages)
(page 1) encl_buffer
(page 2) encl_buffer
(page 3) SSA
(page 4 and 5) STACK
encl_stack:

As shown above there is a symbol, encl_stack, that points to the end of the
.data segment (pointing to the end of page 5 in .data) which is also the
end of the enclave.

The enclave entry code computes the stack address by adding encl_stack to
the pointer to the TCS that entered the enclave. When entering at TCS #1
the stack is computed correctly but when entering at TCS #2 the stack
pointer would point to one page beyond the end of the enclave and a #PF
would result when TCS #2 attempts to enter the enclave.

The fix involves moving the encl_stack symbol between the two stack pages.
Doing so enables the stack address computation in the entry code to compute
the correct stack address for each TCS.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/a49dc0d85401db788a0a3f0d795e848abf3b1f44.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 21 +++++++++-----
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 5d5680d..82fb0df 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -12,7 +12,7 @@
 
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
-	.quad	encl_ssa		# OSSA
+	.quad	encl_ssa_tcs1		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
 	.quad	encl_entry		# OENTRY
@@ -23,10 +23,10 @@
 	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
 	.fill	4024, 1, 0		# Reserved
 
-	# Identical to the previous TCS.
+	# TCS2
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
-	.quad	encl_ssa		# OSSA
+	.quad	encl_ssa_tcs2		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
 	.quad	encl_entry		# OENTRY
@@ -40,8 +40,9 @@
 	.text
 
 encl_entry:
-	# RBX contains the base address for TCS, which is also the first address
-	# inside the enclave. By adding the value of le_stack_end to it, we get
+	# RBX contains the base address for TCS, which is the first address
+	# inside the enclave for TCS #1 and one page into the enclave for
+	# TCS #2. By adding the value of encl_stack to it, we get
 	# the absolute address for the stack.
 	lea	(encl_stack)(%rbx), %rax
 	xchg	%rsp, %rax
@@ -81,9 +82,15 @@ encl_entry:
 
 	.section ".data", "aw"
 
-encl_ssa:
+encl_ssa_tcs1:
+	.space 4096
+encl_ssa_tcs2:
 	.space 4096
 
 	.balign 4096
-	.space 8192
+	# Stack of TCS #1
+	.space 4096
 encl_stack:
+	.balign 4096
+	# Stack of TCS #2
+	.space 4096
