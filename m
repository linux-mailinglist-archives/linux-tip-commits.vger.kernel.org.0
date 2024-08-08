Return-Path: <linux-tip-commits+bounces-2023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428C94C248
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198601F20CEF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B5189BAD;
	Thu,  8 Aug 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoF/DKcU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJh9xBf9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244A8003F;
	Thu,  8 Aug 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133244; cv=none; b=j9gs4GI5MbxIVGGuxMc6JJmbOUFvYJSZYG4aZ8/uMIM5pLS3yUoqLNVRCZRztZW+aLTWNy+uC2ruI/wmY/GsMc6DD7/qyJQ4f3PUkm+9So9bJIeA7iZgi9QPJs9xzBUlztKDpzOQxCeyeAQOPfYckEMAfSziWVHO86ALuoaYisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133244; c=relaxed/simple;
	bh=5F6dDpIeEa+qGyrQd0ZTycZ+Z34sdbZlEewA5KDwzhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BBHRM09CCqF+moAvhG+U0xfQ6nl9CLsC8/gyKCTxZnU+ZCVLsKNg+/BNB4UL6CCwmPg2zrl5hqfqZCl/maVVWRNHoi19tAx4w7DjORQHsxRCKcQn96jwKXRG3ktjWzwUw0cnNZAFAlvq5XbFgCOcOYZBgzpPsxLu8RuwCvlD4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoF/DKcU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJh9xBf9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 16:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723133241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/+yn9vMJG2VUOfRoIReM4ApJghd5uksSCiKQ1FwKcc=;
	b=UoF/DKcU/Mwv2RajMN+Zh6b3X6fXPLjcDz0oTeKldtggcZCE7pM0/DfGhaGdYSeHwVJ82c
	xA2EjO9GQ2oa55M1V8QzeawO5YQ13zNLD2L/qQUGL0nHEw/Gvozv4UiedXE+bo44gl9k21
	JIHllwAWmxZ0rXJzauXhhu7g/NtaZqPMsLONsK8swL3k10ty34BK36HV6vSC8SjR6j/Q8G
	VuAPdtGLipOc1n3Vm1kYw4i5brQ8MJjP+WghregiBJplaM85ZPabK1bWB7VYojFDeuDiwv
	DqRVMKRNcLbvjdbSB1C8l2dKC/ecXzazteXYWBq/6nFsMM4ia5468UfrdQ7ewA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723133241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/+yn9vMJG2VUOfRoIReM4ApJghd5uksSCiKQ1FwKcc=;
	b=OJh9xBf98APP/bX0r8PngbKPH4E/hAPD/PHrQDrhG/MC2RgN4BOB56y4nJX7U1SCZhU2ah
	c7KmAc9qEXQhejAQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/bus_lock: Add support for AMD
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240808062937.1149-3-ravi.bangoria@amd.com>
References: <20240808062937.1149-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313324072.2215.14130290124087145806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     408eb7417a92c5354c7be34f7425b305dfe30ad9
Gitweb:        https://git.kernel.org/tip/408eb7417a92c5354c7be34f7425b305dfe30ad9
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Thu, 08 Aug 2024 06:29:35 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 18:02:15 +02:00

x86/bus_lock: Add support for AMD

Add Bus Lock Detect (called Bus Lock Trap in AMD docs) support for AMD
platforms. Bus Lock Detect is enumerated with CPUID Fn0000_0007_ECX_x0
bit [24 / BUSLOCKTRAP]. It can be enabled through MSR_IA32_DEBUGCTLMSR.
When enabled, hardware clears DR6[11] and raises a #DB exception on
occurrence of Bus Lock if CPL > 0. More detail about the feature can be
found in AMD APM[1].

[1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
     2023, Vol 2, 13.1.3.6 Bus Lock Trap
     https://bugzilla.kernel.org/attachment.cgi?id=304653

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/all/20240808062937.1149-3-ravi.bangoria@amd.com

---
 Documentation/arch/x86/buslock.rst | 3 ++-
 arch/x86/Kconfig                   | 2 +-
 arch/x86/kernel/cpu/common.c       | 2 ++
 arch/x86/kernel/cpu/intel.c        | 1 -
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/buslock.rst b/Documentation/arch/x86/buslock.rst
index 4c5a482..31f1bfd 100644
--- a/Documentation/arch/x86/buslock.rst
+++ b/Documentation/arch/x86/buslock.rst
@@ -26,7 +26,8 @@ Detection
 =========
 
 Intel processors may support either or both of the following hardware
-mechanisms to detect split locks and bus locks.
+mechanisms to detect split locks and bus locks. Some AMD processors also
+support bus lock detect.
 
 #AC exception for split lock detection
 --------------------------------------
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9c4e69a..e3d53fc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2428,7 +2428,7 @@ source "kernel/livepatch/Kconfig"
 
 config X86_BUS_LOCK_DETECT
 	bool "Split Lock Detect and Bus Lock Detect support"
-	depends on CPU_SUP_INTEL
+	depends on CPU_SUP_INTEL || CPU_SUP_AMD
 	default y
 	help
 	  Enable Split Lock Detect and Bus Lock Detect functionalities.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d..a37670e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1832,6 +1832,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	if (this_cpu->c_init)
 		this_cpu->c_init(c);
 
+	bus_lock_init();
+
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8a483f4..799f185 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -610,7 +610,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 	init_intel_misc_features(c);
 
 	split_lock_init();
-	bus_lock_init();
 
 	intel_init_thermal(c);
 }

