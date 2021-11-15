Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C54451D39
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbhKPA0G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243616AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28ECC043192;
        Mon, 15 Nov 2021 12:22:24 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQjju3HcUOG+iBHxZ6iEGuvouMHftWKm4niIM3Xj/YQ=;
        b=siC0IafiWinPgCmndLMzuSO419WJdY8GBCxrF8M1hP6PA7U3UzEBDVxcH/ea7RF9zXi1qP
        1h4yIKGszI78uHSbwxbol2WpD1X9GaSzVLKTm5iRpcjJ4fKm4p8cPCej4PIjMHOQl41naP
        WrfTrjEZpSrjSRpdqBt/tOeWAXseHn7QvXFH/XyHdJRbJjy2tKAJEFFhiwo24EN/vcKjGK
        8KH03vOxqHquTG++GtFWscVdQ4M0tUzaPob04pxvKhdR5oGqdfpRjZzavoZEiTlLJuWfcV
        L4RH0M2vTNaAlnVh8q7nCFKazS8qF/7eUMBuHDv+mvdbzR9JKWIpgEQ3DP9Cqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQjju3HcUOG+iBHxZ6iEGuvouMHftWKm4niIM3Xj/YQ=;
        b=3tjda9ZpQB2W6WCoM8xEIpAEh25ZAMTXlD4DP9E3ti/x7sIiq+DcZWbDIz9XXwgtn+6LA5
        DyQku3f5OUFGC9AQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Provide per-op parameter structs for
 the test enclave
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf9a4a8c436b538003b8ebddaa66083992053cef1=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cf9a4a8c436b538003b8ebddaa66083992053cef1=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774258.414.17086522670706062066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     41493a095e487c207b4b702aee2f8c59a7294e4f
Gitweb:        https://git.kernel.org/tip/41493a095e487c207b4b702aee2f8c59a7294e4f
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:22 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:10 -08:00

selftests/sgx: Provide per-op parameter structs for the test enclave

To add more operations to the test enclave, the protocol needs to allow
to have operations with varying parameters. Create a separate parameter
struct for each existing operation, with the shared parameters in struct
encl_op_header.

[reinette: rebased to apply on top of oversubscription test series]
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/f9a4a8c436b538003b8ebddaa66083992053cef1.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   | 14 ++++-
 tools/testing/selftests/sgx/main.c      | 68 ++++++++++++------------
 tools/testing/selftests/sgx/test_encl.c | 33 +++++++-----
 3 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index f88562a..6ff95a7 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -21,11 +21,21 @@
 enum encl_op_type {
 	ENCL_OP_PUT,
 	ENCL_OP_GET,
+	ENCL_OP_MAX,
 };
 
-struct encl_op {
+struct encl_op_header {
 	uint64_t type;
-	uint64_t buffer;
+};
+
+struct encl_op_put {
+	struct encl_op_header header;
+	uint64_t value;
+};
+
+struct encl_op_get {
+	struct encl_op_header header;
+	uint64_t value;
 };
 
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index ee8139a..3996c00 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -220,27 +220,28 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
@@ -292,7 +293,8 @@ static unsigned long get_total_epc_mem(void)
 TEST_F(enclave, unclobbered_vdso_oversubscribed)
 {
 	unsigned long total_mem;
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	total_mem = get_total_epc_mem();
 	ASSERT_NE(total_mem, 0);
@@ -301,20 +303,20 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
@@ -322,27 +324,28 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
 TEST_F(enclave, clobbered_vdso)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
@@ -357,7 +360,8 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op op;
+	struct encl_op_put put_op;
+	struct encl_op_get get_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -367,20 +371,20 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-	op.type = ENCL_OP_PUT;
-	op.buffer = MAGIC;
+	put_op.header.type = ENCL_OP_PUT;
+	put_op.value = MAGIC;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
 
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	op.type = ENCL_OP_GET;
-	op.buffer = 0;
+	get_op.header.type = ENCL_OP_GET;
+	get_op.value = 0;
 
-	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
 
-	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 734ea52..f11eb83 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,20 +16,29 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-void encl_body(void *rdi,  void *rsi)
+static void do_encl_op_put(void *op)
+{
+	struct encl_op_put *op2 = op;
+
+	memcpy(&encl_buffer[0], &op2->value, 8);
+}
+
+static void do_encl_op_get(void *op)
 {
-	struct encl_op *op = (struct encl_op *)rdi;
+	struct encl_op_get *op2 = op;
 
-	switch (op->type) {
-	case ENCL_OP_PUT:
-		memcpy(&encl_buffer[0], &op->buffer, 8);
-		break;
+	memcpy(&op2->value, &encl_buffer[0], 8);
+}
+
+void encl_body(void *rdi,  void *rsi)
+{
+	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
+		do_encl_op_put,
+		do_encl_op_get,
+	};
 
-	case ENCL_OP_GET:
-		memcpy(&op->buffer, &encl_buffer[0], 8);
-		break;
+	struct encl_op_header *op = (struct encl_op_header *)rdi;
 
-	default:
-		break;
-	}
+	if (op->type < ENCL_OP_MAX)
+		(*encl_op_array[op->type])(op);
 }
