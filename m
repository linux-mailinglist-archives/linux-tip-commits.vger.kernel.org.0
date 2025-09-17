Return-Path: <linux-tip-commits+bounces-6665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647AB7F7ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6993B7A3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3D30BB95;
	Wed, 17 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykVGaFO9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32Y24HTl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821123074BA;
	Wed, 17 Sep 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101271; cv=none; b=GMDtb1vn6ruDDevk2gHduv3VZ5mWwXbJYUKHHcX+HCFJRe6QcbmRJ0zTJ5Ege4cyXwqkktUcz/xAIlanqgh1txekGhnAY7Czo9SlzNv89xwcUgoXaWVZNhHlkrqU/Lb6XW3AGG+MQzHuQ66oJLjvRzEdyWts2jqWOKLeZ5ql3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101271; c=relaxed/simple;
	bh=HNgKghAutMfAiFYgWdpkDM6xGCyD81/qu94x45I502E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DM9Z/nXDadGkRHJBY7yglmQX74/vpfISRbYBIU7pwbhl5r8XO1FUZIocgc0z7oOFIeUPfSFmMbMBMORglnB74UlFTA/weMm7OlfRi/IcNeyTN2LMBQP2g9WUTKAHFeB/vMrjTIOdgrNN83z4hwrNch3/9DKyYQFhjirAu9rdPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ykVGaFO9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32Y24HTl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 09:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758101267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B5MLh17qNbGWEN4OwctOa8QwKA20eL7aoSJ1Nt+oNxA=;
	b=ykVGaFO9Y/cqhmnWxL/iONE9RH86Y8f0R+KWQlaoMgbaiI7oajGvKOGCOf96bLxEBllAP1
	fRdXN9WicD6VwhFMVB/LVJ7IgT4wZeBW6cY784d07Ysq0r9Aulw4cJOZlkiiPDcEMN/3wi
	bU8cqP6pHUA7BBIlR5mxY5X1tDTi0/Fy++XoqZfsNt2HIeI+8OZn8UXeZ2kzZUuZg57T1r
	bcC7gcQGnCx/wIghs0hEhZYi2GRGJQQRu6tfdXzTtxL5a8vy+HnlUzVFp6noPVEEa79RVN
	EtmDHZBJ7wTIaH9pqvpMRu/QjXRvJVjSw/XoLYqSietg1XUtPKwvnZEvEFDuwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758101267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B5MLh17qNbGWEN4OwctOa8QwKA20eL7aoSJ1Nt+oNxA=;
	b=32Y24HTlOByCnaMqkTbbWq9lXo9t2PjyrUXuMLy2wBsrBckCl6ifsO7vR0l259AAxGy2N+
	IUJIDXmjAfbI4AAw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810126585.709179.4725030483865525356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bc6397cf0bc4f2b7a47cc6ac44086daf67c3c71c
Gitweb:        https://git.kernel.org/tip/bc6397cf0bc4f2b7a47cc6ac44086daf67c=
3c71c
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:17=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Sep 2025 11:24:33 +02:00

x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR

Add defines for the 0xc001_1005 MSR (Core::X86::Msr::CPUID_ExtFeatures) used
to toggle the extended CPUID features, instead of using literal numbers. Also
define and use the bits necessary for an old TOPOEXT fixup on AMD Family 0x15
processors.

No functional changes intended.

  [ bp: Massage, rename MSR to adhere to the documentation name. ]

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/20250901170418.4314-1-kprateek.nayak@amd.com
---
 arch/x86/include/asm/msr-index.h   | 5 +++++
 arch/x86/kernel/cpu/topology_amd.c | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index b65c3ba..a734b56 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -631,6 +631,11 @@
 #define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
+
+#define MSR_AMD64_CPUID_EXT_FEAT	0xc0011005
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT	54
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT	BIT_ULL(MSR_AMD64_CPUID_EXT_FEAT_TO=
POEXT_BIT)
+
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_TW_CFG		0xc0011023
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index 7ebd4a1..6ac097e 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -163,11 +163,12 @@ static void topoext_fixup(struct topo_scan *tscan)
 	    c->x86 !=3D 0x15 || c->x86_model < 0x10 || c->x86_model > 0x6f)
 		return;
=20
-	if (msr_set_bit(0xc0011005, 54) <=3D 0)
+	if (msr_set_bit(MSR_AMD64_CPUID_EXT_FEAT,
+			MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT) <=3D 0)
 		return;
=20
-	rdmsrq(0xc0011005, msrval);
-	if (msrval & BIT_64(54)) {
+	rdmsrq(MSR_AMD64_CPUID_EXT_FEAT, msrval);
+	if (msrval & MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT) {
 		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
 		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Suppor=
t.\n");
 	}

