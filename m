Return-Path: <linux-tip-commits+bounces-8121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKWOMV45eWkZwAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 23:17:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC99AF52
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8145E30069B7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DE3570AF;
	Tue, 27 Jan 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EiVLo+dD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E41E2858;
	Tue, 27 Jan 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552216; cv=none; b=lgNjvcYm48n1G+Sjnk6A5KG5oByy2N1wrxEA6Mn0hwx/ZkNQ5YoEYEl9CYY0tjkZPjf9XgQjAu2HCUJuyxGXnrJyEzZ9CAFCXpUrBNaEgGPWODaENRb3pCjyBMBsh/gjkVERukVzB1zfxlWnV0+d3OPGQBk/MFU+qUZ7uqFzr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552216; c=relaxed/simple;
	bh=gkizc+LcJPs7Ni6EXg9dYhHdlbU5t4QtTS/p+TTM68E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5t2V9/pAmotbmH74hfF0HC+LfdpXwIBnQW+wyHbswVVZUrplCwahXGdqBaetloS6sMn1aqf/sYZxkN33g8MB4f9sr6//sMC3BKutk9U6xChg70UTZea7d8S2jryWVmV1bqnDGqHuH971Okpu0oYGsS6wvkP7T/jXEdZ0JPHlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EiVLo+dD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 32BA340E00DE;
	Tue, 27 Jan 2026 22:16:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YGwe0dMrgOsq; Tue, 27 Jan 2026 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769552207; bh=KMfLqUpYDHJA9+H6MbQJAgWcXecDhjTKsU9NgMZdmkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiVLo+dDDFAfLb0qYgemXbTFrsguMky7oJWn0k0eGPEeyMsPB2F2+jJWYIMyE9kHF
	 uTxUy8gVdjVsiUgLHn51d4mi6CZgAx1YJL3kZGw8uf1A3h41cCr7kTqERXEHazbXQ/
	 cJE9jNpgZDqlQ5avWANyD0CdudsEs64frA5QHaKgG+i4itneUJYAzJWbBpDLIv+LmQ
	 Yev22Ro/+2tGvWwForYzdgtYy4Rk28Ex4kYJJ3Wx1bIcWswS9KOzJA4q7Pwn+HImE+
	 dG6m5RHhuhBI0ubB3X2zk27+adKrFQLjz6E9/gR5MHY32BHImyixFLt8n2IqbhnChj
	 1PmWHgRfVT2AJ8PVdJWOOVdnjHjBMmwb/IK20GAIlYsRmA64yAY9RkwL80di2rQ82j
	 kRIingAg9dvJl70dZ2AnB63j+uSSQJZEEZSwloCGSb5c0y2B55bhCgqCdjsUsqRtod
	 g6qbsNjLM3+0RVbQUTAn7snAcAtUcyKjVIiUho8ICUMqu/XaEa0BE8yFi6KM7kmJtO
	 M4bU7DeyvsAcJWcijRxokg0Xi8VSaIw19Nn9e3EqQfc1I1Xc8hDYLtUCYxloeJ8rK2
	 HVNEv7/9WWCqJyfwLCRrxeKVHutFIc+V0LXrsEFcQJyrTat5ere/D5G4ZrHmwVRFO+
	 KCceShOw7MMus6Tk6BQId54E=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 65CA540E0140;
	Tue, 27 Jan 2026 22:16:42 +0000 (UTC)
Date: Tue, 27 Jan 2026 23:16:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH] x86/entry/vdso: Add vdso2c to .gitignore
Message-ID: <20260127221633.GAaXk5QcG8ILa1VWYR@fat_crate.local>
References: <20251216212606.1325678-3-hpa@zytor.com>
 <176834888556.510.1391225459380426538.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176834888556.510.1391225459380426538.tip-bot2@tip-bot2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8121-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-tip-commits@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: F1AC99AF52
X-Rspamd-Action: no action

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 27 Jan 2026 23:09:13 +0100

The commit

  a76108d05ee1 ("x86/entry/vdso: Move vdso2c to arch/x86/tools")

moved vdso2c to arch/x86/tools/ and commit

  93d73005bff4 ("x86/entry/vdso: Rename vdso_image_* to vdso*_image")

renamed .so files but also dropped vdso2c from
arch/x86/entry/vdso/.gitignore.

It should've moved it to arch/x86/tools/.gitignore instead.

Do that.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/tools/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/.gitignore b/arch/x86/tools/.gitignore
index d36dc7cf9115..51d5c22b38d7 100644
--- a/arch/x86/tools/.gitignore
+++ b/arch/x86/tools/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 relocs
+vdso2c
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

