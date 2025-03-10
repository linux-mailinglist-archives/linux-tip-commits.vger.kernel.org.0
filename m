Return-Path: <linux-tip-commits+bounces-4100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D84FA58EB5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 09:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43FB67A59A3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23051224245;
	Mon, 10 Mar 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKdKAr/7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NyXraeWr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEC224244;
	Mon, 10 Mar 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597041; cv=none; b=UHr4/pTbQ04plovgnSghFoPFoG7EvwSaY4ONHYjAoIZTND2qg5FBInr/e+n3FwOoZYIIQdoY1dyLtssE+3ZwqB6TIgkXX5FmB6rL4NJvKJkn5jhdodDBt572Dx94e51KJUdlue+U+cuMv1j6WSuE7F1ejvzg2MI6tzUFlc5QVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597041; c=relaxed/simple;
	bh=+k6GtvcSmIj42+huiKCmhixjot6lu6A3lN07YI0QX8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HmXVaT807K/XACXJuf5knIcPeTYgc9r35yG3VkH58apVvBNU1oT9iS0Nblocp9aAkWodCovZcauhogCXpsbjRvq1908kBacq5Ccv4FyzxnK92r28/tJ7wz15tbGM8UWwiPxZdcnhYNdCAQxdbfC/NWJmoarIsa0w5wb97WzB+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKdKAr/7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NyXraeWr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 08:57:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741597032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5pqoPT5gocZWBmKMd4J0Ax3d81NKoizTihr2tTgYqw=;
	b=MKdKAr/7PYZitax+pmOLOj50GZGqMoxwVBjnnT9bFrOpbIMw52IRpcx+oYIDGaNtxha+Hn
	HD9yvyyRF85etgy9s9rV17KBK08Ykl+jYeBRGOVPKaRNYUkVw8xrHLLxI43LjS0A2xULb9
	ihldehBjuLGodE2ktLb5fSkL8IMb7fszFYME0IW8TnUU2SkZMHekXNeSP7OkG5qOK/dxv9
	LANfmfyZsJgUhGz52uQz1kJg6mQqMZDIFDfZiu4Vx9E9tCIQYiNg9VbWIcTyCQHpU1EDOS
	yXU8qtIIXLbuSFKQicqY7pYAGAwB8LuGHT9BQ95IS+j7tJZ2/CkcCZkSGyTpJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741597032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5pqoPT5gocZWBmKMd4J0Ax3d81NKoizTihr2tTgYqw=;
	b=NyXraeWrbLjWLGsM08hnaWFXojdgy9CuOhGn8vlbbV65rSbfKWeA9UWwTB6ND68KE02GE9
	sJDMplYkRZfs7aCQ==
From: "tip-bot2 for Vladis Dronov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is
 not enabled
Cc: Vladis Dronov <vdronov@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250309172215.21777-2-vdronov@redhat.com>
References: <20250309172215.21777-2-vdronov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174159702651.14745.5605222445633760713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     baf6a4fdb5ead6be10aa0a0e620d6078a669fc75
Gitweb:        https://git.kernel.org/tip/baf6a4fdb5ead6be10aa0a0e620d6078a669fc75
Author:        Vladis Dronov <vdronov@redhat.com>
AuthorDate:    Sun, 09 Mar 2025 18:22:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 09:40:38 +01:00

x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled

The kernel requires X86_FEATURE_SGX_LC to be able to create SGX enclaves,
not just X86_FEATURE_SGX.

There is quite a number of hardware which has X86_FEATURE_SGX but not
X86_FEATURE_SGX_LC. A kernel running on such hardware does not create
the /dev/sgx_enclave file and does so silently.

Explicitly warn if X86_FEATURE_SGX_LC is not enabled to properly notify
users that the kernel disabled the SGX driver.

The X86_FEATURE_SGX_LC, a.k.a. SGX Launch Control, is a CPU feature
that enables LE (Launch Enclave) hash MSRs to be writable (with
additional opt-in required in the 'feature control' MSR) when running
enclaves, i.e. using a custom root key rather than the Intel proprietary
key for enclave signing.

I've hit this issue myself and have spent some time researching where
my /dev/sgx_enclave file went on SGX-enabled hardware.

Related links:

  https://github.com/intel/linux-sgx/issues/837
  https://patchwork.kernel.org/project/platform-driver-x86/patch/20180827185507.17087-3-jarkko.sakkinen@linux.intel.com/

[ mingo: Made the error message a bit more verbose, and added other cases
         where the kernel fails to create the /dev/sgx_enclave device node. ]

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250309172215.21777-2-vdronov@redhat.com
---
 arch/x86/kernel/cpu/sgx/driver.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 22b65a5..40c3347 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -150,13 +150,15 @@ int __init sgx_drv_init(void)
 	u64 xfrm_mask;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		pr_err("SGX disabled: SGX launch control CPU feature is not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
+	}
 
 	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
 
 	if (!(eax & 1))  {
-		pr_err("SGX disabled: SGX1 instruction support not available.\n");
+		pr_err("SGX disabled: SGX1 instruction support not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
 	}
 
@@ -173,8 +175,10 @@ int __init sgx_drv_init(void)
 	}
 
 	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
+	if (ret) {
+		pr_err("SGX disabled: Unable to register the /dev/sgx_enclave driver (%d).\n", ret);
 		return ret;
+	}
 
 	return 0;
 }

