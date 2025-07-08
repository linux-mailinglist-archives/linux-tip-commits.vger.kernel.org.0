Return-Path: <linux-tip-commits+bounces-6029-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05667AFC7D6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661A0564EF7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A926E70D;
	Tue,  8 Jul 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2iDPpCeV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/dmuUqV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4B26E6FB;
	Tue,  8 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969048; cv=none; b=K9Hn3jFlQxMBLoGDvpsmczhRqZh7NerS46MiX/yzZiZkqZICFL0b9K6fGitzJ8TpaKw3rzQmNj0qNef5JUNPxxT6KJ8XgVAYG/2giWBiy3rOYKudQzZ0j9uEE+yW9506uIIJs8sBnI3e37CK/cAjwmp6yqF5azb0+ammlF2w/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969048; c=relaxed/simple;
	bh=9jOGxllo/5kcHh3/3LsrGYxxCWbi3D4rfEazxfOGyKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g+qjPtrRwouynleecb7fScNF1GlO2SnICn6aizVCJYED3DOW1JeAO65P5CSwCUIM+5fspUjog2A/Q6fbL6nwyOwIx37wpU4j0SCOgsVe2mkZYuY2e6blJcUSG7jxV1BzMJ74GmOpS/x0pu3K/Bj/KTa4AlNPiXNhdNbqVCqv5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2iDPpCeV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/dmuUqV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRmxg7Wk+UifH+yhRprWYdUrhu9hsE2wrZPhPoPUA4k=;
	b=2iDPpCeV/x9AgruFhIVbHNpTlC5skpGSsCEwnVUkfv2MVkND14KKonFTsbMySRKIbyP8qD
	m3UNsaBBfKA7sm1zBe/0o4PVlUP91Xz9TyRcgY6CdZh17v9Hw6O2bDvaseGUSHqxS4C6QX
	dszvBX4NcHWH1jlkZvLk4mD2qtXUS4hBPHPNF1c0/zmvH7Wl2sZJG4Kiv8mc3vDmq5YjjI
	Gbt2Zgdh02GD7gvpI104cyieCBuRRzJ0hWQR/pnAAa6+yp+7R7519+pUCrIIAzfb1930YM
	gVU5dPd5wqWGH5+YIYI60IsZ6S49NnenuZIKFAJPZ9yOtmHCVPo9Oaf4Ec6zJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRmxg7Wk+UifH+yhRprWYdUrhu9hsE2wrZPhPoPUA4k=;
	b=T/dmuUqVigbUfhiIWV3YLlo6vp123Bdxv3VuVujxbgHurfCd22LyddaqMnLtkBpaFxGIil
	5bCRWupj0wcD8wBA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] MAINTAINERS: Add maintainer entry for AMD
 Hardware Feedback Driver
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-3-superm1@kernel.org>
References: <20250609200518.3616080-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196904158.406.15619124451523430788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     31b294e522a1ecf83298aa78ecdd7b57578b5b65
Gitweb:        https://git.kernel.org/tip/31b294e522a1ecf83298aa78ecdd7b57578=
b5b65
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:07 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 19:23:22 +02:00

MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-3-superm1@kernel.org
---
 MAINTAINERS |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb0..17ba4ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1112,6 +1112,15 @@ F:	arch/x86/include/asm/amd/hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp/
=20
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

