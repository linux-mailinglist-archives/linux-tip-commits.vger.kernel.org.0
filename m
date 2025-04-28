Return-Path: <linux-tip-commits+bounces-5130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF39A9F9FA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Apr 2025 21:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C2464D85
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Apr 2025 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08901297A6A;
	Mon, 28 Apr 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QohumDQR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MioIuUhV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A924297A48;
	Mon, 28 Apr 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869972; cv=none; b=FuRI0HvR9mv+IADuWJ/TUP21TYW8eyjx2s9nxqjx2KaESGk0do9ujAuyXbDq33cct8vRkZbCmVsm3MxrJY5HMRRJ71HWFF9t8vq3sQZ+a1Vb6cQosw25NHpQn54iU72rL0cv4cVqzzdTF0bo2B9iYqTWW16bqQKhNmXT901rm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869972; c=relaxed/simple;
	bh=jwChOoXC4TDoE7TY3m7P2SVfrlsRULxdum5DpPFxMUI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YvM8jCnSkcjcZ5xdp2ltevozOjEvDzJrWY0QUWd9u8d96dnB0ywExIprUwGmFxcIt0+hcjGULJYOdUkHuG8RbDI8LjWy3xonaEqrG8jlayPdUr+1qQpHbhJy0Kdr90y+2a07nnl5WfRF2aQ2hKs9VuHo5eIdpn0jCKGbpcOQarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QohumDQR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MioIuUhV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Apr 2025 19:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745869968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J2lhbUVZjjWqNgm5FC2+kfuyoRjnEUzQbEK7mgl3MKE=;
	b=QohumDQR3TB2GrjQFNIBDLvDaH93WEDkz4MWj3SZsUIg34NBD6Rkuc6Z1ONtZHWVPGGv8x
	mJJKCnpVqI/PBxRSUTKkaa5v5UEW1YVMuPot77ZJn5sBD6z5DaFqJjg2nY/6loJGHesbOF
	g5m70+5pKBmy52gKNFFHeyB4Zl2F6npE1BI2DdqkWBoHQzl3YC/T2Tj39pXZW9s2E20qwg
	u3J5Jlhqf8E1cJxpICZlVhnL6HW69JCGu9IB8i79x+2O7koBeMHt14bJItqxTiD+Uab3EW
	5/Vmod1lo/gDgJ3Ky3N0MIRol9AuhGc8Jd7ex5D0bVh5IAlPltxetQcRvTwWHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745869968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J2lhbUVZjjWqNgm5FC2+kfuyoRjnEUzQbEK7mgl3MKE=;
	b=MioIuUhVmw0Qxdes3nh9RXAy6W//Ajk6SUaMfnfPCc7bYDOQ7bx8lBTJS3Yt+NrPXarTRe
	ZekOzfye/igb37DA==
From: "tip-bot2 for Eric Biggers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sgx] x86/sgx: Use SHA-256 library API instead of crypto_shash API
Cc: Eric Biggers <ebiggers@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174586996366.22196.10366786516838231392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     e59236b5a09e168fdf961a10d2519cef44f5d6b4
Gitweb:        https://git.kernel.org/tip/e59236b5a09e168fdf961a10d2519cef44f5d6b4
Author:        Eric Biggers <ebiggers@google.com>
AuthorDate:    Mon, 28 Apr 2025 11:38:38 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 28 Apr 2025 12:39:33 -07:00

x86/sgx: Use SHA-256 library API instead of crypto_shash API

This user of SHA-256 does not support any other algorithm, so the
crypto_shash abstraction provides no value.  Just use the SHA-256
library API instead, which is much simpler and easier to use.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250428183838.799333-1-ebiggers%40kernel.org
---
 arch/x86/Kconfig                 |  3 +--
 arch/x86/kernel/cpu/sgx/driver.h |  1 -
 arch/x86/kernel/cpu/sgx/ioctl.c  | 30 ++----------------------------
 3 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378..6eb0ebb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1881,8 +1881,7 @@ endchoice
 config X86_SGX
 	bool "Software Guard eXtensions (SGX)"
 	depends on X86_64 && CPU_SUP_INTEL && X86_X2APIC
-	depends on CRYPTO=y
-	depends on CRYPTO_SHA256=y
+	select CRYPTO_LIB_SHA256
 	select MMU_NOTIFIER
 	select NUMA_KEEP_MEMINFO if NUMA
 	select XARRAY_MULTI
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index 4eddb4d..30f39f9 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -2,7 +2,6 @@
 #ifndef __ARCH_SGX_DRIVER_H__
 #define __ARCH_SGX_DRIVER_H__
 
-#include <crypto/hash.h>
 #include <linux/kref.h>
 #include <linux/mmu_notifier.h>
 #include <linux/radix-tree.h>
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 776a201..66f1efa 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -3,6 +3,7 @@
 
 #include <asm/mman.h>
 #include <asm/sgx.h>
+#include <crypto/sha2.h>
 #include <linux/mman.h>
 #include <linux/delay.h>
 #include <linux/file.h>
@@ -463,31 +464,6 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
-static int __sgx_get_key_hash(struct crypto_shash *tfm, const void *modulus,
-			      void *hash)
-{
-	SHASH_DESC_ON_STACK(shash, tfm);
-
-	shash->tfm = tfm;
-
-	return crypto_shash_digest(shash, modulus, SGX_MODULUS_SIZE, hash);
-}
-
-static int sgx_get_key_hash(const void *modulus, void *hash)
-{
-	struct crypto_shash *tfm;
-	int ret;
-
-	tfm = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	ret = __sgx_get_key_hash(tfm, modulus, hash);
-
-	crypto_free_shash(tfm);
-	return ret;
-}
-
 static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 			 void *token)
 {
@@ -523,9 +499,7 @@ static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 	    sgx_xfrm_reserved_mask)
 		return -EINVAL;
 
-	ret = sgx_get_key_hash(sigstruct->modulus, mrsigner);
-	if (ret)
-		return ret;
+	sha256(sigstruct->modulus, SGX_MODULUS_SIZE, (u8 *)mrsigner);
 
 	mutex_lock(&encl->lock);
 

