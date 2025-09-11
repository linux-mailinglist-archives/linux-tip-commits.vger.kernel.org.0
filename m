Return-Path: <linux-tip-commits+bounces-6559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4DB52E51
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2FD567897
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCD311C2C;
	Thu, 11 Sep 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ynlTy0Cw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InM1eMxI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0531076B;
	Thu, 11 Sep 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586538; cv=none; b=bgwJZLjatq8/h9uXDIv5KZC9O/YRgNKq3HuawTOFM7iys+8GYG2DOlr9MDrBw+gOuHOSqH7JvSBiQu5nEMaPYcKrGURelrnr8oOCUVzfFS9FysT8KimaRZD/HMiYi0zksSQJX/4OisrlFIf7nto9VGmwvvPYoG/d3v9bcZbzbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586538; c=relaxed/simple;
	bh=PxfJeEDOmCY6XVJKRjfRMsi3eTpPZI6fQiuPtAU5i8k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hwx7zNiLqGB8H5YP8pBQ2SY7h7e2MJZ7HuJ1e1/HI6gLGhbRKxn4iuCpmExoK7Inwvc9MPPK0586/0MuwVtVy+uqNOoCbtE3V7Kr/KTEybdabEwyAkzFDq3ZPzPYbQuPUrWplCAV0khF5jnSQKYxe1FF1W/Ro3HkuqbszWKfMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ynlTy0Cw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InM1eMxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J0wk/PvecolNcyUPM0FGwjaAoPGwQGwTEvCx/P8E7uc=;
	b=ynlTy0CwOiRIGgSahB6vxfNCnXXjnzWM9FLjb/BIbLGzfZeoY+qxgrVrvJHXkGehiPhukJ
	cQ4SWMbF62xorCeludFr7Q7rdJxxsswY06juHyc1fhtzuGEMaAkcBlZfrfr3pT0Wan1izA
	3E50p3PaS2L1Y9/sC/Gc9u3oGtFoMi2APo1VavAASLi5yty8t2SH/3UKl7/r/3Q0vJiAKI
	5shDri4ZizOz/HdnVmqRBwtDWdMvVYIPZ5IPQdhx5l7MPThVWJ2AP55xD8akY+waXJQrAn
	7cLkYsMxIXgj2UFrmOJDOEJjVNxxd85oP/tpaO2glqslD5OeEwiKClvMoC3E0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J0wk/PvecolNcyUPM0FGwjaAoPGwQGwTEvCx/P8E7uc=;
	b=InM1eMxIInFDBikfdCQYeWNs2umE7FiFJQW7BaNoSKPKh4E2dzLhCqIYznq173eeP+redH
	0LcyKqmEmcybJCDw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Support SMCA corrected error interrupt
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653358.709179.54343642794388083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9b92e18973ce199a4439c0bf572316b109556323
Gitweb:        https://git.kernel.org/tip/9b92e18973ce199a4439c0bf572316b1095=
56323
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:40=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:47 +02:00

x86/mce/amd: Support SMCA corrected error interrupt

AMD systems optionally support MCA thresholding which provides the ability for
hardware to send an interrupt when a set error threshold is reached. This
feature counts errors of all severities, but it is commonly used to report
correctable errors with an interrupt rather than polling.

Scalable MCA systems allow the platform to take control of this feature.  In
this case, the OS will not see the feature configuration and control bits in
the MCA_MISC* registers. The OS will not receive the MCA thresholding
interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the platform controls
MCA thresholding. However, the platform will now be able to send the MCA
thresholding interrupt to the OS.

Check for, and enable, this feature during per-CPU SMCA init.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a6f5c93..3426894 100644
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

