Return-Path: <linux-tip-commits+bounces-6958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB64BE59C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0911A660C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756832E610B;
	Thu, 16 Oct 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vaDqw8JM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTfFnJD1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8C2E5B27;
	Thu, 16 Oct 2025 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651601; cv=none; b=CWJuf5vZdpsaQXp43QZ61YdNNSN1TI2Hxh1/4E8H8vb0AIz/2Ez5+sFIbPCohg/inswCIYFHCpHfvVNWlLod48T33evxG6UB7eMiZoBVQff0KB4hBuL/zW22cZ9huwBbJFrjLcgAhMvKEzEXiAvRUCxItb4kzA0w5xbrGc2jD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651601; c=relaxed/simple;
	bh=4sOQNypreyCeE9/EuLMpAcPMML6RKhvxMi29FSqAmhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S4bz+nwbpohfiCIzVsJw72zhhaAXdfyIflo9UVk3tJfxFy9icD5XalCv+wyIy0FJtZ6VHfez1GoTToJcE1+2p19FvolMLDhEVvLJ7N4Trhli6ALDFeXH4qonDbPj1eQDS4SBTmJ+EvVf6Bl0M0iNWV6yyKQh1QKzN01SVnNVY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vaDqw8JM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTfFnJD1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:53:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760651597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIWhFB6qp9t9bnA8/P8HzZt07DT39Q4aFa1nIGRoXz8=;
	b=vaDqw8JMPQzbTyczWhytzQNO1mba2Qq8PObdjWAH1DeMS3hbPwSDOMmTBG8d6ylUkIFz9D
	980KJwx8JXCGwiD6JUcn26uW5YXGkdnWIkDS6q/44szkipTXEjkdb/n7BCi1SbMWzkrhI8
	/90ZjhukFpuj/KItJFYNz6IX3bJbhlSzNNCYAmL7M5/woVnBGOhdP3ujuCFZbHsiQSg6P1
	MlZ5uE7X+qeD8lJQDh6g7asAPj3W/ewIx/qdIN+uj/435cK1ZjMN/+5Dy9wTfo++G9D9X9
	cHOh1efX/OxbZ9jgfDQLbKrzuDwezNz5uuf50eBdUzD/k3/5/fCCbs1EmJdfYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760651597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIWhFB6qp9t9bnA8/P8HzZt07DT39Q4aFa1nIGRoXz8=;
	b=kTfFnJD18Xn5WlPpbFyHwvaPPjHL1WdtTnoJc7qNoq1kr7ro90e1U6YVOGuBua1QwclrS/
	n9XE0nh9IMnGsUAA==
From: "tip-bot2 for Elena Reshetova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Implement ENCLS[EUPDATESVN]
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Nataliia Bondarevska <bondarn@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016131314.17153-5-elena.reshetova@intel.com>
References: <20251016131314.17153-5-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176065159299.709179.17178683736582364040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     4e75697faa7af5a254def4c0939d06d0f5b9ed17
Gitweb:        https://git.kernel.org/tip/4e75697faa7af5a254def4c0939d06d0f5b=
9ed17
Author:        Elena Reshetova <elena.reshetova@intel.com>
AuthorDate:    Thu, 16 Oct 2025 16:11:07 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Oct 2025 14:42:09 -07:00

x86/sgx: Implement ENCLS[EUPDATESVN]

All running enclaves and cryptographic assets (such as internal SGX
encryption keys) are assumed to be compromised whenever an SGX-related
microcode update occurs. To mitigate this assumed compromise the new
supervisor SGX instruction ENCLS[EUPDATESVN] can generate fresh
cryptographic assets.

Before executing EUPDATESVN, all SGX memory must be marked as unused. This
requirement ensures that no potentially compromised enclave survives the
update and allows the system to safely regenerate cryptographic assets.

Add the method to perform ENCLS[EUPDATESVN]. However, until the follow up
patch that wires calling sgx_update_svn() from sgx_inc_usage_count(), this
code is not reachable.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Nataliia Bondarevska <bondarn@google.com>
---
 arch/x86/include/asm/sgx.h      | 31 ++++++-------
 arch/x86/kernel/cpu/sgx/encls.h |  5 ++-
 arch/x86/kernel/cpu/sgx/main.c  | 75 ++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 73348cf..c2c4c0d 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -28,21 +28,22 @@
 #define SGX_CPUID_EPC_MASK	GENMASK(3, 0)
=20
 enum sgx_encls_function {
-	ECREATE	=3D 0x00,
-	EADD	=3D 0x01,
-	EINIT	=3D 0x02,
-	EREMOVE	=3D 0x03,
-	EDGBRD	=3D 0x04,
-	EDGBWR	=3D 0x05,
-	EEXTEND	=3D 0x06,
-	ELDU	=3D 0x08,
-	EBLOCK	=3D 0x09,
-	EPA	=3D 0x0A,
-	EWB	=3D 0x0B,
-	ETRACK	=3D 0x0C,
-	EAUG	=3D 0x0D,
-	EMODPR	=3D 0x0E,
-	EMODT	=3D 0x0F,
+	ECREATE		=3D 0x00,
+	EADD		=3D 0x01,
+	EINIT		=3D 0x02,
+	EREMOVE		=3D 0x03,
+	EDGBRD		=3D 0x04,
+	EDGBWR		=3D 0x05,
+	EEXTEND		=3D 0x06,
+	ELDU		=3D 0x08,
+	EBLOCK		=3D 0x09,
+	EPA		=3D 0x0A,
+	EWB		=3D 0x0B,
+	ETRACK		=3D 0x0C,
+	EAUG		=3D 0x0D,
+	EMODPR		=3D 0x0E,
+	EMODT		=3D 0x0F,
+	EUPDATESVN	=3D 0x18,
 };
=20
 /**
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 42a088a..74be751 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -233,4 +233,9 @@ static inline int __eaug(struct sgx_pageinfo *pginfo, voi=
d *addr)
 	return __encls_2(EAUG, pginfo, addr);
 }
=20
+/* Attempt to update CPUSVN at runtime. */
+static inline int __eupdatesvn(void)
+{
+	return __encls_ret_1(EUPDATESVN, "");
+}
 #endif /* _X86_ENCLS_H */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 3a5cbd1..ffc7b94 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <asm/msr.h>
 #include <asm/sgx.h>
+#include <asm/archrandom.h>
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
@@ -917,6 +918,80 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
=20
+/* Counter to count the active SGX users */
+static int sgx_usage_count;
+
+/**
+ * sgx_update_svn() - Attempt to call ENCLS[EUPDATESVN].
+ *
+ * This instruction attempts to update CPUSVN to the
+ * currently loaded microcode update SVN and generate new
+ * cryptographic assets.
+ *
+ * Return:
+ * * %0:       - Success or not supported
+ * * %-EAGAIN: - Can be safely retried, failure is due to lack of
+ * *             entropy in RNG
+ * * %-EIO:    - Unexpected error, retries are not advisable
+ */
+static int __maybe_unused sgx_update_svn(void)
+{
+	int ret;
+
+	/*
+	 * If EUPDATESVN is not available, it is ok to
+	 * silently skip it to comply with legacy behavior.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_EUPDATESVN))
+		return 0;
+
+	/*
+	 * EPC is guaranteed to be empty when there are no users.
+	 * Ensure we are on our first user before proceeding further.
+	 */
+	WARN(sgx_usage_count, "Elevated usage count when calling EUPDATESVN\n");
+
+	for (int i =3D 0; i < RDRAND_RETRY_LOOPS; i++) {
+		ret =3D __eupdatesvn();
+
+		/* Stop on success or unexpected errors: */
+		if (ret !=3D SGX_INSUFFICIENT_ENTROPY)
+			break;
+	}
+
+	switch (ret) {
+	case 0:
+		/*
+		 * SVN successfully updated.
+		 * Let users know when the update was successful.
+		 */
+		pr_info("SVN updated successfully\n");
+		return 0;
+	case SGX_NO_UPDATE:
+		/*
+		 * SVN update failed since the current SVN is
+		 * not newer than CPUSVN. This is the most
+		 * common case and indicates no harm.
+		 */
+		return 0;
+	case SGX_INSUFFICIENT_ENTROPY:
+		/*
+		 * SVN update failed due to lack of entropy in DRNG.
+		 * Indicate to userspace that it should retry.
+		 */
+		return -EAGAIN;
+	default:
+		break;
+	}
+
+	/*
+	 * EUPDATESVN was called when EPC is empty, all other error
+	 * codes are unexpected.
+	 */
+	ENCLS_WARN(ret, "EUPDATESVN");
+	return -EIO;
+}
+
 int sgx_inc_usage_count(void)
 {
 	return 0;

