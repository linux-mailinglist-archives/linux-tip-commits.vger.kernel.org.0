Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2F451D37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbhKPA0C (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85AC043195;
        Mon, 15 Nov 2021 12:22:27 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbckcIL5ATbo67K6Vs3yTL6EuyRxSzI/6RKCGz29pWI=;
        b=YiJYta3I+Fa7uOJpj4Hycfu0RREyG/Aqyst1kTGUtRlOnG/fAsSmC+4JDpnpABwO2tyT+c
        J4Qg750DfctC9g57zFPZN47ckdzPQojwc4SF4JLPXvZ7ONDLw8yyoV2zOVCjIo4A/Hp1Jx
        y7IQv53/9sJoL4JjIy+kGs5m5ygn5+Br201o83KdN5syhAvMYehNmWpUHQzkGATtxSGl2p
        nowr2FI+nJisl94UNzoOnMyz4CrFKdK+iFoVEf6HBipRjNbVmGE7Cu113UjLrpAp/wjQzS
        fKhDm07bnVqs6dCQsy80c7G9pcUFE2VYiWvXb8Nlwr0R8+M5OWG2l5fFveGHBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbckcIL5ATbo67K6Vs3yTL6EuyRxSzI/6RKCGz29pWI=;
        b=UmOgMxJerCwy6VIiZBWWFIxEFnTgkdKQXypaClaflkZnwOO6M5XE/IaEDSVqv84roTxddX
        Eu5Tcd0hd8BvcnAQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Add a new kselftest:
 Unclobbered_vdso_oversubscribed
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C41f7c508eea79a3198b5014d7691903be08f9ff1=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C41f7c508eea79a3198b5014d7691903be08f9ff1=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774336.414.264671625894657330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f0ff2447b8613b883f41ae845b6cc7540d6e5f71
Gitweb:        https://git.kernel.org/tip/f0ff2447b8613b883f41ae845b6cc7540d6e5f71
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:21 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:08 -08:00

selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed

Add a variation of the unclobbered_vdso test.

In the new test, create a heap for the test enclave, which has the same
size as all available Enclave Page Cache (EPC) pages in the system. This
will guarantee that all test_encl.elf pages *and* SGX Enclave Control
Structure (SECS) have been swapped out by the page reclaimer during the
load time.

This test will trigger both the page reclaimer and the page fault handler.
The page reclaimer triggered, while the heap is being created during the
load time. The page fault handler is triggered for all the required pages,
while the test case is executing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/41f7c508eea79a3198b5014d7691903be08f9ff1.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 75 +++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f41fba9..ee8139a 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -245,6 +245,81 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * A section metric is concatenated in a way that @low bits 12-31 define the
+ * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
+ * metric.
+ */
+static unsigned long sgx_calc_section_metric(unsigned int low,
+					     unsigned int high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+/*
+ * Sum total available physical SGX memory across all EPC sections
+ *
+ * Return: total available physical SGX memory available on system
+ */
+static unsigned long get_total_epc_mem(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned long total_size = 0;
+	unsigned int type;
+	int section = 0;
+
+	while (true) {
+		eax = SGX_CPUID;
+		ecx = section + SGX_CPUID_EPC;
+		__cpuid(&eax, &ebx, &ecx, &edx);
+
+		type = eax & SGX_CPUID_EPC_MASK;
+		if (type == SGX_CPUID_EPC_INVALID)
+			break;
+
+		if (type != SGX_CPUID_EPC_SECTION)
+			break;
+
+		total_size += sgx_calc_section_metric(ecx, edx);
+
+		section++;
+	}
+
+	return total_size;
+}
+
+TEST_F(enclave, unclobbered_vdso_oversubscribed)
+{
+	unsigned long total_mem;
+	struct encl_op op;
+
+	total_mem = get_total_epc_mem();
+	ASSERT_NE(total_mem, 0);
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+}
+
 TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
