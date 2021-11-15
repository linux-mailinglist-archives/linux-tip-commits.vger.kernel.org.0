Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0B451D20
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbhKPAZO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245128AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756EAC061766;
        Mon, 15 Nov 2021 12:22:33 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwXCNjX0lCCnb2Nu4EA1fKzucVOGmU2qNSATc6MmBOw=;
        b=l975o9TLI6WlDfvHQXA1d7cDkjOIVRPigmG/eFb1yC7VptyJNdU8DCh9fTFwSR5noxJWUS
        K4XulOvrmnigaHq8NkAAhl22UST32+4fWoAMIY8fySBahVFN0UXkIZKmun9yBz+tkV6TJ8
        mhk7MKOtSiuSOAfTBaKTkL7DfQuluFDqLVDLl2zojRh5sHKr9ebRh1jVvcK+gs+bQRImAx
        bj4T+/0ls9cAinSbR6imnna8Pvr9jIOyFU6bz6Rp9APa929+DMTo/wycE6wO9TYtaXZRvX
        nHGfsEDPeJ8FPntIbWCCjPHI2x7QJjPqMVRwOTA+7T+ret/e1NBojWDNh4EvHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwXCNjX0lCCnb2Nu4EA1fKzucVOGmU2qNSATc6MmBOw=;
        b=AEIzEcupri581u8pUI1nuitr3p8+elOnK4nSwHtyXoKQ1KhvHoSBqtHSJS6jD+Gkf1tX1g
        nRWRQbKMciKpw/Dg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Dump segments and /proc/self/maps only
 on failure
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C23cef0ae1de3a8a74cbfbbe74eca48ca3f300fde=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C23cef0ae1de3a8a74cbfbbe74eca48ca3f300fde=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774556.414.17914976039276112604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     1471721489090515f9f0f059b25124898928e559
Gitweb:        https://git.kernel.org/tip/1471721489090515f9f0f059b25124898928e559
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:18 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:04 -08:00

selftests/sgx: Dump segments and /proc/self/maps only on failure

Logging is always a compromise between clarity and detail. The main use
case for dumping VMA's is when FIXTURE_SETUP() fails, and is less important
for enclaves that do initialize correctly. Therefore, print the segments
and /proc/self/maps only in the error case.

Finally, if a single test ever creates multiple enclaves, the amount of
log lines would become enormous.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/23cef0ae1de3a8a74cbfbbe74eca48ca3f300fde.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 6858a35..deab02f 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -127,12 +127,6 @@ FIXTURE_SETUP(enclave)
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		seg = &self->encl.segment_tbl[i];
-
-		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
-	}
-
 	if (!encl_measure(&self->encl))
 		goto err;
 
@@ -169,6 +163,17 @@ FIXTURE_SETUP(enclave)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
+	return;
+
+err:
+	encl_delete(&self->encl);
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		seg = &self->encl.segment_tbl[i];
+
+		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
+	}
+
 	maps_file = fopen("/proc/self/maps", "r");
 	if (maps_file != NULL)  {
 		while (fgets(maps_line, sizeof(maps_line), maps_file) != NULL) {
@@ -181,11 +186,7 @@ FIXTURE_SETUP(enclave)
 		fclose(maps_file);
 	}
 
-err:
-	if (!sgx_enter_enclave_sym)
-		encl_delete(&self->encl);
-
-	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+	ASSERT_TRUE(false);
 }
 
 FIXTURE_TEARDOWN(enclave)
