Return-Path: <linux-tip-commits+bounces-1563-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F3923A67
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 11:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C3C1C20D1C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A514F9F2;
	Tue,  2 Jul 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/gDEU+l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="57j9QYLI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71821171AF;
	Tue,  2 Jul 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913532; cv=none; b=gEXj7h+QkLjELlxETHJFQUuP2j+QH4fUxb7qJTckV6WyvzED34xJ0j7fv4R5bsw0laj9mCGuqy6K3cJLIrtSZpzSoe5mLON/Jf9vyYnBg61TxTJJlnIuWzNw9yorvyrkbdfahYNhIevV4Ssw2CPQ1MoKD3Ptg0zakS73tbMONkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913532; c=relaxed/simple;
	bh=qGPoKyE716za/4GlAhhSuBs/x8gh39mbVo/3fwf3xec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L/RbvvWE9ZyRelJ4G+D8TpTtBleKOgTE6V23mdimGDd71F4AqJ+ZOKE67wsmQSkoT/zaGwj/tnw3XQ4+dU36nSZoCqm7Xsqnaado2b6UqqtDCkQ47hrm4P6ZT8/nxzjMHxTjPkK2InFN4GRNV+ySUkVRoiCDLR9iHxhEJrdFVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/gDEU+l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=57j9QYLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 09:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719913522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9uUpoGJj7c96LmZHaNMlUfEw2dUMdkNAK+J7mxLgQ8=;
	b=X/gDEU+lf5bM/orntWzDCrROC60IrDHMRzxAB/e62KomNMdUcBU+WA9I9ejPwUlOO8aTr/
	wmiGRzXPJz6ypzPmHJ8stRS8vJALPpeXxDfqm3uzENy4WwzArjSHDYP3q81adR7Qig9ovc
	gmI1gSFrob/MB9PMv8EmJzWEUMHVHQZcSkx/pau8xwTKlW3WEXcK2dY2uaKIBpWuG1rKQc
	+TXxwNwvL9cmX5/EIvr/2FhkeZBTOyUupb/UnTjcQpgx1CpGF4a7qie5BTckItg/GolWCf
	BxGKnZLXoQQHDMhFoVNGo50CgwOHOXisWzitKDppDlavU3Ie6e/SDXRTUIezJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719913522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9uUpoGJj7c96LmZHaNMlUfEw2dUMdkNAK+J7mxLgQ8=;
	b=57j9QYLIeA11DypFdmODdqFgpyfTzeDk1mj93I+Til/cByR0l2qSLolkH1Y/3cNTX7u8BT
	RDgWTYKU4GWkKyDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] Documentation/ABI/configfs-tsm: Fix an unexpected
 indentation silly
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Bagas Sanjaya <bagasdotme@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240701184557.4735ca3d@canb.auug.org.au>
References: <20240701184557.4735ca3d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171991352157.2215.6190082159028914996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8434cf006ceae2183533f04ce3ac11fba6ee1613
Gitweb:        https://git.kernel.org/tip/8434cf006ceae2183533f04ce3ac11fba6ee1613
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 01 Jul 2024 12:34:51 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 11:36:26 +02:00

Documentation/ABI/configfs-tsm: Fix an unexpected indentation silly

Fix:

  Documentation/ABI/testing/configfs-tsm:97: ERROR: Unexpected indentation

when building htmldocs with sphinx. I can't say I'm loving those rigid
sphinx rules but whatever, make it shut up.

Fixes: 627dc671518b ("x86/sev: Extend the config-fs attestation support for an SVSM")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20240701184557.4735ca3d@canb.auug.org.au
---
 Documentation/ABI/testing/configfs-tsm | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index 1db2008..534408b 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -103,8 +103,7 @@ Description:
 		provider for TVMs, like SEV-SNP running under an SVSM.
 		Specifying the service provider via this attribute will create
 		an attestation report as specified by the service provider.
-		Currently supported service-providers are:
-			svsm
+		The only currently supported service provider is "svsm".
 
 		For the "svsm" service provider, see the Secure VM Service Module
 		for SEV-SNP Guests v1.00 Section 7. For the doc, search for

