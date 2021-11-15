Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E967451D38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbhKPA0E (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2CC043191;
        Mon, 15 Nov 2021 12:22:24 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CRUDdyOXsf5g2S/uCIogEmS6+aRNtcMTGT8D89GnbU=;
        b=eAE//AL36CjFiDYHgy1eTJsogLEGoaqgeSdL5w+LtUiFVVDveoOVteSRcJbLH3NP1tegT7
        SsRcK3KWi7n68GAgcuOn+LLLncdL7OWnNbWEP08FmMo19r+PZnHT/48B5tjxCpuaadO0JF
        ng4QpRhT/QCs5Nbi7pcsqFjoJXSDmXXyWb2N+tpi8OE9IvCDBEpnaVTMhPK84OK4TG0jAe
        zq/eijsycbW0zqJBcEA6mk002Oid35qJenS6WF437zDTHpKCXwQ8OMMRbJJ2CyIHK6zAfT
        1tz8RzkgnusemC6FhYcx4TsfTXmJ3+EtOhPx8CYOD3sVFHS2a3tYVplpJ7PN4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CRUDdyOXsf5g2S/uCIogEmS6+aRNtcMTGT8D89GnbU=;
        b=LbQt3UDupHS5H0K8pnZKqgUTQ8J7R1vdyjFGyfEX//CDYvxrNaxfVa+Lp423muDA8NG0JX
        k3IXKm0WVKQ3dYBw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Rename test properties in preparation
 for more enclave tests
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C023fda047c787cf330b88ed9337705edae6a0078=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C023fda047c787cf330b88ed9337705edae6a0078=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774180.414.10218626866102868990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c085dfc7685c8c36698b851b03990b75a3226e97
Gitweb:        https://git.kernel.org/tip/c085dfc7685c8c36698b851b03990b75a3226e97
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 15 Nov 2021 10:35:23 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:11 -08:00

selftests/sgx: Rename test properties in preparation for more enclave tests

SGX selftests prepares a data structure outside of the enclave with
the type of and data for the operation that needs to be run within
the enclave. At this time only two complementary operations are supported
by the enclave: copying a value from outside the enclave into a default
buffer within the enclave and reading a value from the enclave's default
buffer into a variable accessible outside the enclave.

In preparation for more operations supported by the enclave the names of the
current enclave operations are changed to more accurately reflect the
operations and more easily distinguish it from future operations:

* The enums ENCL_OP_PUT and ENCL_OP_GET are renamed to ENCL_OP_PUT_TO_BUFFER
  and ENCL_OP_GET_FROM_BUFFER respectively.
* The structs encl_op_put and encl_op_get are renamed to encl_op_put_to_buf
  and encl_op_get_from_buf respectively.
* The enclave functions do_encl_op_put and do_encl_op_get are renamed to
  do_encl_op_put_to_buf and do_encl_op_get_from_buf respectively.

No functional changes.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/023fda047c787cf330b88ed9337705edae6a0078.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   |  8 +++---
 tools/testing/selftests/sgx/main.c      | 32 ++++++++++++------------
 tools/testing/selftests/sgx/test_encl.c | 12 ++++-----
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 6ff95a7..9ea0c78 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -19,8 +19,8 @@
 #include "../../../../arch/x86/include/uapi/asm/sgx.h"
 
 enum encl_op_type {
-	ENCL_OP_PUT,
-	ENCL_OP_GET,
+	ENCL_OP_PUT_TO_BUFFER,
+	ENCL_OP_GET_FROM_BUFFER,
 	ENCL_OP_MAX,
 };
 
@@ -28,12 +28,12 @@ struct encl_op_header {
 	uint64_t type;
 };
 
-struct encl_op_put {
+struct encl_op_put_to_buf {
 	struct encl_op_header header;
 	uint64_t value;
 };
 
-struct encl_op_get {
+struct encl_op_get_from_buf {
 	struct encl_op_header header;
 	uint64_t value;
 };
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 3996c00..6132122 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -220,15 +220,15 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
@@ -236,7 +236,7 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
@@ -292,9 +292,9 @@ static unsigned long get_total_epc_mem(void)
 
 TEST_F(enclave, unclobbered_vdso_oversubscribed)
 {
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 	unsigned long total_mem;
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
 
 	total_mem = get_total_epc_mem();
 	ASSERT_NE(total_mem, 0);
@@ -303,7 +303,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
@@ -311,7 +311,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
@@ -324,15 +324,15 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
 TEST_F(enclave, clobbered_vdso)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
@@ -340,7 +340,7 @@ TEST_F(enclave, clobbered_vdso)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
@@ -360,8 +360,8 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -371,7 +371,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
@@ -379,7 +379,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index f11eb83..4e8da73 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,16 +16,16 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-static void do_encl_op_put(void *op)
+static void do_encl_op_put_to_buf(void *op)
 {
-	struct encl_op_put *op2 = op;
+	struct encl_op_put_to_buf *op2 = op;
 
 	memcpy(&encl_buffer[0], &op2->value, 8);
 }
 
-static void do_encl_op_get(void *op)
+static void do_encl_op_get_from_buf(void *op)
 {
-	struct encl_op_get *op2 = op;
+	struct encl_op_get_from_buf *op2 = op;
 
 	memcpy(&op2->value, &encl_buffer[0], 8);
 }
@@ -33,8 +33,8 @@ static void do_encl_op_get(void *op)
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
-		do_encl_op_put,
-		do_encl_op_get,
+		do_encl_op_put_to_buf,
+		do_encl_op_get_from_buf,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
