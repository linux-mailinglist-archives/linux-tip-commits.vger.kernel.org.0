Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18C451616
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 22:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbhKOVLl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 16:11:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350711AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R09wNncYqA2dxr1m/uExDJXHK/sZnv0VVfAKdsjvVUs=;
        b=u7nLVGoorl1e0QLG+LU/jyXtTFjsS4YiphSvmG2sIjIEI7Y7Hx8vqQkGvJU68Hbjxhzws3
        DQGS0xsGMTy2KrcDliKio1I9Jj5xr0Gw4S/M8UuYpXMWd7BA/5EDOgOgrwsu0VFzBB9wn9
        3mw7XYyxSJZAbbjFI6s70VM93GCsyvYXyF1fxS4lb8MkuDqvsu5jGTgxgu+spFZYaNwkXc
        aX62JiYIMOgFLjMxo32bPPbz9sNUzIDCXqrpyVXIc40vkV/bl9kVY7hUnRa/787gNyxnfL
        M1RLtAbfCixFrUp0ofHBkQRfBiKiqD2Iy7hYVaJF74+wzj43Clb0xknvE9z99g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R09wNncYqA2dxr1m/uExDJXHK/sZnv0VVfAKdsjvVUs=;
        b=67YeckAKl57S0XmNzGr1Ii8p1W5OIWw6X9UlGXcsSKLsFr8jhMU0U2EffS7990SbzK944I
        q7lfqWDfdVEgb1Bg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Add page permission and exception test
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3bcc73a4b9fe8780bdb40571805e7ced59e01df7=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C3bcc73a4b9fe8780bdb40571805e7ced59e01df7=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774105.414.293696191406062351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     abc5cec4735080d12d644c2d39f96cf98c0a367c
Gitweb:        https://git.kernel.org/tip/abc5cec4735080d12d644c2d39f96cf98c0a367c
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 15 Nov 2021 10:35:24 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:13 -08:00

selftests/sgx: Add page permission and exception test

The Enclave Page Cache Map (EPCM) is a secure structure used by the
processor to track the contents of the enclave page cache. The EPCM
contains permissions with which enclave pages can be accessed. SGX
support allows EPCM and PTE page permissions to differ - as long as
the PTE permissions do not exceed the EPCM permissions.

Add a test that:
(1) Creates an SGX enclave page with writable EPCM permission.
(2) Changes the PTE permission on the page to read-only. This should
    be permitted because the permission does not exceed the EPCM
    permission.
(3) Attempts a write to the page. This should generate a page fault
    (#PF) because of the read-only PTE even though the EPCM
    permissions allow the page to be written to.

This introduces the first test of SGX exception handling. In this test
the issue that caused the exception (PTE page permissions) can be fixed
from outside the enclave and after doing so it is possible to re-enter
enclave at original entrypoint with ERESUME.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/3bcc73a4b9fe8780bdb40571805e7ced59e01df7.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   |  14 ++-
 tools/testing/selftests/sgx/main.c      | 134 +++++++++++++++++++++++-
 tools/testing/selftests/sgx/test_encl.c |  21 ++++-
 3 files changed, 169 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 9ea0c78..0bbda6f 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -21,6 +21,8 @@
 enum encl_op_type {
 	ENCL_OP_PUT_TO_BUFFER,
 	ENCL_OP_GET_FROM_BUFFER,
+	ENCL_OP_PUT_TO_ADDRESS,
+	ENCL_OP_GET_FROM_ADDRESS,
 	ENCL_OP_MAX,
 };
 
@@ -38,4 +40,16 @@ struct encl_op_get_from_buf {
 	uint64_t value;
 };
 
+struct encl_op_put_to_addr {
+	struct encl_op_header header;
+	uint64_t value;
+	uint64_t addr;
+};
+
+struct encl_op_get_from_addr {
+	struct encl_op_header header;
+	uint64_t value;
+	uint64_t addr;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 6132122..1b4858f 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -21,6 +21,7 @@
 #include "main.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
+static const uint64_t MAGIC2 = 0x8877665544332211ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 struct vdso_symtab {
@@ -107,6 +108,25 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the data segment can be found.
+ * The first RW segment loaded is the TCS, skip that to get info on the
+ * data segment.
+ */
+static off_t encl_get_data_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 1; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 FIXTURE(enclave) {
 	struct encl encl;
 	struct sgx_enclave_run run;
@@ -389,4 +409,118 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * Second page of .data segment is used to test changing PTE permissions.
+ * This spans the local encl_buffer within the test enclave.
+ *
+ * 1) Start with a sanity check: a value is written to the target page within
+ *    the enclave and read back to ensure target page can be written to.
+ * 2) Change PTE permissions (RW -> RO) of target page within enclave.
+ * 3) Repeat (1) - this time expecting a regular #PF communicated via the
+ *    vDSO.
+ * 4) Change PTE permissions of target page within enclave back to be RW.
+ * 5) Repeat (1) by resuming enclave, now expected to be possible to write to
+ *    and read from target page within enclave.
+ */
+TEST_F(enclave, pte_permissions)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	unsigned long data_start;
+	int ret;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) +
+		     PAGE_SIZE;
+
+	/*
+	 * Sanity check to ensure it is possible to write to page that will
+	 * have its permissions manipulated.
+	 */
+
+	/* Write MAGIC to page */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = data_start;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Read memory that was just written to, confirming that it is the
+	 * value previously written (MAGIC).
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = data_start;
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Change PTE permissions of target page within the enclave */
+	ret = mprotect((void *)data_start, PAGE_SIZE, PROT_READ);
+	if (ret)
+		perror("mprotect");
+
+	/*
+	 * PTE permissions of target page changed to read-only, EPCM
+	 * permissions unchanged (EPCM permissions are RW), attempt to
+	 * write to the page, expecting a regular #PF.
+	 */
+
+	put_addr_op.value = MAGIC2;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x7);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Change PTE permissions back to enable enclave to write to the
+	 * target page and resume enclave - do not expect any exceptions this
+	 * time.
+	 */
+	ret = mprotect((void *)data_start, PAGE_SIZE, PROT_READ | PROT_WRITE);
+	if (ret)
+		perror("mprotect");
+
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0,
+					 0, ERESUME, 0, 0, &self->run),
+		 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC2);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 4e8da73..5d86e3e 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -4,6 +4,11 @@
 #include <stddef.h>
 #include "defines.h"
 
+/*
+ * Data buffer spanning two pages that will be placed first in .data
+ * segment. Even if not used internally the second page is needed by
+ * external test manipulating page permissions.
+ */
 static uint8_t encl_buffer[8192] = { 1 };
 
 static void *memcpy(void *dest, const void *src, size_t n)
@@ -30,11 +35,27 @@ static void do_encl_op_get_from_buf(void *op)
 	memcpy(&op2->value, &encl_buffer[0], 8);
 }
 
+static void do_encl_op_put_to_addr(void *_op)
+{
+	struct encl_op_put_to_addr *op = _op;
+
+	memcpy((void *)op->addr, &op->value, 8);
+}
+
+static void do_encl_op_get_from_addr(void *_op)
+{
+	struct encl_op_get_from_addr *op = _op;
+
+	memcpy(&op->value, (void *)op->addr, 8);
+}
+
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
 		do_encl_op_put_to_buf,
 		do_encl_op_get_from_buf,
+		do_encl_op_put_to_addr,
+		do_encl_op_get_from_addr,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
