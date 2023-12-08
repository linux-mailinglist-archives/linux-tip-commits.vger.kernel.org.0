Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6680ABC3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5039F1F2106C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7846BBB;
	Fri,  8 Dec 2023 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LeY2Qpdp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZB3xRbtM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0019A6;
	Fri,  8 Dec 2023 10:13:06 -0800 (PST)
Date: Fri, 08 Dec 2023 18:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GQOPBY2uEa4mMRruL0EQ10AyfxkhIbfgpfcqyoIWAmA=;
	b=LeY2QpdpiYp+sG+dROeCR+GDSIaUaddKzJrptUi4ez8idBj4Wb3v6882QyL9hT/yQ/4IWO
	e5PxJukeDaU5vwHxGqK603mjo40eBweUXRH4btAKhhRT1SMrWLWEiIGm4DbnT1lTKsSdAZ
	F1s9RhHRPSSiN5zpC0nKcnloNiL1ZmsDIGNCUn7Z0g2rxDz6mn/SJ/+qEdQYBOgpiv0GNu
	7ydvAmsNUtSZm1NiHkyDDZTpUhiV+YeYYepMt1PR2cHDt9HLzaZxU92Z1ym/K7qRAi6AMh
	RgSIgtM6EObbpZu8TxAaWIewKQNDFw18BInqEp8dkb7U0lniV8U9VUDy3npvOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GQOPBY2uEa4mMRruL0EQ10AyfxkhIbfgpfcqyoIWAmA=;
	b=ZB3xRbtMLTTOOglmtWyPAmFSsd/Z/b2wvZTlrGEM66cghH8RSCxGgPsxsntcxJL0AvJJ+K
	VNpkCsEJVOA9jIAg==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Fix uninitialized pointer dereference
 in error path
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205918453.398.18215984213946504139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     79eba8c924f7decfa71ddf187d38cb9f5f2cd7b3
Gitweb:        https://git.kernel.org/tip/79eba8c924f7decfa71ddf187d38cb9f5f2cd7b3
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:42 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:26 -08:00

selftests/sgx: Fix uninitialized pointer dereference in error path

Ensure ctx is zero-initialized, such that the encl_measure function will
not call EVP_MD_CTX_destroy with an uninitialized ctx pointer in case of an
early error during key generation.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-2-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/sigstruct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index a07896a..d73b29b 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -318,9 +318,9 @@ bool encl_measure(struct encl *encl)
 	struct sgx_sigstruct *sigstruct = &encl->sigstruct;
 	struct sgx_sigstruct_payload payload;
 	uint8_t digest[SHA256_DIGEST_LENGTH];
+	EVP_MD_CTX *ctx = NULL;
 	unsigned int siglen;
 	RSA *key = NULL;
-	EVP_MD_CTX *ctx;
 	int i;
 
 	memset(sigstruct, 0, sizeof(*sigstruct));
@@ -384,7 +384,8 @@ bool encl_measure(struct encl *encl)
 	return true;
 
 err:
-	EVP_MD_CTX_destroy(ctx);
+	if (ctx)
+		EVP_MD_CTX_destroy(ctx);
 	RSA_free(key);
 	return false;
 }

