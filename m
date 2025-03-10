Return-Path: <linux-tip-commits+bounces-4104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B302A592E0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 12:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF783A54D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759121E097;
	Mon, 10 Mar 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cK5KKD80";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lntwmXZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3C21E092;
	Mon, 10 Mar 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606811; cv=none; b=KUVWEVkc4Z7L2H/qZoG2HAToQnaaUff8ByPNTSRqq92BRT3Y9QFYoqROE/l+oD+M3StlHXjGZ8e6zoN2zWokIpBiQW7XG28ZYKs3Rv2Y4JXF1H6nk8PvumXMpKXutkxLxoKMQx37ziCeUj2OMGSrOYtao8xepO/SjlkUbMue5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606811; c=relaxed/simple;
	bh=kec7Xe22wLpgK4izJqAFm7oJGHVWRD9CwUdN50ODEqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GNzVw5t0Jx3GyY/bTsCMtA4wlhoFJ2QBdEgID0FpEE+J3ZJw6tNlYFDDifGCNjLz/GdjJhO0IXGSa07N/grKZhahf5IerV6lUM0zW19r11F2/kAHbw3WA0ww7ckbDaRGxixdD2HcvGaJyzFjHev+W3hgv8jqRO2scREWTs5pTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cK5KKD80; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lntwmXZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 11:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741606806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MxmdXnTmQfNGGgvujUzBMNfCepMANVcFw/xgvmjWL8=;
	b=cK5KKD8077yMfJs6ImH+dyZ+GCcD00UGat+CDHMWrhFewb/b89T7TTa/mvMjFEpNJ4m7/N
	vVHishTSPBXqEM8SvrSiiUrPinwFWUunh2L8nYzvnpZy+fZCs5C3+L4lsAEsawYKcOn5fz
	YyP2b6dnOh6mja5D3iDe86qXAOYf3Ox0HRoM4iiXBqEAWE9SEg2h5V9Uh1FR/D5MqjRXti
	T9HDMpCPT5LbdVcLBWPEXN6YgCF7oyz5H55g/DrvJCa7en6cg8zTTAXXjviAq4CVVk+yKT
	cZa4DZwt58GurT8JUzE3hpZswlaiX7ZPS8ptUxNFhXzdSlMHh9nhlv50ObLGsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741606806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MxmdXnTmQfNGGgvujUzBMNfCepMANVcFw/xgvmjWL8=;
	b=2lntwmXZRmFt9zSU3P/z98UanFyhD7C3hoaX+a94xf7ldkYma7K/lnPBIC0YtjGMUSJH6p
	S9hXf2tD+yPxTXBw==
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
Message-ID: <174160680181.14745.6498994786003224468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     65be5c95d08eedda570a6c888a12384c77fe7614
Gitweb:        https://git.kernel.org/tip/65be5c95d08eedda570a6c888a12384c77fe7614
Author:        Vladis Dronov <vdronov@redhat.com>
AuthorDate:    Sun, 09 Mar 2025 18:22:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 12:29:18 +01:00

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
index 22b65a5..7f8d1e1 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -150,13 +150,15 @@ int __init sgx_drv_init(void)
 	u64 xfrm_mask;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		pr_info("SGX disabled: SGX launch control CPU feature is not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
+	}
 
 	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
 
 	if (!(eax & 1))  {
-		pr_err("SGX disabled: SGX1 instruction support not available.\n");
+		pr_info("SGX disabled: SGX1 instruction support not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
 	}
 
@@ -173,8 +175,10 @@ int __init sgx_drv_init(void)
 	}
 
 	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
+	if (ret) {
+		pr_info("SGX disabled: Unable to register the /dev/sgx_enclave driver (%d).\n", ret);
 		return ret;
+	}
 
 	return 0;
 }

