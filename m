Return-Path: <linux-tip-commits+bounces-7274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C23C3B08F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4E2189A837
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E152330D29;
	Thu,  6 Nov 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7DbIf40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y968egK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F51FDA89;
	Thu,  6 Nov 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433585; cv=none; b=fevFBOOEH9y3Voq+qvy2VyhB5JNgeoZ+9FyJ+v9FKl8l1elMwrzzxXbGCRXMdZbOoR8IR/l1Gl/SGGeGuazAf1i4TB0g5k3rpQgfHYWxeFZRlqkuKHMiDdHq8ZDyaQvvsw/BGVLK3RxmoZdlYjLAqXoAPqQcduYjjpmDQ7IJ9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433585; c=relaxed/simple;
	bh=9h3cRcYO6SbzLkava0UKTKT8wXjG1keIu0LRbsLwlSQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cYbk8jGpHz2c4rjFHV79yWQZQDs7dYfduP5L/ZJxkUP36VC+THr3WW5cBPYR173g3+X39k5hKgqQR38gAWlFkYIELfouiD0ZCJxDs5wvlx6HjUN4JwJM4w533pFzmUF/2/+ysNzaEO5NP35Bke79QsFi3TjXHTRanhVDKChS068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w7DbIf40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y968egK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 12:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762433574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yhhJRnq5EKUC7QVxmuaP3IjDaeMDNFxhpyIkNWxk+8o=;
	b=w7DbIf40zXLeFvPVAnJTe6LK128zzDgJnSwDn65Y0qEEe80wEbLxMA+yArhTzJrvNY/Gc3
	0SN1QYMTDd4GzXrbWtE40+BHMjBIT1BSj2DTXeMZAoPPJ46A9GlEy6xEKNNdfqM96SErlt
	qCB7uRoJgrq5aOP/79gk0UACLyFAIlrsbuQ4yqFz+mBFpfQR6ffOld3DtDy1eBgcL/GVM+
	3UztoTL4qxManp61QjNW3E54E0YfAklBEFj8Pbu1fIqb7ud30BKgH5DETaDD7uq2N+cwCi
	tCOD/OnqAlFhe9AKmJXlcNwEuAHABDrHSi9wJeTupl5u0/Xm2K+OZEE2fkDx4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762433574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yhhJRnq5EKUC7QVxmuaP3IjDaeMDNFxhpyIkNWxk+8o=;
	b=y968egK3PftX38akjtti5nHk8H2kQ7bCyccWlqB4EwWnUteXypeCzLyChSTE5m2grMb8dn
	tiPvXeQv52JUOvCA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Support SMCA Corrected Error Interrupt
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176243357346.2601451.7444433882462199545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4efaec6e16c249b64d389c85c3ef01345580483a
Gitweb:        https://git.kernel.org/tip/4efaec6e16c249b64d389c85c3ef0134558=
0483a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 04 Nov 2025 14:55:41=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 22:10:23 +01:00

x86/mce/amd: Support SMCA Corrected Error Interrupt

AMD systems optionally support MCA thresholding which provides the ability for
hardware to send an interrupt when a set error threshold is reached. This
feature counts errors of all severities, but it is commonly used to report
correctable errors with an interrupt rather than polling.

Scalable MCA systems allow the platform to take control of this feature. In
this case, the OS will not see the feature configuration and control bits in
the MCA_MISC* registers. The OS will not receive the MCA thresholding
interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems. This
will be used in the same configuration where the platform controls MCA
thresholding. However, the platform will now be able to send the MCA
thresholding interrupt to the OS.

Check for, and enable, this feature during per-CPU SMCA init.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 117165c..6d16b45 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -308,6 +308,23 @@ static void smca_configure(unsigned int bank, unsigned i=
nt cpu)
 			high |=3D BIT(5);
 		}
=20
+		/*
+		 * SMCA Corrected Error Interrupt
+		 *
+		 * MCA_CONFIG[IntPresent] is bit 10, and tells us if the bank can
+		 * send an MCA Thresholding interrupt without the OS initializing
+		 * this feature. This can be used if the threshold limit is managed
+		 * by the platform.
+		 *
+		 * MCA_CONFIG[IntEn] is bit 40 (8 in the high portion of the MSR).
+		 * The OS should set this to inform the platform that the OS is ready
+		 * to handle the MCA Thresholding interrupt.
+		 */
+		if ((low & BIT(10)) && data->thr_intr_en) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |=3D BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status =3D !!(low & BIT(8));
=20
 		wrmsr(smca_config, low, high);

