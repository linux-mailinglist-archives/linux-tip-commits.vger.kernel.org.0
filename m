Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B863451D3B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbhKPA0H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243609AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE503C043190;
        Mon, 15 Nov 2021 12:22:21 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAfDA7UFLMzhrgBdZshb+Xn2ZZMdaA6wwoEWc3SuhQQ=;
        b=HB5Evd4DorxfLQyg3MOa3xcThobGxnHn396Mp8TpraY/WyXMrpWV14tCt+zMrr3LUp5VNI
        4twzF9ArLG/21HIDPx9sb9o80MAcT7c3GFMfOyJkjolggp0wHjjDT7FAvtKEY2kRQ9aRJy
        UVTL7W+Lmw6nUgMX/CpOdLYC+8Xe3sZTweWfhnY9N5CkKIvJCI7+tdKLfUkkXzN+U+kMSA
        AMeYn3bx6a+yrgPlrF6Px9BGO1SWf+00fl+9ZkdEOjWTb95B8MTeezubgDFPdvSkgNhA3k
        JrEKE4lVV54dU5zEHZZ38MfxolS31rhaMTQ2mzr/NHw5oPbESmzSblpuWSNVTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAfDA7UFLMzhrgBdZshb+Xn2ZZMdaA6wwoEWc3SuhQQ=;
        b=XIdBlaIaEEZO09DovfGBAeqcQj7y9Au/EGZSlzjJvyMKpikUAbkaULUjpt8mY4SvhK576V
        3RcGvtM1/2ZQYeBA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Add test for multiple TCS entry
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7be151a57b4c7959a2364753b995e0006efa3da1=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C7be151a57b4c7959a2364753b995e0006efa3da1=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700773953.414.8513606653652381608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     688542e29fae655a8be25832f6a9959bdd308dd8
Gitweb:        https://git.kernel.org/tip/688542e29fae655a8be25832f6a9959bdd308dd8
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 15 Nov 2021 10:35:26 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:16 -08:00

selftests/sgx: Add test for multiple TCS entry

Each thread executing in an enclave is associated with a Thread Control
Structure (TCS). The SGX test enclave contains two hardcoded TCS, thus
supporting two threads in the enclave.

Add a test to ensure it is possible to enter enclave at both entrypoints.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/7be151a57b4c7959a2364753b995e0006efa3da1.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   |  1 +-
 tools/testing/selftests/sgx/main.c      | 32 ++++++++++++++++++++++++-
 tools/testing/selftests/sgx/test_encl.c |  6 +++++-
 3 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 0bbda6f..02d7757 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -23,6 +23,7 @@ enum encl_op_type {
 	ENCL_OP_GET_FROM_BUFFER,
 	ENCL_OP_PUT_TO_ADDRESS,
 	ENCL_OP_GET_FROM_ADDRESS,
+	ENCL_OP_NOP,
 	ENCL_OP_MAX,
 };
 
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 1b4858f..7e912db 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -410,6 +410,38 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 }
 
 /*
+ * Sanity check that it is possible to enter either of the two hardcoded TCS
+ */
+TEST_F(enclave, tcs_entry)
+{
+	struct encl_op_header op;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_NOP;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Move to the next TCS. */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
+/*
  * Second page of .data segment is used to test changing PTE permissions.
  * This spans the local encl_buffer within the test enclave.
  *
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5d86e3e..4fca01c 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -49,6 +49,11 @@ static void do_encl_op_get_from_addr(void *_op)
 	memcpy(&op->value, (void *)op->addr, 8);
 }
 
+static void do_encl_op_nop(void *_op)
+{
+
+}
+
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
@@ -56,6 +61,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_get_from_buf,
 		do_encl_op_put_to_addr,
 		do_encl_op_get_from_addr,
+		do_encl_op_nop,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
