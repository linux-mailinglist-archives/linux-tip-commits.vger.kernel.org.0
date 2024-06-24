Return-Path: <linux-tip-commits+bounces-1527-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5D9155B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F6E1C22E51
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80D19F47C;
	Mon, 24 Jun 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Jr6Mcrl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6EKOxZfc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707519F463;
	Mon, 24 Jun 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251263; cv=none; b=RPLRwxJYCzrKTnPEfrfVj4oDMwED0/OklPCaXRJOvMxugDpVjNpefVOsK0krXHC0jOJXO1zhfhEhYuHIfwcIu4/Q13ea8Ov79iUXMzbef1lHwcm5oQ43qOHl+hZDwlONcgAeAnHZMpT5shN0AOYy7WTrJ+HvRiMYDDBoIpJRBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251263; c=relaxed/simple;
	bh=TQeXss5CjbOrmDLzV/GKP6LLID+0m35c2HgMR2W3Rb8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=thR9L64VBLo6UV4HQo+mcI49IxrDEoLntfGZ2h8WfxqAj7jxnEGWyj5r0CQxrw7hoEkCS+wk/xFqlLvIyNJwCtMEab4Gn/VaBsNZeF57MCLjdZMTp1r7E9y+t3bKLjjtMZ/wSdYntnzMjDUR8sVs7yi38z2wx/JVm/cVJ3z1DjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Jr6Mcrl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6EKOxZfc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wyq667JVyg/otuSvolLre7xIvSDAjfFDg3uuOsySp0I=;
	b=0Jr6McrleDKFB4D1g+GMTwMrrH4ALfyAwamz+8I+2+ZqIh0b2KpP/TsBHOW0ZYJk0ygQ3i
	cEKvgD0fbORYzcYXzHUsKJ1SPhR/mhdp4fPRvIeSiKNQqMGKq/gSwTimbYzfnAGFcVlvqZ
	c8ncsbD2+eJb0DFK0Hbqaw9AcybFVv+g1+MVLg/472LF1imoCmwHcQOkuo1HXHIx2U6Uzz
	e+S2uGfRR2U4aqwAH702WvwKga6xgetAKlFqzBBX4Vq5C92qIoS2ZMQc93XovT18a17kc9
	5oV6iXd5Kh/oc1hjNT7kyuTR35uszQLQDc8z3BoG6BXR04n4EKSsKQvU4TeGqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wyq667JVyg/otuSvolLre7xIvSDAjfFDg3uuOsySp0I=;
	b=6EKOxZfcY53Y70C4MgFgPOXpcAKblcvTrgKZQDzswBhjUeXdbqdh+hm4ORIzwkEmf1MZ++
	0GTbQDuM9aYxPbBQ==
From: tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/platform/iosf_mbi: Convert PCIBIOS_* return codes
 to errnos
Cc: ilpo.jarvinen@linux.intel.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527125538.13620-4-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171925125999.10875.8245813312814005530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     7821fa101eab529521aa4b724bf708149d70820c
Gitweb:        https://git.kernel.org/tip/7821fa101eab529521aa4b724bf708149d7=
0820c
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Mon, 27 May 2024 15:55:38 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 19:28:18 +02:00

x86/platform/iosf_mbi: Convert PCIBIOS_* return codes to errnos

iosf_mbi_pci_{read,write}_mdr() use pci_{read,write}_config_dword()
that return PCIBIOS_* codes but functions also return -ENODEV which are
not compatible error codes. As neither of the functions are related to
PCI read/write functions, they should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it.

Fixes: 46184415368a ("arch: x86: New MailBox support driver for Intel SOC's")
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240527125538.13620-4-ilpo.jarvinen@linux.in=
tel.com
---
 arch/x86/platform/intel/iosf_mbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/ios=
f_mbi.c
index fdd49d7..c81cea2 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -62,7 +62,7 @@ static int iosf_mbi_pci_read_mdr(u32 mcrx, u32 mcr, u32 *md=
r)
=20
 fail_read:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
=20
 static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
@@ -91,7 +91,7 @@ static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 md=
r)
=20
 fail_write:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
=20
 int iosf_mbi_read(u8 port, u8 opcode, u32 offset, u32 *mdr)

