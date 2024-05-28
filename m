Return-Path: <linux-tip-commits+bounces-1303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CDF8D22F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57971F251D3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD23487A7;
	Tue, 28 May 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWVef+zv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0KMITf7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC144C7E;
	Tue, 28 May 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919511; cv=none; b=c/iuJT85dB26g81mO78W+cOD3VvymwF+rK+AJarZWQNDoyT+eqpM4CBLDC3Uku7kW+52GFAMuvn78w3CGRX09br6qOloV6cSieLRcCXEyw2H96RgJkyUK9cikrQqf1I+HnZAf6ZEoEBpjWzfwNEEkxlMYT3W/GMvI2pEj2BQCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919511; c=relaxed/simple;
	bh=XSv7dtW2QGc5VcD7GVuLzB88b36XrsU0cg8CqCz9ik8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=abzgY0b/2iSB4T2l3jPESNXzrAiCSTPXjWOPFuT149XDBa5NkmAurA3RNZuvT7Pu9xiodY55AE6RBB1EI4aSKBF5uIe868WcCW4sKix8YE1ohSO2f9MBDeuxYPE7Q/pPJDfZq1IklrW+x1BtMawRb2D64r2jhdjibTrcQ38E06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWVef+zv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0KMITf7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=alJuym5wA7Qa3Iyc1CYTB2wUVwGN3KbBBt4hDiM4Yfg=;
	b=pWVef+zv+aBE5qduC6zTO8cidMiipinWnykM5eH4mnDPxzkPBBS7CeSFuxdYquUi03Bklb
	LSHZ+sfQucJbnzVeb+ZwynavSHJgsMcJXUBOh8k/4bFfVynHsSSX57aj9rYtV1WxtDu9Eu
	uiaPJ99I6cePqy4UXFpwk+VkfTYEqddrDIRiRnUSa2d/Ei0LPqw/vvlF0c8K6/pZ/ZKyCf
	FZDUrRDIz1DOlWKtKkyHe7hRM0LOvl93B89839v4skTlbmiGXshY4j/UsYKT+eE6rC5jNt
	jrMIoRZ9/JuWVZMymHXGj3nl3WED9MsBMwSln5FapwycMVLsuqrWuTKmRQrXeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=alJuym5wA7Qa3Iyc1CYTB2wUVwGN3KbBBt4hDiM4Yfg=;
	b=n0KMITf7QnZjmPNFimcfGvWW1RX4ZzMcEekvkRHjfQeW2UfAMi9eSIU44i025rz+AAfUc2
	XUfMeHvecvJG0oAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950700.10875.7098112075945172834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     744866f5c0e2e13dccde754ade8c89924a29e04d
Gitweb:        https://git.kernel.org/tip/744866f5c0e2e13dccde754ade8c89924a29e04d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:46:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:03 -07:00

x86/cpu: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Update INTEL_CPU_DESC() to work with vendor/family/model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240520224620.9480-34-tony.luck%40intel.com
---
 arch/x86/events/intel/core.c         | 64 +++++++++++++--------------
 arch/x86/include/asm/cpu_device_id.h |  8 +--
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7f7f1c3..0e835dc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5187,35 +5187,35 @@ static __init void intel_clovertown_quirk(void)
 }
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_G,		 1, 0x00000015),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 1, 0x0b000014),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 6, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 7, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		11, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		13, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
+	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
+	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
+	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
+	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
+	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
+	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
 	{}
 };
 
@@ -5232,9 +5232,9 @@ static __init void intel_pebs_isolation_quirk(void)
 }
 
 static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE,		7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	7, 0x0000070c),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
 	{}
 };
 
diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index b6325ee..3831f61 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -280,10 +280,10 @@ struct x86_cpu_desc {
 	u32	x86_microcode_rev;
 };
 
-#define INTEL_CPU_DESC(model, stepping, revision) {		\
-	.x86_family		= 6,				\
-	.x86_vendor		= X86_VENDOR_INTEL,		\
-	.x86_model		= (model),			\
+#define INTEL_CPU_DESC(vfm, stepping, revision) {		\
+	.x86_family		= VFM_FAMILY(vfm),		\
+	.x86_vendor		= VFM_VENDOR(vfm),		\
+	.x86_model		= VFM_MODEL(vfm),		\
 	.x86_stepping		= (stepping),			\
 	.x86_microcode_rev	= (revision),			\
 }

