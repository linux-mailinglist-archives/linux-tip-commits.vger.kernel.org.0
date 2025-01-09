Return-Path: <linux-tip-commits+bounces-3185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93422A0713A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF82F3A1D97
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104D2163B5;
	Thu,  9 Jan 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/j3r/9S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nInQffy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE6215F6A;
	Thu,  9 Jan 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414147; cv=none; b=aCfdAyB8ThSrrWnjspyJgTrnuyO2LsXfP3D4qqMI/mefwYLZM2aPhN/cfV22rZylnrSu1ogVazmY2Us9quTtzUEZsWvb473zzu3y0RHAPuTM4D4rayapKlJEpgapszP7EiVgZZPHdUAjpktJ7cmwi3CYFypBqR4D7SlBKKmAFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414147; c=relaxed/simple;
	bh=eXbUzh04SYzg0AWvdXnpQNrm314p5diBfBr3cdWzMT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l7Bu9m3T/5CsaL3L3E4Jcq7jLUumVgdgpSNVWo6q24UF3c3NyxAJZniI8TPPnnxlHGA/mYFXdQDXPnKSX5FXAzDHl35v8vyWjKHQptDYPsQyyQgaKiDcjleeWYJfccqy2y/mRVCd2Ovke4F9b65YTH6RfqYjZrB80fih76oIEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/j3r/9S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nInQffy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxdi3y46+IoivnpfyE2BUFqiv/vwxMcZaNzm5KWg8cQ=;
	b=w/j3r/9SamqUWq+b0GF4oFuILeSFofWYRZmLNGwNNL++Cnejf+aCy0zHpZJrs/EQ5w0K87
	jmIsMY8rvoohIFwxiEisuXytc3jt1+3+k8JZIilop1pDjWM0aor5C4wo1hVlDo6Fe/Mspw
	ksLhaMPsdJirktkHQu6QeQzA4Tc7hCmB89U5UrnSewPnBv00Aq0sq511eEdDCxN+DRMgi4
	NQ8RFYwjLt8kdyL2GJMtcNoECYIDR2bjrOA5rXfGRRvi0d0KqfMlaIh+h7r5Shg53ipzdt
	z74FG7ySDm5dLTsR3AD1jUOsDyFqnYhLigpt7giysFK0YWHK/zuKrwBCsSn7tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxdi3y46+IoivnpfyE2BUFqiv/vwxMcZaNzm5KWg8cQ=;
	b=1nInQffyCTc3DIa/djEbmmGz00tj0Jyt/2HMBeg3Nb5T25aRNYb3VIQalcgz6sOWi8KEn5
	hmU1395/YFYBSSAg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_nb: Restrict init function to AMD-based systems
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-3-yazen.ghannam@amd.com>
References: <20241206161210.163701-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414394.399.15361493626653734199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     bee9e840609cc67d0a7d82f22a2130fb7a0a766d
Gitweb:        https://git.kernel.org/tip/bee9e840609cc67d0a7d82f22a2130fb7a0a766d
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:55 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:46:57 +01:00

x86/amd_nb: Restrict init function to AMD-based systems

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9fe9972..37b8244 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 

