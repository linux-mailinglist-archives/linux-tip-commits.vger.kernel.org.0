Return-Path: <linux-tip-commits+bounces-6497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E1B463AC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4711CC50A8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BA285406;
	Fri,  5 Sep 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StWaeHnG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJBpq242"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8D27EFFE;
	Fri,  5 Sep 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100793; cv=none; b=UFegAt/MI1ysdpPQt5ZNq1BT5visCBUxkhpU8kk2DM4YNhKfFsUmEsNru7Uy+LLV5/7Aaslh9T79WzMng56FSo0T7BdVQQFsQzDeJC53dZbRpLIs5EDGiC3rXulVinknKwE4X59Qqlzv9LM8uDEApufHwkTkj9Vk7yKSWUNsUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100793; c=relaxed/simple;
	bh=zAHEq0lspdjy2xtVN/EPSx9RUhZ3jfe9h+dE+fvieFE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CirEp/NMMMIJVyseu2czb4GwZEbPr4pY8QVQDzMGnhlHyY2LjcJFHIvsGfK9KRmElKslttz7B4kWVvDbpRak7DA0rVh4WxI5qwLlZHiWEfZJ7bD0g0H06cuD0ncxFh/TsE5shBSyAOVS3dZpWsfjokB3Rc8DyYuPv9jdabVe/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StWaeHnG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJBpq242; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ONmnaAHRfgS0AZBgbZZ7mIdw6X4VEjaShR0dXd2QL4w=;
	b=StWaeHnGHiYSBtBHWRI2j3AwOlrQr+8rvu2NUj9AgdHcCdtzt43kf7KgQtQkihkNjG6bdx
	9Ikd4tpzOcTLjBU0DIwqHcDC6bNYdeV0y7UFOd6/YFMcKUzTA6fS44lr0eIDjOKOhz5ozA
	s/+1ZCDRKEMmHzgoxQpe3zP8SbpyuBPeoOptCTULAedv+OZM8QSNl3JqV8dGESRe4LfuBC
	iOOUAdPFPbKv+mU6XfAyZ9nsU67xpI1fBDdgV6vwM/hCQTHEu8Ute0zVKletfozod+W2W7
	rQKGKnW7XEc9S7HbkTbrRnnbPazfkY/jrO7TKdp1u8y097UU0Yt9dNPyLzlxtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ONmnaAHRfgS0AZBgbZZ7mIdw6X4VEjaShR0dXd2QL4w=;
	b=eJBpq242PzmEtQSJ6K1WsrLNwehoyVvrB86YfWIc69W8bW/sqdO0RX+9+gG4yR5URIveUg
	Bxf39q1l5IcpcpDw==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Farrah Chen <farrah.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710078826.1920.7156049761470343023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     b18651f70ce0e45d52b9e66d9065b831b3f30784
Gitweb:        https://git.kernel.org/tip/b18651f70ce0e45d52b9e66d9065b831b3f=
30784
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:27 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:40 -07:00

x86/kexec: Disable kexec/kdump on platforms with TDX partial write erratum

Some early TDX-capable platforms have an erratum: A kernel partial
write (a write transaction of less than cacheline lands at memory
controller) to TDX private memory poisons that memory, and a subsequent
read triggers a machine check.

On those platforms, the old kernel must reset TDX private memory before
jumping to the new kernel, otherwise the new kernel may see unexpected
machine check.  Currently the kernel doesn't track which page is a TDX
private page.  For simplicity just fail kexec/kdump for those platforms.

Leverage the existing machine_kexec_prepare() to fail kexec/kdump by
adding the check of the presence of the TDX erratum (which is only
checked for if the kernel is built with TDX host support).  This rejects
kexec/kdump when the kernel is loading the kexec/kdump kernel image.

The alternative is to reject kexec/kdump when the kernel is jumping to
the new kernel.  But for kexec this requires adding a new check (e.g.,
arch_kexec_allowed()) in the common code to fail kernel_kexec() at early
stage.  Kdump (crash_kexec()) needs similar check, but it's hard to
justify because crash_kexec() is not supposed to abort.

It's feasible to further relax this limitation, i.e., only fail kexec
when TDX is actually enabled by the kernel.  But this is still a half
measure compared to resetting TDX private memory so just do the simplest
thing for now.

The impact to userspace is the users will get an error when loading the
kexec/kdump kernel image:

  kexec_load failed: Operation not supported

This might be confusing to the users, thus also print the reason in the
dmesg:

  [..] kexec: Not allowed on platform with tdx_pw_mce bug.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/all/20250901160930.1785244-5-pbonzini%40redhat.=
com
---
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index dfb9109..15088d1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -347,6 +347,22 @@ int machine_kexec_prepare(struct kimage *image)
 	unsigned long reloc_end =3D (unsigned long)__relocate_kernel_end;
 	int result;
=20
+	/*
+	 * Some early TDX-capable platforms have an erratum.  A kernel
+	 * partial write (a write transaction of less than cacheline
+	 * lands at memory controller) to TDX private memory poisons that
+	 * memory, and a subsequent read triggers a machine check.
+	 *
+	 * On those platforms the old kernel must reset TDX private
+	 * memory before jumping to the new kernel otherwise the new
+	 * kernel may see unexpected machine check.  For simplicity
+	 * just fail kexec/kdump on those platforms.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE)) {
+		pr_info_once("Not allowed on platform with tdx_pw_mce bug\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Setup the identity mapped 64bit page table */
 	result =3D init_pgtable(image, __pa(control_page));
 	if (result)

