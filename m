Return-Path: <linux-tip-commits+bounces-2973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB099E4765
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2024 23:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650C3161ABD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2024 22:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC9191F7E;
	Wed,  4 Dec 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5EOM7gs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Jvt093w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D518FC75;
	Wed,  4 Dec 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349807; cv=none; b=Ojp+Qhc3sDx3cnNbxdaTabXwkMtnIFYtjPU9kcn0GqXiuF5ep0HlblnJRp91uOapsYCY2H4wW20+xOd+/wYuCBblM/doGKmEloHT8qGUXWd2S9HsmMF6WRoNvpGZbPT8V+XVcJ393kB5MNqSuSOVyLwgb4jMHXlux4eE9KUMz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349807; c=relaxed/simple;
	bh=QmsayPZ2pmhUJ7IBM2zdZ+JK5vqhgcnkxwz1pTSYmc8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=icSk3bDXykIHst2wJRZyJgikUfEoD/T++IlAlnGd/fg62RvNCrfrzOAZCdXL6bNey5xcuMo5kPhlgnisaD8JyK815G+Alvcu87hmKUyL4H9CF7HYIyq3PLR49hyTlXEQ2gfzDkzyVeixI6FPOlkNdSSIBcvADVDU+jldxmXEKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5EOM7gs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Jvt093w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Dec 2024 22:03:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733349803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rPyp5JrYqO9t5oFuyaFVzhwZe5R5UG1Hicd8jEcIqek=;
	b=Y5EOM7gsFpDDMrZ7aCibCgl+ciU7fZjg2z0+YuhPsqqO5/i9CrtIjdWZmf1TtxVNPdJ1GY
	p/gvltPW8GMQjB74BjUszPlLdkJdXlVq+tldqdNISBrdKUoHoUkkLgYK/fLi3VJPCMBtnU
	6pXQB1TseigoVoUn1QE5bl9RTkyHOSPChHVMepEIWXroyD28u9S1GxEnXbYfQodxk/gAOg
	3Gw7GO1b1zfLce2Hirm79QCHIXRrUb/pkC1SppKR/Y5JuJUDhWArlo+6MlQkJXVngOLSdt
	lBaOK0tAyTzsh2oK57PbRD9amNWKquUxrk9WYVm0Rnc+n8ZOrmc51u2PlnyeFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733349803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rPyp5JrYqO9t5oFuyaFVzhwZe5R5UG1Hicd8jEcIqek=;
	b=2Jvt093wzvlig/j0Z9wTRnQxKSN2pR87s6ubPmBQi7hsovJ5gHq6uiIJUIuZC8KXxL3Iot
	fqOYUL56WNfeZaAg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Disable unnecessary virtualization exceptions
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173334980263.412.7159418692292221116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     cd9ce8217345bd13035a0d3edaaecec4244d0ddd
Gitweb:        https://git.kernel.org/tip/cd9ce8217345bd13035a0d3edaaecec4244=
d0ddd
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 09:24:31 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Dec 2024 13:55:15 -08:00

x86/tdx: Disable unnecessary virtualization exceptions

Originally, #VE was defined as the TDX behavior in order to support
paravirtualization of x86 features that can=E2=80=99t be virtualized by the T=
DX
module. The intention is that if guest software wishes to use such a
feature, it implements some logic to support this. This logic resides in
the #VE exception handler it may work in cooperation with the host VMM.

Theoretically, the guest TD=E2=80=99s #VE handler was supposed to act as a "T=
DX
enlightenment agent" inside the TD. However, in practice, the #VE
handler is simplistic:

  - #VE on CPUID is handled by returning all-0 to the code which
    executed CPUID. In many cases, an all-0 value is not the correct
    value, and may cause improper operation.

  - #VE on RDMSR is handled by requesting the MSR value from the host
    VMM. This is prone to security issues since the host VMM is
    untrusted. It may also be functionally incorrect in case the
    expected operation is to paravirtualize some CPU functionality.

Newer TDX modules provide a "REDUCE_VE" feature. When enabled, it
drastically cuts cases when guests receive #VE on MSR and CPUID
accesses. Basically, instead of punting the problem to the VMM, the
TDX module fills in good data. What the TDX module provides is
obviously highly specific to the MSR or CPUID. This is all spelled
out in excruciating detail in the TDX specs.

Enable REDUCE_VE. Make TDX guest behaviour less odd, and closer to
how a normal CPU behaves.

Note that enabling of the feature doesn't eliminate need in #VE handler
for CPUID and MSR accesses. Some MSRs still generate #VE (notably
APIC-related) and kernel needs CPUID #VE handler to ask VMM for leafs in
hypervisor range.

[ dhansen: changelog tweaks, rename/rework VE reduction function ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20241202072431.447380-1-kirill.shutemov%40l=
inux.intel.com
---
 arch/x86/coco/tdx/tdx.c           | 17 ++++++++++++++++-
 arch/x86/include/asm/shared/tdx.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0d9b090..c0ebe8c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -274,6 +274,20 @@ static void enable_cpu_topology_enumeration(void)
 	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
 }
=20
+static void reduce_unnecessary_ve(void)
+{
+	u64 err =3D tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_REDUCE_VE, TD_CTLS_REDUCE_VE);
+
+	if (err =3D=3D TDX_SUCCESS)
+		return;
+
+	/*
+	 * Enabling REDUCE_VE includes ENUM_TOPOLOGY. Only try to
+	 * enable ENUM_TOPOLOGY if REDUCE_VE was not successful.
+	 */
+	enable_cpu_topology_enumeration();
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args =3D {};
@@ -305,7 +319,8 @@ static void tdx_setup(u64 *cc_mask)
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
=20
 	disable_sept_ve(td_attr);
-	enable_cpu_topology_enumeration();
+
+	reduce_unnecessary_ve();
 }
=20
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/=
tdx.h
index 89f7fca..a878c7e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -31,6 +31,7 @@
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
 #define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
+#define TD_CTLS_REDUCE_VE		BIT_ULL(3)
=20
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001

