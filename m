Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795CF451D2E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347718AbhKPAZ4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350723AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cUxJZpXY0jL9OklUdy5vHHQHSQgADGNBH+r7jq83nk=;
        b=DnToB12stJi1HcZpr5TEtVA6wkhPkAV1+U3vlnCx+IrjpZUCbUT/gy9Xoo3K4kcb4yict8
        yq/b57UsXqOZfYckejMIiDUW7z+r4FtijfPIM07gdDvbRCrdCKv510Pt6haJN28A+p1X1x
        uSpIzWUwoyBN9QCIMCU2zBWFqKbqugtmUBPj0bQLBS/+IUlfwCQYAPycLKvFOU/hB7l2hl
        4b5z7OCXkcQzy28tKA/aRcEF39xqe2rlGvPvMa9T9ogPrno8ZVgQnutpxUpyxd/Pea0PGe
        mq24F6u9/POwlRxp3UMY6fozUq39TTS8CM0+EXiYtR4V/0dbI9MJU/0j8JBFAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cUxJZpXY0jL9OklUdy5vHHQHSQgADGNBH+r7jq83nk=;
        b=ouL+s4m2+JPPiU47hTqWI79IWlItQHxVveU5QHDaAc0caxaQi4jWr2x34RaArci3lnYbGs
        L70VVa2b3TwmxRCQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Encpsulate the test enclave creation
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbee0ca867a95828a569c1ba2a8e443a44047dc71=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cbee0ca867a95828a569c1ba2a8e443a44047dc71=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774484.414.14111280130242179738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     1b35eb719549ab5143d61f9e09b0771cd3d00d94
Gitweb:        https://git.kernel.org/tip/1b35eb719549ab5143d61f9e09b0771cd3d00d94
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:19 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:05 -08:00

selftests/sgx: Encpsulate the test enclave creation

Introduce setup_test_encl() so that the enclave creation can be moved to
TEST_F()'s. This is required for a reclaimer test where the heap size needs
to be set large enough to triger the page reclaimer.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/bee0ca867a95828a569c1ba2a8e443a44047dc71.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 44 +++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index deab02f..5b3e49a 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -112,7 +112,8 @@ FIXTURE(enclave) {
 	struct sgx_enclave_run run;
 };
 
-FIXTURE_SETUP(enclave)
+static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
+			    struct __test_metadata *_metadata)
 {
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
@@ -122,25 +123,25 @@ FIXTURE_SETUP(enclave)
 	unsigned int i;
 	void *addr;
 
-	if (!encl_load("test_encl.elf", &self->encl, ENCL_HEAP_SIZE_DEFAULT)) {
-		encl_delete(&self->encl);
-		ksft_exit_skip("cannot load enclaves\n");
+	if (!encl_load("test_encl.elf", encl, heap_size)) {
+		encl_delete(encl);
+		TH_LOG("Failed to load the test enclave.\n");
 	}
 
-	if (!encl_measure(&self->encl))
+	if (!encl_measure(encl))
 		goto err;
 
-	if (!encl_build(&self->encl))
+	if (!encl_build(encl))
 		goto err;
 
 	/*
 	 * An enclave consumer only must do this.
 	 */
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		struct encl_segment *seg = &self->encl.segment_tbl[i];
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
 
-		addr = mmap((void *)self->encl.encl_base + seg->offset, seg->size,
-			    seg->prot, MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+		addr = mmap((void *)encl->encl_base + seg->offset, seg->size,
+			    seg->prot, MAP_SHARED | MAP_FIXED, encl->fd, 0);
 		EXPECT_NE(addr, MAP_FAILED);
 		if (addr == MAP_FAILED)
 			goto err;
@@ -160,16 +161,13 @@ FIXTURE_SETUP(enclave)
 
 	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
-
-	return;
+	return true;
 
 err:
-	encl_delete(&self->encl);
+	encl_delete(encl);
 
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		seg = &self->encl.segment_tbl[i];
+	for (i = 0; i < encl->nr_segments; i++) {
+		seg = &encl->segment_tbl[i];
 
 		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
 	}
@@ -186,7 +184,17 @@ err:
 		fclose(maps_file);
 	}
 
-	ASSERT_TRUE(false);
+	TH_LOG("Failed to initialize the test enclave.\n");
+
+	return false;
+}
+
+FIXTURE_SETUP(enclave)
+{
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
