Return-Path: <linux-tip-commits+bounces-1530-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C89155BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C051C22D62
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1819FA80;
	Mon, 24 Jun 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ag0q1JRL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5pBs0uPa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C219F464;
	Mon, 24 Jun 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251264; cv=none; b=RCCDqNrkha4VrYk8SNOa+WTziyABh1qOTFaC+XXS10LPBwq8HIMLA6Bmh9vhKXPbpJDmHZsfRMa7tvw4TcCmZwSohDDcC0mZtIcdtwGof48qb+SaHI31JkftlcIDA6NvUfIAd3Od+ayAK/+iSyKuIgdJYfsEe65GfpNRbLI7XuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251264; c=relaxed/simple;
	bh=I74WQP6TqBXDz5U9cn941EoWYzkpcPQALpfw2wzjywY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ow7dpQwpgQbK8TIVrV788TETxWOZWjJWdgQAlvYwYEjpqqzvNgcOlgFyVCfjXKJNeSxcLvOiuvyfTYH+UJI3X8VGgR5rU++/QS/nDGXyNxl/BK08+XX4Sj7tlvRE/TNcSkDx4cwXsjTov9BINfPM9cGXndImNsNEVRuFuaMiKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ag0q1JRL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5pBs0uPa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6V5VcGQJaWNnXx/fCqpqIn8TocJE9vyvCMF1JT+VK4=;
	b=Ag0q1JRLr6ac3rl+pFO8x6kygBIlxGLoM7cSH3SkX4qjJvnGwZ5gXWvD4I9U2r661HjcvZ
	MIEkoZ8R0z7MdvCN0WCgZiUJ5jUl6A8PTEaEpQdE6oQER/i7oWb4jQFzlGHgNUHg53LEWS
	B56VivxlQ/mXKXnsx7SgQE84n+E3bYRsCFGpcnmaf4PfkqvhC9OOuqN9Kz7HMMWsTgYPCn
	rY6pv7Q/Vaqb5w2V2hy/xW7bnaDx//nHcMOEJDu8qOuX6vDhMy4vD+cnujENxjJ31mSs5g
	GMEpK7/Ghg8OikeLEtawCSZ0KoFdnYnrrJJpI2Msy3PYSwAyiR+oa6ZqpRiH2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6V5VcGQJaWNnXx/fCqpqIn8TocJE9vyvCMF1JT+VK4=;
	b=5pBs0uPauXYDN6FTkhUDqXOzxsvJxU3BniFhnc17JVKPgYYTNtWkSKnPhXFKFgIR8TLv1V
	5jv3wgP1pJ7i18AQ==
From: tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/pci/xen: Fix PCIBIOS_* return code handling
Cc: ilpo.jarvinen@linux.intel.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527125538.13620-3-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171925126034.10875.8363039612828954865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e9d7b435dfaec58432f4106aaa632bf39f52ce9f
Gitweb:        https://git.kernel.org/tip/e9d7b435dfaec58432f4106aaa632bf39f5=
2ce9f
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Mon, 27 May 2024 15:55:37 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 19:21:25 +02:00

x86/pci/xen: Fix PCIBIOS_* return code handling

xen_pcifront_enable_irq() uses pci_read_config_byte() that returns
PCIBIOS_* codes. The error handling, however, assumes the codes are
normal errnos because it checks for < 0.

xen_pcifront_enable_irq() also returns the PCIBIOS_* code back to the
caller but the function is used as the (*pcibios_enable_irq) function
which should return normal errnos.

Convert the error check to plain non-zero check which works for
PCIBIOS_* return codes and convert the PCIBIOS_* return code using
pcibios_err_to_errno() into normal errno before returning it.

Fixes: 3f2a230caf21 ("xen: handled remapped IRQs when enabling a pcifront PCI=
 device.")
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240527125538.13620-3-ilpo.jarvinen@linux.in=
tel.com
---
 arch/x86/pci/xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 652cd53..0f2fe52 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -38,10 +38,10 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 	u8 gsi;
=20
 	rc =3D pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (rc < 0) {
+	if (rc) {
 		dev_warn(&dev->dev, "Xen PCI: failed to read interrupt line: %d\n",
 			 rc);
-		return rc;
+		return pcibios_err_to_errno(rc);
 	}
 	/* In PV DomU the Xen PCI backend puts the PIRQ in the interrupt line.*/
 	pirq =3D gsi;

