Return-Path: <linux-tip-commits+bounces-7365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D80C5F994
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 00:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3D8535EA20
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5130FC22;
	Fri, 14 Nov 2025 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y0tKXZGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYHhYz7L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38130EF94;
	Fri, 14 Nov 2025 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163201; cv=none; b=Ewomgf89mzvPIT70JiflRXG+ctXrxifolJVx3jAz1Wd5A+0AXLy7Gdqk3qO9c5u7CLzJSApEOgmCEnA28ofqvv06rL2hOAWuqqu2/lGNCoWnxkFoJQ34z6TIOx9L0syFtH8cymOrDzX9qearHsCMLkGyoYbUOOKoqurAfGqH12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163201; c=relaxed/simple;
	bh=ru6X3d+JV20XxLT/4zxWvHy6TUR5SI92DKex7OaIbxY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mp1xEyLpeQPys/n46ctWX4Oopy1SjXoJUMyMowrA6X0+TvKwjFgYMQnBb3s6Wk9jvkiQZEv58nl6Nf1qJPqMNR0PvkZ2mvBai1MZH4uD8HJCNxewhGayCOgNCgD4yRV7y2wR5fufOax6p8ocBCgC5G+b8WcMBeg285HzQSvQvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y0tKXZGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYHhYz7L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 23:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763163198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kccWJa/7hJg8gpL+TKZoffQ08MSZd0TgbQcp+k/ByXQ=;
	b=y0tKXZGqB3PKzm8BCSPRmM5+cg8c2lwh74uY/ZKWB6c9/UMaBJ9ldFKik4vJzomnTfi/Tf
	883ofBIMJeUQ48xhJvNdiZQKw4wkh/YAIoe0Xs7j98+bEeMONwvJ9dqEpREWucmx98JQ4y
	YPNmelRtH+D9iAsbnDJm/CoBHAI/SHqQPUCGlAt51MAgN2wqhOglW8D4C4mG04RsE67IZx
	pHc2DMD5NsSvs2hybbihtR3AyTZSAdlYOfwRSpyl1ct1MrjadUfXqPH+oC6ffA0AlEbb+o
	K73GL6VAV1K27wwO6U61PJylHsPrMD8OnBbzQn9OMClFez3R67LATjBgNuYk/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763163198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kccWJa/7hJg8gpL+TKZoffQ08MSZd0TgbQcp+k/ByXQ=;
	b=dYHhYz7LLO4Vgo60X3MKWFMFpFU8fAeShrZA3xU6WHi4S4qKFb9dgDTOPVsDXTA+05WhLV
	CNMHxEOxRcffG9Ag==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Document structs and enums with '@', not '%'
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176316319676.498.2380806860970355389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     905885fdb1f73368b876de7320e8160e29e2dd03
Gitweb:        https://git.kernel.org/tip/905885fdb1f73368b876de7320e8160e29e=
2dd03
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 08:07:06 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 14 Nov 2025 15:30:26 -08:00

x86/sgx: Document structs and enums with '@', not '%'

Use '@' to document structure members and enum values in kernel-doc markup,
as per Documentation/doc-guide/kernel-doc.rst and flagged by make htmldocs.

  WARNING: arch/x86/include/uapi/asm/sgx.h:17 Enum value 'SGX_PAGE_MEASURE'
           not described in enum 'sgx_page_flags'

Opportunistically add a missing ':' for SGX_CHILD_PRESENT.

Closes: https://lore.kernel.org/all/20251106145506.145fc620@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251112160708.1343355-4-seanjc%40google.com
---
 arch/x86/include/asm/sgx.h      | 60 ++++++++++++++++----------------
 arch/x86/include/uapi/asm/sgx.h |  2 +-
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index c2c4c0d..a88c4ab 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -66,19 +66,19 @@ enum sgx_encls_function {
=20
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
- * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
- * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
+ * @SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
+ * @SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
- * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
- * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
+ * @SGX_CHILD_PRESENT:		SECS has child pages present in the EPC.
+ * @SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
- * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
+ * @SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
  *				is in the PENDING or MODIFIED state.
- * %SGX_INSUFFICIENT_ENTROPY:	Insufficient entropy in RNG.
- * %SGX_NO_UPDATE:		EUPDATESVN could not update the CPUSVN because the
+ * @SGX_INSUFFICIENT_ENTROPY:	Insufficient entropy in RNG.
+ * @SGX_NO_UPDATE:		EUPDATESVN could not update the CPUSVN because the
  *				current SVN was not newer than CPUSVN. This is the most
  *				common error code returned by EUPDATESVN.
- * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
+ * @SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
 	SGX_EPC_PAGE_CONFLICT		=3D 7,
@@ -96,7 +96,7 @@ enum sgx_return_code {
=20
 /**
  * enum sgx_miscselect - additional information to an SSA frame
- * %SGX_MISC_EXINFO:	Report #PF or #GP to the SSA frame.
+ * @SGX_MISC_EXINFO:	Report #PF or #GP to the SSA frame.
  *
  * Save State Area (SSA) is a stack inside the enclave used to store process=
or
  * state when an exception or interrupt occurs. This enum defines additional
@@ -113,16 +113,16 @@ enum sgx_miscselect {
=20
 /**
  * enum sgx_attributes - the attributes field in &struct sgx_secs
- * %SGX_ATTR_INIT:		Enclave can be entered (is initialized).
- * %SGX_ATTR_DEBUG:		Allow ENCLS(EDBGRD) and ENCLS(EDBGWR).
- * %SGX_ATTR_MODE64BIT:		Tell that this a 64-bit enclave.
- * %SGX_ATTR_PROVISIONKEY:      Allow to use provisioning keys for remote
+ * @SGX_ATTR_INIT:		Enclave can be entered (is initialized).
+ * @SGX_ATTR_DEBUG:		Allow ENCLS(EDBGRD) and ENCLS(EDBGWR).
+ * @SGX_ATTR_MODE64BIT:		Tell that this a 64-bit enclave.
+ * @SGX_ATTR_PROVISIONKEY:      Allow to use provisioning keys for remote
  *				attestation.
- * %SGX_ATTR_KSS:		Allow to use key separation and sharing (KSS).
- * %SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used to
+ * @SGX_ATTR_KSS:		Allow to use key separation and sharing (KSS).
+ * @SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used to
  *				sign cryptographic tokens that can be passed to
  *				EINIT as an authorization to run an enclave.
- * %SGX_ATTR_ASYNC_EXIT_NOTIFY:	Allow enclaves to be notified after an
+ * @SGX_ATTR_ASYNC_EXIT_NOTIFY:	Allow enclaves to be notified after an
  *				asynchronous exit has occurred.
  */
 enum sgx_attribute {
@@ -195,7 +195,7 @@ struct sgx_secs {
=20
 /**
  * enum sgx_tcs_flags - execution flags for TCS
- * %SGX_TCS_DBGOPTIN:	If enabled allows single-stepping and breakpoints
+ * @SGX_TCS_DBGOPTIN:	If enabled allows single-stepping and breakpoints
  *			inside an enclave. It is cleared by EADD but can
  *			be set later with EDBGWR.
  */
@@ -260,11 +260,11 @@ struct sgx_pageinfo {
=20
 /**
  * enum sgx_page_type - bits in the SECINFO flags defining the page type
- * %SGX_PAGE_TYPE_SECS:	a SECS page
- * %SGX_PAGE_TYPE_TCS:	a TCS page
- * %SGX_PAGE_TYPE_REG:	a regular page
- * %SGX_PAGE_TYPE_VA:	a VA page
- * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
+ * @SGX_PAGE_TYPE_SECS:	a SECS page
+ * @SGX_PAGE_TYPE_TCS:	a TCS page
+ * @SGX_PAGE_TYPE_REG:	a regular page
+ * @SGX_PAGE_TYPE_VA:	a VA page
+ * @SGX_PAGE_TYPE_TRIM:	a page in trimmed state
  *
  * Make sure when making changes to this enum that its values can still fit
  * in the bitfield within &struct sgx_encl_page
@@ -282,14 +282,14 @@ enum sgx_page_type {
=20
 /**
  * enum sgx_secinfo_flags - the flags field in &struct sgx_secinfo
- * %SGX_SECINFO_R:	allow read
- * %SGX_SECINFO_W:	allow write
- * %SGX_SECINFO_X:	allow execution
- * %SGX_SECINFO_SECS:	a SECS page
- * %SGX_SECINFO_TCS:	a TCS page
- * %SGX_SECINFO_REG:	a regular page
- * %SGX_SECINFO_VA:	a VA page
- * %SGX_SECINFO_TRIM:	a page in trimmed state
+ * @SGX_SECINFO_R:	allow read
+ * @SGX_SECINFO_W:	allow write
+ * @SGX_SECINFO_X:	allow execution
+ * @SGX_SECINFO_SECS:	a SECS page
+ * @SGX_SECINFO_TCS:	a TCS page
+ * @SGX_SECINFO_REG:	a regular page
+ * @SGX_SECINFO_VA:	a VA page
+ * @SGX_SECINFO_TRIM:	a page in trimmed state
  */
 enum sgx_secinfo_flags {
 	SGX_SECINFO_R			=3D BIT(0),
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 0d408f0..3c4d520 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -10,7 +10,7 @@
=20
 /**
  * enum sgx_page_flags - page control flags
- * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
+ * @SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
  *			ENCLS[EEXTEND] operations.
  */
 enum sgx_page_flags {

