Return-Path: <linux-tip-commits+bounces-2825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE089C0E05
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7AF1C22681
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231F215033;
	Thu,  7 Nov 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HW7u1Hw9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+X6dyjKk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4716419;
	Thu,  7 Nov 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005169; cv=none; b=h3DHk4BI8+LRzclSw1Yu4D98XfV4/brtOpGihUmzad2GqSTEXMtIQ+hXoMJ4RY335IXAIYIMFKsduC401AlZyyLGcVgsV6tQEGLgBunmhPw11QVc1um4ciAO2c6ckQ9q+JpCJ67VjceOdoy3SEFabFfagvzC1JRYbL0BYupDRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005169; c=relaxed/simple;
	bh=PEoe/rwe3mZHm1e8SbJUjk9s8n3F5/HZlZKqknvXKaQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rh+iUxxcSNErc1DUNBAAuHJZAA4+ZkJT0jNydGIaHKFjPcj9uFe+Bhmq85Z3lk+99r1kQHNFMvK5tn8ZSy0f0BoavQyuc8wtUrfHzqE+xsIJD28+MOxsVteAoAe0bS7UyJk5XCXyROrJozI/WX8gXizDbWNMV7yMEtNYd8/chtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HW7u1Hw9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+X6dyjKk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 18:46:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731005164;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3Qb1PNRtvobpheoRW7knUIfxmGfqJQNW0VJfNq0pLsw=;
	b=HW7u1Hw9ySypX1OdKDMI4yC9dqShcXT++gY1WNOSKR9FApFKTEkNtSRIBG3soPrJKUakqA
	4/MMzbVw/O9v50BqifyYuNLqRd/GFf+l9Qmhd3jxrv5TCcXI1/tQjfNunAVfpkqDNMF8Rr
	f+Gj+7KJRESKHQSaj3xAF6hBCGSJvnmH4eJTibOpvGjsYqKbsv4dSkq+LVdOTfXJLkt6do
	Wn+ZCZVsqYzFXmueXNjo7QmZvmJM+kehAQSpSJjwFgXayi+/J/cY+qH67mk7NmLBlnrFJK
	It3agJ7CIO2fPU8ygTIwY4e0PLS1Dsj+pgkgZpr6zWXDV3zw6Sk8I+ZYWypV3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731005164;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3Qb1PNRtvobpheoRW7knUIfxmGfqJQNW0VJfNq0pLsw=;
	b=+X6dyjKkqO8btwxvcMF4N5ymc+rS2Qu5XJVniIjZFUrqZFM5Gu2txCT9Z8Q+5ud5n7EDSB
	3xCbgZxguw0YbqDw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Enable CPU topology enumeration
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173100516336.32228.15253243612567317594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     7ae15e2f69bad06527668b478dff7c099ad2e6ae
Gitweb:        https://git.kernel.org/tip/7ae15e2f69bad06527668b478dff7c099ad2e6ae
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 04 Nov 2024 12:38:03 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Nov 2024 10:27:45 -08:00

x86/tdx: Enable CPU topology enumeration

TDX 1.0 defines baseline behaviour of TDX guest platform. TDX 1.0
generates a #VE when accessing topology-related CPUID leafs (0xB and
0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
topology. In practice, this means that the kernel can only boot with a
plain topology. Any complications will cause problems.

The ENUM_TOPOLOGY feature allows the VMM to provide topology
information to the guest. Enabling the feature eliminates
topology-related #VEs: the TDX module virtualizes accesses to
the CPUID leafs and the MSR.

Enable ENUM_TOPOLOGY if it is available.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20241104103803.195705-5-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c           | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2f85ed0..0d9b090 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -248,6 +248,32 @@ static void disable_sept_ve(u64 td_attr)
 		  TD_CTLS_PENDING_VE_DISABLE);
 }
 
+/*
+ * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs (0xB and
+ * 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID #VEs.
+ * In practice, this means that the kernel can only boot with a plain topology.
+ * Any complications will cause problems.
+ *
+ * The ENUM_TOPOLOGY feature allows the VMM to provide topology information.
+ * Enabling the feature  eliminates topology-related #VEs: the TDX module
+ * virtualizes accesses to the CPUID leafs and the MSR.
+ *
+ * Enable ENUM_TOPOLOGY if it is available.
+ */
+static void enable_cpu_topology_enumeration(void)
+{
+	u64 configured;
+
+	/* Has the VMM provided a valid topology configuration? */
+	tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED, &configured);
+	if (!configured) {
+		pr_err("VMM did not configure X2APIC_IDs properly\n");
+		return;
+	}
+
+	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -279,6 +305,7 @@ static void tdx_setup(u64 *cc_mask)
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	disable_sept_ve(td_attr);
+	enable_cpu_topology_enumeration();
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fecb2a6..89f7fca 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -23,12 +23,14 @@
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
+#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
 
 /* TDCS_CONFIG_FLAGS bits */
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
 
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001

