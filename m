Return-Path: <linux-tip-commits+bounces-7825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECCCF9789
	for <lists+linux-tip-commits@lfdr.de>; Tue, 06 Jan 2026 17:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D15A3007633
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jan 2026 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14FB30EF75;
	Tue,  6 Jan 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4SHWiaJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xlvQpxEX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE732DEA86;
	Tue,  6 Jan 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718288; cv=none; b=fXBFPflXZ2HjnWGSigm7TkoiTxHAm02PyA3WkLwdo5LwD/8T8nLbwp/2rZWhJH7CYC5iMpiDIEDdIpEJyCVPTumui8hTDbUxsd+uXlXClhiCNfsFthMYCwdKLkmsrz/jgyZdvY8mkgPJgDmakiZPQr1H9vVpvAN8/imUKkCQ7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718288; c=relaxed/simple;
	bh=xv3NeTZObnNAVAYQXF8wuFxoNTfqe4PI9ZXD2hjqO38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J3ECU96cy3X8QI2pKoYq8zUsEi4+rt44WHUGGHL4xfvgB8oYHwZwhSLcLbABIXOPA/4IUqD1sgV584IFIudlcEts08sARwAWchc7hEu8ZEOH3sXf4IDH/BVBTqWZpMClm724kJirvc9VzMiiCGc3cKuUjxAU2z7OS7e/nZmPaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k4SHWiaJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xlvQpxEX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Jan 2026 16:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767718285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0O+RK8sF8JOiaeSUIoIGPfoi9XmMbMQWkEKXQhuUKng=;
	b=k4SHWiaJWSFz1WrZMG+u6CaEJHUh6As9sNFV8GvXNTk8aZiN5JniB+0vXnzhSo98K/Yrla
	J1yL+sAiI0fwELapvNoxdRmK5KRdwUC0DRMqH8yoxxzgJ91SPAzEXm2DC1TALqtWDv33lb
	4S9gDleNUEWkegGBWdhnSwWSjp1huDKxr3jwFtwl08OySzn3sF8MQSOx/vIfDh09GaZ3As
	R2xwqJG1iD7xN7VFUHJ7c7zrqjw4GfzhjUY0nrmba8o7TgLsnSk1mDKGdoBPn4D85nORqJ
	akI0OahwmdR8eW5eSwppCl5N1arheLaSMYKVirTpXzJWF0OGXrcSq5dECvtV/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767718285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0O+RK8sF8JOiaeSUIoIGPfoi9XmMbMQWkEKXQhuUKng=;
	b=xlvQpxEXbzesSmBZzxAvLgPeIBq/y+WFFBKZ3RxPuZBMAVqgMtEel4VUq3IBYzoPDW42wa
	KGF8UtYLMozxGmBQ==
From: "tip-bot2 for Richard Lyu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] Documentation/x86: Update IOMMU spec references to
 use stable identifiers
Cc: Richard Lyu <richard.lyu@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260106052815.46114-1-richard.lyu@suse.com>
References: <20260106052815.46114-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176771828037.510.9938760067719377968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     6b45ded3f714e78c20708c0f29852fba856fec0c
Gitweb:        https://git.kernel.org/tip/6b45ded3f714e78c20708c0f29852fba856=
fec0c
Author:        Richard Lyu <richard.lyu@suse.com>
AuthorDate:    Tue, 06 Jan 2026 13:28:17 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jan 2026 08:48:40 -08:00

Documentation/x86: Update IOMMU spec references to use stable identifiers

Direct URLs to vendor specifications for Intel VT-d and AMD IOMMU
are frequently changed by vendors, leading to broken links in the
documentation.

Replace the fragile URLs with persistent identifiers, providing the
official document titles and IDs. This ensures users can locate the
relevant specifications regardless of vendor website restructuring.

Signed-off-by: Richard Lyu <richard.lyu@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20260106052815.46114-1-richard.lyu@suse.com
---
 Documentation/arch/x86/iommu.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.=
rst
index 41fbadf..79c3356 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -2,10 +2,11 @@
 x86 IOMMU Support
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The architecture specs can be obtained from the below locations.
+The architecture specs can be obtained from the vendor websites.
+Search for the following documents to obtain the latest versions:
=20
-- Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product=
-specifications/vt-directed-io-spec.pdf
-- AMD: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/=
specifications/48882_3_07_PUB.pdf
+- Intel: Intel Virtualization Technology for Directed I/O Architecture Speci=
fication (ID: D51397)
+- AMD: AMD I/O Virtualization Technology (IOMMU) Specification (ID: 48882)
=20
 This guide gives a quick cheat sheet for some basic understanding.
=20

